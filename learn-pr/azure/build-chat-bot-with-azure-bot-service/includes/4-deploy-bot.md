When you created an Azure web app bot, an Azure web app was deployed to host it. But the bot does require some code, and it still needs to be deployed to the Azure web app. Fortunately, the code was generated for you by the Azure Bot Service. In this unit, you will use Visual Studio Code to place the code in a local Git repository and publish the bot to Azure by pushing changes from the local repository to a remote repository connected to the Azure web app that hosts the bot — a process known as [continuous integration](https://wikipedia.org/wiki/Continuous_integration).

1. Create a folder named "Factbot" in the location of your choice on your hard disk to hold the bot's source code.

1. Return to the Azure portal in the browser and find the resource group created using the seach box at the top, or the **Resource groups** section in the left-hand sidebar. 

1. Locate and select the Web App Bot you created earlier.

1. Select **Build** in the menu on the left, then select **Download Bot source code** to prepare a zip file containing the bot's source code. Once the zip file is prepared, select the **Download Bot source code** button to download it.

    ![Screenshot showing the Build > Download Bot source code steps in the Azure portal for the Web app bot](../media/4-download-sourcecode.png)

1. The portal will take a few minutes to zip up the code and then it should download to your local computer. When the download is complete, extract the contents of the **.zip** file to the "Factbot" folder that you created earlier.

1. Back in the Web App Bot's Build blade in the Azure portal, select the **Publish updates automatically to Azure with Continuous Deployment** link under the **Publish** area in the main view.

1. In the **Deployment Center**, select **Local Git** as the deployment source and click **Continue**.

1. Select the **App Service Kudu build server** option and click **Continue**.

1. Next, select **Deployment Credentials** from menu area, and then **User Credentials** in the opened view.

1. Enter a username and password and click **Save Credentials**.

    ![Screenshot of the Azure portal showing the new bot App Service blade displaying the Deployment credentials screen with the Deployment credentials menu item and Save button highlighted.](../media/4-portal-enter-ci-creds.png)

1. Navigate back to the web app bot configuration and select **All App service settings** in the menu on the left. This will display the underlying web app your bot is hosted in.

1. Note the **Git clone url** in the Overview pane. You will need this URL a bit later.

1. Start **Visual Studio Code**, and use the **File** > **Open Folder...** command to open the "Factbot" folder where you copied the bot's source code.

    > [!TIP]
    > We are using Visual Studio Code for this part which has an integrated Git experience, but you can create the Git repo using any other technique you prefer if you are familiar with the steps. If you don't have Visual Studio Code installed, you can download it for free from [here](https://code.visualstudio.com/).

1. Select the **Source Control** button in the activity bar on the left side of Visual Studio Code. You can hover over each button if the sidebar is collapsed.

1. Select the **Initialize Repository** icon at the top (on the right side of the **SOURCE CONTROL** title).

1. Select the **Initialize Repository** button in the dialog.

1. Type "First commit." into the entry text box.

1. Select the check mark to commit your changes, staging all the files when prompted.

    > [!TIP]
    > If you get a Git error about not having your identity set in Git, launch a Command Prompt and run the following commands, replacing the placeholder email and name values. Then retry the commit button.
    >
    > ```bash
    > git config --global user.email "Your Email"
    > git config --global user.name "Your name"
    > ```

1. Select **Terminal** from Visual Studio Code's **View** menu to open an integrated terminal.

1. Execute the following command in the integrated terminal, replacing BOT_NAME in the following two places with the bot name you entered in Exercise 1.

    > [!NOTE]
    > The full Git remote URL can also be found in the App Service resource's **Overview** section under **Git clone url**.

    ```bash
    git remote add qna-factbot https://BOT_NAME.scm.azurewebsites.net:443/BOT_NAME.git
    ```

1. Return to the **Source Control** panel and select the ellipsis (the three dots) at the top of the SOURCE CONTROL panel, and select **Publish Branch** from the menu to push the bot code from the local repository to Azure. If prompted for credentials, enter the username and password you specified previously in this exercise.

Your bot has been published to Azure. But before you test it there, let's run it locally and learn how to debug it in Visual Studio Code.
