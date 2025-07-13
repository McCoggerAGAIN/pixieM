FROM python:3.10-slim-buster

# Set the working directory in the container to /app
WORKDIR /app

# Install git
RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|http://deb.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    apt-get update && apt-get install -y git


# Clone the repository
RUN git clone https://github.com/McCoggerAGAIN/pixieM .

# Copy the local config.json file to the container

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt


EXPOSE 8888

# Run run.py when the container launches
CMD ["uvicorn", "run:main_app", "--host", "0.0.0.0", "--port", "8888", "--workers", "4"]
