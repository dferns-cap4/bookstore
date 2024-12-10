FROM python:3.10-slim
# Set a directory for the app
WORKDIR /usr/src/app
# Copy all the files to the container
COPY . .
# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt
# Define The port number the container should expose
EXPOSE 8000
# Run the FastAPI project
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]