Today, developers don't hesitate to use components available in public package sources (such as npm or NuGet).

With faster delivery and better productivity, open-source software (OSS) components are encouraged across many organizations.

However, as the dependency on these third-party OSS components increases, the risk of security vulnerabilities or hidden license requirements also increases compliance issues.

For a business, it's critical, as issues related to compliance, liabilities, and customer personal data can cause many privacy and security concerns.

Identifying such issues early in the release cycle gives you an advanced warning and enough time to fix the problems. Notably, the cost of rectifying issues is lower the earlier the project discovers the problem.

Many tools can scan for these vulnerabilities within the build and release pipelines.

Once the merge is complete, the CI build should execute as part of the pull request (PR-CI) process.

Typically, the primary difference between the two runs is that the PR-CI process doesn't need any packaging/staging in the CI build.

These CI builds should run static code analysis tests to ensure that the code follows all rules for both maintenance and security.

Several tools can be used for it:

 -  SonarQube.
 -  Visual Studio Code Analysis and the Roslyn Security Analyzers.
 -  Checkmarx - A Static Application Security Testing (SAST) tool.
 -  BinSkim - A binary static analysis tool that provides security and correctness results for Windows portable executables and many more.

Many of the tools seamlessly integrate into the Azure Pipelines build process. Visit the Visual Studio Marketplace for more information on the integration capabilities of these tools.

Also, to verify code quality with the CI build, two other tedious or ignored validations are scanning third-party packages for vulnerabilities and OSS license usage.

The response is fear or uncertainty when we ask about third-party package vulnerabilities and licenses.

Organizations trying to manage third-party packages vulnerabilities or OSS licenses explain that their process is tedious and manual.

Fortunately, Mend Software's tools can make this identification process almost instantaneous.

In a later module, we'll discuss integrating several helpful and commonly used security and compliance tools.
