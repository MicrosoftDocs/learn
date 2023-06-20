

This unit discusses the prebuilt AI models that are available in Azure Cognitive Services. They are a solid alternative to developing internal custom AI models.

## What is Azure Cognitive Services?

When considering adopting AI into your business, you should consider prebuilt AI services first. Azure Cognitive Services is a Microsoft product that delivers AI as **SaaS**. It includes pretrained models developed by Microsoft global researchers and data scientists to solve common problems. To avoid reinventing the wheel, businesses can leverage prebuilt services to achieve quality and accelerate delivery of technology solutions.

It's better to use the Azure Cognitive Services that offer prebuilt AI services in vision, speech, language, search, or decision-making to solve common scenarios. This brings AI within reach of every developer and organization without requiring machine learning expertise. As a result, it enables developers of all skill levels to easily add intelligence to new or existing business applications.

There are some benefits to using Azure Cognitive Services instead of custom AI models:

* **Empower citizen developers**: Cognitive Services is designed for people with little data science expertise. For example, they usually handle most training decisions and provide basic testing results after training. Business users can use Cognitive Services to adapt it to their business needs, with some guidance and troubleshooting from the data science team.

* **Save costs**: Since Cognitive Services is serverless, they're usually less costly than developing and training the model internally.

* **Deployment flexibility**: You can export Cognitive Services models and run them wherever you need, in the cloud, on-premises, or on the edge.

## What can you do with Azure Cognitive Services?

There are five large families of Cognitive Services: speech, language, vision, decision, and Azure OpenAI Service. Each service includes several AI models that complement each other.

* **Speech**: These models deal with oral conversation. They can transform speech to text and vice-versa. It's also possible to translate what the speaker says and identifying each speaker. Models can even suggest pronunciation corrections to the speakers.

* **Language**: These Cognitive Services focus on processing and analyzing text. They're trained to understand natural language and extract insights. For example, models recognize language, intent, entities, and sentiment in a text. Besides, they can find answers to the questions put to them.

* **Vision**: It includes models that analyze images and videos. Beside more generic models, there are specific ones for extracting text from images (optical character recognition or OCR), for recognizing human faces. Another option is Azure Custom Vision, which lets users build their own AI models to recognize objects or classify images. Keep in mind that face recognition services are highly restricted due to Microsoft responsible AI policies.

* **Decision**: These models provide recommendations on the best decisions to take. They can raise an alert when they detect anomalies in your data, or flag potentially unsafe content. There's also Personalizer, a recommendation model that suggests which content to show to each user based on their behavior.

* **Azure OpenAI Service**: Microsoft offers some of the latest generative AI models developed by OpenAI. The next unit will discuss them in more depth.

All Azure Cognitive Services deliver AI models as SaaS. If you need to customize the product and built your own SaaS, **Azure Applied AI Services** enables you to do so without increasing data science complexity. Azure Applied AI Services is built on top of Azure Cognitive Services and focus on key scenarios. For example, Azure Form Recognizer incorporates OCR and text analytics models to extract data from invoices, receipts, and other documents.

## Use Azure Cognitive Services in a real use case

Let's imagine how you could improve the sales and after-sales functions of your business just using Azure Cognitive Services.

First, you could increase sales by recommending relevant products to users on your website with Personalizer, based on their behavior data. You might assist them during their shopping experience with a virtual assistant powered by Azure OpenAI Services. This assistant could solve questions in a natural, fluid interaction.

Once the sale is done, you may want to analyze the reviews clients are publishing on your products. Language Cognitive Services can analyze feedback and extract insights on what clients think about specific products and your brand. This information is key to improve what you're offering.

However, customers may not always be satisfied with their purchase. You have a call center to solve these issues and deliver post-sale services. Speech Cognitive Services can analyze, monitor, and evaluate these calls. You can find out what customers complain most about, or whether they are content with the solutions you're offering them. Using these insights to improve post-sales services can help you build customer loyalty.

Azure Cognitive Services include the latest AI models. Not only are their models continuously updated, they also cover state-of-the-art OpenAI models. You can use the newest large language models (LLM), like the GPT assistant or the Bing Search Chat. Let's discover how in the next unit.
