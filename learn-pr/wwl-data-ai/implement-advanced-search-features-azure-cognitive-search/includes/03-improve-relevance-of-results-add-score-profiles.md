
Azure AI Search uses the BM25 similarity ranking algorithm. The algorithm scores documents based on the search terms used.

Here, you'll see how to add scoring profiles to alter the scores for documents based on your own criteria.

### How search scores are calculated

Scoring is the last phase of processing a search query.

:::image type="content" source="../media/score-phase-small.png" alt-text="A diagram showing the score phase of search highlighted." lightbox="../media/score-phase.png"border="false":::

The search engine scores the documents returned from the first three phases. The score is a function of the number of times identified search terms appear in a document, the document's size, and the rarity of each of the terms. By default, the search results are ordered by their search score, highest first. If two documents have an identical search score, you can break the tie by adding an `$orderby` clause.

#### Improve the score for more relevant documents

As the default scoring works on the frequency of terms and rarity, the final calculated score might not return the highest score for the most relevant document. Each dataset is different, so AI Search lets you influence a document score using scoring profiles.

:::image type="content" source="../media/weighted-field-score.png" alt-text="A diagram showing a weighted field score." border="false":::

The most straightforward scoring profile defines different weights for fields in an index. In the above example, the Hotel index has a scoring profile that has the Description field five times more relevant than data in the Location or Rooms fields. The Category field is twice as relevant as the HotelName.

The scoring profile can also include functions, for example, distance or freshness. Functions provide more control than simple weighting, for example, you can define the boosting duration applied to newer documents before they score the same as older documents.

The power of scoring profiles means that instead of boosting a specific term in a search request, you can apply a scoring profile to an index so that fields are boosted automatically for all queries.

### Add a weighted scoring profile

You can add up to 100 scoring profiles to a search index. The simplest way to create a scoring profile is in the Azure portal. 

1. Navigate to your search service.
1. Select **Indexes**, then select the index to add a scoring profile to.
1. Select **Scoring profiles**.
1. Select **+ Add scoring profile**.
1. In **Profile name**, enter a unique name.
1. To set the scoring profile as a default to be applied to all searches select **Set as default profile**.
1. In **Field name**, select a field. Then for **Weight**, enter a weight value.
1. Select **Save**.

:::image type="content" source="../media/azure-portal-scoring-profiles.png" alt-text="A screenshot of the Azure portal scoring profiles pane.":::

In the above example, the `boost-category` scoring profile has been added to the `hotels-sample-index`. The Category has a weight of five.

The profile has also been set as the default profile. You can then use this search query:

`search=luxury AND Tags:'air con'*&$select=HotelId, HotelName, Category, Tags, Description&$count=true&queryType=full`

The results now match the same query with a term boosted:

`search=(Description:luxury OR Category:luxury^5) AND Tags:'air con'*&$select=HotelId, HotelName, Category, Tags, Description&$count=true&queryType=full`

You can control which scoring profile is applied to a search query by appending the `&scoringProfile=PROFILE NAME` parameter.

Scoring profiles can also be added programmatically using the Update Index REST API or in Azure SDKs, such as the ScoringProfile class in the Azure SDK for .NET.

#### Use functions in a scoring profile

The functions available to add to a scoring profile are:

|Function  |Description |
|----------|---------|
|Magnitude |Alter scores based on a range of values for a numeric field |
|Freshness |Alter scores based on the freshness of documents as given by a DateTimeOffset field |
|Distance  |Alter scores based on the distance between a reference location and a GeographyPoint field |
|Tag       |Alter scores based on common tag values in documents and queries |

For example, using the hotel index the magnitude function can be applied to the Rating field. The Azure portal will guide you through completing the parameters for each function.

:::image type="content" source="../media/function-parameters.png" alt-text="A screenshot showing the parameters for the magnitude function.":::
