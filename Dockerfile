# Gunakan image dasar yang sesuai
FROM python:3.11-slim

ENV PYTHONUNBUFFERED True
ENV APP_HOME /app
ENV PORT 8080

# Set working directory
WORKDIR $APP_HOME

# Install necessary libraries
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Salin seluruh kode aplikasi ke dalam container
COPY . ./

# Salin requirements.txt dan install dependencies
RUN pip install -r requirements.txt

# Jalankan aplikasi menggunakan gunicorn
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app