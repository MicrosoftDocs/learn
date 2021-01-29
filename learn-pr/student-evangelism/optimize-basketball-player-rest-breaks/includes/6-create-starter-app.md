To create a web app by using the Azure Static Web Apps extension, you'll use a GitHub template repository to get started. GitHub template repositories basically are repos that have everything set up for a specific task, while giving you the flexibility to make it your own. 

In this case, we'll use the Static Web Vanilla Basic repo template. Before continuing, make sure you have your GitHub account, and that you're signed in to GitHub in a web browser.


## Create the web app repo

There are many ways to create a static web app in Azure. In later units, we introduce some other ways. In this module, we'll build a *very* simple web app and deploy it by using GitHub Actions.

To get started, you'll need to create a repo based on this app. Go to [https://aka.ms/LearnWithDrG/Basketball/TemplateApp](https://github.com/microsoft/space-jam-a-new-legacy-template/generate?azure-portal=true) and fill in the form. Name your repo *space-jam-a-new-legacy-app*. You can make this repo public or private, but be sure to include all branches.

:::image type="content" source="../media/web-app-repo-setup.png" alt-text="Screenshot that shows how to set up the new web app repo on GitHub.com.":::

## Clone your repo by using Visual Studio Code

> [!NOTE]
> You might be prompted to sign in to Azure or GitHub throughout the remaining steps in this unit. If so, follow the instructions to authorize Visual Studio Code to access this specific repository and your Azure subscription if you feel comfortable doing so. This is necessary to complete the module.

After your repo is created, you can clone it (make a copy on your local computer) by using Visual Studio Code. First, open a new Visual Studio Code window: select **File** > **New Window**.

Open the command palette, you can use the Ctrl+Shift+P shortcut, and type "Git: Clone":

:::image type="content" source="../media/clone-repo-selection.png" alt-text="Screenshot that shows the clone repository menu item in Visual Studio Code.":::

Then, back on GitHub.com in your *space-jam-a-new-legacy-app* repo, select the **Clone** button and copy the HTTPS URL:

:::image type="content" source="../media/github-clone-url.png" alt-text="Screenshot that shows how to get the HTTPS URL of the repo from GitHub.com.":::

> [!NOTE]
> The *complete-code* branch is there if you need it, but you should ignore it for now as you create this web app on your own. Don't worry, there's lots of start code!

Back in Visual Studio Code, paste the URL you copied at the command prompt and press Enter. If prompted, choose a location for your code to be downloaded.

:::image type="content" source="../media/clone-prompt-visual-studio-code.png" alt-text="Screenshot that shows the prompt to clone repo in Visual Studio Code.":::

If prompted, choose to open the code in your current window. After the files download, Visual Studio Code should look like this:

:::image type="content" source="../media/repo-cloned-downloaded-files.png" alt-text="Screenshot that shows the repository cloned and open in Visual Studio Code.":::

## Create a static web app in Azure in Visual Studio Code

Before we start modifying the web app, let's make sure it can deploy successfully with Azure. In Visual Studio Code, select the Azure extension. Select the plus sign of the Static Web Apps area to create a new static web app:

:::image type="content" source="../media/create-static-web-app.png" alt-text="Screenshot that shows creating a static web app in Visual Studio Code.":::

Follow the prompts. Accept all the default prompts, except the name and the deployment branch:

- **Static web app name**: *space-jam-a-new-legacy-app*
- **Build Preset**: *Custom*
- **Application Code Location**: *./*
- **Azure Functions Location**: *./*
- **Build path**: *build*
- **Location**: *WESTUS2* (or whatever is closest to you geographically!)

Then, you'll be prompted to view the GitHub action that's associated with this static web app. 

To go to the **Actions** page of your *space-jam-a-new-legacy-app* GitHub repo that you created at the beginning of this unit, select **Show Actions**.

:::image type="content" source="../media/action-on-github.png" alt-text="Screenshot that shows the GitHub action for this web app.":::

To see the workflow that was generated, select the action, and then select **Workflow file**. In this action, all code that's pushed to the main branch is deployed to the static web app that's saved in the secret GitHub token that was set up when you connected the repo to Azure in Visual Studio Code.

For this module, all you have to know is that if you push changes to your main branch, the changes are rendered in the static web app.

## View the web app live in the browser

The final setup step is to make sure that your web app is live. Back in Visual Studio Code, in the Azure extension, right-click the Production site for *space-jam-a-new-legacy-app*, and then select **Browse Site**:

:::image type="content" source="../media/browse-site.png" alt-text="Screenshot that shows locating the browse site menu in Visual Studio Code.":::

You might have to authorize Visual Studio Code to open a new browser window or tab. After you've done this, your live web app opens in a browser tab and you'll see the beginnings of a Tune Squad basketball web app:

:::image type="content" source="../media/web-app-browser.png" alt-text="Screenshot that shows the basketball web app with no functionality in a web browser.":::

> [!NOTE]
> If your action on GitHub hasn't finished yet, you'll see a generic static web app page in Azure instead of the *Space Jam: A New Legacy* app that's shown in the preceding screenshot. Just wait until the action finishes, and then reload the page to see the app.

Congratulations! You just deployed a static web app in Azure! Now, it's time to make the app usable with our data.

© 2020 Warner Bros. Ent. All Rights Reserved
