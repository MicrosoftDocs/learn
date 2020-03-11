In this module, you ...

To verify your implementation, you can reference the _end_ folder or you can [view the code on GitHub](https://github.com/MicrosoftDocs/mslearn-advocates.azure-functions-and-signalr/tree/master/end).

<!-- Cleanup sandbox -->

[!include[](../../../includes/azure-sandbox-cleanup.md)]

## Restore Visual Studio Code settings

The following steps return the settings of your Visual Studio Code instance back to how it was before you completed the tutorial. If you don't restore the previous settings, you won't be able to connect to your Azure subscriptions from Visual Studio Code.

### Remove tenant from configuration

1. On Windows or Linux, select **File > Preferences > Settings**. On macOS, select **Code > Preferences > Settings**.
2. Navigate through **User Settings > Extensions > Azure configuration**
3. Clear the tenant in the **Azure: Tenant** textbox.

### Sign out and back in

Once the tenant is removed from the Azure extension settings, open the command palette and select **Azure: Sign Out** and then **Azure: Sign In**.

## Additional Resources

- Learn more about [Azure Cosmos DB input bindings for Azure Functions](https://docs.microsoft.com/azure/azure-functions/functions-bindings-cosmosdb-v2)
