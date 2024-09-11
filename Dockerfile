FROM golang:1.17 as builder
WORKDIR /app
COPY . .
RUN go build -o gophish

FROM ubuntu:20.04
WORKDIR /app
COPY --from=builder /app/gophish /app/gophish
COPY static /app/static
COPY config.json /app/config.json
EXPOSE 3333 80
CMD ["./gophish"]