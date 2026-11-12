::: zone pivot="video"

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=056788db-8e94-4623-bad4-2dc7dd5bc1e6]

::: zone-end

::: zone pivot="text"

Generative AI models learn broad patterns from their training data, but they don't automatically have access to an organization's private or current information. An employee expense claims assistant, for example, needs approved policies and procedures rather than a general answer based on information from the Internet.

![Screenshot of an agent retrieving a grounded response from a corporate knowledge source.](../media/grounded-response.png)

Retrieval-augmented generation (RAG) addresses this need by retrieving relevant information and adding it to the context supplied to a model. Building and maintaining a separate retrieval system for every agent, however, can require significant work.

## Microsoft IQ

Microsoft IQ is a platform for agent knowledge integration that you can use to retrieve relevant contextual data from a wide range of souurces.

![Diagram of Microsoft IQ components.](../media/microsoft-iq-platform.png)

Microsoft IQ includes:

- **Foundry IQ** provides a managed knowledge layer that organizes enterprise and web sources into reusable knowledge bases for agentic retrieval to return relevant, permission-aware information with citations.
- **Web IQ** provides current web information, including web pages, news, images, and videos.
- **Work IQ** provides work context from Microsoft 365, such as documents, communications, and relationships between people and their work.
- **Fabric IQ** provides business context and meaning over organizational data in Microsoft Fabric, helping agents interpret data using shared business concepts and relationships.

In this module, you'll explore the main components of **Foundry IQ** and learn how an agent uses a knowledge base to produce grounded responses.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
