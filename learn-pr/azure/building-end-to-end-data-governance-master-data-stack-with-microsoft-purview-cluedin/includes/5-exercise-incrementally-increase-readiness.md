Exercise - Incrementally increase the readiness of the data. 

We are off to a good start where the data is merging and linking. We still have quite a way to go before this data is of better quality, but the downstream consumers can already start. 

CluedIn was designed that you can decided to improve the data in any order that you want. For example, we could either enrich data first and deduplicate the data afterwards or we could clean the data first and then deduplicate the data and then enrich the data afterwards. Once again, this speaks to the agility of the platform that we do not have to run things in a classic waterfall approach where one part of the story must be done before we can start the next. 

The first step in knowing what to do, is probably to get some idea of what is wrong in the first place. Click on the Data Quality menu option in which you will discover CluedIn's inbuilt Data Quality metrics scoring the data across 17 different dimenions. This is a great place to start. You can see that overall, the completes of all the data in CluedIn is not great. This would tell us that we have many records that are missing values. Although not required, this is a place to start. 

For this, there are a couple of tools I can use to fix this incompleteness:

 - I could expose the data to a 3rd party tool like Azure Functions, Azure Databricks and they can take an engineering approach to it. 
 - I could use the inbuilt enrichers of CluedIn that may be able to use 3rd party data brokers to complete the data. 
 - I can use the Data Stewarding Tools in CluedIn, and manually complete the data or use sophisticated techniques to have completes of data suggested to me. 

 As always, the good news, is that there is no required option above, you could do one approach or all approaches and in any order that you want. However it is worth mentioning that based off the data, in practice, to minimise the amount of manual analysis and work, it does pay off to do one process before the other. For example, we may have a record that is missing it's twitter and linkedin profile and it is because there is a data quality issue with the website url we have in the data. We could either manually enter the linkedIn and Twitter profile in the stewarding tool, or if we just fixed the website url issue, then the enrichers in CluedIn would be able to automatically enrich those values for me. In saying that, if we found that we were missing the LinkedIn and Twitter profiles, but we did have a VAT Number, then chances are that external services would not only provide us with the LinkedIn and Twitter profile, but would automatically correct our website url issue.

 What is most important is that no matter how I apply or make these changes, the ADLSv2 will be automatically updated in real time with these changes as well. 

 NOTE: If the idea of automatic, downstream changes seems scary to you, do know that filters can be setup on the streams to only allow data to leave the platform if it meets certain requirements. 