Continuous security validation should be added at each step from development through production to help ensure the application is always secure.

This approach aims to switch the conversation with the security team from approving each release to consenting to the CI/CD process and monitor and audit the process at any time.

When building green field applications, the diagram below highlights the critical validation points in the CI/CD pipeline.

Depending on your platform and your application's lifecycle, you may gradually implement the tools.

Especially if your product is mature and you haven't previously run any security validation against your site or application.

:::image type="content" source="../media/flowchart-integrated-development-environment-aef25fff.png" alt-text="Flowchart with IDE, and Pull, CI, Dev, and Test. Each node has validation and feedback.":::


## IDE / pull request

Validation in the CI/CD begins before the developer commits their code.

Static code analysis tools in the IDE provide the first line of defense to help ensure that security vulnerabilities aren't introduced into the CI/CD process.

The process for committing code into a central repository should have controls to help prevent security vulnerabilities from being introduced.

Using Git source control in Azure DevOps with branch policies provides a gated commit experience that can provide this validation.

By enabling branch policies on the shared branch, a pull request is required to start the merge process and ensure the execution of all defined controls.

The pull request should require a code review, the one manual but important check for identifying new issues introduced into your code.

Along with this manual check, commits should be linked to work items for auditing why the code change was made and require a continuous integration (CI) build process to succeed before the push can be completed.
