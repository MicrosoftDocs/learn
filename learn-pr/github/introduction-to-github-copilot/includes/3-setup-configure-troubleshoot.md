In this unit, we discuss how to sign up for GitHub Copilot, how to configure GitHub Copilot using Visual Studio Code, and some steps to troubleshoot GitHub Copilot using Visual Studio Code.

## Sign up for GitHub Copilot

Before you can start using GitHub Copilot, you need to set up a free trial or subscription for your personal account.

You can do so by selecting your profile photo and then selecting **Settings**. Copilot is on the left-hand menu under **Code, planning, and automation**.

After you sign up, you'll need to install an extension for your preferred environment. GitHub Copilot supports GitHub.com, Visual Studio Code, Visual Studio, JetBrains IDEs, and Neovim as an unobtrusive extension.

For this specific module, we'll just be reviewing extensions and configurations for Visual Studio Code, because the exercise we'll complete in this module uses Visual Studio Code.

If you're using a different environment, you can find specific links to set up those environments in the References section at the end of this module.

## Configure GitHub Copilot in Visual Studio Code

### Add the Visual Studio Code extension

Follow these steps to add the Visual Studio Code extension for GitHub Copilot.

1. In the Visual Studio Code Marketplace, go to the [GitHub Copilot extension page](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot) and select **Install**.
1. A popup appears asking to open Visual Studio Code. Select **Open**.
1. In the **Extension: GitHub Copilot** tab in Visual Studio Code, select **Install**.
1. If you haven't previously authorized Visual Studio Code in your GitHub account, you're prompted to sign in to GitHub in Visual Studio Code. Select **Sign in to GitHub**.

GitHub Copilot can autocomplete code as you type when you use Visual Studio Code. After installation, you can enable or disable GitHub Copilot, and you can configure advanced settings within Visual Studio Code.

### Enable or disable GitHub Copilot in Visual Studio Code

1. To enable or disable GitHub Copilot, select the status icon in the bottom panel of the Visual Studio Code window

    :::image type="content" source="../media/status-icon-visual-studio-code.png" alt-text="Screensgot of the status icon for GitHub Copilot in the bottom panel of the Visual Studio Code Window. Background color matches the color of the status bar when enabled." border="false":::

2. When disabling GitHub Copilot, you're asked whether you want to disable suggestions globally, or for the language of the file you're currently editing.

   - To disable suggestions from GitHub Copilot globally, select **Disable Globally**.
   - To disable suggestions from GitHub Copilot for a specified language, select **Disable for LANGUAGE**.

### Enable or disable inline suggestions in Visual Studio Code

1. In the File menu, navigate to **Preferences** and select **Settings**.

    :::image type="content" source="../media/vsc-settings.png" alt-text="Screenshot of the File menu in Visual Studio Code. The Preferences drop down submenu is open with Settings selected." border="false":::

2. In the left-side panel of the settings tab, select **Extensions**, then select **Copilot**.
3. Under **Inline Suggest: Enable**, select or deselect the checkbox to enable or disable inline suggestions

Additionally, you can choose to enable or disable inline suggestions and specify for which languages you want to enable or disable GitHub Copilot.

## Troubleshoot GitHub Copilot in Visual Studio Code

In Visual Studio Code, the log files are useful for diagnosing connection issues. The GitHub Copilot extension stores the log files in the standard log location for Visual Studio Code extensions. You can find the log files through the developer option and open extension logs folder within Visual Studio Code.

In rare cases, errors might not be logged in the regular locations. If you encounter errors and there's nothing in the logs, you might try to see the logs from the process running Visual Studio Code and the extension. This process allows you to view the Electron logs. You can find these logs under developer and in **Help** > **Toggle Developer Tools** within Visual Studio Code.

Network restrictions, firewalls, or your proxy may cause issues when connecting to GitHub Copilot. If this occurs, you can follow these next steps to open a new editor with the relevant information that you can inspect yourself or share with the support team.

1. Open the Visual Studio Code Command Palette:

    - For Mac, use **Shift+Command+P**
    - For Windows or Linux, use **Ctrl+Shift+P**
1. Type **Diagnostics**, then select **GitHub Copilot: Collect Diagnostics** from the list.

For more information on how to troubleshoot in other environments, check out the References section in the last unit of this module.
