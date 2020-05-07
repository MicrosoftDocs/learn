Now it's time to create a fallback route so your users can navigate to your app successfully.

## Pull your latest code

Azure Static Web Apps added a GitHub Actions workflow file to the branch you selected in the previous exercise. First, you'll get this file by pulling your code from Git.

Pull your code changes from Git by following these steps:

1. Open the folder _my-static-web-app_ in Visual Studio Code.
1. Open the command palette by pressing <kbd>F1</kbd>.
1. Type and select **Git: Pull**.

You can now see your workflow file in the folder _.github/workflows_.

## Create a routing rule

Before publishing your app, you'll create routing rules that include a fallback route.

### Create the file routes.json

1. Open the folder _my-static-web-app_ in Visual Studio Code

::: zone pivot="angular"

1. In Visual Studio Code, right-click the folder _angular-app/src/_

::: zone-end

::: zone pivot="react"

1. In Visual Studio Code, right-click the folder _react-app/public_

::: zone-end

::: zone pivot="svelte"

1. In Visual Studio Code, right-click the folder _svelte-app/public_

::: zone-end

::: zone pivot="vue"

1. In Visual Studio Code, right-click the folder _vue-app/public_

::: zone-end

2. Select **New File**
3. Type _routes.json_ and press <kbd>Enter</kbd>
4. Update the _routes.json_ file to include the following fallback route:

   ```json
   {
     "routes": [
       {
         "route": "/*",
         "serve": "/index.html",
         "statusCode": 200
       }
     ]
   }
   ```

::: zone pivot="angular"

### Configure Angular

Angular apps don't copy files in the _src_ folder to the artifact folder by default. Use the following steps to ensure the _routes.json_ is copied to the appropriate location.

1. In Visual Studio Code, open the workflow file in the _.github/workflows_ folder
1. Add the `routes_location` property right below the `app_artifact_location` property
1. Set the value of `routes_location` to `angular-app/src`

   ```yaml
   jobs:
     build_and_deploy_job:
       steps:
         - name: Build And Deploy
           with:
             app_location: 'angular-app/'
             api_location: 'api'
             app_artifact_location: 'dist/angular-app'
             routes_location: 'angular-app/src'
   ```

Now your workflow is configured to locate the _routes.json_ file when your app builds.

::: zone-end

### Push your changes to Git

Now save, commit, and push your changes to Git by following these steps:

1. Open the command palette by pressing <kbd>F1</kbd>.
1. Type and select **Git: Commit All**. If Visual Studio Code prompts you to automatically stage all of your changes and commit them directly, select **Yes**.
1. Enter a commit message such as **added routing rules for a fallback route**.
1. Open the command palette by pressing <kbd>F1</kbd>.
1. Type and select **Git: Push**.

### Try the fallback route

The GitHub Actions workflow will build and deploy your app.

Go to your repository in your browser and watch the GitHub Action's progress. Follow these steps to view the progress:

1. Click on the **Actions** menu
1. Under the Workflows menu, click on the **Azure Static Web Apps CI/CD** workflow item
1. Select the latest (top) link in the action runs to the right
1. Click the **Build and Deploy Job** link

You can see the progress of your GitHub Action as it builds and publishes your web app and API.

Once it is redeployed, browse to your app. Notice the URL displays **/products**. Now refresh the browser by pressing <kbd>F5</kbd> to test your fallback route. Your app should reload successfully thanks to your fallback route in your routing rules!
