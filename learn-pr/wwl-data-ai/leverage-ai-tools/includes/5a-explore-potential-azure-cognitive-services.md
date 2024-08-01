This unit discusses the prebuilt AI models that are available in Azure AI Services. They are a solid alternative to developing internal custom AI models.

## What is Azure AI Services?

When considering adopting AI into your business, you should consider prebuilt AI services first. Azure AI Services is a Microsoft product that delivers AI as **SaaS**. It includes pretrained models developed by Microsoft global researchers and data scientists to solve common problems. To avoid reinventing the wheel, businesses can leverage prebuilt services to achieve quality and accelerate delivery of technology solutions.

It's better to use the Azure AI Services that offer prebuilt AI services in vision, speech, language, search, or generative AI to solve common scenarios. This brings AI within reach of every developer and organization without requiring machine learning expertise. As a result, it enables developers of all skill levels to easily add intelligence to new or existing business applications.

Using Azure AI Services can:

* **Save costs**: Since AI Services is serverless, they're usually less costly than developing and training custom models from scratch internally.

* **Give deployment flexibility**: You can export AI Services models and run them wherever you need, in the cloud, on-premises, or on the edge.

* **Provide enterprise-level security**: AI services provide a layered security model, including authentication with Microsoft Entra credentials, a valid resource key, and Azure Virtual Networks. 

* **Connect to an ecosystem of products**: AI services are part of a broad ecosystem that includes automation and integration tools, deployment options, Docker containers for secure access, and tools for big data scenarios. 

## Azure AI Services capabilities

Azure AI capabilities include: vision, language, speech, document intelligence, search, and generative AI. You can build solutions with these capabilities using a suite of Azure AI services, including:

* **Azure AI Vision**: includes models that analyze images and videos. Beside more generic models, there are specific ones for extracting text from images (optical character recognition or OCR), for recognizing human faces. Another option is Azure Custom Vision, which lets users build their own AI models to recognize objects or classify images. Keep in mind that face recognition services are highly restricted due to Microsoft responsible AI policies.

* **Azure AI Language**: focuses on processing and analyzing text. They're trained to understand natural language and extract insights. For example, models recognize language, intent, entities, and sentiment in a text. Besides, they can find answers to the questions put to them.

* **Azure AI Speech**: provide models that deal with oral conversation. They can transform speech to text and vice-versa. It's also possible to translate what the speaker says and identifying each speaker. Models can even suggest pronunciation corrections to the speakers.

* **Azure AI Document Intelligence**: incorporates OCR and text analytics models to extract data from invoices, receipts, and other documents. Document intelligence relies on machine learning models that are trained to recognize data in text.

* **Azure AI Search**: provides secure information retrieval at scale over user-owned content in traditional and generative AI search applications. Azure AI Search can index unstructured, typed, image-based, or hand-written media. The indexes can be used for internal only use, or to enable searchable content on public-facing internet assets.

* **Azure OpenAI Service**: enables users to leverage generative AI models via *Azure AI Services*. In other words, it allows you to access OpenAI models directly from Azure, instead of the public API. Keep in mind that Azure OpenAI Service isn't the only Microsoft product delivering  this kind of models to users. In previous units, we've already discussed generative AI included in Microsoft Copilot for Microsoft 365 and Copilot in Power Platform. These copilot features are powered by GPT, an OpenAI model for text generation.

* **Azure AI Studio**: a Microsoft cloud platform that brings together multiple Azure AI-related services into a single, unified development environment. Developers can use these services to build end-to-end AI solutions. Specifically, Azure AI Studio combines:
    - The model catalog and prompt flow development capabilities of Azure Machine Learning service.
    - The generative AI model deployment, testing, and custom data integration capabilities of Azure OpenAI service.
    - Integration with Azure AI Services for speech, vision, language, document intelligence, and content safety.

>[!TIP]
>**Customer story**: An automotive manufacturer uses Azure AI Services to streamline invoice and credit note processing.
>Azure AI Document Intelligence provides the necessary AI capabilities to extract data from documents in a variety of formats, including emails, digital and scanned PDFs, and written bills.
>Since launch, the company has saved 10,000 manual hours—about 850-plus manual hours per month.
>Employees are positive about the automated solution and value having more time to focus on innovation and tasks related to their specific skill sets.
>Read the full case study here: [https://aka.ms/ai-services-customer-story](https://aka.ms/ai-services-customer-story)

