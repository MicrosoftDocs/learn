In this exercise, we'll secure an Azure Sphere application

## Step 1: List your IoT Central network endpoints

1. Open the command prompt.

2. Navigate to the **azure-sphere-samples** directory. You cloned the Azure Sphere samples repository when you set up the development environment.

   - On Windows, navigate to the **Samples\AzureIoT\Tools\win-x64** directory.
   - On Linux, navigate to the **Samples/AzureIoT/Tools/linux-x64** directory. On Linux, you may need to explicitly set execution permissions for the **ShowIoTCentralConfig** tool. From a terminal, run `chmod +x ShowIoTCentralConfig` to add execution permissions for the tool.

3. When you run the **ShowIoTCentralConfig** tool, you will be prompted for the following information:

   | Prompt                                                 | Response                                                         |
   | ------------------------------------------------------------ | ------------------------------------------------------------ |
   | **Are you using a legacy (2018) IoT Central application (Y/N)** | Respond **N**.                                                |
   | **IoT Central App URL**                                      | This can be found in your browser address bar. For example: https://myiotcentralapp.azureiotcentral.com |
   | **API token**                                                | This can be generated from your Azure IoT Central application. In the Azure IoT Central application, select **Administration**, select **API Tokens**, select **Generate Token**, provide a name for the token (for example, "AzureSphere"), select **Administrator** as the role, and click **Generate**. Copy the token to the clipboard. The token starts with **SharedAccessSignature**. |
   | **ID Scope**                                                 | In the Azure IoT Central application, select **Administration** > **Device Connection** and then copy the **ID Scope**. |

4. Run the **ShowIoTCentralConfig** tool and follow the prompts that the tool provides.

   > [!NOTE]
   > Your organization might require consent for the **ShowIoTCentralConfig** tool to access your Azure IoT Central data in the same way that the Azure API requires such consent.

5. Review the output from the **ShowIoTCentralConfig** tool. It will look similar to the following text.

   ```json
   "CmdArgs": [ "--ConnectionType", "DPS", "--ScopeID", "0ne0099999D" ],
   "Capabilities": {
      "AllowedConnections": [ "global.azure-devices-provisioning.net", "iotc-9999bc-3305-99ba-885e-6573fc4cf701.azure-devices.net", "iotc-789999fa-8306-4994-b70a-399c46501044.azure-devices.net", "iotc-7a099966-a8c1-4f33-b803-bf29998713787.azure-devices.net", "iotc-97299997-05ab-4988-8142-e299995acdb7.azure-devices.net", "iotc-d099995-7fec-460c-b717-e99999bf4551.azure-devices.net", "iotc-789999dd-3bf5-49d7-9e12-f6999991df8c.azure-devices.net", "iotc-29999917-7344-49e4-9344-5e0cc9999d9b.azure-devices.net", "iotc-99999e59-df2a-41d8-bacd-ebb9999143ab.azure-devices.net", "iotc-c0a9999b-d256-4aaf-aa06-e90e999902b3.azure-devices.net", "iotc-f9199991-ceb1-4f38-9f1c-13199992570e.azure-devices.net" ],
      "DeviceAuthentication": "--- YOUR AZURE SPHERE TENANT ID---",
   }
   ```

6. Copy the output from the **ShowIoTCentralConfig** tool to Notepad, as you'll need this information soon.

## Step 2: Get your Azure Sphere tenant ID

We need the ID of the Azure Sphere tenant that is now trusted by Azure IoT Central.

1. From the  Windows **PowerShell command line** or Linux **Terminal**, run the following command.

   ```
   azsphere tenant show-selected
   ```

   The output of this command will look similar to the following.

    ```
    ------------------------------------ -------------------
    Id                                   Name
    ========================================================
    99999999-e021-43ce-9999-fa9999499994 yourSphereTenant
    ------------------------------------ -------------------
    ```

2. Copy the Azure Sphere tenant ID to Notepad, as you'll need it soon.
