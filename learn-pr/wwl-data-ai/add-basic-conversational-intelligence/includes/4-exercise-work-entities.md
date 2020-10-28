Next, let's create the entities we need to capture specific requests from users. For example, when users want to search the pictures, they might specify what they're looking for in the picture such as names, dates, product names, or any significant group of words. An utterance can include many entities or none at all. A client application may need the data to perform its task. 

An entity extracts data from a user utterance at prediction runtime. An optional, secondary purpose is to boost the prediction of the intent or other entities by using the entity as a feature.

There are several types of entities:

- Machine-learning entity - this is the primary entity. You should design your schema with this entity type before using other entities.
- Non-machine-learning used as a required feature - for exact text matches, pattern matches, or detection by prebuilt entities.
- Pattern.any - to extract free-form text such as book titles from a Pattern.

Machine-learning entities provide the widest range of data extraction choices. Non-machine-learning entities work by text matching and are used as a required feature for a machine-learning entity or intent.

>[!NOTE]
>Entities need to be labeled consistently across all training utterances for each intent in a model.

Find more specific guidance on creating good entities on the [Entity Concepts](https://docs.microsoft.com/azure/cognitive-services/luis/luis-concept-entity-types) page.

## Create entities in the LUIS portal

1. Ensure you are signed in to your LUIS app and on the **Build** tab.

1. In the left column, select **Entities**, and then select **+ Create**.

1. Name the entity **facet** (to represent one way to identify an image).

1. Select **Machine learned** for **Type**. Then select **Create**.

    :::image type="content" source="../media/select-facet.png" alt-text="Adding an entity named facet, of type Machine learned":::

## Add entities with code

In this exercise, you will use code to add the single **facet** entity to the application. You can use the code sample here to add multiple entities if you want.  The code will be the same as for a single entity.

:::zone pivot="csharp"

1. Create a new method in your Program.cs class to add an entity to the LUIS application.

   ```csharp
   // Create entity objects
   async static Task AddEntities(LUISAuthoringClient client, ApplicationInfo app_info)
   {
       // Add machine learned entity
       var facetEntityId = await client.Model.AddEntityAsync(app_info.ID, app_info.Version, new ModelCreateObject()
       {
           Name = "facet"
       });
   
       Console.WriteLine("Created entity facet");
   }
   ```

1. Modify Main() to add a call to this method immediately after the call to AddIntents().

   ```csharp
   await AddEntities(client, appInfo);
   ```

1. You will expand on this code in later units.

:::zone-end

:::zone pivot="python"

1. Create a function to add the entity to the LUIS app.

   ```python
   def add_entities(app_id, app_version):
   
       facetEntityId = client.model.add_entity(app_id, app_version, name="facet")
       print("facetEntityId {} added.".format(facetEntityId))
   ```

1. Modify the create_app() function by adding the following line of code under the add_intents() function.

   ```python
   add_entities(app_id, app_version)
   ```

1. You will expand on this code in later units.

:::zone-end
