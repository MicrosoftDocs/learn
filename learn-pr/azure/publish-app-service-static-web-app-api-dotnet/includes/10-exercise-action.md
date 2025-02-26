Your web app and API are both running locally. Now it's time to publish your web app and API to Azure Static Web Apps.

## Push your changes to GitHub

In the previous exercise, you made changes to your API. Now it's time to commit those changes to the **api** branch and push them to GitHub.

## Create a pull request

You pushed your **api** branch to GitHub. Now you want the GitHub Action to publish your web app and API in a preview URL. So your next step is to create a pull request against the **main** branch.

1. Open a browser.

1. Go to your repository:

   `https://github.com/<YOUR_GITHUB_USERNAME>/my-static-blazor-app`

1. Select the **Pull requests** link.

1. Select **New pull request**.

1. Select the **main** branch from the **base** dropdown list.

1. Select the **api** branch from the **compare** dropdown list.

1. Select **Create pull request**.

1. Again, select **Create pull request**.

Your GitHub Action is now triggered.

## Watch the GitHub Action build and publish

You can stay in your browser on your repository and watch the GitHub Action's progress. Follow these steps to view the progress:

1. Select the **Actions** menu.

1. Under the Workflows menu, select the **Azure Static Web Apps CI/CD** workflow item.

1. Select the latest (top) link in the action runs to the right.

1. Select the **Build and Deploy Job** link.

You can see the progress of your GitHub Action as it builds and publishes your web app and API.

## Browse to the preview URL

After the GitHub Action completes successfully, you can view your running app in the browser.

1. Select the **Pull requests** menu.

1. Select your pull request.

1. Select the link following the message **Azure Static Web Apps: Your stage site is ready! Visit it here**.

Notice that the preview URL contains a hyphen followed by a number. The number matches the pull request number for the pull request you created. For every pull request you create, you get a unique and repeatable preview URL. The region is also used to form the preview URL, too.

## Next steps

Congratulations, you created your first Azure Static Web Apps instance with a web app and API! If you merge the pull request you created, Azure Static Web Apps automatically deploys the changes to your production app.
