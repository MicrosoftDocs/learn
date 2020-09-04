In this tutorial, you created, modified, and published a web app to Azure Static Web Apps.

The solution for the [sample project is on GitHub in the _solution_ branch](https://github.com/MicrosoftDocs/mslearn-staticwebapp/tree/solution?azure-portal=true). The instructions on how to get started appear in the README file.

<!-- Cleanup sandbox -->

[!include[](../../../includes/azure-sandbox-cleanup.md)]

## Restore Visual Studio Code settings

The following steps return the settings of your Visual Studio Code instance back to how it was before you completed the tutorial. If you don't restore the previous settings, you won't be able to connect to your Azure subscriptions from Visual Studio Code.

### Remove tenant from configuration

1. On Windows or Linux, select **File > Preferences > Settings**. On macOS, select **Code > Preferences > Settings**.
2. Navigate through **User Settings > Extensions > Azure configuration**
3. Clear the tenant in the **Azure: Tenant** textbox.

![Add tenant ID to Visual Studio Code Azure extension configuration](../media/vs-code-tenant-blank.png)

### Sign out and back in

Once the tenant is removed from the Azure extension settings, open the command palette and select **Azure: Sign Out** and then **Azure: Sign In**.

## Additional resources

Here are several resources where you can learn more about Azure Static Web Apps, Visual Studio Code, and other concepts covered in this module.

- [Azure Static Web Apps on Microsoft Docs](https://docs.microsoft.com/azure/static-web-apps)
- Use [Angular](https://code.visualstudio.com/docs/nodejs/angular-tutorial), [React](https://code.visualstudio.com/docs/nodejs/reactjs-tutorial), and [Vue](https://code.visualstudio.com/docs/nodejs/vuejs-tutorial) in Visual Studio Code
