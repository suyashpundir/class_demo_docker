# Use a lightweight official Python image as the base
FROM python:3.11-slim

# Set environment variables for non-buffered output and skipping bytecode creation
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file first to leverage Docker layer caching
COPY requirements.txt .

# Install dependencies, including gunicorn, with no caching to keep the image small
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Expose the port where Gunicorn will listen (internal container port)
EXPOSE 5000

# Command to run the application using Gunicorn, binding to 0.0.0.0 on port 5000.
# 'app:app' means look for the 'app' variable (Flask instance) inside the 'app' module (app.py).
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]
