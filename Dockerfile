# Use Microsoft's official Playwright python image (contains Node.js and all Ubuntu X11 browser dependencies)
FROM mcr.microsoft.com/playwright/python:v1.42.0-jammy

# Install Node.js natively (Robot Framework Browser library uses a Node backend)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs


# Establish isolated workspace
WORKDIR /app

# Install python libraries explicitly
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Initialize Browser library binaries via Node.js
RUN rfbrowser init

# Copy in the rest of the framework codebase (Videos and cache are safely protected by .dockerignore)
COPY . .

# Dictate the default container execution command
CMD ["python", "-m", "robot", "-d", "results", "-v", "HEADLESS:True", "tests/"]
