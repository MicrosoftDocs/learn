

## Explore a retail example

Imagine the fictitious Contoso Outdoors, an enterprise retail website that sells hiking and camping gear to adventure-seekers. When you go on an adventure, it's essential that you bring the appropriate gear. Contoso Outdoors wants to help its customers by integrating a chat application with their website, allowing customers to ask any question they have, at any time of day.

For example, a customer can navigate to the website and search for a backpack, but find that there are many backpacks in various shapes and sizes. To understand better the type of backpack the customer still needs, they can ask for advice based on previous purchases.

:::image type="content" source="../media/contoso-chat-website.png" alt-text="Screenshot of the website of Contoso Chat.":::

To respond to the customer in real-time, Contoso Outdoors can integrate GenAI to generate an answer, which needs to be based on their own product and customer data.

Let's explore the GenAIOps architecture for Contoso Outdoors. The custom chat application is hosted in Azure Container Apps (ACA), exposing an API endpoint that can be accessed from authenticated third party applications, which in this case is the website where customers can sign in with their account.

Any messages in the chat window are requests that are forwarded to the chat application that uses GenAI models combined with a Retrieval Augmented Generation (RAG) design pattern to retrieve product and customer data before generating a response. In this case, the chat application orchestrates interactions with Azure OpenAI models like GPT-4, Azure AI Search for product retrieval, and Cosmos DB for customer data. Finally the generated response is returned to the customer in the same chat window.

