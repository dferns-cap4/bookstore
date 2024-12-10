# Stage 1: Builder Stage
FROM python:3.10-slim as builder

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy only the requirements to leverage Docker's caching mechanism
COPY requirements.txt .

# Install dependancies to a temporary location
RUN pip install --user --no-cache-dir -r requirements.txt

# Stage 2: Runtime Stage
FROM python:3.10-slim

#Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the application files into the container
COPY . .

# Copy the depencies installed in the builder stage
COPY --from=builder /root/.local /root/.local

# Copy the wait-for-it.sh script from the scripts folder
COPY scripts/wait-for-it.sh /usr/src/app/

# Ensure the script has executable permissions
RUN chmod +x /usr/src/app/wait-for-it.sh

# Update Path to include pip binaries installed in the user's directory
ENV PATH="/root/.local/bin:$PATH"

# Default command to start the app
CMD ["./wait-for-it.sh", "db:5432", "--", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
