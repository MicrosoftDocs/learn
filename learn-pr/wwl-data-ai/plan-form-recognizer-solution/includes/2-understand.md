Azure AI Document Intelligence is easy to use but, to create a reliable solution, you must understand its objects such as models, APIs, and tools.

In your polling company, you're assessing Azure AI Document Intelligence to see if it can streamline your data entry workflow. You need to understand what data Azure AI Document Intelligence can obtain from the different polling forms you use and how your development team will build a AI data entry system and integrate it with your mobile and desktop apps and databases.

In this unit, you'll learn what Azure AI Document Intelligence does and how developers can configure it to support their forms and documents.

## What is Azure AI Document Intelligence?

Until recently, getting data from a completed form into a database or any other data store required someone to enter it manually. Manual data entry is a slow and intensive task and can be expensive, especially if you have thousands of forms to enter. Operators often make reading or typing errors that reduce the accuracy of your data. 

Manual data entry was the only option because it was difficult for computers to recognize printed or hand-written text. Now, Artificial Intelligence (AI) has become commonplace and has enabled computers to recognize patterns, such as letter shapes in a piece of text, with a high degree of accuracy. We can use AI as an alternative to manual data entry with lower costs and fewer errors in the extracted data. 

Azure AI Document Intelligence is an Azure service that you can use to analyze forms completed by your customers, partners, employers, or others and extract the data that they contain.

:::image type="content" source="../media/02-search-marketplace.png" alt-text="Screenshot showing that Azure AI Document Intelligence is an Azure service and can be found in the Azure Marketplace.":::

Azure AI Document Intelligence is one of the Azure AI Services, which are built from individual Azure AI Services. The other AI Services include:

- **Azure Metrics Advisor.** Analyze your business performance data and detect anomalies.
- **Azure Cognitive Search.** Enrich data in your search indexes by using AI to analyze vision, language, and speech in content.
- **Azure Immersive Reader.** Improve access to your web applications for new readers, language learners, and people with learning differences, such as dyslexia.
- **Azure Bot Service.** Create bots that can converse with your customers and partners and respond to their queries.
- **Azure Video Analyzer.** Generate data and business understanding from video streams.

> [!NOTE]
> This module dicusses the features of Azure AI Document Intelligence v3.0. 

## Responsible use of AI

AI technologies are powerful and have the potential to make great impacts on people's lives. To ensure that such impacts are positive, Microsoft uses the following principles when it designs and builds AI solutions. You should consider these principles whenever you make use of AI:

- **Fairness.** All AI systems should treat people fairly, regardless of race, belief, gender, sexuality, or other factors. 
- **Reliability and safety.** All AI systems should give reliable answers with quantifiable confidence levels. 
- **Privacy and security.** All AI systems should secure and protect sensitive data and operate within applicable data protection laws.
- **Inclusiveness.** All AI systems should be available to all users, regardless of their abilities.
- **Transparency.** All AI systems should operate understandably and openly.
- **Accountability.** All AI systems should be run by people who are accountable for the actions of those systems.

To conform to these principals, first you should take time to understand the AI system you're using and comprehend what it can do. For example, when using Forms Analyzer, make sure you test your solution thoroughly with the forms you want it to read to ensure it extracts the data you expect. Ensure you collect only the data you need in forms and have the user's consent to store and analyze their information. Obtain legal advice on your solution, especially if the data it handles is personal or sensitive. Continue to use human agents to check on the deployed system and ensure your administrators can intervene in the solution to prevent harm. Continuously check the security of the system and its resilience against malicious attack and accidental data loss.

## Using models with Azure AI Document Intelligence

Use a model to inform Azure AI Document Intelligence about the type of data you expect to be in the documents you're analyzing. If your forms have a common structure or layout, you can increase the accuracy of the results and control the structure of the output data by using the most appropriate model. Azure AI Document Intelligence outputs data in JSON format, which is widely compatible with many databases, other storage locations, and programming languages. 

Azure AI Document Intelligence includes several prebuilt models for common types of forms and documents. If your forms are of one of these types, you can extract information from them without training your own custom models. It's very quick to create and deploy an Azure AI Document Intelligence solution when you use prebuilt models.

In Azure AI Document Intelligence v3.0, three of the prebuilt models are for general document analysis:

- Read
- General document
- Layout

The other prebuilt models expect a common type of form or document:

- Invoice
- Receipt
- W-2 US tax declaration
- ID Document
- Business card

> [!IMPORTANT]
> This list shows the documented prebuilt models avaiable at the time of writing. More prebuilt models are in development will be deployed soon. Check the Azure AI Document Intelligence documentation for the latest models.

If you have an unusual or unique type of form, you can use the above general document analysis prebuilt models to extract information from them. However, if you want to extract more specific information than the prebuilt models support, you can create a **custom model** and train it by using examples of completed forms. 

You can also associate multiple custom models, trained on different types of document, into a single model, known as a **composed model**. With a composed model, users can submit forms of different types to a single service, which identifies them and selects the most appropriate custom model to use in their analysis. 

## Azure AI Document Intelligence and Azure AI Vision

As an Azure AI Service, Azure AI Document Intelligence is a high-level AI service that enables developers to access data in forms quickly. It's built on the lower level Azure AI Services, including Azure AI Vision. 

If you use Azure AI Vision with its Optical Character Recognition (OCR) feature, you can submit photographed or scanned documents and extract their words and text in JSON format. This functionality is similar to Azure AI Document Intelligence and can make it difficult to choose from these services. 

If you want to extract simple words and text from a form or document, without contextual information, Azure AI Vision OCR is an appropriate service to consider. You might want to use this service if you already have your own analysis code, for example. However, Azure AI Document Intelligence includes a more sophisticated analysis of documents. For example, it can identify key/value pairs, tables, and context-specific fields. If you want to deploy a complete document analysis solution that enables users to both extract and understand text, consider Azure AI Document Intelligence.

## Azure AI Document Intelligence tools

If you want to try many features of Azure AI Document Intelligence without writing any code, you can use **Azure AI Document Intelligence Studio**. This online tool provides a Graphical User Interface (GUI) for exploring and understanding the capabilities of Azure AI Document Intelligence and its support for your forms. 

For example, you can use Azure AI Document Intelligence Studio to try analyzing your sales invoices and to explore the data produced by the Invoice prebuilt model. Then you could decide whether the prebuilt model extracts the values you need or whether to create your own custom model for a more unusual type of invoice.

> [!NOTE]
> At the time of writing, Azure AI Document Intelligence Studio is in preview. 

To integrate Azure AI Document Intelligence into your own applications you'll need to write code. For example, you could enable users of your sales mobile app to scan receipts with their device's camera and call Azure AI Document Intelligence to obtain prices, costs, and custom details. The app could store this information in your customer relationship management database.

Azure AI Document Intelligence includes Application Programming Interfaces (APIs) for each of the model types you've seen. The following languages are supported:

- C#/.NET
- Java
- Python
- JavaScript

If you prefer to use another language, you can call Azure AI Document Intelligence by using its RESTful web service.

## Learn more

- [What is Azure AI Document Intelligence?](/azure/applied-ai-services/form-recognizer/overview)
- [Guidance for integration and responsible use with Azure AI Document Intelligence](/legal/cognitive-services/document-intelligence/guidance-integration-responsible-use?toc=%2Fazure%2Fai-services%2Fdocument-intelligence%2Ftoc.json&bc=%2Fazure%2Fai-services%2Fdocument-intelligence%2Fbreadcrumb%2Ftoc.json)
- [Azure AI Document Intelligence models](/azure/applied-ai-services/form-recognizer/concept-model-overview)
- [Azure AI Document Intelligence Studio (preview)](/azure/applied-ai-services/form-recognizer/concept-form-recognizer-studio)
