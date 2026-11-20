::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=1e668990-e302-4dc4-83e7-996e0d79f162]

::: zone-end

::: zone pivot="text"

The Contoso product assistant answers a shopper's question about commuter lights, recommends one, and explains why. The shopper closes the browser. A week later, they come back, ask a follow-up about the same bike, and the assistant has no idea who they are. It asks again what they ride, and recommends the light they rejected last time.

Nothing is broken. Retrieval works, and every sentence the assistant writes traces back to the catalog. What the assistant lacks is memory: anything that survives the end of a conversation. Retrieval tells an agent about the world. Memory tells it about this person.

Building that memory is a data problem before it's a model problem. Raw turns arrive on every message and go stale within weeks. The durable part, that this shopper rides a touring bike after dark and requires lights that run for at least eight hours per charge, is a few sentences buried in thousands of turns. Azure Cosmos DB for NoSQL holds both halves: the raw turns, cheap and expiring, and the distilled memories, indexed for vector, full-text, and hybrid retrieval.

The design decisions concern those two stores. What you keep, how you scope it, how much of a finite context window you spend on it, and when you delete it.

In this module, you separate short-term conversation state from long-term memory, store and recall both in Azure Cosmos DB for NoSQL, retrieve the right memory into a limited context window, and set the retention and consolidation policies that keep a memory store trustworthy.

By the end of this module, you can design and implement a durable agent memory store on Azure Cosmos DB for NoSQL that recalls what matters and forgets what doesn't.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
