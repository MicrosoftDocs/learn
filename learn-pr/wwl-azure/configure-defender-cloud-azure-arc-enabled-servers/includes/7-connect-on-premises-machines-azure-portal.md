Use the Azure portal to generate an onboarding script for one Windows or Linux server. The script downloads and installs the Azure Connected Machine agent, creates the Azure Arc-enabled server resource, and associates the server with that resource.

Before you begin, confirm that the server meets the [Azure Connected Machine agent prerequisites](/azure/azure-arc/servers/prerequisites). Use an account with the **Azure Connected Machine Onboarding** or **Azure Connected Machine Resource Administrator** role. These roles provide the required permissions without the broader access that the **Owner** role grants.

To generate the script:

1. Sign in to the [Azure portal](https://portal.azure.com/), and search for and select **Azure Arc**.
2. On the Azure Arc menu, expand **Infrastructure**, and then select **Machines**.
3. Select **Onboard/Create** > **Onboard existing machines**.
4. On the **Basics** page, select the subscription, resource group, region, operating system, and connectivity method. For **Authentication method**, select **Authenticate machines manually**. Specify a proxy server, private endpoint, or Azure Arc gateway if your environment requires one.
5. On the **Tags** page, review the suggested physical-location tags and add any custom tags that your organization uses.
6. On the **Download and run script** page, review the settings, and then select **Download**.

The portal downloads `OnboardingScript.ps1` for Windows or `OnboardingScript.sh` for Linux. Follow the next two units to run the appropriate script on the target server.

Manual authentication is suitable for onboarding one server interactively. For onboarding at scale, generate a script that uses a service principal, assign it the **Azure Connected Machine Onboarding** role, and protect its secret or certificate from command output and logs.
