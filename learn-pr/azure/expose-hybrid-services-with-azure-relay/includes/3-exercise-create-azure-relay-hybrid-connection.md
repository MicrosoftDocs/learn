Before your apps can use Azure Relay to exchange messages, you must create and configure a namespace.

In your financial organization, for the credit-checking service, your developers use hybrid connections, so you want to create a relay that supports them. You also wish to obtain the security credentials that your apps need to connect.

Here, you'll create a new Azure Relay namespace and store the primary key and connection string, which we'll use later in our app code.

## Create a new namespace in Azure Relay

Let's start by creating a new Azure Relay namespace.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), in the left menu, click **Create a resource**.
1. In the **Search the Marketplace** text box, type **Relay**, and then click **Enter**.
1. In the **Relay** page, read the information, and then click **Create**.
1. In the **Create namespace** page, enter these values, and then click **Create**:

    | Setting | Value |
    | --- | --- |
    | Name | Use a name that's unique within the **servicebus.windows.net** domain. For example, use `creditcheckrelay-ab`, replacing `ab` with your initials or another text string. |
    | Subscription | Concierge Subscription |
    | Resource groups | <rgn>[sandbox resource group name]</rgn> |
    | Location | Choose a location near you |
    | | |

    ![Create a new namespace in Azure Relay](../media/3-create-namespace.png)

Azure creates and deploys the new namespace. This deployment may take several minutes.

## Get the primary connection string and primary key, and store them for later use

Azure Relay maintains security by requiring that applications supply an access key when they connect. Obtain that key now, so you can use it in the app code later in the module.

1. When the namespace deployment has completed, in the left Azure menu, click **All resources**, and then click the relay you created.
1. Under **Settings**, click **Shared access policies**, and then click the **RootManageSharedAccessKey** policy.

    ![Obtain the access key for the relay](../media/3-obtain-access-key.png)

1. To the right of the **Primary Key** text box, click the **Copy to clipboard** button.
1. Start a new instance of **Notepad**, or another text editor, on your computer and paste the key into it.
1. To the right of the **Primary Connection String** text box, click the **Copy to clipboard** button.
1. In the text editor, paste the connection string on a new line.
1. Save the text file in a local folder of your choice. Name the file **AccessKeys.txt**.

## Create a new hybrid connection in the namespace

For your credit-checking web service, you want to use hybrid connections, not WCF connections. Let's add that capability to the relay.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), in the left menu, click **All resources**.
1. Click the relay you created earlier.
1. Under **Entities**, click **Hybrid Connections**, and then click **+ Hybrid Connection**:

    ![Adding a hybrid connection to a namespace](../media/3-add-hybrid-connection.png)

1. In the **Name** text box, type **CreditCheckConnection**, and then click **Create**:

    ![New connection details](../media/3-new-connection-details.png)

You've completed the configuration of the relay in Azure. Apps can exchange messages through the relay when they make the right connection to it. 