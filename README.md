# SauceDemo Test Automation Framework

This repository serves as a portfolio piece demonstrating modern UI Test Automation utilizing the **Robot Framework** and the Playwright-powered **Browser library** using Antigravity IDE Agentic capabilities.

## 🏗 Architecture
This framework is built using the **Page Object Model (POM)** design pattern.
* **`resources/PageObjects/`**: Contains the Page classes/resources. This strictly separates UI locators (CSS/Attributes) and granular interactions from the test logic.
* **`tests/`**: Contains the human-readable test suites. Test cases consist only of high-level business actions, abstracting away the underlying browser automation.

## 🚀 Features
- **Strict Locator Strategies**: Prioritizes `data-test` attributes for resilience against UI changes.
- **Speed & Reliability**: Built on Playwright (via Robot Framework Browser), ensuring automatic waiting and zero flakiness.
- **Isolated Testing**: Utilizes Browser Contexts (`New Context`) to ensure every test in a suite runs in a completely clean, logged-in state without browser cache contamination.

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
