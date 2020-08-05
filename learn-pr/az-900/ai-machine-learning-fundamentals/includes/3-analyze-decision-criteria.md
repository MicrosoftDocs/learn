In this unit, we'll analyze the criteria that experts employ when deciding which Azure artificial intelligence (AI) service to use for a given business need.  Understanding the criteria can also help you better understand the nuanced differences between each product.

## Four factors to consider

With such a wide array of options and tools, it can be difficult to know which tool is the best one for the job.

### Do you need a Bot?

Use the Bot Service when you need to create an agent to interact with humans using natural language.  The Bot Service provides the form factor and logic to interact via natural language.  However, for many solutions you will also rely on additional AI services.  For example, you will need to train the Bot with the kinds of questions you anticipate your users will ask and pair them with the answers you want to respond with.

Before jumping in to build a custom chat experience using Azure Bot Service, it might make sense to search for pre-built, no-code solutions that cover common scenarios.  For example, QnA Maker, available from the Azure Marketplace, allows you to build, train and publish a sophisticated bot using FAQ pages, support websites, product manuals, SharePoint documents or editorial content through an easy-to-use UI or via REST APIs.  Likewise, Power Virtual Agents integrate with Microsoft's Power Platform allowing you to use  hundreds of prebuilt connectors for data input.  You can extend the Power Virtual Agent by building custom workflows with Power Automate, and if you feel that the out-of-the-box experience is too limiting, you can still build more complex intractions with Microsoft Bot Framework.

### Do you need to train custom models or can you use "off the shelf" trained models?

Azure Cognitive Services provides ready-to-use models, that are for general purpose usage while Azure Machine Learning allows you to build custom models using your own custom algorithms and data to train the models.  When it comes to general purpose tasks like performing speech to text, integrating with search, identifying the objects in an image, and so on, it probably doesn't make sense to re-invent the wheel.  Instead, it's likely a better use of resources to use Azure Cognitive Services.

However, if you need to analyze years worth of financial transactions to discover new patterns that could help you create new products and services for your company's clients and offer those new services during routine customer service calls, then you will likely need to build a more custom, tailored model.  In this case, you would work with data scientists at your organization to use Azure Machine Learning.

### Do you have Data Science or Programmer expertise?

Use Cognitive Services when you have developers that do not have deep data science backgrounds, and your solution can use a generalized solution that doesn't necessarily need to be trained from your own data.  Machine learning problems require familiarity with the specific subject matter and data of the problem under consideration, as well as expertise in data science.

### How soon do you need it?

Cognitive Services are generally ready to be used within minutes, not days or weeks, because it provides a trained model for you. This brings data and an algorithm together, available from a REST API(s) or SDK. 

Machine learning is a process that generally requires a longer period of time to implement successfully. This time is spent on data collection, cleaning, transformation, algorithm selection, model training, and deployment to get to the same level of functionality provided by a Cognitive Service. With machine learning, it is possible to provide answers to highly specialized and/or specific problems.