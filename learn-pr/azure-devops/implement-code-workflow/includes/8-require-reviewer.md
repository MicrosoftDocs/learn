In this unit, you'll set up a rule on GitHub that requires a reviewer to approve changes before they can be merged into the `main` branch. As a bonus, you'll also fix the typing error on the *Space Game* website's home page.

Currently, the team allows anyone who makes a pull request to merge the code into the `main` branch. Because no review is required, it's possible for incorrect or unstable code to creep in.

Andy decides that he wants to add a check to the pull request in the form of another pair of eyes. He wants to set up GitHub to require someone other than the pull request author to review the code before it's merged. Let's see how to do this.

Andy heads off to find Mara and spots her at her desk working away, her head bobbing to the music in her earbuds.

**Andy:** Mara, I've been meaning to talk to you about something.

Mara looks up.

**Mara:** What can I help you with?

**Andy:** Several small mistakes are making it through the build. Just today, a typing error showed up on the home page. Amita is spending too much time on these things. We need to stop them before they make it to the `main` branch. We need another pair of eyes on the code before the pull request is approved.

**Mara:** I can set that up. In GitHub, there's a way to make sure that no pull request is merged before someone else reviews and approves it.

## Set up approvals

In this section, you'll set up a rule on GitHub that requires at least one reviewer to approve a pull request before it can be merged into the `main` branch. You'll then verify that the rule works by pushing up a fix to the typing error that Mara made earlier.

### Add the rule

1. In GitHub, go to your _Space Game_ project repository.
1. Select the **Settings** tab near the top of the page.
1. On the left menu, select **Branches**.
1. Make sure that **main** is selected as your default branch.
1. Select **Add branch protection rule**.
1. Under **Branch name pattern**, enter **main**.
1. Select the **Require a pull request before merging** check box.
1. Select the **Require approvals** check box.
1. Keep the **Required approving reviews** value at **1**.
1. Select **Create**.
1. Select **Save changes**.

> [!NOTE]
> At the bottom of the list of choices is an option named **Include Administrators**. This option requires repository administrators to follow the rule. You don't set that, because you're an administrator of your repository and there isn't another reviewer. In this unit, for learning purposes, you review and approve your own pull requests.

### Submit the fix

In this section, you submit a fix to the typing error on the home page. Remember that the word "official" is mistyped as "oficial".

 :::image type="content" source="../media/5-web-site-revised-text.png" alt-text="Screenshot of the Space Game website showing a typing error.":::

1. In Visual Studio Code, go to the terminal.
1. To check out the `main` branch, run `git checkout`:

    ```bash
    git checkout main
    ```

1. To pull down the latest changes to the `main` branch from GitHub, run `git pull`:

    ```bash
    git pull origin main
    ```

    You can see that two files are updated:

    * **README.md**: Contains the Markdown code for displaying the build badge.
    * **Index.cshtml**: Contains the updated home page text, which includes the typing error.

1. To fix the error, create and check out a branch:

    ```bash
    git checkout -B bugfix/home-page-typo
    ```

1. In File Explorer, open **Index.cshtml**.
1. Locate the error:

    ```html
    <p>Welcome to the oficial Space Game site!</p>
    ```

1. Change the line to correct the error:

    ```html
    <p>Welcome to the official Space Game site!</p>
    ```

1. Save the file.
1. In the terminal, stage and commit the change:

    ```bash
    git status
    git add Tailspin.SpaceGame.Web/Views/Home/Index.cshtml
    git commit -m "Fix typing error on the home page"
    ```

    In practice, you'd ordinarily build and run the site locally to verify the change. In this unit, for the sake of brevity, let's skip that step.
1. Push the branch to GitHub.

    ```bash
    git push origin bugfix/home-page-typo
    ```

### Test the rule

1. In GitHub, locate and select the `bugfix/home-page-typo` branch.

    :::image type="content" source="../media/8-github-recent-branch.png" alt-text="Screenshot of GitHub showing the recently pushed branch.":::

1. To start your pull request, select **Contribute** and then **Open pull request**.
1. Set your forked repository as the base repository.

    :::image type="content" source="../media/8-github-set-base.png" alt-text="Screenshot of GitHub confirming that the branch can be merged.":::

1. Select **Create pull request**.

    You can see that a human review is required before you can merge the change.

    :::image type="content" source="../media/8-github-review-required.png" alt-text="Screenshot of a pull request on GitHub showing that a review is required in order to merge.":::

    In practice, you'd assign a team member to review your change. In this unit, you can merge your own pull request for learning purposes.

1. Select the **Merge without waiting for requirements to be met (bypass branch protections)** check box, and then select **Merge pull request**.
1. Select **Confirm merge**.

   Your change is merged.
1. To delete the `bugfix/home-page-typo` branch, select **Delete branch**.
