The last step is to perform the migration.  Here you'll log into your Azure account and associate your Migration Assistant session.  You'll fill out the details for migration, then watch as the Migration Assistant goes to work.  Finally, you'll observe the web app running in Azure App Service and view the settings of your new Azure App Service account.

## Exercise Steps

1. Click Next. This displays the "Login to Azure" step. Here you'll use a special code to associate this assessment on your server to your Azure account.  

In the next few steps you'll need to use the device code then login to your Azure account using your Azure credentials.  You will need to do this on your local computer.  You'll copy the URL and the device code from your VM session and paste the URL and device code into a web browser on your local computer.

> [!Important]
> For this exercise, you will need to complete the "Login to Azure" step on your local computer.  You'll copy the URL and the device code from the VM and paste into a web browser on your local computer.

2.  In the Migration Assistant, select "Copy Code & Open Browser".  This will launch a web browser in your VM.  Copy the URL to your clipboard.  

3.  Minimize your Remote Desktop session so that you're working on your local computer and not inside the Virtual Machine hosted on Azure.  Open a web browser on your local computer and paste the URL you copied so that you see the "Enter code" web page on your local computer.  

4. Back in the Migration Assistant running in the VM, copy the device code to your clipboard.

5. Minimize your Remote Desktop session, and paste the device code into the "Enter code" web page on your local computer, then select "Next".

6. On your local computer, select "Next". Sign in using your Microsoft account.

> [!Note]
> When running the Azure Approve request on your "Microsoft account app". 2FactorAuth

Once you log in successfully, you should see a confirmation message that you have successfully signed in to the Azure App Service Migration Assistant application on your device.  Close the web browser on your local computer.

7. Back in the Migration Assistant running in the VM, the step "Azure Options" is displayed.  Here you'll enter details about the target Azure App Service where you'll move your app to.  Use the following table to make your selections:

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
> In this exercise, you'll deploy to a free-tier App Service plan that was created for you as partt of the exercise.  However, when you use the Azure App Service Migration Assistant in your own environment, your web app will be deployed to a single Premium P1v2 instance.  After the Migration Assistant migrates your web app, you may want to change the service tier to adjust the pricing as desired.

8. Select "Migrate".  The "Migration in Progress" step will display the current status of the migration.  You might see a message like the following image.

---------------- todo: image -----------------

Once the migration is complete you'll continue to the "Migration Results" step.  

9. Minimize Remote Desktop and open the web browser on your local computer.  Navigate to the URL of your web app to validate that the migration was successful.

> [!Note]
> When running this in your own environment, depending on your selections the Migration Assistant would include optional steps.  For instance, if you chose to set up a hybrid connection to an on-premises database, you would continue to download and install the Setup Hybrid Connection Manager.

10. On your local computer, navigate to the Azure Portal and select "App Service" from the home page.  From the list of deployed App Service, select "mymigrationapp".  This will display the settings for your new Azure App Service.

Congratulations, you have successfully migrated a web app running on Internet Information Services to Azure App Service using the Azure App Service Migration Assistant. 