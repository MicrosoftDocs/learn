One of the benefits of deploying your infrastructure as code is that your templates are shareable, allowing you to collaborate on your Bicep code with other team members. It's important that your Bicep code is easy to read and easy to work with. In this module, you'll learn some ways to structure and style your Bicep code to make it easy for others to understand, modify, and deploy.

## Example scenario

Suppose you work as an Azure infrastructure administrator at a toy company. You and your team have standardized on using Bicep for your Azure deployments, and you've built a library of reusable templates.

A colleague from the quality control team has been tasked to run a customer survey. To accomplish this, they need to deploy a new website and database. They're on a tight deadline so they don't want to build a whole new template if they don't have to. After speaking with them about their requirements, you remember you have a template that is close to what they need.

It's one of the first Bicep files you wrote, so you're worried that it might not be ready for them to use. How can you revise your template to ensure that it's easy to understand, easy to read, and easy to modify?

## What will we be doing?

In this module, you'll learn how to improve and refactor Bicep files to make your code easier for others to work with. You'll learn how parameters and names are an important part of making your Bicep code and Azure deployments useful to others, and you'll learn how to define your template structure, follow a consistent style, and add comments so that your colleagues will be able to understand how your template works.

## What is the main goal?

By the end of this module, you'll be able to author Bicep templates that are clear, reusable, and well-documented.

## Prerequisites

You should be familiar with Bicep structure and syntax, including parameters, loops, conditions, and modules.

To follow along with the exercises in the module, you'll need the following installed locally:
- [Visual Studio Code](https://code.visualstudio.com)
- The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep)
