As your use of Bicep and infrastructure as code matures, it becomes increasingly important to have a systematic process to manage your files. It's easy to lose track of the changes you make, especially if you have multiple versions of a file in development at the same time. When you work with pipelines to deploy your Bicep code, it's essential to keep your templates in a version control system so that the pipeline can access them. In this module, you'll learn about Git, which is a popular version control system.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. You've created a number of Bicep templates, which you've stored on your own computer. But now you're building up such a large collection of templates, you're finding it hard to keep track of things. You've experimented with changes to some of your templates and have got multiple copies of files. You even accidentally broke a working template by making a change to it before you went on vacation, and now you can't remember what you changed or how to fix it. You feel like there must be a better way to manage your Bicep code.

## What will we be doing?

In this module, you'll create a Git repository and add some of your Bicep files to it. You'll explore some of important Git features, like commits, branches, and merges, and see how they can help as you write your Bicep code.

## What is the main goal?

By the end of this module, you'll have an understanding of what version control and Git can do to help you as you work with Bicep code. You'll be able to use the Visual Studio Code support for Git to initialize a local Git repository, commit files, create branches, and merge branches.

## Prerequisites

You should have:

- Familiarity with the basic Bicep template structure and syntax, including modules.
- Familiarity with Azure, including the Azure portal, subscriptions, resource groups, and resource definitions.
