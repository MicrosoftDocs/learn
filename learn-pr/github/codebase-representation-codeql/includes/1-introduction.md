Imagine that you're a developer with administrator permissions for a GitHub repository. You want to automate security checks. These steps help you analyze your releases for any vulnerabilities. Luckily, your organization purchased and enabled GitHub Advanced Security. Your advanced security license enables you to accomplish these tasks using CodeQL. 

CodeQL enables you to analyze the code in your GitHub repository and identify security vulnerabilities. It's available for public repositories and private repositories owned by your organization. CodeQL supports many languages for analysis including: C/C++, Java, Python, among others.

##  Learning objectives

In this module, we review:

- Installing the CodeQL CLI from the GitHub CodeQL releases page
- Creating a database by using CodeQL to extract a single relational representation of each source file in the codebase
- Running CodeQL in a database to find problems in your source code and find potential security vulnerabilities
- Understanding CodeQL scan results using queries created by GitHub, or your own custom queries

##  Prerequisites

- Basic knowledge of GitHub Actions
- Familiarity with GitHub code scanning
- Administrative access to a repository
- Familiarity with SQL<sup>[1]</sup>, Prolog<sup>[2]</sup>, and Datalog<sup>[3]</sup>
