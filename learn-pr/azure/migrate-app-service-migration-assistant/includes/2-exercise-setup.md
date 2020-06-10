In this unit, you'll launch our sandbox environment.  The exercises in this module will use a Virtual Machine to simulate an on premises Windows server running Internet Information Services and an ASP.NET web app.  The Virtual Machine has the Azure App Service Migration Assistant pre-installed.

First, click the button above to Active Sandbox.  It will take moment to launch the sandbox environment.

Next copy and paste the following script into the Azure Cloud Shell on the right, then execute the script by selecting <key>enter</key>.

```bash
source <(curl -s https://raw.githubusercontent.com/MicrosoftDocs/mslearn-app-service-migration-assistant/master/provision.sh)
```

It will take several moments for the script to run.  The script provisions a new Virtual Machine and installs all the resources to complete the exercise in this module.  In the meantime, you'll learn about the Migration Assistant.

After you see the message "Provisioning started! Continue to the next unit" on the right, choose Continue at the bottom of this page.