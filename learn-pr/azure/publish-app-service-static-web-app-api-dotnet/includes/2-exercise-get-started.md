Azure Static Web Apps publishes websites to a production environment by building apps from a GitHub repository. In this exercise, you'll build a web application using Blazor from a GitHub repository.

## Create a repository

This tutorial makes it easy for you to create a new repository by using a GitHub template repository. A template is available which contains a starter app built with Blazor.

1. Navigate to the [create from template page](https://github.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/generate?azure-portal=true) for the template repository.
   - If you get a 404 Page Not Found error, sign in to GitHub and try again.
1. If prompted for **Owner**, choose one of your GitHub accounts
1. Name your repository **my-static-blazor-app**
1. Click the **Create repository from template** button

## Run your app

You just created a GitHub repository named **my-static-blazor-app** in your GitHub account. Next, you'll clone the repo and run the code locally on your computer.

1. Open Visual Studio and clone the GitHub repository to your computer.

1. Open the solution file, _ShoppingList.sln_.

1. Finally, run the front-end client application by selecting **Client** as the start up project and launching the debugger.

## Browse to your app

It's time to see your application running locally. Visual Studio will open the website in your default browser.

:::image type="content" source="../media/my-shopping-list-app-loading.png" alt-text="Browsing to your web app":::

Your app should say **Loading data ...** because there is no data or API yet. You'll add the API for your web app later on in this tutorial.

Now stop your running app by ending the debugging session in Visual Studio.

## Next steps

You built your application and now it's running locally in your browser.

Next, you'll publish your application to Azure Static Web Apps.
