When you work on Bicep code, it's important to review and test all your changes. Even when your deployment workflows and processes are designed to detect bugs or problems, it's less time-consuming to find and fix any problems as early as possible. Pull requests provide an opportunity to review your code changes. When you review Azure deployments, it's a good practice not only to validate the code changes, but also to verify that the changes are deployed successfully and function as you expect.

In this module, you'll learn how to add automated checks to your pull request review process. You'll learn how to validate changes to your Bicep code within a pull request, long before it's merged or deployed to a real environment.

You'll also learn how you can automatically deploy your changes to _ephemeral environments_, which are temporary environments where collaborators and reviewers can test the code changes before they're approved and merged into the repository's main branch.

## Example scenario

Suppose you're the Azure administrator at a toy company. You've been working with your website team to create Bicep code that deploys and configures the Azure resources for your website.

Your team is growing, and it's getting more difficult to keep control of all the changes that everyone is making. You recently started to use pull requests to ensure that changes are reviewed before they're merged to the main branch of your project's GitHub repository. Each reviewer validates the Bicep code changes in the pull request, and many reviewers even deploy the changes to a temporary environment so they can try them out.

Your colleagues have told you that the current manual review process is cumbersome and time consuming. It's important that your pull request reviews are easy for everybody on the team, so you decide to automate some of the review process within the pull requests.

You need to make some changes to the configuration of your website, so it's a great opportunity to establish and try out a new process.

## What will you learn?

In this module, you'll learn how you can run automated checks and tests for each pull request to build confidence in the changes to your Bicep code.

You'll configure your pull request workflow to scan your Bicep code against recommended practices by using the Bicep linter. You'll also configure the creation of ephemeral environments for each pull request, which you can use to review the changes to your Azure environment, and automatically delete the environment when the pull request is merged or closed.

## What is the main goal?

After completing this module, you'll be able to add automated checks and validation to your GitHub pull requests for your Bicep code.
