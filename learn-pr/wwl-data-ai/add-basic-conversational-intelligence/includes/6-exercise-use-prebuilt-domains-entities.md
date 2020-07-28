Prebuilt domains are used as pre-trained models for your intents and entities. Entities represent the specific information, or data, from the utterances.  Rather than trying to manage common types of information yourself, you should use the prebuilt entities included with LUIS.  These represent information such as:

- dates
- times
- numbers
- measurements
- currency

>[!NOTE]
>Support for prebuilt entities will vary by culture. You can reference the [prebuilt entity](https://docs.microsoft.com/azure/cognitive-services/luis/luis-reference-prebuilt-entities) page to determine the support for you specific culture.

## Add prebuilt domains

1. Navigate to your LUIS portal and open the app you have been creating in this module.
1. In the left toolbar, select **Prebuilt Domains**.
1. Take a few  minutes to review the listed domains to get an idea on the specific uses.
1. Select the **Add domain** button under **Places**.
1. Select the **Add domain** button under **Utilities**.
1. Select **Intents** in the left toolbar.
1. You should notice there are already additional intents added, based on the selections you made for prebuilt domains.
1. These prebuilt intents already contain trained utterances.
1. Select the **Places.AddFavoritePlace** intent.
1. Note the example utterances that are already part of this intent.
1. Navigate to the **Entities** page.
1. Note the new additions to the entities based on the prebuilt domains you added.
1. Select the **Places.Nearby** entity and review the list of values and associated synonyms.  These are used to represent sample entity keywords related to location of items.
1. You can add synonyms on this screen by selecting the **Type in value...** location and entering the new synonym. Select the option next to **Adjacent** and enter the text **close by**, then press Enter.  Your new synonym is now added to the entity.
1. Removing a synonym can be accomplished by select the **X** next to the synonym. Select the **X** next to the **close by** synonym you just added.  The value is deleted.
