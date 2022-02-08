## Summary 

This module introduces learners to code scanning and explains how to set up code scanning on a repository using both CodeQL and third party tools. 

## Audiences

- Developers
- Security Personnel
- Compliance and Regulatory Agencies

## Personas and Objective Domains

As a Developer, I want to understand the features of code scanning and how to enable it, so that I can find security vulnerabilities and errors in my repository. 

## Prerequisites

- A GitHub enterprise account with a GitHub Advanced Security license 
- Familiarity with managing GitHub administrative settings 
- Basic knowledge of GitHub Actions 

## Products affected and Versioning

- GHES
- GHEC

## Objective Domains

- #### 4.1 Describe and enable code scanning. 
    - 4.1.1 Describe code scanning. 
    - 4.1.2 List the steps for enabling code scanning in a repository. 
    - 4.1.3 Enable code scanning for use with a CodeQL workflow.
    - 4.1.4 Describe how code scanning relates to GitHub Actions consumption. 
- #### 4.2 Use code scanning with third party tools. 
    - 4.2.1 Enable code scanning for use with a third party analysis, including running code scanning in a container. 
    - (Optional) 4.2.2 Contrast the steps for using CodeQL versus third party analysis when enabling code scanning. 
    - 4.2.3 Contrast how to implement CodeQL analysis in a GitHub Actions workflow versus a third party CI tool. 
- #### 4.3 Configure code scanning. 
   - 4.3.1 Describe how code scanning fits in the SDLC. 
   - 4.3.2 Contrast the frequency of code scanning workflows(scheduled versus triggered by events). 
   - 4.3.3 Choose a triggering event for a given development pattern(for example, in a pull request and for specific files). 
   - 4.3.4 Edit the default template for Actions workflow to fit an active, open source, production repository. 

## Learning Objectives

1. Describe code scanning
2. List the steps for enabling code scanning in a repository
3. List the steps for enabling code scanning with third party analysis
4. Contrast how to implement CodeQL analysis in a GitHub Actions workflow versus a third party CI tool
5. Explain how to configure code scanning on a repository using triggering events
6. Contrast the frequency of code scanning workflows(scheduled vs triggered by events)

## Chunk your content into subtasks

**Identify the subtasks of Configure code scanning on your GitHub repository**

<html>
<body>
<!--StartFragment-->

Subtask | What part of the introduction scenario does this subtask satisfy? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- |
 | Describe and enable code scanning | Knowing how to set up and enable code scanning | 1,2 | Yes |
 | Enable code scanning with third party tools | Knowing how to use code scanning with third party tools, as well as CodeQL  | 3,4 | Yes |
| Configure code scanning | Knowing how to best configure code scanning to save time and effort |  5,6 | Yes |

<!--EndFragment-->
</body>
</html>

## Outline the units

#### 1. Introduction

Imagine that you are a developer with administrator permissions contributing to a GitHub repository for a project. You want to be sure that your code does not contain any security vulnerabilities or errors. Manually verifying this, especially on a large code base, can be very time consuming. Your company has just purchased a GitHub Advanced Security license that will help save time and effort by allowing you to enable and use code scanning. When using code scanning, you will receive alerts indicating any problematic code and can quickly find the problem areas and make the necessary changes. In order to enable code scanning, you will need to know what tools are at your disposal and the features of each. You will also need to understand the best frequency to perform code scanning and the types of events you can use to trigger scans.

  - Learning Objectives
  - Prerequisites

#### 2. What is code scanning?

- Set up code scanning for repositories
- Options for setting up code scanning
- Setting up code scanning using Actions _(Need screenshots to show this process)_
- Billing for Actions
- Bulk set up of code scanning 

#### 3. Enable code scanning with third party tools

- About third party tools 
- Uploading a SARIF file to GitHub
- About SARIF file uploads for code scanning
- Uploading a code scanning analysis with GitHub Actions
- Example workflow for SARIF files generated outside a repository  _(Need screenshot)_
- Example workflow that runs the ESLint analysis tool  _(Need screenshot)_
- About code scanning with CodeQL
- About CodeQL

#### 4. Configure code scanning

- Configure code scanning
- About code scanning configuration
- Editing code scanning workflow _(Need to add screenshots)_
- Configuring frequency
- Scan on Push
- Scan on PR

#### 5. Exercises

#### 6. Knowledge Check

#### 7. Summary


## Knowledge check

What types of questions will test *learning objective*? *[(Knowledge check guidance)](/help/learn/id-guidance-knowledge-check)*

- Question type
- Question type

