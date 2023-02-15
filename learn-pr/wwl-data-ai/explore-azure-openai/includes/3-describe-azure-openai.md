![Screenshot of Microsoft and OpenAI logos together for Azure OpenAI.](../media/openai-microsoft-logo.png)

Microsoft has partnered with OpenAI to deliver on three main goals:  
- To utilize Azure's infrastructure, including security, compliance, and regional availability, to help users build enterprise-grade applications.
- To deploy OpenAI AI model capabilities across Microsoft products, including and beyond Azure AI products.
- To use Azure to power all of OpenAI's workloads.  

## Introduction to Azure OpenAI Service

Azure OpenAI Service is a result of the partnership between Microsoft and OpenAI. The service combines Azure's enterprise-grade capabilities with OpenAI's generative AI model capabilities. 

Azure OpenAI is available for Azure users and consists of four components: 
- Pre-trained generative AI models 
- Customization capabilities; the ability to fine-tune AI models with your own data 
- Built-in tools to detect and mitigate harmful use cases so users can implement AI responsibly
- Enterprise-grade security with role-based access control (RBAC) and private networks

Using Azure OpenAI allows you to transition between your work with Azure services and OpenAI, while utilizing Azure's private networking, regional availability, and responsible AI content filtering. 

### Understand Azure OpenAI workloads 

Azure OpenAI supports many common AI workloads and solves for some new ones.

Common AI workloads include machine learning, computer vision, natural language processing, conversational AI, anomaly detection, and knowledge mining. 

Other AI workloads Azure OpenAI supports can be categorized into three groups: 

- **Generating Natural Language**
    - *Text completion*: generate and edit text 
    - *Embeddings*: search, classify, and compare text
- **Generating Code**: generate, edit, and explain code
- **Generating Images**: generate and edit images

### Azure OpenAI's relationship to Azure AI services 

![Diagram showing Microsoft AI portfolio and how they relate.](../media/Microsoft-ai-portfolio.png)

Azure's AI services are tools for solving AI workloads and can be categorized into Azure's Machine Learning platform, Cognitive Services, and Applied AI Services.   
 
Azure Cognitive Services has five pillars: vision, speech, language, decision, and the Azure OpenAI Service. The services you choose to use depend on what you need to accomplish. In particular, there are several overlapping capabilities between the Cognitive Service's Language service and OpenAI's service, such as translation, sentiment analysis, and keyword extraction. 

While there's no strict guidance on when to use a particular service, Azure's existing Language service can be used for widely known use-cases that require minimal tuning, the process of optimizing a model's performance. Azure OpenAI's service may be more beneficial for use-cases that require highly customized generative models, or for exploratory research. 

>[!NOTE]
>Pricing is different for Azure OpenAI and Azure Cognitive Service for Language. [Learn more here](https://azure.microsoft.com/pricing/details/cognitive-services/openai-service?azure-portal=true).

When making business decisions about what type of model to use or to understand why pre-trained machine learning models are so sought after, it's important to understand how time and compute needs factor into machine learning training. In order to get a working machine learning model, it needs to be trained with data. The 'learning' portion of training requires a computer to try all solutions until it identifies a model that best fits the data. A higher performing model, a more complex task, and a larger training dataset results in more time required to run through possible solutions.
