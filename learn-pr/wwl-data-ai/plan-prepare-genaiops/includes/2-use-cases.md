Generative AI applications are rapidly evolving across multiple industries. Understanding how these applications can be deployed across different use cases can help you to better design solutions that are both effective and scalable. Let's explore some examples, highlighting the specific requirements and challenges that shape the architecture of GenAI solutions.

## Enhance customer support in retail

In retail, GenAI applications can help you to create personalized experiences by providing support to customers whenever they need it.

Imagine the fictitious Contoso Outdoors, an enterprise retail website that sells hiking and camping gear to adventure-seekers. When you go on an adventure, it's essential that you bring the appropriate gear. Contoso Outdoors wants to help its customers by integrating a chat application with their website, allowing customers to ask any question they have, at any time of day.

For example, a customer can navigate to the website and search for a backpack, but find that there are many backpacks in various shapes and sizes. To understand better the type of backpack the customer still needs, they can ask for advice based on previous purchases.

To respond to the customer in real-time, Contoso Outdoors can integrate GenAI to generate an answer, which needs to be based on their own product and customer data.

Let's explore the GenAIOps architecture for Contoso Outdoors.

:::image type="content" source="../media/contoso-chat-architecture.png" alt-text="Diagram of the Contoso Chat application architecture." lightbox="../media/contoso-chat-architecture.png":::

The custom chat application is hosted in Azure Container Apps (ACA). ACA exposes an API endpoint. This endpoint is accessed by an authenticated application, such as the website where customers sign in.

Any messages in the chat window are requests. These requests are forwarded to the chat application. The application uses GenAI models and the Retrieval Augmented Generation (RAG) design pattern. It retrieves product and customer data before generating a response. The chat application interacts with Azure OpenAI models like GPT-4, Azure AI Search for product retrieval, and Cosmos DB for customer data. Finally, the system returns the generated response to the customer in the chat window.

> [!Tip]
> Learn more about this use case in the [Azure Samples repository for Contoso Chat](https://github.com/Azure-Samples/contoso-chat?tab=readme-ov-file&azure-portal=true).

## Generate product specific articles

Now imagine you need to create high quality articles for your website. The articles for the Contoso Outdoors website must be well-researched and include product-specific information to engage customers effectively.

To streamline this process, you can develop a creative writer app that allows any writer to generate a new article by entering key details, such as the products they want to feature.

Once the information is submitted, the app processes it through an AI-driven agent workflow, which automates the research, writing, and refinement of the article. A writer can then review the generated article before finalizing and publishing the article to the website.

To understand what is happening behind the scenes, let's explore the architecture for the Contoso Creative Writer app.

:::image type="content" source="../media/creative-writer-architecture.png" alt-text="Diagram of the Contoso Creative Writer application architecture." lightbox="../media/creative-writer-architecture.png":::

When an authenticated user inputs the required information, the Creative Writer app uses a combination of multiple agents to generate the article:

- A **research** agent that uses the [Bing Grounding Tool](/azure/ai-services/agents/how-to/tools/bing-grounding?azure-portal=true) in [Azure AI Agent Service](/azure/ai-services/agents/overview?azure-portal=true) to research the product, and uses [Azure AI Search](/products/ai-services/ai-search?azure-portal=true) to do a semantic similarity search for related products from a vector store.
- A **writer** agent that combines the researched and retrieved product information into a helpful article.
- An **editor** agent that refines the article before presenting it to the user.

Contoso Creative Writer simplifies and accelerates the content creation process by integrating these AI-powered agents, making it easier than ever to generate high-quality, product-focused articles.

> [!Tip]
> Learn more about this use case in the [Azure Samples repository for Contoso Creative Writer](https://github.com/Azure-Samples/contoso-creative-writer?tab=readme-ov-file&azure-portal=true).
