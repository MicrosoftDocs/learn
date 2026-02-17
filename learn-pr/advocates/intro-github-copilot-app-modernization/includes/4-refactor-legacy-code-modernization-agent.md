Refactoring means restructuring existing code without changing its external behavior. When modernizing an application, a significant part of the work is in the refactoring, which includes making code cleaner, more efficient, and aligned with current standards while ensuring it still passes all tests.

Common refactoring tasks the modernization agent can assist with include:

- **Updating deprecated APIs.** Replacing old library calls or framework APIs with their modern equivalents. For example, replacing Java's javax.\* namespace with jakarta.\* when upgrading to Jakarta EE.
- **Modernizing async patterns.** Converting callback-based code to modern async/await patterns, or upgrading from old HTTP clients (like WebClient) to modern alternatives (like HttpClient).
- **Improving error handling.** Adding structured exception handling, logging, and retry logic where legacy code silently ignored errors.
- **Upgrading framework idioms.** Using newer language features such as Java's var keyword, Streams API, or C#'s pattern matching and nullable reference types.
- **Simplifying configuration.** Migrating from legacy XML configuration to modern annotation-based or code-based configuration.

Unlike the process you use when interacting with GitHub Copilot normally, such as prompting Copilot and reviewing the inline suggestion, the modernization agent takes a systematic approach:

1. **Assessment.** The agent scans your entire project and identifies all locations where deprecated APIs, outdated patterns, or framework-incompatible code exists.
1. **Plan generation.** It produces a detailed plan listing every change needed, organized by priority and dependency order.
1. **Automated transformation.** Using OpenRewrite recipes and AI-powered code generation, the agent applies changes across the codebase—not just one file at a time, but project-wide.
1. **Validation.** After each batch of changes, the agent builds the project, runs tests, and fixes any compilation errors or test failures before moving on.

The GitHub Copilot app modernization agent doesn't wait for you to navigate to each file and write a comments indicating where alterations should occur. The agent identifies all such patterns across the project, applies the transformations, and validates that the build still succeeds.
