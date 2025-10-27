# Usa una imagen base oficial de Python.
# python:3.10-slim es una versión ligera y segura.
FROM python:3.10-slim

# Establece el directorio de trabajo dentro del contenedor.
WORKDIR /app

# Copia el archivo de dependencias primero para aprovechar el cache de Docker.
COPY requirements.txt requirements.txt

# Instala las dependencias.
# --no-cache-dir reduce el tamaño final de la imagen.
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto del código de tu aplicación al contenedor.
COPY . .
# Exponer el puerto (Cloud Run usa 8080)
EXPOSE 8080

# Comando para ejecutar la aplicación usando un servidor de producción (Gunicorn).
# Escuchará en el puerto que Google Cloud le asigne a través de la variable de entorno $PORT.
CMD exec gunicorn --bind 0.0.0.0:${PORT:-8080} --workers 1 --threads 8 --timeout 0 app:app
