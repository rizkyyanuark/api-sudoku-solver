FROM python:3.10-slim

ENV PYTHONUNBUFFERED True
ENV APP_HOME /app

# Set working directory
WORKDIR $APP_HOME

# Install necessary libraries
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements.txt and install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY src/ ./src/

# Set the environment variable for the port
ENV PORT 8080

# Expose the port the app runs on
EXPOSE $PORT

# Run the application using gunicorn
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 src.app:app