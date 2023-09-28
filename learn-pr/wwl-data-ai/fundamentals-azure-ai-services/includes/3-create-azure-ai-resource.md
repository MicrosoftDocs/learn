Azure AI services are cloud-based, and like all Azure services you need to create a resource to use them.
There are two types of AI service resources: multi-service or single-service. Which type you use will be determined by your development requirements and how you want costs to be billed. 

- **Multi-service** resource: Azure AI Services is a resource created in the Azure portal that provides access to multiple Azure AI services with a single key and endpoint. Use this resource when you need several AI services or are exploring AI capabilities. When you use an AI Services resource, all your AI services are billed together.
- **Single-service** resources: a resource created in the Azure portal that provides access to a single Azure AI service, such as Speech, Vision, Language, etc. Each Azure AI service has a unique key and endpoint. These resources might be used when you only require one AI service or want to see cost information separately. 

The two steps to creating and using an AI service are:
1.	Create a resource in the Azure portal for the AI service or services you require. 
2.	Associate the resource with an Azure AI Studio or identify the resource in the application you are creating. 

## How to create an Azure AI services resource 

To create an AI services resource, sign in to the Azure portal with Contributor access and click Create a resource. To create a multi-services resource search for Azure AI Services. To create a single-service resource, search for the specific AI service such as Face, Language, or Content Safety, and so on. Most AI services have a free price tier to allow you to explore their capabilities. After clicking Create for the resource you require, you will be prompted to complete details of your subscription, the resource group to contain the resource, the region, a unique name, and the price tier. 