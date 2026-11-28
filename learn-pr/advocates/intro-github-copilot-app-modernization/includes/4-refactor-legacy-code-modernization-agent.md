Refactoring means restructuring existing code without changing its external behavior. Modernization includes refactoring, but it can also intentionally change frameworks, authentication, dependencies, and deployment behavior. Identify those changes in the plan rather than assuming that every modernization step is behavior-preserving.

Common refactoring tasks the modernization agent can assist with include:

- **Updating incompatible APIs.** Replace affected enterprise APIs when moving to Jakarta EE 9 or later, for example `javax.servlet` with `jakarta.servlet`. Don't replace every `javax` import: Java SE packages such as `javax.sql` retain their names. Update the corresponding libraries and application server/framework versions together.
- **Modernizing async patterns.** Converting callback-based code to modern async/await patterns, or upgrading from old HTTP clients (like WebClient) to modern alternatives (like HttpClient).
- **Improving error handling.** Review structured exception handling and logging. Retry changes need explicit design: retrying a non-idempotent operation can duplicate work, so don't treat added retries as a behavior-neutral cleanup.
- **Upgrading framework idioms.** Using newer language features such as Java's var keyword, Streams API, or C#'s pattern matching and nullable reference types.
- **Simplifying configuration.** Migrating from legacy XML configuration to modern annotation-based or code-based configuration.

The modernization workflow coordinates project-wide work through a reviewable plan. The stages below describe the work, not guaranteed pauses: some CLI requests proceed automatically or reuse existing assessment and planning artifacts.

1. **Assessment.** The agent analyzes available project code and dependencies to identify likely incompatibilities. Review the report for reflection, generated code, runtime configuration, and other behavior static analysis might miss.
1. **Plan generation.** Review the proposed changes, dependencies, and success criteria. Add application-specific constraints and any missing work.
1. **Transformation.** The agent applies changes across files using the selected scenario's tools. Java workflows can use OpenRewrite recipes alongside AI-assisted changes; don't assume the .NET workflow uses the same engine.
1. **Validation.** Review build results, enabled test runs, and dependency findings. The agent can attempt fixes, but unresolved problems and untested paths remain the developer's responsibility.

You don't need to annotate every file before the agent starts. However, a project-wide transformation or successful build doesn't establish complete coverage. Confirm important behavior with tests and review before merging the changes.
