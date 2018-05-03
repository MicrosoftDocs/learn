To use CI/CD best practices, change your workflow so that the build definition deploys to a staging slot instead of to production. Create a staging slot for your web app in the Azure portal:

1. In the [Azure portal](https://portal.azure.com), sign in to your Azure account.
2. In the left menu, select **Resource groups**.
3. Select the resource group you created for your web app, for example, *myResourceGroup*. Then, select your web app, for example, *myWebApp*.
4. In the left menu of the web app window, select **Deployment slots**, and then select **Add Slot**.
5. Enter a name for your deployment slot, such as **staging**. Then, select your existing web app for **Configuration source**. To create the deployment slot, select **OK**.
6. After the deployment slot has been created, select it from the list of available slots. The overview for the deployment slot is shown, including the URL. The deployment slot is added to the name of your web app, such as *https://mywebapp-staging.azurewebsites.net*:

    ![Overview of the web app deployment slot in the Azure portal](../media/azure-portal-web-app-staging-slot.png)

Select the URL to open it in a new web browser window. Leave the Azure portal and staging slot website browser windows open.