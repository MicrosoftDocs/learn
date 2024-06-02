In this unit, you'll use the [Microsoft Purview governance portal](https://web.purview.azure.com/) to provide a user within your Microsoft Entra read access to the data map. You'll then create another collection.

1. To open [Microsoft Purview governance portal](https://web.purview.azure.com/), you can use the link and select your account, or you can open the Azure portal, search for the Microsoft Purview account you created in the last session, and select **Open Microsoft Purview Governance Portal**.

    :::image type="content" source="../media/open-purview-studio.png" alt-text="Screenshot of the Microsoft Purview account in the Azure portal, with the Open Microsoft Purview governance portal button highlighted.":::

1. On the left-hand menu of [Microsoft Purview governance portal](https://web.purview.azure.com/), navigate to **Data map**. 

    :::image type="content" source="../media/locate-purview-data-map.png" alt-text="Screenshot of the Microsoft Purview governance portal left hand menu, with Data map highlighted.":::

1. Select **Collections**.

    :::image type="content" source="../media/locate-purview-collections.png" alt-text="Screenshot of the Microsoft Purview governance portal left hand menu, with the secondary menu opened and Collections highlighted.":::

1. Select the root collection. This should be the only collection on your new account, and will have the same name as your account.

    :::image type="content" source="../media/purview-root-collection.png" alt-text="Screenshot of the Microsoft Purview governance portal Collections page, with the root collection (ACCOUNT-NAME in this example) highlighted.":::

1. Select **Role assignments**.

    :::image type="content" source="../media/purview-role-assignments.png" alt-text="Screenshot of the Microsoft Purview governance portal root collection page, with the Role assignments button highlighted.":::

1. Open the **Edit role assignments** menu and select **Data readers**.

    :::image type="content" source="../media/purview-data-reader.png" alt-text="Screenshot of the Microsoft Purview governance portal root collection page, with the Edit role assignment drop-down menu opened, and Data readers selected.":::

1. Search for another user within your Microsoft Entra ID, select their account, select **OK**. This will grant the user read permissions on your Microsoft Purview account.

    :::image type="content" source="../media/purview-add-data-reader.png" alt-text="Screenshot of the Microsoft Purview governance portal Add or remove data readers menu open. The search bar is highlighted, and an example user is highlighted below.":::

1. Back at your root collection, select **+ Add a collection**

    :::image type="content" source="../media/add-a-collection.png" alt-text="Screenshot of the Microsoft Purview governance portal root collection page, with the Add a collection button highlighted.":::

1. Give your new collection a name. In this example, we've used 'Finance', but any name that suits the top level of your organization will work. You can also choose to add a collection admin for this collection. The collection will automatically inherit an admin from the root collection, but you can add another.

    :::image type="content" source="../media/create-collection.png" alt-text="Screenshot of the New collection window with 'Finance' added as an example name, and the Create button highlighted.":::

1. After you've created your collection, you'll automatically be navigated to this collection's page. You'll see it now has its own window where you can add a subcollection, edit, or add role assignments, just like the root collection.

    :::image type="content" source="../media/created-collection.png" alt-text="Screenshot of the newly created collection called 'Finance'. It has its own window where you can also edit, add role assignments, or a new collection.":::

1. Let's add one more collection under our new 'Finance' collection. Select the 'Finance' collection, then select **+ Add a collection**, and give your new collection a name. In our example, we've chosen 'Investment'.

    :::image type="content" source="../media/add-second-collection.png" alt-text="Screenshot creating a new collection called 'Investment'.":::


1. Once you've created your new collection, select the new collection, select **Role assignments**. Enable to **Restrict inherited permissions** toggle. This will create a secure subcollection that won't inherit permissions from the Finance or root collections.

    :::image type="content" source="../media/restrict-inherited-permissions.png" alt-text="Screenshot of the newly created collection called 'Investment', selected and open to the Role assignments tab. The Restrict inherited permissions option has been turned on.":::
