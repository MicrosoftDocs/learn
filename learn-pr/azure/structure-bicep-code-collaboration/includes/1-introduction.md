One of the benefits of deploying your infrastructure as code is that your templates are shareable, allowing you to collaborate on your Bicep code with other team members. It's important to make your Bicep code easy to read and easy to work with. 

In this module, you'll learn some ways to structure and style your Bicep code so that it's easy for others to understand, modify, and deploy.

## Example scenario

Suppose you're an Azure infrastructure administrator at a toy company. You and your team have standardized on using Bicep for your Azure deployments, and you've built a library of reusable templates.

Two members of the quality control team have been tasked to run a customer survey. To accomplish this, they need to deploy a new website and database. They're on a tight deadline, and they want to avoid building a whole new template if they don't have to. After you've spoken with them about their requirements, you remember that you already have a template that's close to what they need.

The template is one of the first Bicep files you wrote, so you're worried that it might not be ready for them to use. The question is, how can you revise the template to ensure that it's correct, easy to understand, easy to read, and easy to modify?

## What will we be doing?

In this module, you'll learn how to improve and refactor Bicep files to make your code easier for others to work with. You'll learn how parameters and names are an important part of making your Bicep code and Azure deployments useful to others. You'll also learn how to define your template structure, follow a consistent style, and add comments that help your colleagues understand how your template works.

## What is the main goal?

By the end of this module, you'll be able to author Bicep templates that are clear, reusable, and well documented.

## Prerequisites

You should be familiar with Bicep structure and syntax, including parameters, loops, conditions, and modules.

To follow along with the exercises in the module, you'll need the following:

- [Visual Studio Code](https://code.visualstudio.com) installed locally
- The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep) installed locally
