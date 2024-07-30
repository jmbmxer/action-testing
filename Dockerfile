# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir flask

# Create a simple Flask app
RUN echo "from flask import Flask\n\
app = Flask(__name__)\n\
\n\
@app.route('/')\n\
def hello():\n\
    return 'Hello, World!'\n\
\n\
@app.route('/test')\n\
def test():\n\
    return 'This is a test endpoint'\n\
\n\
if __name__ == '__main__':\n\
    app.run(host='0.0.0.0', port=8080)" > app.py

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python", "app.py"]