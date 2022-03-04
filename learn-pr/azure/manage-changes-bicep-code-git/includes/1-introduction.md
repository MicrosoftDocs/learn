As your use of Bicep and infrastructure as code matures, it becomes increasingly important to have a systematic process to manage your files. It's easy to lose track of the changes you make, especially if you have multiple versions of a file in development at the same time. 

You also need to consider how you share your templates with your colleagues, and ensure you have a process to track and communicate your changes. Additionally, when you work with pipelines to deploy your Bicep code, it's essential to keep your templates in a version control system so that the pipeline can access them. 

In this module, you'll learn about the popular version control system called Git.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. You've created Bicep templates and stored them on your own computer. 

You're building such a large collection of templates that you're finding it hard to keep track of things. You've experimented with changes to some of your templates and have multiple copies of files. You even accidentally broke a working template by making a change to it before you went on vacation, and now you can't remember what you changed or how to fix it. 

You feel like there must be a better way to manage your Bicep code. You want to start by improving the way you work with the Bicep files that deploy your company's website.

## What will we be doing?

In this module, you'll create a Git repository and add some of your Bicep files to it. You'll explore some important Git features and see how they can help as you write your Bicep code. You'll also learn about GitHub and Azure Repos, and how publishing your Git repository to one of these services enables you to collaborate with your team.

## What is the main goal?

By the end of this module, you'll have an understanding of what version control and Git can do to help you as you work with Bicep code. You'll be able to use the Visual Studio Code support for Git to initialize a local Git repository, commit files, create branches, and merge branches. Finally, you'll be able to publish a Git repository to GitHub or Azure Repos.

## Prerequisites

You should be familiar with creating basic Bicep templates, including modules.

To follow along with the exercises in the module, you'll need [Visual Studio Code](https://code.visualstudio.com) installed locally.
