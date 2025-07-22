# 1. Gunakan base image Python yang lebih lengkap
FROM python:3.12-bullseye

# 2. Instal system dependencies yang dibutuhkan oleh 'dlib'
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake

# 3. Set direktori kerja di dalam container
WORKDIR /app

# 4. Copy file requirements dan install packages Python
COPY requirements.txt .
ENV MAX_JOBS=1
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy sisa kode aplikasi ke dalam container
COPY . .

# 6. Jalankan migrasi database untuk membuat tabel
# Pastikan DATABASE_URL sudah diatur di Railway Variables
RUN flask db upgrade

# 7. Expose port yang digunakan oleh Flask
EXPOSE 5000

# 8. Tentukan perintah untuk menjalankan aplikasi saat container start
CMD ["python", "app.py"]
