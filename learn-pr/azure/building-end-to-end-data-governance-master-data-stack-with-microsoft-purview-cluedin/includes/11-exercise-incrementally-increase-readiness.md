We're off to a good start where the data is merging and linking. We still have quite a way to go before this data is of better quality, but the downstream consumers can already start working with it.

CluedIn was designed that you can decide to improve the data in any order that you want. For example, we could either enrich data first and deduplicate the data afterwards or we could clean the data first and then deduplicate the data and then enrich the data afterwards. Once again, this speaks to the agility of the platform that we don't have to run things in a classic waterfall approach where one part of the story must be done before we can start the next. 

The first step in knowing what to do, is probably to get some idea of what is wrong in the first place. 

## Assess your data quality

1. Select the Data Quality menu option, where you'll discover CluedIn's inbuilt Data Quality metrics scoring the data across 17 different dimensions. This is a great place to start. You can see that overall, the completes of all the data in CluedIn isn't great. This would tell us that we have many records that are missing values. Although not required, this is a place to start. 

1. For this, there are a couple of tools I can use to fix this incompleteness:

    - I could expose the data to a third party tool like Azure Functions, Azure Databricks and they can take an engineering approach to it.
    - I could use the inbuilt enrichers of CluedIn that may be able to use third party data brokers to complete the data.
    - I can use the Data Stewarding Tools in CluedIn, and manually complete the data or use sophisticated techniques to have completed of data suggested to me.

 As always, the good news, is that there's no required option above, you could do one approach or all approaches and in any order that you want. However it's worth mentioning that based off the data, in practice, to minimize the amount of manual analysis and work, it does pay off to do one process before the other.

For example: we may have a record that is missing it's Twitter and LinkedIn profile and it is because there's a data quality issue with the website url we have in the data. We could either manually enter the LinkedIn and Twitter profile in the stewarding tool, or if we fix the website url issue, then the enrichers in CluedIn would be able to automatically enrich those values for you. Or, if we found that we were missing the LinkedIn and Twitter profiles, but we did have a VAT Number, then chances are that external services wouldn't only provide us with the LinkedIn and Twitter profile, but would automatically correct our website url issue.

 What is most important is that no matter how I apply or make these changes, the ADLS Gen2 will be automatically updated in real time with these changes as well.

>[!NOTE] 
> If the idea of automatic, downstream changes is frightening, do know that filters can be setup on the streams to only allow data to leave the platform if it meets certain requirements. 