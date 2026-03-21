# Start from an official Python base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the Python dependencies
RUN pip install -r requirements.txt

# Copy all the rest of the app code into the container
COPY . .

# Tell Docker the app runs on port 5000
EXPOSE 5000

# The command to start the app
CMD ["python", "app.py"]