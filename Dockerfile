# Gunakan base image Python yang ringan
FROM python:3.10-slim

# Install dependencies sistem yang diperlukan OpenCV & Mediapipe
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 libglib2.0-0 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Buat direktori kerja
WORKDIR /app

# Salin semua file proyek ke dalam container
COPY . .

# Install dependensi Python
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Expose port yang digunakan Railway/Heroku
EXPOSE 8080

# Jalankan aplikasi menggunakan gunicorn
CMD ["gunicorn", "App:app", "--bind", "0.0.0.0:8080"]
