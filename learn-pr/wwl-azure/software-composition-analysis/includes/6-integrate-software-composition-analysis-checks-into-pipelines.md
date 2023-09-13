
Security scanning used to be thought of as an activity that was completed once per release by a dedicated security team whose members had little involvement with other groups.

This practice creates a dangerous pattern in which security specialists find large batches of issues at the exact time when developers are under the most pressure to release a software product.

The pressure often results in software deployment with security vulnerabilities that need to be addressed after a product has been released, integrating scanning into a team's workflow at multiple points along the development path. Secure DevOps can help make all quality-assurance activities, including security, continuous and automated.

## Pull request code scan analysis integration.

DevOps teams can submit proposed changes to an application's (main) codebase using pull requests (PRs). To avoid introducing new issues, developers need to verify the effects of the code changes before creating a PR. A PR is typically made for each small change in a DevOps process. Changes are continuously merged with the main codebase to keep the main codebase up to date. Ideally, a developer should check for security issues before creating a PR.

Azure Marketplace extensions that help integrate scans during PRs include:

 -  [Mend](https://www.mend.io/). Helps validate dependencies with its binary fingerprinting.
 -  [Checkmarx](https://www.checkmarx.com/). Provides an incremental scan of changes.
 -  [Veracode](https://www.veracode.com/). Implements the concept of a developer sandbox.
 -  [Black Duck by Synopsis](https://www.blackducksoftware.com/). An auditing tool for open-source code to help identify, fix, and manage compliance.

These extensions allow developers to experiment with changes before submitting them as a PR.

## Build and release definition code scan, analysis, and integration

Developers need to optimize CI for speed to get immediate feedback about build issues. Code scanning can be performed quickly enough to integrate the CI build definition, preventing a broken build. It enables developers to restore a build's status to ready/ green by fixing potential issues immediately.

At the same time, the CD needs to be thorough. In Azure DevOps, the CD is typically managed through release definitions (which progress the build output across environments) or other build definitions.

Build definitions can be scheduled (daily) or triggered with each commit. In either case, the build definition can do a longer static analysis scan (as illustrated in the following image).

You can scan the complete code project and review any errors or warnings offline without blocking the CI flow.

:::image type="content" source="../media/workflow-diagram-build-definition-7149d684.png" alt-text="Diagram showing a workflow outlining how a build definition can trigger a static analysis scan of source code.":::
