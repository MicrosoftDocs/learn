In this exercise, you'll create a GitHub account, create a repository, and create a local copy of the repository on your machine. This unit will set you up nicely for a future exercise where you'll modify your repository files. 

## Create a GitHub account

First, you need an account with GitHub. The following steps guide you in setting up an account.

1. Visit the GitHub website at https://github.com and sign up for a new account.
2. Provide the necessary information, including your username, email address, and password. You might need to verify your email address to create your personal account.
3. Take a moment to customize your profile by adding a profile picture and a brief bio by adding a README file.  

Example of a GitHub profile:

:::image type="content" source="../media/sample-profile.png" alt-text="Screenshot showing an example of a GitHub profile.":::

## Create a repository

To start creating a repository and explore the options for public and private repositories on GitHub:

1. Sign in to GitHub, if you’re not signed in already.

1. Go to your dashboard and select the plus ("+") icon in the upper-right corner.  

    :::image type="content" source="../media/plus-sign.png" alt-text="Screenshot showing where to locate the plus sign to create a repository in GitHub.":::

1. Select **New repository** from the dropdown menu.

    :::image type="content" source="../media/create-repository.png" alt-text="Screenshot showing the new repository button in the GitHub UI.":::

1. Choose a descriptive name for your repository that reflects the project it represents.

    :::image type="content" source="../media/create-new-settings.png" alt-text="Screenshot showing the create a new repository screen with repository name highlighted.":::

1. Determine the visibility of your repository: whether it should be public (visible to anyone) or private (with restricted access for specific collaborators).

1. Optionally, add a description to provide an overview of your project, its purpose, and its key features. Consider adjusting other repository settings based on your requirements, such as including a README file or adding a license.

    :::image type="content" source="../media/read-me-settings.png" alt-text="Screenshot showing additional setting options for a new repository in GitHub, including adding a README file.":::

## Clone a repository

1. On the main page of your GitHub repository, select the green **Code** button.

    :::image type="content" source="../media/fork-step-1.png" alt-text="Screenshot showing where to locate the code button on your new repository's homepage.":::

1. Copy the repository's URL provided in the dropdown menu. You'll use it later to create a local copy of the repository on your machine.

    :::image type="content" source="../media/fork-step-2.png" alt-text="Screenshot showing how to copy the repository URL to your clipboard.":::

1. Open a terminal or Git Bash on your local machine and go to the directory where you want to clone the repository.

1. Use the command `git clone <repository URL>` to clone the repository to your local machine. For example: `git clone https://github.com/your-username/repository-name.git`

Congratulations! You created a GitHub account, set up your profile, created a repository, and cloned the new repository to your local machine. This workflow establishes a solid foundation for collaborating and sharing code effectively using Git and GitHub.
