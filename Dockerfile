# Usar una imagen base de Ubuntu
FROM ubuntu:latest

# Instalar dependencias necesarias
RUN apt-get update && \
    apt-get install -y \
    wget \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Descargar y extraer Gophish
WORKDIR /gophish
COPY ./gophish_linux_amd64 /gophish/gophish
RUN chmod +x /gophish/gophish

# Copiar archivos de configuración
COPY config.json /gophish/config.json
COPY gophish_admin.crt /gophish/gophish_admin.crt
COPY gophish_admin.key /gophish/gophish_admin.key
COPY static/ /gophish/static/
COPY templates/ /gophish/templates/
COPY db/ /gophish/db/
COPY gophish.db /gophish/gophish.db

# Exponer puertos
EXPOSE 3333
EXPOSE 8080

# Comando para ejecutar Gophish
CMD ["/gophish/gophish"]
