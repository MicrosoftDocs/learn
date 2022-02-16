## Create a pull request to merge the feature branch

Since you are unable to push changes to main directly, you will now try and merge the changes through a pull request.

1. In your browser, navigate to **Repos** > **Files**.

1. Select the **Feature1** branch.

1. You will notice a banner on top indicating there are changes in the feature1 branch and that you can create a pull request for them. Select **Create a pull request**.

1. Take note of the title and the description and the extra info you can indicate. We will leave them as is. Select **Create**.


You just created a pull request. In a team-based context one of your team members will review and approve your pull request so you have an extra set of eyes on it. In this case you will approve your own pull request.

1. Your previous action brought you to the detail screen of your pull request. You can also navigate to this screen through **Repos** > **Pull requests** > and then select the pull request from the list.

1. Select the **Files** tab. This will show you the files that were changed in this pull request.

1. In the **main.bicep** file that was changed on line 34, hover over the line in the right window with the changes, select the **comment** button that appears.

1. In the comment box, type the following text: **Standard service plan not allowed for test environments, change back to the free plan**.

1. Select **Comment**.

1. Navigate back to Visual Studio Code.

1. In the terminal window check out the feature1 branch.

   ```bash
   git checkout feature1
   ```

1. Select the *main.bicep* file in the deploy folder.

1. Change the value of the app service plan on line 34 to F1.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Changed to free plan"
   git push
   ```

1. Navigate back to your pull request in your browser.

1. Select the **Updates** tab. This will show you all updates that happened. You will also see the commit you just added.

1. Select the **Commits** tab. This will show you the commits that happened. Here as well you will see your commit.

1. Select the **Overview** tab. Add a comment: **This looks good. Ok to merge.**. 

1. Select **Approve**.

1. Select **Complete**.

1. In the slide out window, leave all the defaults in place and select **Complete merge**.

1. Navigate to **Repos** > **Commits**. You will notice in the commit history the changes from the feature1 branch were merged into the main branch.

You now can review all changes before they make it into the main branch of your repository. In the next section we will add automatic validation checks to improve your confidence in the changes that were made.
