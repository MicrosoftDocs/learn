In today’s fast-paced business environment, intelligent business processes and efficient collaboration are key to the success of organizations. A recent study by Microsoft on the business value of AI reveals 71% of organizations are already using AI to speed up business processes. For every $1 invested, organizations are seeing a return of 3.5 times their investments. 

SAP systems have data related to business processes while the Microsoft Graph has data related to collaboration such as emails, chats, and schedules. Combining both data forms together with AI transforms the business processes of many organizations.

As every organization is different, apart from using out-of-the-box solutions, organizations are looking for the convenience of being able to build their own customs solutions when they need it and as they want it. Microsoft offers powerful AI and low code development tools that are easily connected to SAP systems. The combination enables organizations to develop their own intelligent copilots to enhance business processes and workflows. 

Microsoft is helping customers and partners apply SAP with AI in three areas: 

- Working with SAP to provide a fantastic out-of-the-box experience to customers and partners. The [SAP Joule & Microsoft Copilot announcement](https://news.sap.com/2024/06/joule-microsoft-copilot-unified-work-experience/) at Sapphire and also the SAP S/4HANA Public Cloud & Microsoft Copilot integration are the first tangible results of our collaboration. 
- Our functional Copilots (Copilot for Sales, Copilot for Finance, and Copilot for Services) provide a similar out-of-the-box experience but focusing on Microsoft 365 applications. [Copilot for Finance](/copilot/finance/) accelerates time-to-impact for finance professionals by surfacing insights that support strategic decision-making and reduce the time spent on manual, repetitive work. It comes with an out-of-the-box integration in Outlook and Excel and allows customers and partners to extend the integration to other systems using a custom connector. 
- Joint solutions using SAP and Microsoft can't address all customer requirements. [Copilot Studio](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-studio) offers powerful AI and low code development tools connected to SAP systems for developing intelligent copilots and bots for stronger business processes and workflows. 

To demonstrate how seamless and easy it's to utilize AI using Microsoft AI tools, let's explore a scenario that demonstrates how SAP data, along with Copilot Studio, Azure OpenAI, Microsoft Teams, and the Microsoft Power Platform.

Below is a scenario that demonstrates how a salesperson can use AI to streamline a business process:

1. **Customer Inquiry and Complaint**: A customer reaches out to the salesperson with a complaint regarding a delayed order. 
2. **Order Investigation**: The salesperson investigates the customer's orders via a chatbot deployed on Teams delving deep into the delayed order with AI-summarized insights. The insights are in the context from Outlook emails, Teams' messages and data directly from the SAP system. 
3. **Generated Report**: The salesperson figures out the issue and has AI generate a report summarizing the conversation and the cause of the delay. The report is then sent via email to the customer through chat with the bot on Teams.

The salesperson has utilized AI to understand and summarize order-related data from various sources (SAP and Microsoft Graph), convert data from one format to another, and identifying the root cause of a problem. Additionally, provides updates to the customer using email and Teams chat. 

Azure OpenAI provides the foundation for developing and training the bot that provides access to the AI models that generate responses. The Power Platform, particularly Power Automate, integrates various services, including SAP systems and the Microsoft 365 Graph enabling data flow and automation. The SAP Enterprise Resource Planning (ERP) connector ensures real-time data retrieval and updates from SAP systems, enhancing the bot’s ability to interact with enterprise data. Copilot Studio allows for the customization and deployment of AI copilots, making the bot adaptable to specific business needs, in this case, deploying it on Teams.

Explore how to build this scenario on this GitHub link which has detailed step by step instructions on how to build it from scratch. The link also contains the exported Power Platform flows that one can import into their own environment to refer to and use.

Let's walk through an overview of the steps to build this scenario:

1. **Set up a bot on Azure AI Studio**: Azure AI Studio allows you to create and test bots using the Chat Playground. You can get access to Azure AI Studio here. 
2. **Set up Microsoft Power Platform**: By creating a Microsoft 365 developer account, you gain access to the Power Platform, which includes Power Automate among others. Create a Microsoft 365 Developer account and get access to the Power Platform here.
3. **Set up SAP connection in Power Automate**: To connect Power Automate to your SAP system and use SAP ERP connector, you establish a connection between the Power Platform and your SAP system. 
4. **Set up / Sign up for Copilot Studio**: Copilot Studio enables you to create and customize AI copilots. You can build and deploy copilots that use generative AI, enhancing the capabilities of your bot. You can learn more about it and get access to it here.

This scenario is just an example of how these technologies can transform and make business processes more efficient by harnessing the power of AI and Automation. With the Microsoft tools an easy connectivity to SAP systems and the Microsoft Graph, you have all the tools in your arsenal to make a task/business process AI powered. 
