CluedIn was designed so that you can decide to improve the data in any order that you want. For example, we could enrich data first and deduplicate the data afterwards. Or, we could clean the data first, then deduplicate the data, and then enrich the data afterwards. This flexibility means your data can be continually improved without having to rework the entire system.

The first step in knowing how to keep improving your data is to get some idea of what is wrong in the first place.

## Assess your data quality

In CluedIn, select the **Data Quality** menu option, where you discover CluedIn's inbuilt Data Quality metrics scoring, where the data is scored across 17 different dimensions. You can see that overall, the completeness of all the data in CluedIn isn't great. These scoring metrics tell us that we have many records that are missing values. We can start here.

There are a couple of tools you can use to fix this incompleteness:

- You could expose the data to a third party tool like Azure Functions or Azure Databricks, and they can take an engineering approach to it.
- You could use the inbuilt enrichers of CluedIn that might be able to use third party data brokers to complete the data.
- You can use the Data Stewarding Tools in CluedIn, and manually complete the data. Or you can use sophisticated techniques that suggest completed data to you.

As always, the good news, is that there's no required option. You could do one approach or all approaches and in any order that you want. It's worth mentioning, however, that based off the data, it pays off to do one process before the other. In practice, this approach minimizes the amount of manual analysis and work.

For example, we might have a record that's missing its Twitter and LinkedIn profile, because there's a data quality issue with the website URL in the data. We could either manually enter the LinkedIn and Twitter profile in the stewarding tool, or if we fix the website url issue. If we fix the URL issue, then the enrichers in CluedIn would be able to automatically enrich those values for you. Or, if we found that we're missing the LinkedIn and Twitter profiles, but we did have a VAT Number. Then, chances are that external services wouldn't only provide us with the LinkedIn and Twitter profile, but would automatically correct our website url issue.

What is most important, is that no matter how you apply or make these changes, the Azure Data Lake Storage (ADLS) Gen2 is automatically updated in real time with the same changes.

>[!NOTE] 
> If the idea of automatic, downstream changes is frightening, do know that filters can be setup on the streams to only allow data to leave the platform if it meets certain requirements. 