After having identified an area where you can contribute, the next step is to prepare your contribution. We'll review here how you can communicate your intent to participate in a project, forge a pull request, and improve your chances of getting it accepted.

When it comes to contributing work to an open-source project, communication is a key success factor. You may find it uncomfortable to communicate with others on your proposed changes or improvements. Often, this will lead to discussions and compromises of your original vision. However, avoiding active communication with others who are involved in the project means risking your time working on tasks that someone else is already working on, or working on features or improvements that do not align with the project's values or best practices. When this happens, it wastes everyone's time. Conversely, committing to active communication ensures that your work will be well received and impactful.

How can you ensure success when communicating with other project members about new features and changes? First, try to keep an open mind. Be open to feedback, and practice patience. Open-source project maintainers most likely have a day job, and a private life to tend to. If you don't get an answer immediately, wait a little (longer) before pinging the maintainers.

## Communicating your intent to maintainers

You should always start by communicating your intent to contribute before doing any actual work. Unless it's indicated otherwise in the README, the issue tracker is usually the best place for doing that.

- If you want to work on an existing issue, check that nobody is assigned to it by looking at the **assignees**. Also check that there's no **linked pull requests**, that would mean somebody is already working on it. Look through the comments to see if someone manifested their interest to work on the issue. If everything's clear, you may post a comment on the issue to indicate your interest to work on it. That way you're making clear to people that may come later that someone's working on it, and if needed maintainers can reply to you with guidance and advice.

    :::image type="content" source="../media/3-checks.png" alt-text="Screenshot showing the assignees and linked pull request sections":::

- If you want to work on a new feature or a bug that's not already present in the issue tracker, then you should create a new issue. Make sure to follow the issue template if one is proposed, and clearly express your intent to work on the issue. If it's a new feature proposition or if the issue requires many changes, make sure to get the maintainers' approval before moving on to the next step.

## Creating a pull request on a GitHub repository

Once you've communicated your intent to help the project, you're now ready to start working on your actual contribution.

Your contribution will take the form of a *Pull Request* or *PR*. A pull request is special place on GitHub that contains a few things:

- A title and description for your changes.
- One or more commits that constitutes the changes you're proposing.
- Comments where everyone can participate to discuss about the changes.
- Code reviews where you can find detailed feedback on your changes and eventually commit suggestions.
- Status checks, coming for example from automated tests that the maintainers may have put in place. They can serve different purposes, for example to ensure that your changes follow the project's rules or that your change don't break the code.

After a pull request is created, it can be updated with new commits, comments or code reviews until the project maintainers take the final decision to approve and merge the pull request, or reject the changes and close the pull request. When you pull request is merged, it means that your changes have been integrated in the project's codebase.

### Creating a pull request step by step

1. Open the GitHub page of the project you want to contribute.
1. Click on the **Fork** button to create a copy of the repository on your GitHub account. This step is necessary as by default you don't have the permissions to make any changes on a public repository, unless it's your own (copy). By forking the project, you're creating a copy to which you can make changes.

    :::image type="content" source="../media/3-fork.png" alt-text="Screenshot showing the fork button of a GitHub project":::

1. Click on the **Code** button to get information on how to "clone" the git repository to your local machine.

    :::image type="content" source="../media/3-clone.png" alt-text="Screenshot showing the options for cloning a GitHub project":::

1. Click on the clipboard icon to copy the repository URL, then enter in a terminal:

    ```sh
    git clone <REPOSITORY_URL>
    ```

    This command will create a copy of the repository on your local machine.

    Alternatively, you can use [GitHub Desktop](https://desktop.github.com/) if you prefer using an application, or [GitHub Codespaces](https://github.com/features/codespaces) if the option is proposed to you. If you're a VS Code user, Codespaces will feel familiar to you.

1. Once the project has finished cloning, enter the project folder:

    ```sh
    cd <PROJECT_FOLDER>
    ```

1. (Optional) Create a new branch using the following command:

    ```sh
    git checkout -b <BRANCH_NAME>
    ```

    This step isn't mandatory but highly recommended, it allows you to work on multiple contributions separately, each one using a different branch.

1. Make the wanted changes to the project, and commit them:

    ```sh
    git add .
    git commit -m "<COMMIT_MESSAGE>"
    ```

    These commands will stage your changes for commit, then create a commit with the specified message. Be sure to describe your changes accurately in the commit message. It's also a good idea to check if there are mentions in CONTRIBUTING file of a commit message convention you need to follow.

1. Push your changes to the remote using the command:

    ```sh
    git push --set-upstream origin <BRANCH_NAME>
    ```

    This command will create a new branch on the upstream repository on GitHub (your fork), and push all your commits to it.

    > [!NOTE]
    > When we talk about *upstream* repository, we refer to the remote repository linked to your local repository. `origin` is the default alias for the repository URL, created by git in the step 1.

    If you didn't create a branch previously, enter only `git push`.

1. Open your project fork on GitHub, and click on the **Compare & pull request** button in the suggestion box that appears.

    :::image type="content" source="../media/3-pr-suggestion.png" alt-text="Screenshot showing the pull request suggestion box on GitHub":::

1. Fill in the title and description, and click on **Create pull request**.

    :::image type="content" source="../media/3-create-pr.png" alt-text="Screenshot showing pull request creation interface":::

    If there's a template for the pull request description, take the time to fill in all required information. If there isn't now, make sure to provide enough context for maintainers to understand what changes you're proposing and why. You should also link back to the related issue by mentioning its number using the `#<ISSUE_NUMBER>`. You can find the issue number next to its title.

    :::image type="content" source="../media/3-issue-number.png" alt-text="Screenshot showing issue number":::

## Passing the status checks

After you've created the pull request, you may see a section with status checks at the bottom, like this:

:::image type="content" source="../media/3-pr-checks.png" alt-text="Screenshot showing status checks results on a pull request":::

These are automated checks that the maintainers have put in place to ensure a consistent quality of the project.

To get your pull request accepted, it needs to pass all automated checks. If one is failing like in the screenshot above, you can click on the **Details** button to learn more about the failure, to find out what you need to fix it.

If you're unsure about what to do with a failing check, you can always use the comments to ask for the maintainers guidance or help to fix it.

## Asking for guidance or reviews on pull requests

If you're unsure about some changes you made and would like to get the maintainers' opinion, the best way to do that is to comment directly on the pull request(s). And if you consider your changes a work-in-progress, you also have the option to create a **draft pull request** instead to ask for guidance or help from other contributors.

:::image type="content" source="../media/3-draft-pr.png" alt-text="Screenshot showing the draft pull request option":::

Once the project maintainers come by your pull request, they can reply to the conversation or directly review your changes. There are multiple possible outcomes following a pull request review:

- Your changes are approved, congratulations!
- You pull request requires some changes. Don't get discouraged! Look closely at the feedback provided, if you make the requested changes, there's a good chance that your pull request get accepted. If you push new commits to your branch, the pull request will automatically update with the new changes.
- The reviewer made some comments. It usually means that more details are needed about you changes or the motivation behind it.

### Responding to comments on your pull request

Remember to always be respectful in all your exchanges, and to act in accordance to the CODE_OF_CONDUCT. It's likely that before your changes can be accepted, there will be an ongoing discussion with the maintainers or other contributors. Contributing to open source requires patience, sometimes you don't get immediate feedback. Don't reach out to the maintainers privately via email, Twitter or any other means hoping to get a faster answer, this is considered harmful behavior. Discussing things publicly also gives the chance to other contributors or passersby to learn about the process behind the changes and the best practices to follow.
