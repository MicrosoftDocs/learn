In this unit, you create an instance of a digital twins resource and collect the connection data you need to access the instance.

## Create an instance of a Digital Twin resource

1. Open the [Azure portal](https://portal.azure.com/#home/?azure-portal=true) in new browser window.

1. Select **+ Create a resource**.

1. In the **Search the marketplace** text box, enter "digital twins".

1. Select **Azure Digital Twins** when the option appears. Select **Create**.

1. In the **Create Resource** pane that appears, for the **Subscription** entry, select a subscription you belong to where you have administrator access.

1. For **resource group**, select an existing resource group where you want the Digital Twin instance to exist, or create a new one.

1. For **Location**, select the region nearest to you.

1. For **Resource name**, enter a friendly name. For example: "digital-twins-instance".

    :::image type="content" source="../media/create-digital-twins-instance.png" alt-text="Screenshot showing the completed Create Resource pane for a digital twins instance" lightbox="../media/create-digital-twins-instance.png":::

1. Select **Review + create**. Then Select **Create**.

1. Wait a few moments while **Deployment in progress** appears, then select **Go to resource** when it's ready. You should see a screen with the title **Get started with Azure Digital Twins**.

The next step is to save some important data used to connect other resources to your digital twins instance.

### Save the connection data to a reference file

1. It's a good idea to create a text file to store and work with connection string data. Using a tool such as Notepad, create a file called "twins connections.txt" or something similar.

1. Copy the name of your digital twins instance, **digital-twins-instance**, to the text file.

1. Locate the **Resource group** field, near the top left of your screen. Notice that if you hover the mouse pointer over the name, a copy icon appears. Copy the name of your resource group to your text file.

1. Locate the **Host name**. Again, hover the mouse over the name, and use the icon to copy the host name to your text file.

1. The host name forms the bulk of a connection url to your digital twins instance. Complete the url by adding **https://** to the start of the host name in your text file.

### Specify a role

1. Locate and select the **Access control (IAM)** entry, in the left menu.

1. If you select **Role assignments**, you should see your name with the **Owner** role. This is *not* the role that you need to access the resource. The role you need is **Azure Digital Twins Data Owner**.

    > [!NOTE]
    > If you get the following warning message, ignore it. You don't need to see other role assignments.

    :::image type="content" source="../media/permission-error.png" alt-text="Screenshot showing a permissions warning message" lightbox="../media/permission-error.png":::

1. Select **+ Add**, then select **Add role assignment**.

1. In the **Role** field, search for **Azure Digital Twins Data Owner** and select it.

1. The **Assign access to** field should say **User, group, or service principal**.

1. In the **Select** field, enter enough of your name or email so that your full name and email address appears in the search results list.

1. Select your entry, and notice that your details now appear under a **Selected members:** title.

1. Select **Save**. After a few seconds, you should see your details added to the role assignments, but now with the correct role.

    :::image type="content" source="../media/create-role-assignment.png" alt-text="Screenshot showing the correct role assignments for a digital twins instance" lightbox="../media/create-role-assignment.png":::

Great work. You have completed the bulk of the setup for this module. Next, you'll go over the format and purpose of the digital twin models.
