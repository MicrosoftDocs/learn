In this exercise, we create a new repository using the GitHub template for the JavaScript personal portfolio frontend web application.

## How to set up GitHub Copilot

To use GitHub Copilot, you need to complete the following steps:

1. **GitHub Account**: 
   - Create a GitHub account. Since Copilot is a GitHub service, you need a GitHub account to use it. If you don’t have an account, visit the [GitHub webpage](https://gh.io/) to create one for free.

2. **Sign up and enable GitHub Copilot**: 
   - You can set up a GitHub Copilot Free account or sign up for a subscription to GitHub Copilot Pro trial with a one-time 30-day trial. For learning purposes, the Copilot Free option with usage limits should be sufficient.
   - It's important to be aware of the GitHub Copilot free trial conditions: if you choose the free trial offer for GitHub Copilot, a form of payment is requested at sign-up. Charges aren't applied until the trial is over, unless you cancel before the conclusion of the 30-day period.
     
> [!TIP]
> GitHub Copilot offers a free tier with **2,000 code autocompletes and 50 chat messages per month**. To get started, open Visual Studio Code, click on the GitHub Copilot icon, and then click "Sign in to Use GitHub Copilot for Free". Log in to your GitHub account in the window that will open in the browser. [Learn more](https://gh.io/copilot). Educators, Students and select open-source maintainers can receive Copilot Pro for free, learn how at: [https://aka.ms/Copilot4Students](https://aka.ms/Copilot4Students).

3. **Install the Extension**:
   - GitHub Copilot is available as an extension for major IDEs, including Visual Studio, Visual Studio Code, JetBrains IDEs, VIM, and XCode.
   - To install, search for "GitHub Copilot" in your IDE's extension marketplace and follow the installation instructions. For example, in the VS Code marketplace, you will find GitHub Copilot, GitHub Copilot Chat, and GitHub Copilot for Azure as options to install.

## Accessing GitHub Copilot

To use GitHub Copilot, you need to complete the following steps:

1. **GitHub Account**: 
   - If necessary, create a GitHub account.
   - Copilot is a GitHub service, so you need a GitHub account to use it.

2. **Check Copilot Access**: 
   - Check the [Copilot pricing plans](https://github.com/features/copilot/plans) for your situation.
   - For learning, the **Copilot Free** option with usage limits should be sufficient. It includes:
      - Access to inline code completions
      - Multi-file editing
      - Copilot Chat
      - Selecting multple models
      - Support across all editors and in github.com

>[!Note]
> Educators, Students and select open-source maintainers can receive Copilot Pro for free, learn how at: https://aka.ms/Copilot4Students

3. **Verify Copilot Access is Enabled**:
   - In GitHub, go to your profile, then head over to **Settings**.
   - In the left navigation, select **Copilot**.
   - Verify Copilot is active and **Copilot Chat in the IDE** is enabled.

4. **Install the Extension**:
   - Extensions are available for major IDEs like Visual Studio, Visual Studio Code, JetBrains IDEs, VIM, and XCode.
   - Simply search for `GitHub Copilot` in your IDE's extension marketplace and install it.

## Environment set up

First you need to launch the Codespaces environment, which comes preconfigured with the GitHub Copilot extension.

1. Select the following button to Open the Codespace with the preconfigured environment.

    [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/MicrosoftDocs/mslearn-copilot-codespaces-javascript)

1. On the **Create codespace** page, review the codespace configuration settings and then select **Create new codespace**
1. Wait for the codespace to start. This startup process can take a few minutes.
1. The remaining exercises in this project take place in the context of this development container.

> [!IMPORTANT]
> All GitHub accounts can use Codespaces for up to 60 hours free each month with 2 core instances. For more information, see [GitHub Codespaces monthly included storage and core hours](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts).

### JavaScript portfolio

When complete, Codespaces loads with a terminal section at the bottom. Codespaces installs all the required extensions and dependencies in your container. Once complete, this template is configured to use `npm start` to start the web application within your Codespace.

When the web application has successfully started, a message in the terminal shows that the server is running on port 1234 within your Codespace.
