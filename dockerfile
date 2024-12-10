# Example Dockerfile
FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the application files into the container
COPY . .

# Copy the wait-for-it.sh script from the scripts folder
COPY scripts/wait-for-it.sh /usr/src/app/

# Ensure the script has executable permissions
RUN chmod +x /usr/src/app/wait-for-it.sh

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Default command to start the app
CMD ["./wait-for-it.sh", "db:5432", "--", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
