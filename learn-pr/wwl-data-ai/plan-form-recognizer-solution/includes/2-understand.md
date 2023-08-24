Azure Forms Recognizer is easy to use but, to create a reliable solution, you must understand its objects such as models, APIs, and tools.

In your polling company, you're assessing Azure Forms Recognizer to see if it can streamline your data entry workflow. You need to understand what data Forms Recognizer can obtain from the different polling forms you use and how your development team will build a AI data entry system and integrate it with your mobile and desktop apps and databases.

In this unit, you'll learn what Azure Forms Recognizer does and how developers can configure it to support their forms and documents.

## What is Azure Form Recognizer?

Until recently, getting data from a completed form into a database or any other data store required someone to enter it manually. Manual data entry is a slow and intensive task and can be expensive, especially if you have thousands of forms to enter. Operators often make reading or typing errors that reduce the accuracy of your data. 

Manual data entry was the only option because it was difficult for computers to recognize printed or hand-written text. Now, Artificial Intelligence (AI) has become commonplace and has enabled computers to recognize patterns, such as letter shapes in a piece of text, with a high degree of accuracy. We can use AI as an alternative to manual data entry with lower costs and fewer errors in the extracted data. 

Azure Form Recognizer is an Azure service that you can use to analyze forms completed by your customers, partners, employers, or others and extract the data that they contain.

:::image type="content" source="../media/02-search-marketplace.png" alt-text="Screenshot showing that Forms Recognizer is an Azure service and can be found in the Azure Marketplace.":::

Azure Form Recognizer is one of the Azure Applied AI Services, which are built from individual Azure AI Services. The other Applied AI Services include:

- **Azure Metrics Advisor.** Analyze your business performance data and detect anomalies.
- **Azure Cognitive Search.** Enrich data in your search indexes by using AI to analyze vision, language, and speech in content.
- **Azure Immersive Reader.** Improve access to your web applications for new readers, language learners, and people with learning differences, such as dyslexia.
- **Azure Bot Service.** Create bots that can converse with your customers and partners and respond to their queries.
- **Azure Video Analyzer.** Generate data and business understanding from video streams.

> [!NOTE]
> This module dicusses the features of Form Recognizer v3.0. 

## Responsible use of AI

AI technologies are powerful and have the potential to make great impacts on people's lives. To ensure that such impacts are positive, Microsoft uses the following principles when it designs and builds AI solutions. You should consider these principles whenever you make use of AI:

- **Fairness.** All AI systems should treat people fairly, regardless of race, belief, gender, sexuality, or other factors. 
- **Reliability and safety.** All AI systems should give reliable answers with quantifiable confidence levels. 
- **Privacy and security.** All AI systems should secure and protect sensitive data and operate within applicable data protection laws.
- **Inclusiveness.** All AI systems should be available to all users, regardless of their abilities.
- **Transparency.** All AI systems should operate understandably and openly.
- **Accountability.** All AI systems should be run by people who are accountable for the actions of those systems.

To conform to these principals, first you should take time to understand the AI system you're using and comprehend what it can do. For example, when using Forms Analyzer, make sure you test your solution thoroughly with the forms you want it to read to ensure it extracts the data you expect. Ensure you collect only the data you need in forms and have the user's consent to store and analyze their information. Obtain legal advice on your solution, especially if the data it handles is personal or sensitive. Continue to use human agents to check on the deployed system and ensure your administrators can intervene in the solution to prevent harm. Continuously check the security of the system and its resilience against malicious attack and accidental data loss.

## Using models with Form Recognizer

Use a model to inform Form Recognizer about the type of data you expect to be in the documents you're analyzing. If your forms have a common structure or layout, you can increase the accuracy of the results and control the structure of the output data by using the most appropriate model. Form Recognizer outputs data in JSON format, which is widely compatible with many databases, other storage locations, and programming languages. 

Form Recognizer includes several prebuilt models for common types of forms and documents. If your forms are of one of these types, you can extract information from them without training your own custom models. It's very quick to create and deploy a Form Recognizer solution when you use prebuilt models.

In Forms Recognizer v3.0, three of the prebuilt models are for general document analysis:

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
> This list shows the documented prebuilt models avaiable at the time of writing. More prebuilt models are in development will be deployed soon. Check the Forms Recognizer documentation for the latest models.

If you have an unusual or unique type of form, you can use the above general document analysis prebuilt models to extract information from them. However, if you want to extract more specific information than the prebuilt models support, you can create a **custom model** and train it by using examples of completed forms. 

You can also associate multiple custom models, trained on different types of document, into a single model, known as a **composed model**. With a composed model, users can submit forms of different types to a single service, which identifies them and selects the most appropriate custom model to use in their analysis. 

## Forms Recognizer and Azure Computer Vision

As an Azure Applied AI Service, Forms Recognizer is a high-level AI service that enables developers to access data in forms quickly. It's built on the lower level Azure AI Services, including Azure Computer Vision. 

If you use Azure Computer Vision with its Optical Character Recognition (OCR) feature, you can submit photographed or scanned documents and extract their words and text in JSON format. This functionality is similar to Form Recognizer and can make it difficult to choose from these services. 

If you want to extract simple words and text from a form or document, without contextual information, Azure Computer Vision OCR is an appropriate service to consider. You might want to use this service if you already have your own analysis code, for example. However, Forms Recognizer includes a more sophisticated analysis of documents. For example, it can identify key/value pairs, tables, and context-specific fields. If you want to deploy a complete document analysis solution that enables users to both extract and understand text, consider Forms Recognizer.

## Form Recognizer tools

If you want to try many features of Form Recognizer without writing any code, you can use **Form Recognizer Studio**. This online tool provides a Graphical User Interface (GUI) for exploring and understanding the capabilities of Form Recognizer and its support for your forms. 

For example, you can use Form Recognizer Studio to try analyzing your sales invoices and to explore the data produced by the Invoice prebuilt model. Then you could decide whether the prebuilt model extracts the values you need or whether to create your own custom model for a more unusual type of invoice.

> [!NOTE]
> At the time of writing, Form Recognizer Studio is in preview. 

To integrate Form Recognizer into your own applications you'll need to write code. For example, you could enable users of your sales mobile app to scan receipts with their device's camera and call Form Recognizer to obtain prices, costs, and custom details. The app could store this information in your customer relationship management database.

Form Recognizer includes Application Programming Interfaces (APIs) for each of the model types you've seen. The following languages are supported:

- C#/.NET
- Java
- Python
- JavaScript

If you prefer to use another language, you can call Form Recognizer by using its RESTful web service.

## Learn more

- [What is Azure Form Recognizer?](/azure/applied-ai-services/form-recognizer/overview)
- [Guidance for integration and responsible use with Form Recognizer](/legal/cognitive-services/document-intelligence/guidance-integration-responsible-use?toc=%2Fazure%2Fai-services%2Fdocument-intelligence%2Ftoc.json&bc=%2Fazure%2Fai-services%2Fdocument-intelligence%2Fbreadcrumb%2Ftoc.json)
- [Form Recognizer models](/azure/applied-ai-services/form-recognizer/concept-model-overview)
- [Form Recognizer Studio (preview)](/azure/applied-ai-services/form-recognizer/concept-form-recognizer-studio)
