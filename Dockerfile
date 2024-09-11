# Usa una imagen base de Go
FROM golang:1.17-alpine AS builder

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos del proyecto
COPY . .

# Inicializa el módulo de Go
RUN go mod init github.com/TomGGB/gophishlinux || true
RUN go mod tidy

# Compila la aplicación
RUN go build -o gophish ./...

# Usa una imagen base más pequeña para el contenedor final
FROM alpine:latest

# Establece el directorio de trabajo
WORKDIR /app

# Copia el binario compilado desde la etapa de construcción
COPY --from=builder /app/gophish .

# Expone los puertos necesarios
EXPOSE 3333
EXPOSE 80

# Comando para ejecutar la aplicación
CMD ["./gophish"]