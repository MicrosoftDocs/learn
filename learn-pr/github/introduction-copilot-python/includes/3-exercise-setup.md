In this exercise, we create a new repository using the GitHub template for the Python personal portfolio frontend web application.

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

## Environment setup

First you need to launch the Codespaces environment, which comes preconfigured with the GitHub Copilot extension.

1. Open the [Codespace with the preconfigured environment](https://codespaces.new/MicrosoftDocs/mslearn-copilot-codespaces-python?azure-portal=true) in your browser.
1. On the **Create codespace** page, review the codespace configuration settings, then select **Create new codespace**.
1. Wait for the codespace to start. This startup process can take a few minutes.
1. The remaining exercises in this project take place in the context of this development container.

> [!IMPORTANT]
> All GitHub accounts can use Codespaces for up to 60 hours free each month with 2 core instances. For more information, see [GitHub Codespaces monthly included storage and core hours](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts).

### Python Web API

When complete, Codespaces loads with a terminal section at the bottom. Codespaces installs all the required extensions in your container. Once the package installs are completed, Codespaces executes the `uvicorn` command to start your web application running within your Codespace.

When the web application successfully starts, a message in the terminal shows that the server is running on port 8000 within your Codespace.

### Testing the API

In the **Simple Browser** tab of your Codespace, on the **Containerized Python API** page, select the **Try it out** button. A **FastAPI** page opens in the **Simple Browser** tab that allows you to interact with the API by sending a request using the self-documented page.

To test the API, select the **POST** button and then the **Try it Out** button. Scroll down the tab and select **Execute**. If you scroll down the tab further, you can see the response to your sample request.
