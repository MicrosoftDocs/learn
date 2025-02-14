There are many factors, including cost, availability, performance, and capability, to consider when choosing which LLM to use. Generally, we recommend the following guides:

- **gpt-35-turbo**: This model is economical, performs well, and, despite the ChatGPT name, can be used for a wide range of tasks beyond chat and conversation.

- **gpt-35-turbo-16k**, **gpt-4** or **gpt-4-32k**: These models are a good choice if you need to generate more than 4,096 tokens or need to support larger prompts. However, these models are more expensive, can be slower, and might have limited availability.

- **Embedding models**: If your tasks include search, clustering, recommendations, and anomaly detection, you should use an embedding model. Computers can easily utilize a vector of numbers that form the embedding. The embedding is an information-dense representation of the semantic meaning of a piece of text. The distance between two embeddings in the vector space is correlated with semantic similarity. For example, if two texts are similar, then their vector representations are also similar.

- **DALL-E**: This model generates images from text prompts. DALL-E differs from other language models because its output is an image, not text.

- **Whisper**: This model is trained on a large dataset of English audio and text. Whisper is optimized for speech-to-text capabilities like transcribing audio files. It can be used to transcribe audio files that contain speech in languages other than English, but the output of the model is English text. Use Whisper to quickly transcribe audio files one at a time, translate audio from other languages into English, or provide your prompt to the model to guide the output.
