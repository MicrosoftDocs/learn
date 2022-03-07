Now it's your opportunity to explore Azure Cosmos DB.

This exercise can be completed using a Microsoft Learn *sandbox*, which provides a temporary Azure subscription. To activate the sandbox subscription, you must sign in using a Microsoft account. The sandbox subscription will be automatically deleted when you complete this module. After the sandbox has been activated, [sign into the Azure portal using the credentials you used to start your sandbox session](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). Ensure you're working in the **Microsoft Learn Sandbox** directory - indicated at the top right of the portal under your user ID. If not, select the user icon and switch directory.

[!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

> [!TIP]
> If you prefer, you can use your own Azure subscription. To do so, [sign into the Azure portal using credentials for your subscription](https://portal.azure.com?azure-portal=true). Ensure you are working in the directory containing your subscription - indicated at the top right under your user ID. If not, select the user icon and switch directory.

## Create a Cosmos DB account

To use Cosmos DB, you must provision a Cosmos DB account in your Azure subscription. In this exercise, you'll provision a Cosmos DB account that uses the core (SQL) API.

1. In the Azure portal, select **+ Create a resource** at the top left, and search for *Azure Cosmos DB*.  In the results, select **Azure Cosmos DB** and select  **Create**.
1. In the **Core (SQL) - Recommended** tile, select **Create**.
1. Enter the following details, and then select **Review + Create**:
    - **Subscription**: If you're using a sandbox, select *Concierge Subscription*. Otherwise, select your Azure subscription.
    - **Resource group**:  If you're using a sandbox, select the existing resource group (which will have a name like *learn-xxxx...*). Otherwise, create a new resource group with a name of your choice.
    - **Account Name**: Enter a unique name
    - **Location**: Choose any available location
    - **Capacity mode**: Provisioned throughput
    - **Apply Free-Tier Discount**: Select Apply if available
    - **Limit total account throughput**: Unselected
1. When the configuration has been validated, select **Create**.
1. Wait for deployment to complete. Then go to the deployed resource.

## Create a sample database

1. On the page for your new Cosmos DB account, in the pane n the left, select **Data Explorer**.
1. In the **Data Explorer** page, select **Start with Sample** and then observe the status in the panel at the bottom of the screen until the **SampleDB** database and the sample **Persons** container has been created (which may take a minute or so).
1. Select **Close** on the notification message.

## View and create items

1. In the Data Explorer page, expand the **SampleDB** database and the Persons container, and select **Items** to see a list of items in the container. The items represent people, each with a unique id, a firstname, an age, and other properties.
2. Select any of the items in the list to see a JSON representation of the item data.
3. At the top of the page, select **New Item** to create a new blank item.
4. Modify the JSON for the new item as follows, and then select **Save**.

```json
{
    "id": "123",
    "firstname": "Bob",
    "age": 54
}
```

5. After saving the new item, notice that additional metadata properties are added automatically.

## Query the database

1. In the **Data Explorer** page, select the **New SQL Query** icon.
2. In the SQL Query editor, review the default query (`SELECT * FROM c`) and use the **Execute Query** button to run it.
3. Review the results, which includes the full JSON representation of all items.
4. Modify the query as follows:

```sql
SELECT c.id, c.firstname, c.age
FROM c
WHERE c.age > 40
```

5. Use the **Execute Query** button to run the revised query and review the results, which includes JSON containing the id, firstname, and age fields for person items with an age greater than 40.
6. Close the SQL Query editor, discarding your changes.

    You've seen how to create and query JSON entities in a Cosmos DB database by using the data explorer interface in the Azure portal. In a real scenario, an application developer would use one of the many programming language specific software development kits (SDKs) to call the core (SQL) API and work with data in the database.

> [!TIP]
> If you used your own Azure subscription, and you have finished exploring Azure Cosmos DB, you can delete the resource group that you created in this exercise.
