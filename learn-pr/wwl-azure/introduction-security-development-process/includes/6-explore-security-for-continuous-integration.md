The CI build should be executed as part of the pull request (PR-CI) process once the merge is complete.

Typically, the primary difference between the two runs is that the PR-CI process doesn't need to do any packaging/staging in the CI build.

These CI builds should run static code analysis tests to ensure that the code follows all rules for both maintenance and security.

Several tools can be used for it:

 -  SonarQube.
 -  Visual Studio Code Analysis and the Roslyn Security Analyzers.
 -  Checkmarx - A Static Application Security Testing (SAST) tool.
 -  BinSkim - A binary static analysis tool that provides security and correctness results for Windows portable executables and many more.

Many of the tools seamlessly integrate into the Azure Pipelines build process. Visit the Visual Studio Marketplace for more information on the integration capabilities of these tools.

Also, to verify code quality with the CI build, two other tedious or ignored validations are scanning third-party packages for vulnerabilities and OSS license usage.

When we ask about third-party package vulnerabilities and licenses, the response is fear or uncertainty.

Those organizations trying to manage third-party packages vulnerabilities or OSS licenses explain that their process is tedious and manual.

Fortunately, a couple of tools by WhiteSource Software can make this identification process almost instantaneous.

In a later module, we'll discuss integrating several helpful and commonly used security and compliance tools.
