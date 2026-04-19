FROM mcr.microsoft.com/playwright:v1.43.0-jammy

# Set work directory
WORKDIR /app

# Copy project files
COPY . .

# Install system dependencies including xvfb for headless display
RUN apt-get update && apt-get install -y \
    python3-pip \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Fix for robot-tests.yml expectations (if needed)
ENV PATH="/home/pwuser/.local/bin:${PATH}"

# Enable Playwright browser headless mode
ENV PLAYWRIGHT_HEADLESS=true

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt && \
    python3 -m textblob.download_corpora lite

# Initialize Playwright
RUN rfbrowser init

# Default command
CMD ["robot", "-d", "results", "tests/"]
