# Use la imagen base oficial de Python
FROM python:3.8-slim

# Establecer el directorio de trabajo en /app
WORKDIR /app

# Copiar el archivo requirements.txt al contenedor
COPY requirements.txt .

# Instalar las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el código de la aplicación al contenedor
COPY . .

# Exponer el puerto 8080, que es el puerto predeterminado que Cloud Run utiliza para HTTP
EXPOSE 8080

# Definir la variable de entorno para Flask
ENV FLASK_APP=app.py

# Ejecutar el servidor Gunicorn cuando se inicie el contenedor
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]
