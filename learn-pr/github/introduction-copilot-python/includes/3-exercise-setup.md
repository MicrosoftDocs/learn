
In this exercise, we create a new repository using the GitHub template for the Python personal portfolio frontend web application.

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
