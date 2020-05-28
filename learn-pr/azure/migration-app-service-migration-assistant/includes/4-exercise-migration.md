Now that you've deployed the Virtual Machines containing your web application to the sandbox environment, you'll use the Azure App Service Migration Assistant to perform an assessment and migration to Azure App Services.

> [!Important]
> This module assumes you've successfully completed the steps in the previous unit and you're using Remote Desktop to view the Virtual Machine running in our sandboxed Azure Virtual Machine environment.  If not, please make sure you complete those steps before continuing on to this unit.

## Exercse steps

1. In the Virtual Machine, open a web browser and navigate to: http://localhost.  Confirm that the web site is running locally.

1. On the Windows desktop, double-click the icon to launch the Azure App Service Migration Assistant.  Once launched, the user interface lists the Migration Assistant's steps with the first step highlighted, "Choose a Site".  In the main area, the Migration Assistant lets you know that it found one site to assess.  

2. Select the radio button next to "my_migration_app".  Then, select the Next button at the bottom of the dialog.  This will begin the assessment of the site.

3. After a moment, the Assessment Report step should complete and you should see that all 13 assessments were successful with no warnings or errors.  You may take a moment to expand the chevron icon next to the label "Success (13)" to see the types of assessments it performed.  We covered some of these previously in an earlier unit.

4. Click Next. This displays the "Login to Azure" step. Here you'll use a special code to associate this assessment on your server to your Azure account.  

In the next few steps you'll need to use the device code then login to your Azure account using your Azure credentials.  You will need to do this on your local computer.  You'll copy the URL and the device code from your VM session and paste the URL and device code into a web browser on your local computer.

> [!Important]
> For this exercise, you will need to complete the "Login to Azure" step on your local computer.  You'll copy the URL and the device code from the VM and paste into a web browser on your local computer.

5.  In the Migration Assistant, select "Copy Code & Open Browser".  This will launch a web browser in your VM.  Copy the URL to your clipboard.  

6.  Minimize your Remote Desktop session so that you're working on your local computer and not inside the Virtual Machine hosted on Azure.  Open a web browser on your local computer and paste the URL you copied so that you see the "Enter code" web page on your local computer.  

7. Back in the Migration Assistant running in the VM, copy the device code to your clipboard.

8. Minimize your Remote Desktop session, and paste the device code into the "Enter code" web page on your local computer, then select "Next".

7. On your local computer, select "Next". Sign in using your Microsoft account.

> [!Note]
> When running the Azure Approve request on your "Microsoft account app". 2FactorAuth

Once you log in successfully, you should see a confirmation message that you have successfully signed in to the Azure App Service Migration Assistant application on your device.  Close the web browser on your local computer.

8. Back in the Migration Assistant running in the VM, the step "Azure Options" is displayed.  Here you'll enter details about the target Azure App Service where you'll move your app to.  Use the following table to make your selections:

| Field | Your entry |
| --- | ----------- |
| Subscription | ??? |
| Resource Group | ??? |
| Destination Site Name | ??? |
| App Service Plan | ??? |
| Region | ??? |
| Azure Migrate Project | Leave empty |
| Databases | Choose "Skip database setup" |

> [!Note]
> In this exercise, you'll deploy to the free App Service tier.  However, when you use the Azure App Service Migration Assistant in your own environment, your web app will be deployed to a single Premium P1v2 instance.  After the Migration Assistant migrates your web app, you may want to change the service tier to adjust the pricing as desired.

9. Select "Migrate".  The "Migration in Progress" step will display the current status of the migration.  You might see a message like the following image.

---------------- todo: image -----------------

Once the migration is complete you'll continue to the "Migration Results" step.  

10. Minimize Remote Desktop and open the web browser on your local computer.  Navigate to the URL of your web app to validate that the migration was successful.

> [!Note]
> When running this in your own environment, depending on your selections the Migration Assistant would include optional steps.  For instance, if you chose to set up a hybrid connection to an on premise database, you would continue to download and install the Setup Hybrid Connection Manager.

11. On your local computer, navigate to the Azure Portal and select "App Services" from the home page.  From the list of deployed App Services, select "mymigrationapp".  This will display the settings for your new Azure App Service.

--------------- todo: cleanup steps? -------------

Congratulations, you have successfully migrated a web app running on Internet Information Services to Azure App Services using the Azure App Service Migration Assistant. 