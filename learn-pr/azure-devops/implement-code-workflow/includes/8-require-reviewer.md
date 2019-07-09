In this part, you'll set up a rule on GitHub that requires a reviewer to approve changes before those changes can be merged into the `master` branch. As a bonus, you'll fix the spelling error on the _Space Game_ web site's home page.

Currently, the team allows anyone who makes a pull request to merge the code into the `master` branch. Since there's no review required, it's possible for incorrect or unstable code to creep in.

Andy decides that he wants to add a check to the pull request in the form of another pair of eyes. He wants to set up GitHub to require someone else to review the code before it's merged. Let's see how to do this.

Andy heads off to find Mara and spots her at her desk working away, her head bobbing to the music in her earbuds.

**Andy**: Mara, I've been meaning to talk to you about something.

Mara looks up.

**Mara**: What can I help you with?

**Andy**: Several small mistakes are making it through the build. Just today, a spelling error showed up on the home page. Amita is spending too much time on these things. We need to stop them before they make it to the `master` branch. We need another pair of eyes on the code before the pull request is approved.

**Mara**: I can set that up. In GitHub, there's a way to make sure no pull request is approved before someone else reviews it.

## Set up approvals

Here, you'll set up a rule on GitHub that requires at least one reviewer before a pull request can be merged into the `master` branch. You'll set up the rule and then verify that it works by pushing up a fix to the typing error Mara made earlier.

### Add the rule

1. From GitHub, navigate to your _Space Game_ project's repository.
1. Click the **Settings** tab near the top of the page.
1. From the menu, click **Branches**.
1. Make sure that **master** is chosen as your default branch.
1. Click the **Add rule** button.
1. Under **Branch name pattern**, enter "master".
1. Check the box that reads **Require pull request reviews before merging**.
1. Keep **Required approving reviews** at **1**.
1. Click the **Create** button to create the rule in the master branch.
1. Click **Save changes**.

> [!NOTE]
> At the bottom of the list of choices is an option named **Include Administrators**. This option requires Administrators of the repository to follow the rule. You didn't set that because you are an Administrator of your repository and we don't have another reviewer. For learning purposes, you'll review and approve your own pull requests.

### Submit the fix

Here you'll submit a fix to the typing error on the home page. Recall that the word "official" is misspelled.

![The Space Game web site showing a typing error](../media/5-web-site-revised-text.png)

1. From Visual Studio Code, navigate to the terminal.
1. Run `git checkout` to checkout the `master` branch.

    ```bash
    git checkout master
    ```
1. Run `git pull` to pull down changes the latest changes to the `master` branch from GitHub.

    ```bash
    git pull origin master
    ```

    You see that two files are updated:

    * **README.md** &mdash; this file contains the Markdown code to display the build badge.
    * **Index.cshtml** &mdash; this file contains the updated home page text, which includes a typing error.

1. Create and checkout a branch to fix the typing error on the home page, `Index.cshtml`.

    ```bash
    git checkout -b bugfix/home-page-typo
    ```
1. From the file explorer, open **Index.cshtml**.
1. Locate the spelling mistake.

    ```html
    <p>Welcome to the oficial Space Game site!</p>
    ```
1. Change the line to correct the spelling mistake.

    ```html
    <p>Welcome to the official Space Game site!</p>
    ```
1. Save the file.
1. From the terminal, stage and commit the change.

    ```bash
    git status
    git add "Tailspin.SpaceGame.Web/Views/Home/Index.cshtml"
    git commit -m "Fix typing error on the home page"
    ```

    In practice, you would typically build and run the site locally to verify the change. Here, we omit that step for brevity.
1. Push the branch to GitHub.
    ```bash
    git push origin bugfix/home-page-typo
    ```

### Test the rule

1. From GitHub, locate the `bugfix/home-page-typo` branch.

    ![GitHub showing the recently pushed branch](../media/8-github-recent-branch.png)

1. Click the **Compare and pull request** button to create a pull request.
1. Set your forked repository as the base repository.
1. Click **Create pull request**.

    You see that a human review is required before you can merge the change.

    ![A pull request on GitHub showing that a review is required](../media/8-github-review-required.png)

    In practice, you would assign a team member to review your change. For learning purposes, here you'll merge your own pull request.

1. Click the **Merge pull request** button to merge the pull request.
1. Check the box that reads **Use your Administrator privileges to merge this pull request**. Then click **Confirm merge**.
1. Click **Delete branch** to delete the `bugfix/home-page-typo` branch. Your change is merged.

## Revert your master branch to its original state

In future modules, you'll continue working with the Tailspin team and the _Space Game_ web site. To limit each module to just the new concepts, you'll base new work on the original `master` branch that came with your fork of the _Space Game_ repository on GitHub.

To ensure that the branches you create later will properly integrate with the `master` branch, here you'll reset your GitHub repository's `master` branch to its original state.

> [!WARNING]
> The process you'll follow here involves temporarily deleting the branch protection rule you set up earlier, fetching the `master` branch from Microsoft's repository, and then performing a _force push_ of that branch to your repository.
>
> Although we typically don't recommend that you force push changes, here you'll do so to reset the state of your GitHub repository. In practice, there are safer ways to [revert changes through Git](https://github.blog/2015-06-08-how-to-undo-almost-anything-with-git?azure-portal=true).

1. Delete the branch protection rule you set up earlier. To do so:

    1. From GitHub, navigate to your _Space Game_ project's repository.
    1. Click the **Settings** tab near the top of the page.
    1. From the menu, click **Branches**.
    1. Under **Branch protection rules**, locate the rule named "master" that you set up earlier in this part.
    1. Click **Edit**.
    1. Uncheck the box that reads **Require pull request reviews before merging**.
    1. Click **Save changes**.

1. From Visual Studio Code, navigate to the integrated terminal. Then run these commands.

    ```bash
    git checkout master
    git reset --hard upstream/master --
    git push -f origin master
    ```

1. From the **Settings** tab in your GitHub repository, recreate the branch protection rule you set up earlier in this part.