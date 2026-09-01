GitHub Agentic Workflows enable AI-powered automation in GitHub repositories. In this exercise, you'll install GitHub Agentic Workflows, author an agentic workflow in Markdown, and run it to propose updates to Mona's GitHub Info website.

The workflow uses Mona's notes, the GitHub Blog, and the GitHub Changelog to draft current website updates. The proposed changes are submitted through a pull request so they can be reviewed before they are merged.

## Who is this for?

This exercise is for developers, DevOps engineers, and anyone curious about AI-powered automation in GitHub repositories.

## What you'll learn

By completing this exercise, you'll learn how to:

- Install the `gh aw` extension.
- Set up GitHub Agentic Workflows in a repository.
- Author an agentic workflow using Markdown.
- Define instructions, inputs, and outputs for an AI-powered workflow.
- Run an agentic workflow from a GitHub repository.
- Inspect proposed changes in a pull request.
- Use pull requests to review AI-generated updates before merging them.

## What you'll build

You'll build the following repository-level automation:

- GitHub Agentic Workflows setup files.
- An agentic workflow written in Markdown.
- A workflow that drafts updates to Mona's GitHub Info website.
- A pull request containing the proposed website changes.

The workflow gathers information from:

- Mona's notes.
- The GitHub Blog.
- The GitHub Changelog.

## Prerequisites

Before you begin, make sure you have:

- A GitHub account with access to GitHub Copilot.
- A public copy of the exercise repository.
- Basic familiarity with GitHub repositories, branches, and pull requests.
- Comfort editing YAML and Markdown files.

This exercise takes less than 45 minutes to complete.

> [!IMPORTANT]
> This exercise is designed for public repository copies. If you copy the exercise as a private repository, token setup may require additional account or organization policy configuration.

## Instructions

1. Select the **Start the exercise on GitHub** button at the bottom of this page. It takes you to the public GitHub template repository for the Agentic Workflows exercise.

1. Select the **Start course** button or use the **Use this template** feature in the template repository. This action prompts you to create a new repository.

   Use a public repository copy for the best exercise experience. Private repositories may require additional token, account, or organization policy configuration.

1. After you create your repository from the template, wait about 20 seconds and refresh the page so that the first lesson can be prepared.

1. Open the repository in GitHub Codespaces or use a local development environment with the GitHub CLI installed.

1. Install the GitHub Agentic Workflows extension by following the instructions provided in the exercise repository.

   Confirm that the `gh aw` extension is available and that the repository setup commands complete successfully.

1. Create the repository setup for GitHub Agentic Workflows.

   Review the generated configuration files and confirm that they contain the expected workflow and permissions setup.

1. Create a branch for the repository setup changes.

1. Commit the setup changes and open a pull request.

1. Review the setup pull request, then merge it into the repository's `main` branch.

   The agentic workflow should run from the configured repository setup on the default branch.

1. Create an agentic workflow in Markdown.

   The workflow should instruct GitHub Agentic Workflows to:

   - Read Mona's notes.
   - Review recent information from the GitHub Blog.
   - Review recent information from the GitHub Changelog.
   - Identify relevant updates for Mona's GitHub Info website.
   - Draft appropriate website changes.
   - Open a pull request containing the proposed changes.
   - Include a clear summary of the sources and updates used.

1. Review the workflow instructions and confirm that the workflow clearly defines:

   - Its purpose.
   - The files it can modify.
   - The sources it should consult.
   - The expected format of its proposed changes.
   - The review process for generated updates.

1. Commit the agentic workflow to the repository.

1. Run the workflow using the GitHub CLI and the instructions in the exercise repository.

1. Wait for the workflow to complete, then inspect the pull request it creates for Mona.

1. Review the pull request.

   Check that:

   - The pull request was created by the agentic workflow.
   - The proposed changes are limited to the intended website files.
   - The updates are relevant to Mona's GitHub Info website.
   - The workflow used Mona's notes, the GitHub Blog, and the GitHub Changelog.
   - The pull request includes a useful summary of the proposed changes.
   - The changes are suitable for human review before merging.

1. Make any necessary improvements to the workflow or proposed changes.

1. Commit your final updates and leave the generated pull request open for review, unless the exercise instructions specify otherwise.

## Expected outcome

When you finish the exercise, your repository should include:

- GitHub Agentic Workflows repository setup.
- A working agentic workflow written in Markdown.
- A workflow capable of drafting updates to Mona's GitHub Info website.
- A pull request containing proposed website updates.
- A clear summary of the sources and reasoning used by the workflow.

## How to start this exercise

Simply copy the exercise to your account, give your favorite Octocat, Mona, about 20 seconds to prepare the first lesson, and then refresh the page.

When you finish the exercise, return to this module for:

> [!div class="checklist"]
> - A quick knowledge check.
> - A summary of what you learned.
> - A badge for completing this module.

> [!div class="nextstepaction"]
> [Start the exercise on GitHub](https://github.com/skills/agentic-workflows-that-read-the-room)
