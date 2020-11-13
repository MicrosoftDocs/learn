After having identified an area where you can contribute, the next step is to prepare your contribution. We'll review here how you can communicate your intent to participate in a project, forge a pull request and improve your chances of getting it accepted.

Communication is a key factor of success here. Even if sometimes it can be more comfortable to work things on your own and just submit the result, that's also taking the risk of working on something already done or not aligning with the project's values or best practices, resulting in a waste of time for everyone.

There are a few steps you can take to reduce the chance of something like this happening. The first rule is to always keep an open mind, be open to feedback, and do not be in a rush. Open source project maintainers most likely have daily jobs too and their own life to care for, so if you don't get an immediate answer on something you ask please be patient.

## Communicating your intent to maintainers

You should always start by communicating your intent to contribute before doing any actual work. Unless it's indicated otherwise in the README, the issue tracker is usually the best place for that.

- If you want to work on an existing issue, check that nobody is assigned to it by looking at the **assignees**. Also check that there's no **linked pull requests**, that would mean somebody is already working on it. Look through the comments to see if someone manifested its interest to work on the issue. If everything's clear, you may post a comment on the issue to indicate your interest to work on it. That way you're making clear to people that may come later that someone's working on it, and if needed maintainers can reply to you with some guidance and advices.

    :::image type="content" source="../media/3-checks.png" alt-text="Screenshot showing the assignees and linked pull request sections":::

- If you want to work on a new feature or a bug that's not already present in the issue tracker, then you should create a new issue. Make sure to follow the issue template if one is proposed, and clearly express your intent to work on the issue. If it's a new feature proposition or if the issue requires a lot of changes, make sure to get the maintainers' approval before moving on to the next step.

## Creating a pull request on a GitHub repository

Great, you've communicated your intent to help the project, you're now ready to start working on your actual contribution.

1. Open the GitHub page of the project you want to contribute.
1. Click on the **Fork** button to create a copy of the repository on your GitHub account. This is necessary as by default your don't have the permissions to make any changes on a public repository, unless it's your own. By forking the project, you're creating a copy on which on can make changes.

    :::image type="content" source="../media/3-fork.png" alt-text="Screenshot showing the fork button of a GitHub project":::

1. Click on the **Code** button to get information on how to clone the git repository on your local machine.

    :::image type="content" source="../media/3-clone.png" alt-text="Screenshot showing the options for cloning a GitHub project":::

1. Click on the clipboard icon to copy the repository URL, then enter in a terminal:

    ```sh
    git clone <REPOSITORY_URL>
    ```

    Alternatively, you can use [GitHub Desktop](https://desktop.github.com/) if you prefer using an application, or [GitHub Codespaces](https://github.com/features/codespaces) if the option is proposed to you.

1. Once the project has finished cloning, enter the project folder:

    ```sh
    cd <PROJECT_FOLDER>
    ```

1. (Optional) Create a new branch using the following command:

    ```sh
    git checkout -b <BRANCH_NAME>
    ```

    This step is not mandatory but highly recommended, it allows you to work on multiple contributions separately, each one using a different branch.

1. Make the desired changes to the project, and commit your changes:

    ```sh
    git add .
    git commit -m "<COMMIT_MESSAGE>"
    ```

    Be sure to describe your changes accurately in the commit message. It's also a good idea to check if there's mentions in CONTRIBUTING file of a commit message convention you need to follow.

1. Push your changes to the remote using the command:

    ```sh
    git push --set-upstream origin <BRANCH_NAME>
    ```

    If you did not create a branch previously, enter only `git push`.

1. Open your project fork on GitHub, and click on the **Compare & pull request** button in the suggestion box that appears.

    :::image type="content" source="../media/3-pr-suggestion.png" alt-text="Screenshot showing the pull request suggestion box on GitHub":::

1. Fill in the title and description, and click on **Create pull request**.

    :::image type="content" source="../media/3-create-pr.png" alt-text="Screenshot showing pull request creation interface":::

    If there's a template for the pull request description, take the time to fill in all required information. If there's not, make sure to provide enough context for maintainers to understand what changes you are proposing and why. You should also link back to the related issue by mentioning it's number using the `#<ISSUE_NUMBER>`. You can find the issue number next to its title.

    :::image type="content" source="../media/3-issue-number.png" alt-text="Screenshot showing issue number":::

## Asking for guidance or reviews on pull requests

If you're unsure about some changes you made and would like to get the maintainers' opinion, the best way to do that is to comment directly on the pull requests. And if you consider your changes a work-in-progress, you also have the option to create a **draft pull request** instead to ask for guidance or help from other contributors.

:::image type="content" source="../media/3-draft-pr.png" alt-text="Screenshot showing the draft pull request option":::

Once the project maintainers comes by your pull request, they can reply to the conversation or directly review your changes. There are multiple possible outcomes following a pull request review:

- Your changes are approved, congratulations!
- You pull request require some changes. Don't get discouraged! Look closely at the feedback provided, if you make the requested changes, there's a good chance that your pull request get accepted. If you push new commits to your branch, the pull request will automatically be updated with the new changes.
- The reviewer made some comments. This usually means that more details are needed about you changes or the motivation behind it.

Remember to always be respectful in all your exchanges, and to act in accordance to the CODE_OF_CONDUCT. It's likely that before your changes can be accepted, there will be an ongoing discussion with the maintainers or other contributors. Contributing to open-source also requires patience, as sometimes you don't get an immediate feedback. Don't reach out to the maintainers privately via email, Twitter or any other means in hope to get a faster answer, this is considered harmful behavior. Discussing things publicly also gives the chance to other contributors or passersby to learn about the process behind the changes and the best practices to follow.
