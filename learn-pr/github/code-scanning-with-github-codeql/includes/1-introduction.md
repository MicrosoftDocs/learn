Code scanning using CodeQL provides an extensible method to automate vulnerability scanning across your organizations GitHub repositories. It's important to understand how the tool works and what its features are so as to best implement code scanning to meet your code's security needs. You'll also need to understand the various configuration options and how to implement and maintain a code-scanning pipeline in order to configure and deploy code scanning correctly.

In this module, we review the CodeQL static-analysis tool and how the code-scanning feature in GitHub uses it to automate vulnerability scanning. We also learn how to customize a code scanning workflow that uses CodeQL, how to include additional queries, and how to adapt your workflow to repositories that have multiple languages.

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
