Now that we have addressed the duplicate records in the system, it is now important that we fix the data quality issues that we detected when we looked at the raw data. 

For this, we will be using the CluedIn Data Steward tool - CluedIn Clean. 

1. In the left hand menu, select Preperation -> New Clean. 

    ![New_Clean](images/New_Clean.png)

1. Select "Create Project" in which CluedIn will then ask you to specify what records and what columns you would like to clean.

1. For the filter, choose "Entity Type equals Employee" and for the properties, choose "employee.Job".

    This will create a cleaning project, in which you will need to select "Generate Project". Once this is finished you will received a link to "Clean" the data. Selecting on the "Clean" button will launch a studio in a new tab with your 10 Employee records in which you will see a column name for the Origin Entity Code and the person.Job column. 

    >[!NOTE]
    > Don't delete the column name for the Origin Entity Code as it is the reference of what to save these records back to. 

1. On the person.job header, select the drop down and select "Text Facet".

    ![Clean_Text_Facet](images/Clean_Text_Facet.png)

    On the left hand side you will see that CluedIn shows an aggregation of all of the unique values of that column and then a count next to each item to reflect how many rows share a column value. 

1. Select the "Cluster" button in which CluedIn will show a prompt that will suggest where the data quality issues lie, and the proposed solution on what to normalise the values to. 

    From the dropdown, choose the "Keying function" option and the the subsequent dropdown, choose the "metaphone3" option. 

    ![CleaN_Keying_Function](images/CleaN_Keying_Function.png)

    You will notice that CluedIn is recommending that all of the different spelling of Accounting on the left and proposing that they are all normalised into "Accounting" on the right. Accept this suggestion and the one for Software Dev and then change cycle through all the other Keying functions and their suggestions until all the values are normalised and that there are now only 2 permutations of the Job titles that we had in the origianl raw data. 

1. Close this tab, and on the previous tab you used to get to this application, select "Process".

    When prompted, make sure that the checkbox for "Auto-creating Rules" is ticked. 

## Analysing the results

This exercise above has yielded a few elements, including:

 - The records in CluedIn e.g. Lorain, now has a new Job Title (with the history of the old job title)
 - Under the Rules menu within CluedIn, we have seen 2 business rules automatically created for us (disabled by default).
 - If we look in our Container Storage, we can see that new files have been created that include the delta changes. 


1. Head back to the automated rules that were constructed and select them all and toggle to activate them. 

    ![Rules_Created](images/Rules_Created.png)

1. Head back to the datasources in CluedIn, and map the final file called ContactsAddLater.csv that had the same data quality issues in it, but this time, just process the data directly and don't clean it at all. 

1. If you head back to your Container Storage, you will notice that you have even more files now, however their job titles have been automatically fixed by CluedIn due to our rules. 