

The Azure connector is shipped as of SAP LaMa 3.0 SP05. We recommend always installing the latest support package and patch for SAP LaMa 3.0. The Azure connector uses a Service Principal to authorize against Microsoft Azure.

## Create a Service Principal for SAP Landscape Management

Follow these steps:

1. Sign in to the Azure portal.
2. Open **Azure Active Directory**.
3. Select **App registrations**.
4. Select **Add**.
5. Enter a **Name**, select Application Type "**Web app/API**", enter a sign-on URL (for example ``` <http://localhost> ```) and select **Create**. The sign-on URL isn't used and can be any valid URL.
6. Select the **new App** and select **Keys** in the **Settings** tab.
7. Enter a description for a new key, select "**Never expires**" and select **Save**.
8. Write down the **Value**. It's used as the password for the Service Principal.
9. Write down the **Application ID**. It's used as the username of the Service Principal.

## Give the Service Principal permissions to access your Azure resources

By default, the Service Principal doesn't have permissions to access your Azure resources. Follow these steps to give it the necessary permissions:

1. In the Azure portal, open **Resource groups**.
2. Select the resource group you want to use.
3. Select **Access control (IAM)**.
4. Select **Add role assignment**.
5. Select the role **Contributor**.
6. Enter the name of the application you created previously.
7. Select **Save**.
8. Repeat step 2 to 7 for all resource groups you want to use in SAP LaMa.
9. Open the SAP LaMa website and navigate to **Infrastructure**. Go to the **Cloud Managers** tab and select **Add**. Select the **Microsoft Azure Cloud Adapter** and select **Next**. Enter the following information:

     - **Label**: Choose a name for the connector instance
     - **User Name**: Service Principal Application ID
     - **Password**: Service Principal key/password
     - **URL**: Keep default ```<https://management.azure.com/>```
     - **Monitoring Interval (Seconds)**: Should be at least 300
     - **Subscription ID**: Azure subscription ID
     - **Azure Active Directory Tenant ID**: ID of the Active Directory tenant
     - **Proxy host**: Hostname of the proxy if SAP LaMa needs a proxy to connect to the internet
     - **Proxy port**: TCP port of the proxy
10. Select **Test Configuration** to validate your input. You should see the message **Connection successful: Connection to Microsoft cloud was successful.**
11. SAP LaMa communicates with the virtual machine using the SAP Host Agent. If you deploy the virtual machines manually or not using the Azure Resource Manager template from the quickstart repository, make sure to install the latest SAP Host Agent and the SAP Adaptive Extensions.
