
In this unit you will learn the importance of machine learning and artificial technologies in the innovation process and customer experience.

## Machine Learning and Artificial Intelligence to Create Value

When evaluating which application features are going to enhance the customer experience and thus increase business value, Artificial Intelligence (AI) is a great asset to improve the interaction with your customers and partners.

Additionally to the transformation of its main e-commerce applications into a microservices architecture, Tailwind Traders is evaluating introducing new functionality that enhances the customer experience.

Tailwind Traders has no data science skills. In the midterm new staff will be hired, but in the meantime quick wins should be identified that can help in improving the competitiveness of the company's web shop. Four possibilities are being evaluated:

- Embedding a recommendation engine to increase cross sales
- Including a support chat to improve the support experience
- Redesign the search engine to reduce the time it takes customers to find products
- Analyze product reviews to better understand customer's sentiments

Tailwind Traders needs to evaluate which Azure technologies can help them to start their journey into infusing their applications with Machine Learning and Artificial Intelligence.

## Machine Learning and Artificial Intelligence in Azure

Azure offers some tools and services that can help organizations to build machine learning and artificial intelligence functionality in their applications quicker and at a lower cost.

### Azure Cognitive Services

[Azure Cognitive Services](https://docs.microsoft.com/azure/cognitive-services/what-are-cognitive-services) are pre-built models that do not require machine learning expertise to introduce AI functionality to an application. Encompassing many different areas such as vision, speech, language, decision and search, the main goal of Azure Cognitive Services is being easy to use, so that organizations without extensive machine learning skills can leverage the power of AI too.

Tailwind Traders sees a high potential in Azure Cognitive Services, since its data science department is not fully operational yet. These are the services that will be evaluated to innovate the e-commerce application:

- **Personalizer**: this service can be used to learn which users prefer which products, and make fine-tuned, individual recommendations. Some customers will prefer products with quick delivery, others products on sale. Personalizer uses a type of Machine Learning called Reinforcement Learning, which does not require huge amounts of data to train. This is very interesting for Tailwind Traders, since that data does not exist yet.
- **Text Analytics**: many users leave product reviews that could be researched looking for dissatisfied customers that express negative sentiments. Focusing on these customers would reduce customer churn, and increase loyalty.
- **Translator**: product reviews can be a very effective sales tool, unfortunately they can only be leveraged by customers that understand the language they are written in. Using real-time translation services would allow Tailwind Traders to show product reviews to any user world wide, independently of the customer's native language.

There are other Azure Cognitive Services that have potential for Tailwind Traders, but the previous three have been short selected. The reason is the positive ratio between the potential increase business impact and the low effort that their introduction would require.

### Knowledge Mining and Azure Cognitive Search

[Azure Cognitive Search](https://docs.microsoft.com/azure/search/search-what-is-azure-search) powers the introduction of knowledge mining and flexible search engines into applications with little coding effort. Not only can it index massive amount of data, but it can enrich it using Azure Cognitive Services to augment the information available to search.

One of the areas where the Tailwind Traders application needs to be improved is the product search. Customers reportedly spend too long trying to find the product they are looking for. Replacing the existing search engine with Azure Cognitive Search will allow to expose rich search controls such as faceted navigation (multi category filters), relevance tuning and autocomplete.

Customers are used to sophisticated search engines, so Tailwind Traders cannot afford to continue offering the existing, old-fashioned functionality. Fortunately, Azure Cognitive Search is offered as a set of APIs that is extremely easy to use.

### Azure Conversational AI and Azure Bot Services

The next area where surveys have surfaced customer dissatisfaction is in customer support. Long resolve times and congested phone lines are the two complaints being surfaced most frequently.

Tailwind Traders is considering [Azure Bot Services](https://docs.microsoft.com/azure/bot-service) to implement a chat-based support system with which support issues can be solved quicker, with a lower cost, and a higher customer satisfaction. Azure Bot Services can be implemented using different languages like C#, JavaScript and Python. This makes it easier finding developers in the organization that can use a familiar programming language to create the new support chat functionality.

Azure Bot Services can be implemented in a variety of channels, but Tailwind Traders is mostly interested in offering it as a web-based chat for users visiting the e-commerce web site.

### Azure Machine Learning

[Azure Machine Learning](https://docs.microsoft.com/azure/machine-learning/overview-what-is-azure-ml) facilitate the process of creating custom Machine Learning models, deploying those models to production, and manage different versions of all deployed models across the organization.

Azure Machine Learning facilitates the job of data scientists by helping them to share experiment results and manage different models at scale. It helps fine-tuning models with automated learning and hyperparameter tuning, as well as with the deployment of the models on Kubernetes clusters to offer highly scalable, enterprise-grade APIs.

Tailwind Traders is considering using custom models for a next-generation product recommender that would be more sophisticated than the Recommender Azure Cognitive Service.

## Tailwind Traders Analysis

Tailwind Traders has formulated the hypothesis "A recommendation engine would increase cross sales". Ideally, Azure Machine Learning Services could be used to build a recommendation engine purpose-built for the organization needs. However, Tailwind Traders has no data science expertise at the moment.

Tailwind Traders has decided to use the Personalizer Azure Cognitive Service to enrich the application without the need for data scientists for the time being.

If the hypothesis is validated, the data science team that is currently being built would evolve the prototype with custom-built Machine Learning models built with Azure (example in (Build a Real-time Recommendation API on Azure)[https://docs.microsoft.com/azure/architecture/reference-architectures/ai/real-time-recommendation])

Additionally, Tailwind Traders has decided to validate the existing hypothesis around building a support chat with the Azure Bot Service, and improving the e-commerce site with Azure Cognitive Search. Both prototypes can be built with relatively low effort, so that Tailwind Traders starts their foray into Machine Learning and Artificial Intelligence at full speed.
