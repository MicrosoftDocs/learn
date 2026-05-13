In this exercise, we'll secure an Azure Sphere application

## Step 1: List your IoT Central network endpoints

1. Open the command prompt.
1. Navigate to the **azure-sphere-samples** directory. You cloned the Azure Sphere samples repository when you set up the development environment.

   - On Windows, navigate to the **Samples\AzureIoT\Tools\win-x64** directory.
   - On Linux, navigate to the **Samples/AzureIoT/Tools/linux-x64** directory. On Linux, you may need to explicitly set execution permissions for the **ShowIoTCentralConfig** tool. From a terminal, run `chmod +x ShowIoTCentralConfig` to add execution permissions for the tool.
1. When you run the **ShowIoTCentralConfig** tool, you will be prompted for the following information:

   | Prompt                                                 | Response                                                         |
   | ------------------------------------------------------------ | ------------------------------------------------------------ |
   | **Are you using a legacy (2018) IoT Central application (Y/N)** | Respond **N** for a current IoT Central application. |
   | **IoT Central App URL**                                      | Use your app-specific URL from the browser address bar or the Azure portal. For example: `https://myapp.azureiotcentral.com/`. |
   | **API token**                                                | In your IoT Central application, select **Permissions** > **API tokens**, select **+ New** or **Create an API token**, provide a name for the token (for example, "AzureSphere"), select **App Administrator** as the role for this exercise, or use a custom role with equivalent administrator permissions, and select **Generate**. Copy the token to the clipboard. The token starts with **SharedAccessSignature** and is shown only once. |
   | **ID Scope**                                                 | In your IoT Central application, in the left pane select **Permissions**, then **Device connection groups**. The application's **ID scope** is shown at the top of the **Device connection groups** page (it is an application-level value, not specific to any one group). Copy this value. |
1. Run the **ShowIoTCentralConfig** tool and follow the prompts that the tool provides.

   > [!IMPORTANT]
   > On Windows, run **ShowIoTCentralConfig** from a **PowerShell** or **Command Prompt** window. Don't launch it from the Start menu or by double-clicking the executable, because the console window closes when the program finishes and you won't be able to capture the output. If the tool fails to start with a missing-library error, close the tool, delete the `%LOCALAPPDATA%\Temp\.net\ShowIoTCentralConfig` folder, and run **ShowIoTCentralConfig** again from the command line.

   > [!NOTE]
   > Your organization might require consent for the **ShowIoTCentralConfig** tool to access your Azure IoT Central data in the same way that the Azure API requires such consent.
1. Review the output from the **ShowIoTCentralConfig** tool. It will look similar to the following text.

   ```json
   {
      "CmdArgs": [ "--ConnectionType", "DPS", "--ScopeID", "0ne0099999D" ],
      "Capabilities": {
         "AllowedConnections": [ "global.azure-devices-provisioning.net", "iotc-9999bc-3305-99ba-885e-6573fc4cf701.azure-devices.net", "iotc-789999fa-8306-4994-b70a-399c46501044.azure-devices.net", "iotc-7a099966-a8c1-4f33-b803-bf29998713787.azure-devices.net", "iotc-97299997-05ab-4988-8142-e299995acdb7.azure-devices.net", "iotc-d099995-7fec-460c-b717-e99999bf4551.azure-devices.net", "iotc-789999dd-3bf5-49d7-9e12-f6999991df8c.azure-devices.net", "iotc-29999917-7344-49e4-9344-5e0cc9999d9b.azure-devices.net", "iotc-99999e59-df2a-41d8-bacd-ebb9999143ab.azure-devices.net", "iotc-c0a9999b-d256-4aaf-aa06-e90e999902b3.azure-devices.net", "iotc-f9199991-ceb1-4f38-9f1c-13199992570e.azure-devices.net" ],
         "DeviceAuthentication": "--- YOUR AZURE SPHERE (LEGACY) TENANT ID ASSOCIATED WITH THE CATALOG ---"
      }
   }
   ```
1. Copy the output from the **ShowIoTCentralConfig** tool to Notepad, as you'll need this information soon. The **DeviceAuthentication** value in the tool output is a placeholder; replace it with the Azure Sphere (Legacy) tenant UUID that you get in Step 2 before you update **app_manifest.json**.
1. After you have captured the **ShowIoTCentralConfig** output, delete (revoke) the API token you created for this exercise. In IoT Central, select **Permissions** > **API tokens**, select the token, and delete it. The App Administrator token grants application access and should not remain active after this lab step.

## Step 2: Get the Azure Sphere (Legacy) tenant UUID associated with your catalog

The current Azure Sphere management model uses catalogs. The Azure Sphere application manifest still uses the **DeviceAuthentication** capability value to identify the Azure Sphere (Legacy) tenant UUID associated with your catalog. With Azure Sphere Integrated, every catalog exposes this tenant UUID as the `properties.tenantId` field of the Azure Sphere Catalog Azure resource — it is **not** the Azure Resource Manager catalog resource ID.

1. From the Windows **PowerShell command line** or Linux **Terminal**, run the following command. Replace `<resource-group-name>` and `<catalog-name>` with your Azure Sphere resource group and catalog name. This works for both brand-new Integrated catalogs and catalogs that were migrated from Azure Sphere (Legacy).

   ```azurecli
   az sphere catalog show --resource-group <resource-group-name> --catalog <catalog-name> --query "properties.tenantId" --output tsv
   ```

   The output of this command will look similar to the following.

     ```
     99999999-e021-43ce-9999-fa9999499994
     ```

   > [!NOTE]
   > Catalogs that were migrated from Azure Sphere (Legacy) also store the same value in the `tags.MigratedCatalogId` resource tag for backward compatibility. Both `--query "properties.tenantId"` and `--query "tags.MigratedCatalogId"` return the same UUID for migrated catalogs, but only `properties.tenantId` is guaranteed for catalogs created directly in the Integrated model. The `properties.tenantId` field is documented in the [Azure Sphere Catalog REST API schema](https://learn.microsoft.com/rest/api/azuresphere/catalogs/get?view=rest-azuresphere-2024-04-01).
1. Copy the Azure Sphere (Legacy) tenant UUID to Notepad, as you'll need it soon.
