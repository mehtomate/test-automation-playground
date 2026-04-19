# Autonomous Quality Governance & Alignment Standards

This document establishes the authoritative standards for Quality Engineering in this ecosystem. To ensure enterprise-grade scalability and AI-native consistency, all agents and contributors must adhere to these directives.

## 🏗 Modular Architecture (POM)
- **Domain Separation**: Strictly decouple UI technical implementations (Locators) from business process logic (Keywords).
- **Locator Strategy**: Prioritize `data-test` and `aria-label` attributes to ensure robust automation that survives front-end refactoring.
- **Encapsulation**: Keywords must abstract complexity, providing a clean interface for "human-in-the-loop" review.

## 🧪 Declarative Quality design
- **Business Alignment**: Test specifications must mirror high-level requirements or Acceptance Criteria. Avoid technical implementation details in test suites.
- **Logic-Less Suites**: Test files should be purely declarative. Logic, transformations, and assertions must be encapsulated within Resource or Library layers.
- **Data-Driven Execution**: Leverage Robot Framework templates for comprehensive coverage without code duplication.

## 🔍 Heuristic Verification & Evidence
- **Smart Assertions**: Use descriptive, state-based verification keywords (e.g., `Verify Sorting Order Is High To Low`) rather than generic comparisons.
- **Traceability**: Every check must generate evidentiary artifacts (Video, Screenshots, Logs) to support autonomous triage.

## 🚀 Agentic Operations & MCP
- **Requirement-First Ingestion**: Agents MUST utilize MCP connections to synchronize with the current "Source of Truth" (Notion/GitHub) before generating code.
- **Autonomous Compliance**: Code generation MUST pass local linting and execution checks before being proposed for merging.

## 🛠 Project Health & Maintenance
- **Naming Protocol**: Use industry-standard descriptive naming (e.g., `Verify User Navigation Flow`).
- **Standardized Setup**: Leverage `common.resource` for global context management.
- **Variable Management**: Zero hardcoding. Configuration and environment states must be managed via variables.
