Now that we addressed the duplicate records in the system, we need to fix the data quality issues that we detected when we looked at the raw data.

For this task, we use the CluedIn data steward tool: CluedIn Clean.

1. In CluedIn, in the left hand menu, select **Preparation** -> **Clean**.

    :::image type="content" source="../media/clean.png" alt-text="Screenshot of the CluedIn preparation window.":::

1. Select **Create Project** and choose the entity type. For this example, we choose **Employee**.

1. In the new cleaning project, select **Create new clean project**.

1.When finished, select the new clean project from the menu. This launches a studio in a new tab with your employee records.

1. On the employee.job header, select the drop-down, select **Facet**, and select **Text Facet**.

    :::image type="content" source="../media/clean-text-facet.png" alt-text="Screenshot of the ClueIn project window, showing the header dropdown with facet and text facet selected.":::

1. On the left hand side, you see that CluedIn shows an aggregation of all of the unique values of that column. It also shows a count next to each item to reflect how many rows share a column value.

1. Select the **Cluster** button. CluedIn shows a prompt that suggests where the data quality issues lie, and the proposed solution on what to normalize the values to. 

1. From the dropdown, choose the **Keying function** option. Choose the **metaphone3** option in the subsequent dropdown.

    You notice that CluedIn is recommending that all of the different spelling of Accounting on the left and proposing that they're all normalized into **Accounting** on the right. Accept this suggestion and the one for Software Dev.

    :::image type="content" source="../media/clean-keying-function.png" alt-text="Screenshots of the Cluster & Edit column person.job page.":::

1. Cycle through all the other Keying functions and their suggestions until all the values are normalized. There are now only two permutations of the Job titles that we had in the original raw data.

1. Close this tab, and on the previous tab you used to get to this application, select **Commit**.

1. When prompted, make sure that the checkbox for **Auto-creating Rules** is ticked.

## Analyzing the results

The previous exercise yields a few elements, including:

- If we look at the records in CluedIn, we can see that some data is changed. For example, Lorain now has a new Job Title with the history of the old job title.
- Under the Rules menu within CluedIn, there are two business rules automatically created for us (disabled by default).
- If we look in our container storage, we can see that new files are created that include the delta changes.

1. Go back to the automated rules that were constructed and select them all. Toggle to activate them.

    :::image type="content" source="../media/rules-created.png" alt-text="Screenshot of the rules in CluedIn that you can activate by toggling.":::

1. Return to the data sources in CluedIn. Map the final file called ContactsAddLater.csv that had the same data quality issues in it. This time, just process the data directly and don't clean it at all.

1. Go back to your container storage, and notice that you have even more files now. CluedIn's rules automatically fixed their job titles.