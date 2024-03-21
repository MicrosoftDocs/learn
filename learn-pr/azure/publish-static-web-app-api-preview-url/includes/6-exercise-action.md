Your web app and API are both running locally. Now it's time to publish your web app and API to Azure Static Web Apps.

## Push your changes to GitHub

You made changes to your API in the previous exercise. Commit those changes to the **api** branch and push them to GitHub by following these steps:

1. In Visual Studio Code, open the command palette by pressing <kbd>F1</kbd>
1. Type and select **Git: Commit All**. If Visual Studio Code prompts you to automatically stage all of your changes and commit them directly, select **Yes**.
1. Enter a commit message such as **api changes**
1. Open the command palette by pressing <kbd>F1</kbd>
1. Type and select **Git: Push**
1. If you're prompted with the message **The branch 'api' has no upstream branch. Would you like to publish this branch?** press the **OK** button

## Create a Pull Request

You pushed your **api** branch to GitHub. Now you want the GitHub Action to publish your web app and API in a preview URL. So your next step is to create a pull request against the **main** branch.

1. Open a browser
1. Navigate to your repository

   `https://github.com/<YOUR_GITHUB_USERNAME>/my-static-web-app-and-api`

1. Select the **Pull requests** link
1. Select the **New pull request** button
1. Select the **main** branch from the **base** dropdown
1. Select the **api** branch from the **compare** dropdown
1. Select the **Create pull request** button
1. Again, select the second **Create pull request** button

Your GitHub Action is now triggered.

## Watch the GitHub Action build and publish

You can stay in your browser on your repository and watch the GitHub Action's progress. Follow these steps to view the progress:

1. Select the **Actions** menu
1. Under the Workflows menu, select the **Azure Static Web Apps CI/CD** workflow item
:::image type="content" source="../media/track-actions-workflow.png" alt-text="Screenshot showing how to find the correct workflow.":::
1. Select the top link in the list of action runs.
1. Select the **Build and Deploy Job** link.

:::image type="content" source="../media/build-and-deploy-job.png" alt-text="Screenshot showing the build and deploy button on the workflow page.":::

You can see the progress of your GitHub Action as it builds and publishes your web app and API.

## Browse to the preview URL

Once the GitHub Action successfully completes, you can view your running app in the browser.

1. Select the **Pull requests** menu
1. Select your pull request
1. Select the link following the message **Azure Static Web Apps: Your stage site is ready! Visit it here**

Notice that the preview URL contains a hyphen followed by a number. The number matches the pull request number for the pull request you created. For every pull request you create, you get a unique and repeatable preview URL. The region is also used to form the preview URL.

::: zone pivot="angular"

:::image type="content" source="../media/my-shopping-list-app-angular.png" alt-text="Screenshot showing your angular web app.":::

::: zone-end

::: zone pivot="react"

:::image type="content" source="../media/my-shopping-list-app-react.png" alt-text="Screenshot showing your react web app.":::

::: zone-end

::: zone pivot="svelte"

:::image type="content" source="../media/my-shopping-list-app-svelte.png" alt-text="Screenshot showing your svelte web app.":::

::: zone-end

::: zone pivot="vue"

:::image type="content" source="../media/my-shopping-list-app-vue.png" alt-text="Screenshot showing your vue web app.":::

::: zone-end

## Next steps

Congratulations, you created your first Azure Static Web Apps instance with a web app and API!
