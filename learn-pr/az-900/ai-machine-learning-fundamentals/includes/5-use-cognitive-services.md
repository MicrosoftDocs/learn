Tailwind Traders is faced with a different opportunity that could be solved using one of Microsoft's articial intelligence services.

## What's the opportunity?

The first generation of the Tailwind Trader's ecommerce website was available exclusively in English.  However, the Marketing department sponsored a demographics study for their brick-and-mortar locations.  On average, only 80% of potential customers spoke English, and that number is as high as 50% in some neighborhoods.  The Marketing department sees this as a wonderful opportunity to serve non-English speakers with the same online ecommerce experience as English speakers.  Given that there are several other high priority initiatives, they need to complete this project quickly -- within a month if possible.

But, how to quickly, easily and inexpensively translate every product description into most popular languages?  The ecommerce development team is looking at translating both strings of text that were formerly hard coded into the website's page templates as well as product titles and descriptions that are saved in the database.

### Which service should we choose?

Translating textual content from one language into another is a general purpose tasks that is made easy using Azure Cognitive Service's Translator.  It's is easy to integrate in your applications, websites, tools, and solutions. It allows you to add multi-language user experiences in more than 60 languages, and can be used on any hardware platform with any operating system for text-to-text language translation.

### Why not use Azure Machine Learning?

While it would be possible to create a Machine Learning model to perform multi-language translation, it would be expensive and time consuming for Tailwind Traders to attempt to do this themselves.  They do not have the linguistic competency, nor the linguistic data required to train the models.

### Why not use Azure Bot Service?

In this scenario, the Azure Bot Service would not be a candidate for consideration.  However, should Tailwind Traders ever implement a customer service agent, they may want to consider using the Translator's APIs to provide real-time translation to help customers who are not English speakers.