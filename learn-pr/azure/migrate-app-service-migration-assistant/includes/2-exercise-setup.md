In this unit, you'll open a sandbox environment. The exercises in this module use a virtual machine to simulate an on-premises Windows Server installation running Internet Information Services (IIS) and an ASP.NET web app. The VM has the Azure App Service Migration Assistant pre-installed.

First, select the **Activate sandbox** button to activate the sandbox. It takes a moment to open the sandbox environment.

Next, copy and paste the following script into Azure Cloud Shell on the right, and then run the script by pressing <kbd>Enter</kbd>.

```bash
source <(curl -s https://raw.githubusercontent.com/MicrosoftDocs/mslearn-app-service-migration-assistant/master/provision.sh)
```

The script provisions a new virtual machine, and installs all the resources to complete the exercises in this module. In the meantime, you'll learn about the Migration Assistant.

After you see the message "Provisioning started! Continue to the next unit" on the right, select **Continue** at the bottom of this page.
