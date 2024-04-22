Azure Key Vault is a cloud service that provides a secure store for keys, secrets, and certificates.

## Sign in to Azure

Sign in to the [Azure portal](https://portal.azure.com/),

## Create a vault

1.  From the Azure portal menu, or from the **Home** page, select **Create a resource**.
2.  In the Search box, enter **Key Vault**.
3.  From the results list, choose **Key Vault**.
4.  On the Key Vault section, choose **Create**.
5.  On the **Create key vault** section provide the following information:
     -  **Name**: A unique name is required. For this quickstart, we use **Contoso-vault2**.
     -  **Subscription**: Choose a subscription.
     -  Under **Resource Group**, choose **Create new** and enter a resource group name.
     -  In the **Location** pull-down menu, choose a location.
     -  Leave the other options to their defaults.
6.  Select **Create**.

Take note of these two properties:

 -  **Vault Name**: In the example, this is Contoso-Vault2. You'll use this name for other steps.
 -  **Vault URI**: In the example, the Vault URI is `https://contoso-vault2.vault.azure.net/`. Applications that use your vault through its REST API must use this URI.

At this point, your Azure account is the only one authorized to perform operations on this new vault.

## Configure Azure Key Vault networking settings

1. Browse to the previously created key vault.

2. Select **Networking**, and then select the **Firewalls and virtual networks** tab.

3. Under **Allow access from**, select **Selected networks**.

4. To add existing virtual networks to firewalls and virtual network rules, select **+ Add existing virtual networks**.

5. In the new blade that opens, select the subscription, virtual networks, and subnets that you want to allow access to this key vault. If the virtual networks and subnets you select don't have service endpoints enabled, confirm that you want to enable service endpoints, and select **Enable**. It might take up to 15 minutes to take effect.

6. Under **IP Networks**, add IPv4 address ranges by typing IPv4 address ranges in CIDR (Classless Inter-domain Routing) notation or individual IP addresses.

7. If you want to allow Microsoft Trusted Services to bypass the Key Vault Firewall, select 'Yes'. For a full list of the current Key Vault Trusted Services please see the following link. Azure Key Vault Trusted Services

8. Select **Save**.

You can also add new virtual networks and subnets, and then enable service endpoints for the newly created virtual networks and subnets, by selecting **+ Add new virtual network**. Then follow the prompts.
