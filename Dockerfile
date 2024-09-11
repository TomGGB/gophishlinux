# Usar una imagen base de Ubuntu
FROM ubuntu:latest

# Instalar dependencias necesarias
RUN apt-get update && \
    apt-get install -y \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Crear un directorio de trabajo
WORKDIR /gophish

# Copiar los archivos de Gophish al contenedor
COPY gophish /gophish/gophish
COPY config.json /gophish/config.json
COPY gophish_admin.crt /gophish/gophish_admin.crt
COPY gophish_admin.key /gophish/gophish_admin.key
COPY static/ /gophish/static/
COPY templates/ /gophish/templates/
COPY db/ /gophish/db/
COPY gophish.db /gophish/gophish.db
COPY VERSION /gophish/VERSION

# Dar permisos de ejecución al binario de Gophish
RUN chmod +x /gophish/gophish

# Exponer los puertos que usa Gophish
EXPOSE 3333
EXPOSE 8080

# Comando para ejecutar Gophish
CMD ["/gophish/gophish"]
