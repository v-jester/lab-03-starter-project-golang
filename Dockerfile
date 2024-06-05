FROM golang:1.21 AS builder

WORKDIR /dir

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -o /build/fizzbuzz

FROM gcr.io/distroless/base-debian10

WORKDIR /app

COPY --from=builder /dir/templates /app/templates
COPY --from=builder /build/fizzbuzz /app

CMD ["./fizzbuzz", "serve"]
