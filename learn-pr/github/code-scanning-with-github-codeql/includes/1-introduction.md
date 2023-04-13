Code scanning using CodeQL provides an extensible method to automate vulnerability scanning across your organizations GitHub repositories.

Imagine that you're a senior developer at a startup company specializing in health care software. Your flagship product is a Java-based web portal that allows physicians to manage patient records. A recent penetration test of this product revealed a number of serious vulnerabilities that could compromise patient information. The CIO has asked you to implement automated code-vulnerability scanning. Because your code is already hosted in a private repository on GitHub, you've decided to use the code-scanning feature with CodeQL. You'll need to understand how the feature works to persuade other developers and management to use the feature. You'll also need to understand the various configuration options and how to implement and maintain a code-scanning pipeline to assist other developers at your company in configuring and deploying code scanning correctly.

In this module, you'll learn about the CodeQL static-analysis tool and how the code-scanning feature in GitHub uses it to automate vulnerability scanning. You'll also learn how to customize a code scanning workflow that uses CodeQL, how to include additional queries, and how to adapt your workflow to repositories that have multiple languages.

## Learning objectives

By the end of this module, you'll be able to:

* Understand CodeQL and how it analyzes code.
* Understand QL, a unique logic programming language.
* Set up CodeQL based code scanning in a GitHub repository.
* Reference a custom CodeQL query.
* Configure the language matrix in a CodeQL workflow.
* Learn how to use the CodeQL CLI to generate code scanning results and upload them to GitHub.
* Implement custom build steps.

## Prerequisites

* A GitHub enterprise account with a GitHub Advanced Security license
* Necessary permissions to administrate your repository
* Knowledge of GitHub Advanced Security's code scanning feature
* Knowledge of GitHub Actions
