## Context
- OS: {{OS}}
- Preferred language for communication: Spanish
- Preferred language for code/comments: English

## General
- Generate comments in code. In Java use Javadoc; in other languages use their standard equivalent (JSDoc, docstrings, etc.).
- All code and comments must be in English.
- Always apply best practices (SOLID, YAGNI, KISS, Design Patterns) and mention which ones are being applied when relevant.
- If it is not clear which framework, library, or architectural style to use, ask before proceeding.
- Follow existing code conventions in the project. If none exist, propose one and ask for approval.

## Error Handling & Logging
- Follow the project's existing error handling and logging style.
- Never swallow exceptions silently. At minimum, log them.
- Prefer custom exceptions over generic ones.
- Exception messages must be groupable: never include dynamic IDs or unique values in the exception message. Use static, categorical messages (e.g., `entity_not_found` instead of `entity_123_not_found`). Dynamic context (IDs, values) goes in the log message, not in the exception.

## Diagrams
- Use Mermaid for all diagrams.
- Use Mermaid skill if installed. If not, recommend installing it before continuing.
- Never use images, ASCII art, or external tools.

## Tests
- After generating code, generate tests covering the changes in their corresponding files.
- Generate both unit tests and integration tests.
- Target 100% coverage on business logic and service layers.
- DTOs, configurations, and trivial code (getters/setters) do not require explicit tests unless they contain logic. If they are not already excluded from the coverage report, suggest excluding them from the coverage configuration.
- Use descriptive test names following: `should_[expectedBehavior]_when_[condition]` or equivalent BDD style.
- Include edge cases and error scenarios, not just happy paths.

## Documentation
- Generate inline documentation in code (Javadoc, JSDoc, docstrings, etc.).
- Generate or update related documentation (README, CONTRIBUTING, CHANGELOG, OpenAPI/Swagger specs, etc.).
- Markdown files must follow standard CommonMark syntax. Use double newline for paragraph separation. Avoid inline HTML (`<br>`) unless strictly necessary (e.g., inside tables).

## Dependencies
- Do not upgrade dependencies without explicit approval.
- If a new dependency is needed, suggest it with a brief justification (why this one over alternatives).

## Git
If the current branch is `main` or `master`, ask if I want to create a fix or a new feature.
- If fix selected: run `git fetch && git pull` (do NOT suppress output), then suggest creating a new branch `hotfix/{{fix-description}}`.
- If feature selected (includes bug fixes): switch to `develop`, run `git fetch && git pull` (do NOT suppress output), then suggest creating a new branch `feature/{{feature-description}}`.

For commit messages, use the `/git.commit-message` skill. If not installed, recommend installing it before committing.

## Plan Mode
- Plans must be in markdown format, multi-phase, with clear deliverables per phase.
- Do not advance to implementation if there is ambiguity. Ask first.
- At the end of each plan, include:
  1. **Unresolved questions** — extremely concise, sacrifice grammar for brevity.
  2. **Assumptions made** — so I can correct them early.
  3. **Risks/trade-offs** — one line each.

## Specifications (SDD Framework)
- **Functional specs**: describe WHAT the system does. No technology, protocol, or implementation details.
- **Technical specs**: describe HOW. Architecture, technologies, protocols, data models, and integration points. Keep it strictly technical.
- If an existing ADR in the ADR folder describes the functionality, reference it in both specs.

## Code Review Mode
- When reviewing code, flag: security issues, performance concerns, readability problems, missing tests, and violations of the conventions above.
- Prioritize findings as: 🔴 Critical, 🟡 Important, 🟢 Suggestion.

## Refactoring
- Never refactor code outside the scope of the current task unless explicitly asked.
- If refactoring is advisable, suggest it but wait for approval.