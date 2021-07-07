Bicep enables you to collaborate effectively as a team. You can define a clear structure, ensure your infrastructure code is documented, and share it in a version control system.

<!-- TODO 

Motivation for IaC is that it's shareable
Part of this is that you need to think about how other people will use your Bicep code
In this module you'll learn about some ways to think about how you structure and style your Bicep code to make it easy for others to understand, deploy, and modify

-->

## Example scenario

Imagine you're working as the Azure administrator in a toy company. You've been asked to help out another team, who is building a website for a new toy. You've worked with Bicep a lot already, so you managed to create a Bicep template and use it to provision all of the resources for the team's website.

So far, you've been working alone, but the project team is growing, and the website is a key part of the team's strategy. You want to ensure new team members can be easily onboarded and can contribute to the project, and even reuse the code for other projects. You've decided to rethink the way you designed, structured, and authored your Bicep code, since you want to enable team collaboration and improve the efficiency of working with the Bicep files.

## What will we be doing?

In this module, you'll be provided with an existing Bicep template that you need to refactor and optimize for team collaboration. You will:

- Break down your Bicep code into reusable modules.
- Define your template structure and authoring style.
- Use comments and other metadata to document your code.
- Enable version control and publish your Bicep code on GitHub.

## What is the main goal?

By the end of this module, you'll be able to author Bicep templates in a way they're modular, reusable, and well documented. You'll also be able to publish your templates on GitHub and enable better collaboration through standard Git-based workflows.

## Prerequisites

You should be familiar with Bicep structure and syntax, including parameters, modules, and conditions.

To follow along with the exercises in the module, you'll need the following installed locally:
- [Visual Studio Code](https://code.visualstudio.com)
- The [Bicep extension for Visual Studio code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep)
