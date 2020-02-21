Before your apps can use Azure Relay to exchange messages, you must create and configure a namespace.

In your financial organization, for the credit-checking service, your developers use hybrid connections. You want to create a relay that supports these connections. You also want to obtain the security credentials that your apps need to connect.

In this unit, you'll create an Azure Relay namespace and then store the primary key and connection string for later use in your app code.

## Create a namespace in Azure Relay

Let's start by creating a new Azure Relay namespace.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), in the left pane, select **Create a resource**.
1. In the **Search the Marketplace** box, enter **Relay**, and then select **Enter**.
1. In the **Relay** pane, read the information, and then select **Create**.
1. In the **Create namespace** pane, enter the following values, and then select **Create**:

    | Setting | Value |
    | --- | --- |
    | Name | Use a name that's unique within the *servicebus.windows.net* domain. For example, use 
    **creditcheckrelay-ab**, replacing *ab* with your initials or another text string. |
    | Subscription | Enter your Concierge subscription. |
    | Resource group | Enter <rgn>[sandbox resource group name]</rgn>. |
    | Location | Choose a location near you. |
    | | |

Azure creates and deploys the new namespace. This deployment might take several minutes.

## Get the primary connection string and primary key, and store them for later use

Azure Relay helps maintain security by requiring applications to supply an access key when they connect. Get that key now, so you can use it in the app code later in the module.

1. When the namespace deployment is finished, in the left pane, select **All resources**, and then select the relay you created.
1. Under **Settings**, select **Shared access policies**, and then select the **RootManageSharedAccessKey** policy.

    ![Get the access key for the relay](../media/3-obtain-access-key.png)

1. Next to the **Primary Key** box, select **Copy to clipboard**.
1. In Notepad or another text editor, paste the key.
1. Next to the **Primary Connection String** box, select **Copy to clipboard**.
1. In the text editor, paste the connection string on a new line.
1. Name the text file *AccessKeys.txt*, and save it to a local folder.

## Create a new hybrid connection in the namespace

For your credit-checking web service, you want to use hybrid connections, not Windows Communication Foundation (WCF) connections. Let's add that capability to the relay.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), in the left pane, select **All resources**.
1. Select the relay you created earlier.
1. Under **Entities**, select **Hybrid Connections**, and then select **Hybrid Connection**.
1. In the **Name** box, enter **CreditCheckConnection**. Leave **Requires Client Authentication** selected, and then select **Create**.

You've completed the configuration of the relay in Azure. Apps can exchange messages through the relay when they make the right connection to it. 