
One way to improve customer satisfaction is to help them quickly locate answers to their questions. The information they're looking for might be in Frequently Asked Questions (FAQs), support documentation, or even product manuals. 

Search pages can help with this effort, but many organizations look for ways to interact more personally with customers while still using automated mechanisms. The QnA Maker service answers your users' natural language question by matching it with the best possible answer from your knowledge base. Customers can have an interactive "conversation" with the automated service naturally to help them locate the necessary information.

You create a Knowledge Base for QnA Maker through an easy-to-use web portal.  Through the portal, you can create, manage, train, and publish your service without any developer experience. Once the service is published to an endpoint, a client application such as a chatbot can use the service to process a conversation with a user to determine the asked question and respond with the best answer.

## Architecture

To understand the services that QnA Maker provides, we can look at the architecture behind it. As mentioned earlier, you use a web-based portal to create your knowledge base. This portal is part of the QnA Maker management services. The management services also provide facilities for updating, training, and publishing your knowledge base for consumption. You can also make use of REST-based APIs to manage your knowledge base.

Once you've created the knowledge base and published it, the QnA Maker data and runtime are responsible for making your service available.  It will be accessible from your Microsoft Azure subscription in the region you chose during the creation process. The content that you've added into your knowledge base is stored in Azure Search and the access endpoint for client applications is deployed as an Azure App service. Microsoft Azure also provides the option of integrating Application Insights into your service for analytics.

![The QnA Architecture Diagram](../media/2-overview-of-qna-architecture.png)