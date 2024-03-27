Now it's time to create a fallback route so your users can navigate to your app successfully.

## Pull your latest code

Azure Static Web Apps added a GitHub Actions workflow file to the branch you selected in the previous exercise. First, you get this file by pulling your code from Git.

Pull your code changes from Git by following these steps:

1. Open the **ShoppingList** solution in Visual Studio.

1. Pull the latest changes from GitHub.

   :::image type="content" source="../media/pull-latest-changes.png" alt-text="Screenshot showing where to pull changes from GitHub.":::

You can now see your workflow file in the folder _.github/workflows_ in **Windows Explorer** (the file isn't part of the Visual Studio solution).

## Create a routing rule

Before publishing your app, you create routing rules that include a fallback route.

### Create the file _staticwebapp.config.json_

If you don't already have a _staticwebapp.config.json_ file in your project, you can create one by following these steps:

1. In Visual Studio, right-click the folder _wwwroot_ within the _Client_ project.

1. Select **Add -> New Item**.

1. Select **JSON File** from the available templates, name it _staticwebapp.config.json_, and press <kbd>Enter</kbd>.

After the _staticwebapp.config.json_ is created, update it to include the following fallback route:

```json
{
  "navigationFallback": {
    "rewrite": "index.html",
    "exclude": ["/_framework/*", "/css/*"]
  }
}
```

### Push your changes to Git

Now, save and commit your changes to your local Git repository. Next, push those changes to GitHub.

### Try the fallback route

The GitHub Actions workflow builds and deploys your app.

Go to your repository in your browser and watch the GitHub Action's progress. Follow these steps to view the progress:

1. Select the **Actions** menu.

1. Under the Workflows menu, select the **Azure Static Web Apps CI/CD** workflow item.

1. Select the latest (top) link in the action runs to the right.

1. Select the **Build and Deploy Job** link.

You can see the progress of your GitHub Action as it builds and publishes your web app and API.

After your app is redeployed, browse to it. Notice the URL displays **/products**. Now, refresh the browser by pressing <kbd>F5</kbd> to test your fallback route. Your app should reload successfully thanks to your fallback route in your routing rules!
