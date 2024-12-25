One of the values of a system like CluedIn is that it builds golden records. Golden records are an amalgamation of many records from across one or more sources that are essentially the same semantic entity.

For example, the term **Single View of Customer**. In many cases, each system has a different representation of the same value. It's the role of CluedIn to interrogate these representations and automatically blend data together so that all the information you have on a particular customer is found in this one view. For example, instead of having the "Microsoft" customer record in Dynamics CRM and the "Microsoft Corporate" record from Office 365. We have one record merged together, with a lineage of which values came from Dynamics CRM and which values came from Office 365.

It's also the responsibility of CluedIn to manage the merge conflicts. For example, if Dynamics CRM is saying that the company website is `https://www.microsoft.com` and Office 365 is saying `http://microsoft.com`. Essentially both values are correct, but we need to choose which one we want to represent the final composed record that we send to the downstream systems. Even after CluedIn makes these choices, it maintains a history of all values, which can be made available to the downstream consumers.  

Deduplication in CluedIn is an iterative and cyclical process. If you have cleaner and more enriched data, then typically the deduplication can be more confident in identifying and merging duplicate records. So, a good approach is to only merge records with high confidence. Although it's ok and sometimes even recommended that you wait to have more data or cleaner data before committing to a merge. You can always undo merges if you find later on they're incorrect.

The process of detecting duplicates is about getting a list of possible duplicates and then going through a process of merging and survivorship. The survivorship in CLuedIn can either be automated or manual. When the Auto-Select is chosen, it falls back to using the default Golden Record Evaluator. If it isn't selected, then you can manually choose which properties from which records should make their way to the Golden Record. Once again, you can always undo this selection at a later point.

## Example process

So far in the exercise, we found that most of our records were the result of merging perfect identifier matches. However, if we look at the records in our Products.csv files YellowSystemsProducts.csv, we can see that there are no overlaps of identifiers, but there's an overlap of names. In general, it isn't safe to say that we can use the Name field as a way to find matching products. However, we can set up deduplication projects to detect this fact and put through manual deduplication of data.

1. In the left hand side menu of CluedIn, select **Management** -> **Deduplication**.

    :::image type="content" source="../media/deduplication-menu.png" alt-text="Screenshot of CluedIn duplicate management dashboard.":::

1. Create a new deduplication project called **Products** and select the Entity Type of **Product**.

    :::image type="content" source="../media/deduplication-product.png" alt-text="Screenshot of the CluedIn Create Duplication Project window.":::

1. Give the project a useful description and select **Create**.

1. Under the tab called **Matching Rules**, create a new rule called **Match on Name**.

    :::image type="content" source="../media/match-on-name.png" alt-text="Screenshot of the Add Matching Rule page.":::

1. When prompted to provide input, choose the radio button for **Property** to choose the name of the record.

1. It asks you to choose a comparator, in which we can keep it simple for now and use the Equals comparator.

    :::image type="content" source="../media/simple-matching-rule.png" alt-text="Screenshot showing the Equals comparator showing in the matching function.":::

1. Complete the project creator and then select **Generate Results** on the page.

    Within about 10 to 15 seconds, you should notice that it brings back 10 results in your list. These results are essentially 10 "clusters" of results where the comparator found matches.

1. Select through to the first cluster, where you're asked to choose the surviving properties from the two records of the cluster. Feel free to choose the values that you would like to keep as part of the golden record and select **Preview**.

1. Select **Approve**.

1. Repeat the same process for the other clusters.

1. When you're finished merging all the clusters, select all items in the list and select the **Merge All** button.

1. Head back to your search once you receive a notification that the process is finished. You now find that you have 10 products in the system, not 20.

1. Open the product called **MDM** and go to the Topology tab. You see that CluedIn is telling us that the reason the two products for **MDM** in each file were merged was because of the deduplication project that we submitted.

>[!NOTE]
> You can select any of these records an revert what has just been done if necessary.