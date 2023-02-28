Now that we've addressed the duplicate records in the system,  we need to fix the data quality issues that we detected when we looked at the raw data. 

For this, we'll be using the CluedIn data steward tool: CluedIn Clean.

1. In CluedIn, in the left hand menu, select **Preparation** -> **New Clean**.

    :::image type="content" source="../media/New_Clean.png" alt-text="Screenshot of the CluedIn preparation window.":::

1. Select **Create Project** and choose what records and columns you want to clean.

1. For the filter, choose **Entity Type equals Employee** and for the properties, choose **employee.Job**.

1. In the new cleaning project, select **Generate Project**. 

1. Once this is finished you'll received a link to "Clean" the data. Selecting the **Clean** button will launch a studio in a new tab with your 10 Employee records. You'll see a column name for the Origin Entity Code and the person.Job column.

    >[!NOTE]
    > Don't delete the column name for the Origin Entity Code as it is the reference of what to save these records back to.

1. On the person.job header, select the drop-down, select **Facet**, and select **Text Facet**.

    :::image type="content" source="../media/Clean_Text_Facet.png" alt-text="Screenshot of the ClueIn project window, showing the header dropdown with facet and text facet selected.":::

1. On the left hand side you'll see that CluedIn shows an aggregation of all of the unique values of that column and then a count next to each item to reflect how many rows share a column value.

1. Select the **Cluster** button. CluedIn will show a prompt that will suggest where the data quality issues lie, and the proposed solution on what to normalize the values to. 

1. From the dropdown, choose the **Keying function** option and the subsequent dropdown. Choose the **metaphone3** option.

    You'll notice that CluedIn is recommending that all of the different spelling of Accounting on the left and proposing that they're all normalized into **Accounting** on the right. Accept this suggestion and the one for Software Dev.

    :::image type="content" source="../media/CleaN_Keying_Function.png" alt-text="Screenshots of the Cluster & Edit column person.job page.":::

1. Cycle through all the other Keying functions and their suggestions until all the values are normalized and there are now only two permutations of the Job titles that we had in the original raw data.

1. Close this tab, and on the previous tab you used to get to this application, select **Process**.

1. When prompted, make sure that the checkbox for **Auto-creating Rules** is ticked.

## Analyzing the results

This exercise above has yielded a few elements, including:

* The records in CluedIn (For example: Lorain), now has a new Job Title (with the history of the old job title).
* Under the Rules menu within CluedIn, we've seen two business rules automatically created for us (disabled by default).
* If we look in our container storage, we can see that new files have been created that include the delta changes.

1. Go back to the automated rules that were constructed and select them all and toggle to activate them.

    :::image type="content" source="../media/Rules_Created.png" alt-text="Screenshot of the rules in CluedIn that can be toggled to be activated.":::

1. Return to the data sources in CluedIn, and map the final file called ContactsAddLater.csv that had the same data quality issues in it, but this time, just process the data directly and don't clean it at all.

1. If you go back to your container storage, you'll notice that you have even more files now, however their job titles have been automatically fixed by CluedIn's rules.