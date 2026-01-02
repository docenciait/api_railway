FROM python:3.11-slim

# Evitar buffering
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Instalar dependencias del sistema si hiciera falta (aquí muy mínimo)
RUN apt-get update && apt-get install -y build-essential default-libmysqlclient-dev && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Railway suele exponer el puerto en la env var PORT
ENV PORT=8000

CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${PORT}"]