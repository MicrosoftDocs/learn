Azure Static Web Apps publishes websites to a production environment by building apps from a GitHub repository. In this exercise, you'll build a web application using Blazor from a GitHub repository.

## Create a repository

This module makes it easy for you to create a new repository by using a GitHub template repository. A template is available that contains a starter app built with Blazor.

1. Go to the [create from template page](https://github.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/generate?azure-portal=true) for the template repository.
   - If you get a 404 Page Not Found error, sign in to GitHub and try again.

1. If prompted for **Owner**, choose one of your GitHub accounts.

1. Name your repository **my-static-blazor-app**.

1. Azure Static Web Apps supports both public and private repositories. For this exercise, select **Private** as the visibility.

1. Select **Create repository**.

## Run your app

You just created a GitHub repository named **my-static-blazor-app** in your GitHub account. Next, you'll clone the repo and run the code locally on your computer.

1. In your GitHub repository, select **Code**, and select **Open with Visual Studio** from the menu. This command will prompt you to launch Visual Studio and clone the repository to your machine.
   - If you have multiple versions of Visual Studio installed, ensure your app is opened in Visual Studio 2022 or later.

1. Open the solution file, _ShoppingList.sln_.

   :::image type="content" source="../media/open-solution.png" alt-text="Screenshot showing where to open the shopping list solution.":::

1. Finally, run the front-end client application by selecting **Client** as the start-up project and launching the debugger.

   :::image type="content" source="../media/select-start-project.png" alt-text="Screenshot showing the client project selected.":::

## Browse to your app

It's time to see your application running locally. Visual Studio will open the website in your default browser.

:::image type="content" source="../media/my-shopping-list-app-loading.png" alt-text="Screenshot showing the UI of your web app.":::

Your app should say **Loading data ...** because there's no data or API yet. You'll add the API for your web app later on in this module.

Now, stop your running app by ending the debugging session in Visual Studio.

## Next steps

You built your application and now it's running locally in your browser.

Next, you'll publish your application to Azure Static Web Apps.
