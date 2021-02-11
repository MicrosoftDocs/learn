Now it's time to create a fallback route so your users can navigate to your app successfully.

## Pull your latest code

Azure Static Web Apps added a GitHub Actions workflow file to the branch you selected in the previous exercise. First, you'll get this file by pulling your code from Git.

Pull your code changes from Git by following these steps:

1. Open the **ShoppingList** solution in Visual Studio.
1. Pull the latest changes from GitHub.

You can now see your workflow file in the folder _.github/workflows_ in **Windows Explorer** (the file in not part of the Visual Studio solution).

## Create a routing rule

Before publishing your app, you'll create routing rules that include a fallback route.

### Create the file routes.json

1. In Visual Studio, right-click the folder _wwwroot_ within the _Client_ project.
2. Select **Add -> New Item**.
3. Select **JSON File** from the available templates, name it _routes.json_ and press <kbd>Enter</kbd>.
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

### Push your changes to Git

Now, save and commit your changes to your local Git repository, then push those changes to GitHub.

### Try the fallback route

The GitHub Actions workflow will build and deploy your app.

Go to your repository in your browser and watch the GitHub Action's progress. Follow these steps to view the progress:

1. Click on the **Actions** menu
1. Under the Workflows menu, click on the **Azure Static Web Apps CI/CD** workflow item
1. Select the latest (top) link in the action runs to the right
1. Click the **Build and Deploy Job** link

You can see the progress of your GitHub Action as it builds and publishes your web app and API.

Once it is redeployed, browse to your app. Notice the URL displays **/products**. Now refresh the browser by pressing <kbd>F5</kbd> to test your fallback route. Your app should reload successfully thanks to your fallback route in your routing rules!
