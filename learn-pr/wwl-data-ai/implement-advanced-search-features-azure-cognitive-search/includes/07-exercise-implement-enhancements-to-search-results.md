You have an existing search service that a holiday booking app uses. You've seen that the relevance of search results is impacting the number of bookings you're getting. You've also recently added hotels in Portugal so would like to offer Portuguese as a supported language.

In this exercise, you'll add a scoring profile to improve the relevance of search results. Then you'll use Azure AI Services to add Portuguese descriptions for all your hotels.

> [!NOTE]
>To complete this exercise, you will need a Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at [https://azure.com/free](https://azure.com/free?azure-portal=true).


### Create Azure resources

You'll create a Cognitive Search Service and import sample hotel data. 

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. Select **+ Create a resource**.
1. Search for **cognitive search**, and then select **Azure Cognitive Search**.
1. Select **Create**.
1. Create a Resource group, name it **learn-advanced-search**.
1. In **Service name**, enter **advanced-search-service-12345**. The name needs to be globally unique so add random numbers to the end of the name.
1. Select a supported Region near you.
1. Use the default values for the **Pricing tier**.
1. Select **Review + create**.
1. Select **Create**.
1. Wait for the resources to be deployed, then select **Go to resource**.

### Import sample data into the search service

Import the sample data. 

1. On the **Overview** pane, select **Import data**.

    :::image type="content" source="../media/import-data.png" alt-text="A screenshot showing the import data menu.":::
1. On the **Import data** pane, in **Data source**, select **Samples**. 
1. Select **hotels-sample**.

    :::image type="content" source="../media/add-cognitive-services.png" alt-text="A screenshot showing selecting adding Azure AI Services.":::

1. On the **Add cognitive skills (Optional)** tab, expand **Attach Azure AI Services**, then select **Create new Azure AI Services resource**.

#### Create a Cognitive Service to support translations

1. In the new tab, sign in to the Azure portal.
1. In **Resource group**, select the **learn-advanced-search**.
1. In **Region**, select the same region you chose for the search service.
1. In **Name**, enter **learn-cognitive-translator-12345**. The name needs to be globally unique so add random numbers to the end of the name.
1. In **Pricing tier**, select **Standard S0**.
1. Check **By checking this box I acknowledge that I have read and understood all the terms below**.
1. Select **Review + create**.
1. Select **Create**.
1. When the resources have been created, close the tab.

#### Add a translation enrichment

1. On the **Add cognitive skills (Optional)** tab, select Refresh.
1. Select the new cognitive service, **learn-cognitive-translator-12345**.
1. Expand the **Add enrichments** section.

    :::image type="content" source="../media/add-translation-enrichment.png" alt-text="A screenshot showing adding Portuguese translation.":::

1. Select **Translate text**, change the **Target Language** to **Portuguese**, then change the **Field name** to **Description_pt**.
1. Select **Next: Customize target index**.

#### Change the field to store translated text

1. On the **Customize target index** tab, scroll to the bottom of the field list and change the **Analyzer** to **Portuguese (Portugal) - Microsoft**.
1. Select **Next: Create an indexer**.
1. Select **Submit**.

    The index is created, the indexer will be run, and 50 documents containing sample hotel data will be imported.
1. On the **Overview** pane, select **Indexes**, then select **hotels-sample-index**.
1. Select **Search** to see JSON for all of the documents in the index.
1. Search for **Description_pt** in the results and note that it isn't a Portuguese translation of the English description.

    ```json
    "Description_pt": "45",
    ```

The Azure portal assumes the first field in the document needs to be translated. So it's currently using the translation skill to translate the `HotelId`.

#### Update the skillset to translate the correct field in the document

1. At the top of the page, select the search service, **advanced-search-service-12345**
1. On the **Overview** pane, select **Skillsets**, then select **hotels-sample-skillset**.
1. Edit the JSON document, change line 11 to:

    ```json
    "context": "/document/Description",
    ```
1. Change the default from language to English on line 12:

    ```json
    "defaultFromLanguageCode": "en",
    ```

1. Change the source field on line 18 to:

    ```json
    "source": "/document/Description"
    ```
1. Select **Save**.
1. At the top of the page, select the search service, **advanced-search-service-12345**
1. On the **Overview** pane, select **Indexers**, then select **hotels-sample-indexer**.
1. Select **Indexer Definition (JSON)**.
1. Change the source field name on line 21 to:

    ```json
    "sourceFieldName": "/document/Description/Description_pt",
    ```
1. Select **Save**.
1. Select **Reset**.
1. Select **Run**.

#### Test the updated index

1. At the top of the page, select the search service, **advanced-search-service-12345**
1. On the **Overview** pane, select **Indexes**, then select **hotels-sample-index**.
1. Select **Search** to see JSON for all of the documents in the index.
1. Search for **Description_pt** in the results and note that now there is a Portuguese description.

    ```json
    "Description_pt": "O maior resort durante todo o ano da área oferecendo mais de tudo para suas férias – pelo melhor valor!  O que você pode desfrutar enquanto estiver no resort, além das praias de areia de 1,5 km do lago? Confira nossas atividades com certeza para excitar tanto os jovens quanto os jovens hóspedes do coração. Temos tudo, incluindo ser chamado de \"Propriedade do Ano\" e um \"Top Ten Resort\" pelas principais publicações.",
    ```
1. Search for hotels that have views of lakes. Start by using a simple search but return only the `HotelName`, `Description`, `Category`, and `Tags`. 
1. In the **Query string**, enter this search:

    `lake + view&$select=HotelName,Description,Category,Tags&$count=true`

    Look through the results and try to find the fields that matched the `lake` and `view` search terms. Note this hotel and its position:

    ```json
    {
      "@search.score": 0.9433406,
      "HotelName": "Lady Of The Lake B & B",
      "Description": "Nature is Home on the beach.  Save up to 30 percent. Valid Now through the end of the year. Restrictions and blackout may apply.",
      "Category": "Luxury",
      "Tags": [
        "laundry service",
        "concierge",
        "view"
      ]
    },
    ```

This hotel has matched the term lake in the `HotelName` field and on view in the `Tags` field. You'd like to boost matches of terms in the `Description` field over the hotel's name. Ideally, this hotel should be last in the results.

### Add a scoring profile to improve search results

1. Select the **Scoring profiles** tab.
1. Select **+ Add scoring profile**.
1. In **Profile name**, enter **boost-description-categories**.
1. Select **Add scoring profile**.
1. Select **Add weights**.

    :::image type="content" source="../media/add-weights.png" alt-text="A screenshot of weights being added to a scoring profile.":::
1. In **Field name**, select **Description**.
1. In **Weight**, enter **5**.
1. In **Field name**, select **Category**.
1. In **Weight**, enter **3**.
1. In **Field name**, select **Tags**.
1. In **Weight**, enter **2**.
1. Select **OK**.
1. On the right, select **...**
1. Select **Set as default profile**.
1. Select **Save**.

#### Test the updated index

1. At the top of the page, select the search service, **advanced-search-service-12345**
1. On the **Overview** pane, select **Indexes**, then select **hotels-sample-index**.
1. In the **Query string**, enter the same search as before:

    `lake + view&$select=HotelName,Description,Category,Tags&$count=true`

    Check the search results. 

    ```json
    {
      "@search.score": 3.5707965,
      "HotelName": "Lady Of The Lake B & B",
      "Description": "Nature is Home on the beach.  Save up to 30 percent. Valid Now through the end of the year. Restrictions and blackout may apply.",
      "Category": "Luxury",
      "Tags": [
        "laundry service",
        "concierge",
        "view"
      ]
    }
    ```

    The search score has increased, from **0.9433406** to **3.5707965**. However, all the other hotels have higher calculated scores. This hotel is now last in the results.

### Delete exercise resources

Now that you've completed the exercise, delete all the resources you no longer need. Start with the code cloned to your machine. Then delete the Azure resources.

1. In the Azure portal, select **All resources**.
1. Select the resources you don't need, then select **Delete**.
