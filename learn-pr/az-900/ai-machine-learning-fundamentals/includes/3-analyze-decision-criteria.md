In this unit, you'll analyze the criteria experts employ when choosing an Azure artificial intelligence (AI) service for a given business need.  Understanding the criteria can also help you better understand the nuanced differences between each product.

## Are you building a virtual agent that interfaces with humans via natural language?

Use the Bot Service when you need to create a virtual agent to interact with humans using natural language. The Bot Service integrates knowledge sources, natural language processing, and form factors to allow interaction across different channels.

Bot Service solutions usually rely on other AI services for things like natural language understanding or even translation for localizing replies into the customer's preferred language.

Before jumping in to build a custom chat experience using Azure Bot Service, it might make sense to search for pre-built, no-code solutions that cover common scenarios.  For example, QnA Maker, available from the Azure Marketplace, allows you to build, train, and publish a sophisticated bot using FAQ pages, support websites, product manuals, SharePoint documents, or editorial content through an easy-to-use UI or via REST APIs.  Likewise, Power Virtual Agents integrates with Microsoft's Power Platform allowing you to use  hundreds of prebuilt connectors for data input.  You can extend the Power Virtual Agent by building custom workflows with Power Automate, and if you feel that the out-of-the-box experience is too limiting, you can still build more complex interactions with Microsoft Bot Framework.

## Do you need a service that can understand the content and meaning of images, video, audio, or translate text into a different language?

Use Azure Cognitive Services When it comes to general purpose tasks like performing speech to text, integrating with search, identifying the objects in an image, and so on.  Azure Cognitive Services is "general purpose", meaning that many different kinds of customers can benefit from the work Microsoft has already done to train and test these models and offer them inexpensively at scale.


## Do you need to predict user behavior or provide users with personalized recommendations in your app?

Azure Cognitive Services' Personalizer service watches your users' actions within an application and can be used to predict their behavior and provide relevant experiences as it identifies usage patterns. Here again, you could capture and store user behavior and create your own custom Azure Machine Learning solution to do these things, but this approach would require much effort and expense.


## Will your app predict future outcomes based on private historical data?

Choose Azure Machine Learning when you need to analyze data to predict future outcomes.  For example, suppose you need to analyze years worth of financial transactions to discover new patterns that could help you create new products and services for your company's clients and offer those new services during routine customer service calls. When you're working with proprietary data then you will likely need to build a more custom, tailored machine learning model.