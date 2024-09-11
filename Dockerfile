FROM golang as builder
WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY . ./
RUN go build -o gophish

FROM ubuntu:latest
WORKDIR /app
COPY --from=builder /app/gophish /app/gophish
COPY static /app/static
COPY config.json /app/config.json
EXPOSE 3333 80
CMD ["./gophish"]