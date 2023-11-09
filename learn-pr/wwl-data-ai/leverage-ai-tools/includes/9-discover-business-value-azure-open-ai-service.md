Azure OpenAI Service is the latest addition to Azure AI Services. It's evidence of Microsoft commitment to offer state-of-the-art AI models in a way that's accessible to business users.

## What is Azure OpenAI Service?

OpenAI is a successful AI company that has lately developed some of the most famous generative AI models. ChatGPT and DALL-E are some of their creations. These models are available via a public API. As all generative AI, OpenAI models receive prompts or instructions from the user and send back AI-generated content.

Azure OpenAI Service is a Microsoft product that enables users to leverage OpenAI models via **Azure AI Services**. In other words, it allows you to access OpenAI models directly from Azure, instead of the public API. Keep in mind that Azure OpenAI Service isn't the only Microsoft product delivering  this kind of models to users. In previous units, we've already discussed generative AI included in Microsoft 365 Copilot and Copilot in Power Platform. These copilot features are powered by GPT, the OpenAI model for text generation.

## What can you do with Azure OpenAI Service?

The models included in Azure OpenAI Service focus on generative AI. That is, they allow users to automatically create content that credibly looks human-made. For example:

* **Language**: GPT models that understand and produce natural language. They can extract meaning from the users' prompts, including nuances, at human-like level. Thanks to this ability, they can engage in a believable and satisfactory conversation. They're also good summarizing, solving questions, and writing emails, copies, code, or other documents when given clear instructions.

* **Image**: DALL-E models that create visuals. They translate the user's prompt into an image. These models can be used to generate all kinds of art: realistic photographs, illustrations, logos, sketches, and so on. DALL-E successfully recreates styles when asked to.

* **Code**: Codex models are designed to translate user's prompts into working programing code. Developers can use them to create code snippets and speed up their performance. Codex provides results in several programming languages. It's technology behind GitHub Copilot.

* **More complex models**: Embeddings models provide the ground for data scientists to build more complex AI models. They analyze texts and create an abstract mapping of their meaning. These mappings help AI experts find similarities in texts. Embeddings models are key in scenarios involving searches, recommendations, or anomalies.

OpenAI models evolve continuously, and so does Azure OpenAI Service. You can check which specific versions of these models are available in the [Azure OpenAI Service documentation](/azure/cognitive-services/openai/concepts/models).

## Benefits of using Azure OpenAI Service instead of connecting directly to the OpenAI API

Many business leaders aren't sure about the difference between consuming OpenAI models directly from their API or via Azure OpenAI Service. There are clear reasons for organizations to prefer the Azure OpenAI Service:

* **Same models**: Given a specific model and version, Azure delivers exactly the same as the API. Azure users aren't missing any updates. The AI is just as good.

* **Privacy**: OpenAI's API is public. This fact implies that all data sent to the API may be used to improve the models. If your use case involves private, confidential information, using the API may not be the best option. In contrast, when using Azure OpenAI Service, Microsoft hosts the models within their Azure infrastructure. No customer data is sent to OpenAI for improving the models, since it all remains in Azure.

* **Security**: Microsoft Azure is a dependable, robust, and trustworthy platform. Azure developers have extensive experience securing the infrastructure for public and private organizations from all around the world to work safely in Azure. Azure OpenAI Service is built upon this expertise. It delivers encryption, private networking, and a system of regional availability to ensure your business blooms safe and uninterrupted.

* **Responsible AI**: The Microsoft ethical commitment guides how OpenAI models are offered in Azure. Microsoft is doing extensive research and work to identify, measure, mitigate, and operate to deal with all potential harms coming from this generative AI. For example, developers prevent misuse with a system of additional instructions that overrule specific prompts. There's also a content filter system that ensures the models don't deliver any potentially harmful content.

In conclusion, Azure OpenAI Service combines the best of OpenAI and of Microsoft Azure. On one hand, it delivers the innovative OpenAI models. On the other hand, it has all the benefits of being hosted in the reliable, business-friendly environment that is Azure.

## Use Azure OpenAI Service in a real use case

Let's imagine how an organization could develop a virtual assistant with Azure OpenAI Service. In the last unit's use case, we mentioned this possibility to deliver post-sales services.

Customers could interact with the assistant to ask for information about their orders, purchases, or warranties. They could talk to this assistant by chat or call. Previous generations of virtual assistants required designing the conversation flows, and this approach made conversations rigid to some extent. An assistant powered by a GPT model wouldn't suffer from this obstacle. It would require no workflow design and it could engage in more flexible, natural conversations. This perk implies that the assistant would be able to solve questions and tasks without specific training, as long as it's provided the information. This approach saves time and resources from the development team.

The AI team should feed the virtual assistant personal data and internal documentation to answer doubts about the refund policy, shipment status, and so on. Azure OpenAI Service allows you to do this operation safely, without risk of misusing data. Ensuring client data privacy is key, especially when the business deals with sensible information such as credit card numbers.

Customers often dislike the user experience provided by chatbots because they perceive them as cold and distant. To create a friendlier, more human-like experience, the AI team could generate with DALL-E avatars for the virtual assistant or even the client's profile. This feature would reinforce the more natural conversation flow achieved by the GPT model. In general, customers would benefit from a warmer, more natural post-sales experience.

If the client is satisfied at the end of their interaction with the virtual assistant, data scientists could use the Embeddings model to recommend them further purchases. In this scenario, it's not only important to deliver the right recommendation. It's even more crucial to correctly read the mood of the customer: if they're unhappy about the shopping experience, it could be counter-productive to suggest that they buy again. In that case, the assistant should be restrained from offering a recommendation. For this reason, it's key to count with GPT models, which are particularly good at noticing these nuances.

By now, we've covered what you can achieve with the available AI resources. Next, let’s wrap up everything you’ve learned with a knowledge check.