::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=f1a99431-d9fe-4201-8e6b-a1ca0f5ec23c]

::: zone-end

::: zone pivot="text"

AI applications require fast, reliable data access to deliver real-time responses and maintain user engagement. This module guides you through implementing data operations with Azure Managed Redis to accelerate your AI solutions with high-performance caching.

Imagine you're a developer at an AI startup building an intelligent customer service chatbot for an e-commerce platform. Your AI model needs to access user profiles, product catalogs, session data, and conversation history with sub-millisecond latency to provide personalized, contextual responses. Without proper caching, each user interaction would require multiple database queries, causing noticeable delays that frustrate users and degrade the AI experience. The client expects the chatbot to handle thousands of concurrent conversations while maintaining fast response times and remembering context across sessions. You need to implement a robust caching strategy that can store user data, cache expensive AI model results, manage session state, and automatically expire stale information. Additionally, the solution must be scalable, secure, and integrate seamlessly with your Python-based AI application. Without the right caching infrastructure, delivering a responsive, intelligent user experience would be nearly impossible.

After completing this module, you'll be able to:

- Explain Azure Managed Redis capabilities and caching strategies for high-performance applications
- Select appropriate client libraries and apply development best practices for Redis implementations
- Implement data operations including storage, retrieval, expiration, and cache invalidation patterns
- Build a Python application that performs data operations with Azure Managed Redis

> [!NOTE]
> All code examples in this module are based on the most recent version of the `redis-py` library at the time of writing. The library is updated often and the recommendation is to visit the [redis-py GitHub](https://github.com/redis/redis-py) site for the most up-to-date information.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
