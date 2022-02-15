# Title: Code scanning with GitHub CodeQL

The content in this module covers the following learning objectives as defined in the objective domains for the following certifications:

## Resources

- [GitHub Advanced Security objective domain mapping](https://docs.google.com/spreadsheets/d/1LDdYpoCRPYJAT1xSSjJkE8dxqkwiUkBmTVreTDjXWTI/edit#gid=0)
- [Code scanning with GitHub CodeQL](https://docs.google.com/document/d/1YR7C7HEqzAaR2NAq5f4D-Bv4mTRVqYddC46V3L1MBCA)

## Role(s)

- administrator, developer, security-engineer, service-adoption-specialist, technology-manager

## Level/Audiences

- intermediate

## Product(s)

- GHES
- GHEC

## Prerequisites

- Knowledge of GitHub Advanced Security's code scanning feature
- Knowledge of GitHub Actions
- A GitHub enterprise account with a GitHub Advanced Security license
- Necessary permissions to administrate your repository

## Summary

Scan your code for vulnerabilities, errors and weaknesses using CodeQL. CodeQL is a code analysis engine developed by GitHub based on another programming language called QL, which models the data flow in a program to detect conditions like un-sanitized inputs. Understand how QL and CodeQL work. Understand how to leverage CodeQL in a basic code scanning process. Understand also how to use additional configuration options like reusing queries published in different repos.

## Unit outline

1. Introduction
1. What is QL? 
1. What is CodeQL?
1. How does CodeQL analyze code?
1. Code scanning with CodeQL
1. Customizing your code scanning workflow with CodeQL (part 1)
1. Customizing your code scanning workflow with CodeQL (part 2)
1. Using the CodeQL CLI
1. Custom build steps

## Learning objectives

Upon completion of this module, the learner will be able to:

1. Describe the fundamentals of QL and CodeQL.
   
   1. Describe some basic concepts of the *QL* programming language which underlies CodeQL.
   2. Describe some basic concepts of the *CodeQL* code analysis engine.
   3. Describe the default CodeQL query suites.
   4. Describe how CodeQL analyzes code and produces results.

2. Implement code scanning using CodeQL to detect weaknesses and vulnerabilities in code.
   
   3. Introduce a CodeQL analysis workflow to a repository
   4. Configure code scanning within a repository or organization using the default CodeQL workflow.
   5. Contrast the steps to execute code scanning in GitHub Actions vs the CodeQL CLI.
   6. Identify the custom build steps necessary in a CodeQL workflow.
   7. List the locations that CodeQL queries can be specified for use with code scanning
   8. Configure the language matrix in a CodeQL workflow

3. Extend the basic code scanning features using queries and configuration files from different locations.
   
   1. Reference a CodeQL query from a public repository within a code scanning workflow
   2. Reference a CodeQL query from a private repository within a code scanning workflow
   3. Reference a CodeQL query from a local directory within a code scanning workflow
   4. Reference a configuration file within the same repository
   5. Reference a configuration file in a remote public repository

## Personas and objective domains

Targeted personas: developer, security architect, compliance engineer.

As a developer, I would like to use CodeQL to scan for high severity vulnerabilities so that I can remediate them before my code goes to production. I would also like to modify and produce new CodeQL queries to catch more vulnerabilities. [OD tasks: 5.1, 5.4, 5.12]

As a security architect, I would like to scan my company's repositories using CodeQL so that I can administer our vulnerability remediation program and follow up with the developers responsible for the code. [OD tasks: 5.1-5.14]

As a compliance engineer, I would like to scan multiple repositories with CodeQL so that I can ensure that we are adhering to regulations regarding security scanning. [OD tasks:  5.1, 5.5-5.11]

## Chunk your content into subtasks

| Subtask                                                                                        | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet?                                                        | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- | -------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| Describe some basic concepts of the *QL* programming language which underlies CodeQL.          | "need to understand how the feature works"                        | Knowledge check                                          | Describe the fundamentals of QL and CodeQL.                                  | Yes                                                                                                                            |
| Describe some basic concepts of the *CodeQL* code analysis engine.                             | "need to understand how the feature works"                        | Knowledge check                                          |                                                                                                         | Describe the fundamentals of QL and CodeQL.                                                         |
| Describe the default CodeQL query suites.                                                      | "need to understand how the feature works"                        | Knowledge check                                          | Describe the fundamentals of QL and CodeQL.                                  | Yes                                                                                                                            |
| Describe the role of CodeQL as a static analysis tool and how it analyzes code.                | "need to understand the various configuration options"            | Knowledge check                                          | Describe the fundamentals of QL and CodeQL.                                  | Yes                                                                                                                            |
| Introduce a CodeQL analysis workflow to a repository.                                          | "need to understand the various configuration options"            | Knowledge check                                          | Use CodeQL and GitHub code scanning to detect weaknesses and vulnerabilities in code.                   | Yes                                                                                                                            |
| Configure code scanning within a repository or organization using the default CodeQL workflow. | "need to understand the various configuration options"            | Exercise                                                 | Implement code scanning using CodeQL to detect weaknesses and vulnerabilities in code.                  | Yes                                                                                                                            |
| Configure the language matrix in a CodeQL workflow.                                            | "need to understand the various configuration options"            | Exercise                                                 | Implement code scanning using CodeQL to detect weaknesses and vulnerabilities in code.                  | Yes                                                                                                                            |
| Reference a CodeQL query from a public repository within a code scanning workflow.             | "need to understand the various configuration options"            | Knowledge check                                          | Extend the basic code scanning features using queries and configuration files from different locations. | Yes                                                                                                                            |
| Reference a CodeQL query from a private repository within a code scanning workflow.            | "need to understand the various configuration options"            | Knowledge check                                          | Extend the basic code scanning features using queries and configuration files from different locations. | Yes                                                                                                                            |
| Reference a CodeQL query from a local directory within a code scanning workflow                | "need to understand the various configuration options"            | Exercise                                                 | Extend the basic code scanning features using queries and configuration files from different locations. | Yes                                                                                                                            |
| Reference a configuration file within the same repository                                      | "need to understand the various configuration options"            | Knowledge check                                          | Extend the basic code scanning features using queries and configuration files from different locations. | Yes                                                                                                                            |
| Reference a configuration file in a remote public repository                                   | "need to understand the various configuration options"            | Knowledge check                                          | Extend the basic code scanning features using queries and configuration files from different locations. | Yes                                                                                                                            |
| Contrast the steps to execute code scanning in GitHub Actions vs the CodeQL CLI.               | "how to implement and maintain a code scanning pipeline"          | Knowledge check                                          | Implement code scanning using CodeQL to detect weaknesses and vulnerabilities in code.                  | Yes                                                                                                                            |
| Identify the custom build steps necessary in a CodeQL workflow.                                |                                                                   | Knowledge check                                          | Implement code scanning using CodeQL to detect weaknesses and vulnerabilities in code.                  | Yes                                                                                                                            |

## Outline the units

1. **Introduction**

    You are a senior developer at a start-up company specializing in health care software. Your flagship product is a Java based web portal that allows physicians to manage patient records. A recent penetration test of this product revealed a number of serious vulnerabilities that could compromise patient information. The CIO has asked you to implement automated code vulnerability scanning. Because your code is already hosted in a private repository on GitHub, you have decided to use the code scanning feature with CodeQL. You will need to understand how the feature works to persuade other developers and management to use the feature.  You will also need to understand the various configuration options and how to implement and maintain a code scanning pipeline to assist other developers at your company in configuring and deploying code scanning correctly.

1. **Unit: What is CodeQL**

    1. LO1: *Describe come of the basic concepts of the CodeQL code analysis engine*. 
       - [Documentation](https://codeql.github.com/docs/codeql-overview/about-codeql/)
       - Variant analysis
       - CodeQL analysis
       - CodeQL databases
       - Query suites
       - Query packs
    1. LO2: Describe the default CodeQL query suites
        - [Discusses the three default query suites and what is in each one](https://codeql.github.com/codeql-query-help/javascript/)
        - Default query suites: `code-scanning`,`security-extended`,`security-and-quality`
    - **Knowledge check** What types of questions will test *Describe the default CodeQL query suites*?
        - Understand
        - Apply
    - **Knowledge check** What types of questions will test *Describe the fundamentals of the QL and CodeQL programming languages*?
        - Analyze
        - Understand


1. **Unit: How does CodeQL analyze code?**

    1. LO1: *Describe how CodeQL analyzes code and produces results*. 
        - Documentation:
            - [Analysis](https://codeql.github.com/docs/codeql-overview/about-codeql/#codeql-analysis)
            - [Database creation](https://codeql.github.com/docs/codeql-overview/about-codeql/#database-creation)
            - [Query execution](https://codeql.github.com/docs/codeql-overview/about-codeql/#query-execution)
            - [Query results](https://codeql.github.com/docs/codeql-overview/about-codeql/#query-results)

        - "CodeQL analysis consists of three steps: (1) Preparing the code, by creating a CodeQL database (2) Running CodeQL queries against the database (3) Interpreting the query results"
        - "For compiled languages, extraction works by monitoring the normal build process."
        - "For interpreted languages, the extractor runs directly on the source code, resolving dependencies to give an accurate representation of the codebase."
        - "When using CodeQL through GitHub Actions, what source code CodeQL analyzes is either controlled through 1) paths array            configuration file options to restrict analysis to certain source code directories (for non-compiled languages) or 2) build steps in a workflow (for compiled languages)"
        - **Knowledge check** What types of questions will test *learning objective*?
           - Analyze
           - Understand

1. **Unit: What is QL**

    1. LO1: Describe some basic concepts of the *QL* programming language which underlies CodeQL.*.
        - [Documentation](https://codeql.github.com/docs/ql-language-reference/about-the-ql-language/)
        - About query languages and databases
        - Properties of QL
        - QL and object orientation
        - QL vs general purpose programming languages
        - **Knowledge check** What types of questions will test *Describe the fundamentals of the QL and CodeQL programming languages.*?
            - Analyze
            - Understand

1. **Unit: Code Scanning and CodeQL**

    1. LO1: *Introduce a CodeQL analysis workflow on a repository*. 
      - [Setup code scanning using actions](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/setting-up-code-scanning-for-a-repository#setting-up-code-scanning-using-actions)
       - Options for setting up code scanning
       - Setting up code scanning using actions
       - Bulk set up of code scanning
       - **Knowledge check** What types of questions will test *Introduce a CodeQL analysis workflow on a repository*?
           - Apply
           - Analyze
    1. LO2: *Configure code scanning within a repository or organization using the default CodeQL workflow*. 
        - Documentation:
            - [Setup code scanning using actions](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/setting-up-code-scanning-for-a-repository#setting-up-code-scanning-using-actions)
        - Using GitHub actions and a workflow (codeql-analysis.yml)
        - **Exercise** [Exercise - Enable code scanning using codeql](https://github.com/githubtraining/exercise-enable-code-scanning-using-codeql)

1. **Unit: Customizing your code scanning workflow with CodeQL (part 1)**
    1. LO1: *List the locations in which CodeQL queries can be specified for use with code scanning*. 
        - Documentation:
            1. [Editing a workflow](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/configuring-code-scanning#editing-a-code-scanning-workflow), 
            1. [Using a custom config file](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/configuring-code-scanning#using-a-custom-configuration-file).
        - Using a workflow (codeql-analysis.yml)
        - Using a custom configuration file

    1. LO2: *Reference CodeQL queries from a public repo, private repo or local directory within a code scanning workflow*:
        - [Running additional Queries](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/configuring-code-scanning#running-additional-queries)
        - [Packs](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/configuring-code-scanning#using-codeql-query-packs)
        - [Custom configuration files](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/configuring-code-scanning#working-with-custom-configuration-files)
        - import instruction for reusing existing query suite definitions
        - **Exercise - reference a CodeQL Query**
            - List the steps which apply the learning content from previous unit:
                1. Create a copy of the template/exercise repository
                1. configure the CodeQL Init Action in the `.github/workflows/codeQL.yml` workflow to use a custom configuration file as input

1. **Unit: Customizing your code scanning workflow with CodeQL (part 2) .**
    1. LO1: *Reference local and remote configuration files*.
        - [Using a custom configuration file](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/configuring-code-scanning#using-a-custom-configuration-file)
        - use the config-file parameter of the init action to specify a configuration file path
        - use the OWNER/REPOSITORY/FILENAME@BRANCH syntax for external repositories
    1. LO2: Configure the language matrix in a CodeQL workflow
        - [Documentation](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/configuring-code-scanning#changing-the-languages-that-are-analyzed).
        - build matrices
        - the language matrix
        - **Exercise** [Exercise: Configure the language matrix in a CodeQL workflow](https://github.com/githubtraining/exercise-configure-codeql-language-matrix)

1. **Unit: Using the CodeQL CLI**
    1. LO1: *Contrast the steps to execute code scanning in GitHub actions vs the CodeQL CLI*. 
       - [Setting up code scanning using actions](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/setting-up-code-scanning-for-a-repository#setting-up-code-scanning-using-actions)
       - [Generating code scanning results with CodeQL CLI](https://docs.github.com/en/code-security/code-scanning/using-codeql-code-scanning-with-your-existing-ci-system/configuring-codeql-cli-in-your-ci-system#about-`generating-code-scanning-results-with-codeql-cli)
       - You use three different commands to generate results and upload them to GitHub:
           - `database create` to create a CodeQL database to represent the hierarchical structure of each supported programming language in the repository.
           - `database analyze` to run queries to analyze each CodeQL database and summarize the results in a SARIF file.
           - `github upload-results` to upload the resulting SARIF files to GitHub where the results are matched to a branch or pull request and displayed as code scanning alerts.
       - **Knowledge check**
       - What types of questions will test *Contrast the steps to execute code scanning in GitHub actions vs the CodeQL CLI*?
           - Apply
           - Evaluate

1. **Unit: Custom build steps for code scanning with CodeQL**
    1. LO1: Identify the custom build steps necessary in a CodeQL workflow
        - [Configuring code scanning for compiled languages](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/configuring-code-scanning#configuring-code-scanning-for-compiled-languages)
        - For the supported compiled languages, you can use the autobuild action in the CodeQL analysis workflow to build your code. 
        - If the C/C++, C#, or Java code in your repository has a non-standard build process, autobuild may fail. You will need to remove the autobuild step from the workflow, and manually add build steps. 
        - After removing the autobuild step, uncomment the run step and add build commands that are suitable for your repository. The workflow run step runs command-line programs using the operating system's shell. You can modify these commands and add more commands to customize the build process.
        - **Knowledge check** What types of questions will test *Identify the custom build steps necessary in a CodeQL workflow*?
          - Apply
          - Evaluate
