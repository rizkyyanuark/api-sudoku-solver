# Gunakan image Python sebagai dasar
FROM python:3.10-slim

# Tetapkan direktori kerja di dalam container
WORKDIR /app

# Salin semua file ke dalam container
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 8080 untuk Cloud Run
EXPOSE 8080

# Jalankan aplikasi
CMD ["python", "app.py"]