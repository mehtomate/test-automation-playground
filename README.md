# SauceDemo Test Automation Framework

This repository serves as a portfolio piece demonstrating modern UI Test Automation utilizing the **Robot Framework** and the Playwright-powered **Browser library** using Antigravity IDE Agentic capabilities.

## 🏗 Architecture
This framework is built using the **Page Object Model (POM)** design pattern.
* **`resources/PageObjects/`**: Contains the Page classes/resources. This strictly separates UI locators (CSS/Attributes) and granular interactions from the test logic.
* **`tests/`**: Contains the human-readable test suites. Test cases consist only of high-level business actions, abstracting away the underlying browser automation.

## 🚀 Features & Architecture
- **Page Object Model (POM)**: Tests are strictly separated from UI logic. The Page classes handle locators and actions, while tests handle high-level business scenarios.
- **Dynamic Dockerization**: The entire test suite and Chromium binaries are packaged into a customized Microsoft Playwright Ubuntu Docker Image. Tests run flawlessly across any OS without manual dependency installation.
- **Headless CI/CD Pipeline**: GitHub Actions heavily automates the testing strategy on ever push, leveraging the sealed Docker container to run the suite in complete isolation.
- **Agentic AI Workflow (MCP)**: This repository is uniquely configured to support autonomous Agent connections. Using the Model Context Protocol (MCP), an AI Agent can dynamically read requirements from Notion databases or GitHub Issues and autonomously write new Robot tests leveraging this framework. *(See `mcp_config.example.json` for connectivity patterns).*
- **Failure Evidence Strategy**: The framework automatically spins up HD Video recordings and creates DOM snapshots on test failures without bloated external libraries.

## 🏁 Getting Started

### Prerequisites
- Python 3.8+
- Node.js (Required by Playwright)

### Installation
1. Install the required Python packages:
   ```bash
   pip install robotframework robotframework-browser
   ```
2. Initialize the browser dependencies (downloads the Chromium binaries):
   ```bash
   rfbrowser init
   ```

### Execution
To execute the entire test suite and generate the HTML reports in the `/results` directory:
```bash
robot -d results tests/
```
