One of the values of a system like CluedIn is that it builds golden records. Golden records are an amalgamation of many records from across one or more sources that are essentially the same semantic entity. 

For example, the term "Single View of Customer". You could imagine that all the information you have on a particular customer would be found in this one view, pieced together from different systems. In many cases, each system has a different representation of the same value. It's the role of CluedIn to interrogate this and automatically blend data together. So instead of having the "Microsoft" customer record in Dynamics CRM and the "Microsoft Corporate" record from Office 365, we have one record merged together, with a lineage of what values came from Dynamics CRM and which values came from Office 365.

It's also the responsibility of CluedIn to manage the merge conflicts. For example, if Dynamics CRM is saying that the company website is https://www.microsoft.com and Office 365 is saying http://microsoft.com. Essentially both values are correct, but we need to choose which one we want to represent the final composed record that we'll send to the downstream systems. Even after making these choices, CluedIn will maintain a history of all values, which can be made available to the downstream consumers.  

Deduplication in CluedIn is an iterative and cyclical process. If you have cleaner and more enriched data, then typically the deduplication can be more confident in identifying and merging duplicate records. So the advice here's that you should only merge records with high confidence and it's ok and sometimes even recommended that you wait to have more data or cleaner data before committing to a merge. You can always undo merges if you find later on they're incorrect.

The process of detecting duplicates is about first of all getting a list of possible duplicates and then going through a process of merging and survivorship. The survivorship in CLuedIn can either be automated or manual. When the Auto-Select is chosen, it will fall back to using the default Golden Record Evaluator. If not selected then you can manually choose which properties from which records will make its way to the Golden Record. Once again, you can always undo this at a later point if necessary.

So far in the exercise, we have found that the majority of our records were able to actually merge of perfect identifier matches, however if we look at the records in our Products.csv files in the Navision and YellowSystems folders, we can see that there are no overlaps of identifiers, however there is an overlap of names. Although it would not be safe to say that we can use the Name as a way to find matching products in general, we can setup deduplication projects to detect this and put through manual deduplication of data. 

1. In the left hand side menu of CluedIn, select Management -> Deduplication. 

    ![Deduplication_Menu](../media/Deduplication_Menu.png)

1. Create a new deduplication project called "Products" and select the Entity Type of "Product". 

    ![Deduplication_Product](../media/Deduplication_Product.png)

1. Give the project a useful description and select "Create".

    Under the tab called "Matching Rules", create a new rule called "Match on Name".

    ![Match_On_Name](../media/Match_On_Name.png)

1. When prompted to provide input, choose the radiobox for 'Property' in which choose the Name of the record. 

    It will ask you to choose an comparor, in which we can keep it very simple for now and use the Equals comparetor.

    ![Simple_Matching_Rule](../media/Simple_Matching_Rule.png)

1. Select "Generate Results".

    Within about 10 to 15 seconds you will notice that it should bring back 10 results in your list. These are essentially 10 "clusters" of results where the comparator has found matches. 

1. Select through to the first cluster, where you will be asked to choose the surviing properties from the 2 records of the cluster. Feel free to chose the values that you would like to keep as part of the golden record and select "Preview".

    This will show you a preview of what the final record will look like if you were to approve this merge. 

1. Select "Approve".

1. Repeat the same process for the other 9 clusters. 

    When you are finished merging all 10 clusters, select all items in the list and select the "Merge All" button. 

    Head back to your search once you receive a notification that the process has finished and you will now find that you have 10 products in the system now, not 20. 

1. Open the product called "MDM" and head to the Topology tab. You will see that CluedIn is telling us that the reason why the 2 products for MDM in each file were merged was because of the deduplication project that we just submitted.

>[!NOTE]
> You can select any of these records an revert what has just been done if necessary. 