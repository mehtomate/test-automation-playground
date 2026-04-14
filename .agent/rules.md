# Antigravity SDET Best Practices

This document defines the core standards for test automation in this repository. All AI agents (Antigravity) and contributors should strictly adhere to these principles.

## 🏗 Page Object Model (POM)
- **Separation of Concerns**: Strictly separate UI locators and granular interactions from the high-level test logic.
- **Locator Management**: All locators (CSS, XPath, Data-Tests) MUST reside within `resources/PageObjects/` files.
- **Granular Keywords**: Page Objects should provide clean, reusable keywords that abstract away the complexity of the UI.

## 🧪 Declarative Test Design
- **Business Language**: Test cases in the `tests/` directory should read like high-level business requirements or Acceptance Criteria.
- **No Low-Level Logic**: Test suites MUST NOT contain technical logic like loops, `IF/ELSE` blocks, list manipulation, or raw assertions.
- **Abstraction**: If you need to verify a complex state (like a sorted list or a total price calculation), create a high-level keyword in the Page Object instead.

## 🔍 Encapsulated Verification
- **Smart Assertions**: Instead of comparing raw data in the test, use descriptive keywords like `Verify Products Are Sorted By Price Low To High`.
- **Data Parsing**: Logic for parsing strings (e.g., removing currency symbols) belongs in the Page Object or a Library, not the test suite.

## 🛠 Project Standards
- **Naming Conventions**: Use clear, descriptive names for all test cases and keywords (e.g., `Verify User Can...` vs `check_login`).
- **Setup/Teardown**: Leverage `common.resource` for standard suite and context management.
- **No Hardcoded Data**: Use variables for configuration, credentials, and test data wherever possible.

## 🚀 Connectivity Tools (MCP)
- ALWAYS check for linked Notion Requirement pages or GitHub Issues before starting a task.
- When a task is complete, update the relevant issue or requirement status via the available tools.
