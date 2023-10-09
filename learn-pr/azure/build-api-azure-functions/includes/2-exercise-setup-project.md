You're a new developer at Tailwind Traders. Before you can start, you'll need to get your development environment configured. Don't worry, Tailwind Traders has made the onboarding process easy. There are just a few small steps you need to follow to get up and running.

## Scaffold the project resources

1. Sign in to Azure Cloud Shell (also known as, "Tailwind Traders Production Environment") as indicated at the top of this page.

1. Copy the following line, and paste it into Azure Cloud Shell terminal to the right.

   ```bash
   git clone https://github.com/MicrosoftDocs/mslearn-build-api-azure-functions && ./mslearn-build-api-azure-functions/DB_SETUP/CREATE_DATABASE.sh
   ```

   This command creates a new database with product data. This process can take up to 10 minutes. Feel free to continue on with the module. The process continues to run even if you leave this page.

## Clone the project in Visual Studio Code

1. Open Visual Studio Code.

1. In the top menu bar, select **View** > **Command Palette**.

1. In the prompt, enter *clone*.

1. In the Command Palette, select **Git: Clone**.

1. Enter the following repo URL.

   ```bash
   https://github.com/MicrosoftDocs/mslearn-build-api-azure-functions
   ```

1. Select a folder on your local drive where you want the project to be cloned.

1. When prompted to open the cloned repository, select **Open**.

1. Visual Studio Code detects a workspace file in this project, and asks if you want to open it. Select **Open Workspace**.

   :::image type="content" source="../media/open-workspace.png" alt-text="Screenshot of Visual Studio Code notification prompt to open workspace." loc-scope="Visual Studio Code":::

When the workspace opens, two projects appear in Visual Studio Code: "frontend" and "api". The "frontend" project contains the web app. The "api" project is where you build the serverless API with Azure Functions.

## Run the front-end project

1. To open the integrated terminal in Visual Studio Code, press <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>`</kbd>.

1. Select **frontend**.

1. To run the front-end project in the browser, in the integrated terminal, run the `npm start` command.

   ```bash
   npm start
   ```

   A small webserver called *serve* should be running in the Visual Studio Code terminal window. It displays the URL where the front-end app is running.

   :::image type="content" source="../media/npm-start.png" alt-text="Screenshot of Visual Studio Code terminal with a callout highlighting the url and port of running application." loc-scope="vs-code":::

1. To open the app in the browser, select that URL in the terminal window.

   The app loads, but there's no data present because you haven't created the API for this app.

   :::image type="content" source="../media/products-manager-start.png" alt-text="Screenshot of the application running in a browser. No data is displayed and an error message explaining that the get operation failed." loc-scope="other"::: <!-- no-loc -->

Excellent! You've successfully configured your environment to be a productive developer at Tailwind Traders. That means that it's time to create the Azure Functions project that will serve as the API for the Products Manager application.
