In this unit, you learn the importance of machine learning and AI technologies in the innovation process and customer experience.

## Machine learning and AI to create value

Machine learning and AI are great assets for improving interaction with your customers and partners. Tailwind Traders is evaluating these application features as a way to enhance the user experience and increase business value.

In addition to transforming its main e-commerce applications into a microservices architecture, the company wants to introduce new functionality to enhance customer experience. Currently, they have no staff with data-science skills. New staff will be hired in the future, but in the meantime, the company should identify quick wins that can help in improving the competitiveness of its web shop.

Tailwind Traders is evaluating four possibilities:

- Embedding a recommendation engine to increase cross-sales.
- Including a support chat to improve the user experience when problems arise.
- Redesigning the search engine to shorten the time it takes for customers to find products.
- Analyzing product reviews to better understand customers' sentiments.

Tailwind Traders needs to evaluate which Azure technologies can help the company start its journey into infusing its applications with machine learning and AI.

## Machine Learning and AI in Azure

Azure offers tools and services that can help organizations build machine learning and AI functionality in applications quicker and at a lower cost.

### Azure Cognitive Services

[Azure Cognitive Services](/azure/ai-services/what-are-ai-services) contains prebuilt models that don't require machine-learning expertise to introduce AI functionality to an application. Azure Cognitive Services encompasses many areas, such as vision, speech, language, decision, and search. It's easy to use, so organizations can use the power of AI without extensive machine-learning skills.

Tailwind Traders sees a high potential in Azure Cognitive Services, because its data-science department isn't fully operational. The company is evaluating these features to innovate the e-commerce application:

- **Personalizer**: Organizations can use this feature to learn which users prefer which products, and to make fine-tuned, individual recommendations. Some customers prefer products with quick delivery, whereas other customers prefer products on sale. Personalizer uses a type of machine-learning algorithm called *reinforcement learning*, which doesn't require huge amounts of data to be trained. Tailwind Traders is interested in Personalizer, because it doesn't have this type of data yet.
- **Text Analytics**: Many users write product reviews. Organizations can analyze reviews to find customers who express negative sentiments. Focusing on these customers can reduce customer churn and increase loyalty.
- **Translator**: Product reviews can be an effective sales tool, but they're useful only to customers who understand the language they're written in. Using real-time translation services would allow Tailwind Traders to show product reviews to any user regardless of their native language.

Other Azure Cognitive Services features have potential for Tailwind Traders, but the company decided to start with the previous three. The reason is the positive ratio between the potential increase in business impact and the low effort that their introduction would require.

### Knowledge mining and Azure Cognitive Search

[Azure Cognitive Search](/azure/search/search-what-is-azure-search?azure-portal=true) helps introduce knowledge mining and flexible search engines into applications with little coding effort. Not only can the service index massive amounts of data, it can also add enrichments to augment the information available to search.

One of the areas where the Tailwind Traders application needs to be improved is the product search. Customers spend too much time trying to find the product they're looking for. Replacing the existing search engine with Azure Cognitive Search could allow the company to expose rich search controls such as faceted navigation (multiple-category filters), relevance tuning, and autocomplete.

Internet users are used to sophisticated search engines, so Tailwind Traders can't afford to continue offering the old-fashioned functionality in the present version of the e-commerce platform. Fortunately, Azure Cognitive Search is offered as a set of APIs that enable the quick creation of MVPs.

### Azure Bot Service

The next area where surveys have surfaced user dissatisfaction is customer support. Long resolution times and congested phone lines are common complaints.

Tailwind Traders is considering [Azure Bot Service](/azure/bot-service?azure-portal=true) to implement a chat-based support system where users can resolve their issues quicker at a lower cost. Azure Bot Service can be implemented in various languages, like C#, JavaScript, and Python. The variety of languages makes it easier to find developers in the organization who can use a familiar programming language to create the chat functionality.

Azure Bot Service can be implemented in various channels, but the company is mostly interested in offering it as a web-based chat for users who visit the e-commerce website.

### Azure Machine Learning

[Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-ml?azure-portal=true) facilitates the process of creating custom machine-learning models, deploying those models to production, and managing versions of all deployed models across the organization.

Azure Machine Learning makes the job of data scientists easier by helping them to share experiment results and manage different models at scale. It can refine models with hyperparameter tuning, and even create new ones with automated learning. It can then deploy the selected models to Kubernetes clusters to offer highly scalable, enterprise-grade APIs that can run the organization's machine-learning models in production.

Tailwind Traders is considering using custom models for a next-generation product recommender that would be more sophisticated than the Recommender feature in Azure Cognitive Services. However, this improvement is possible only when data-science expertise exists in the organization.

## Tailwind Traders analysis

Tailwind Traders formulates the hypothesis that "A recommendation engine would increase cross-sales." Ideally, Tailwind Traders would use the Azure Machine Learning service to build a recommendation engine that's tailored to the organization's needs. However, the company has no data-science expertise at the moment.

For now, the company decides to use the Personalizer feature in Azure Cognitive Services to enrich the application without the need for data scientists. If the hypothesis is validated, the data science team that's eventually hired can evolve the prototype with custom machine-learning models built with Azure. An example is in the article [Build a real-time Recommendation API on Azure](/azure/architecture/reference-architectures/ai/real-time-recommendation?azure-portal=true).

Additionally, the company decides to validate the existing hypothesis around building a support chat with Azure Bot Service and improving the e-commerce site with Azure Cognitive Search. Both prototypes can be built with relatively low effort, so Tailwind Traders can start its foray into machine learning and AI at full speed.
