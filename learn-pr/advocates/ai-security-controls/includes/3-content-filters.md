AI content filters are systems designed to detect and prevent harmful or inappropriate content. They work by evaluating input prompts and output completions, using neural classification models to identify specific categories such as hate speech, sexual content, violence, and self-harm. These filters help ensure that AI-generated content aligns with safety guidelines and provides high-quality information.

Microsoft's Content Safety Studio assists you in ensuring all user-generated content, such as product reviews, forum posts, and images, aligns with your organization's content guidelines.

Content Safety Studio offers a suite of features designed to monitor and moderate content in real-time. It includes:

- **Text Moderation**: Detects and filters out harmful content in text, such as hate speech, violence, or inappropriate language.
- **Image Moderation**: Analyzes images to identify and block content that may be considered unsafe or offensive.
- **Multimodal Content Analysis**: Works across different types of content, ensuring a comprehensive content safety strategy.
- **Groundedness** **Detection**: Detects and blocks incorrect information in model outputs, ensuring that the text responses of large language models are factual and accurate, based on the source materials provided.
- **Prompt Shields**: Analyzes LLM inputs and detects user Prompt attacks and Document attacks.
- **Protected Material Detection**: Identifies and blocks outputs that could potentially violate copyright by scanning for matches against an index of third-party text content, including songs, news articles, recipes, and selected web content.
- **Monitor Online Activity**: Track your moderation API usage and trends across different modalities.

Here you can see an example of content filtering working correctly and also failing:

![Image shows guardrail protection and failure modes](../media/content-filtering.png)