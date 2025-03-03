Test your understanding of Spring AI, Azure OpenAI integration, and deployment concepts.

## Question 1

Which Spring AI component is used for generating vector embeddings?

- [ ] ChatClient
- [x] EmbeddingClient
- [ ] VectorClient
- [ ] AIClient

Explanation: The EmbeddingClient in Spring AI is specifically designed for generating vector embeddings from text, which is crucial for implementing semantic search functionality.

## Question 2

What PostgreSQL extension is required for vector similarity search?

- [ ] pg_similarity
- [ ] pg_trgm
- [x] pgvector
- [ ] pg_vector_ops

Explanation: The pgvector extension adds vector similarity search capabilities to PostgreSQL, which is essential for implementing RAG patterns with vector embeddings.

## Question 3

Which Azure Container Apps feature enables automatic scaling based on HTTP traffic?

- [x] HTTP Scale Rules
- [ ] Traffic Manager
- [ ] Load Balancer
- [ ] Application Gateway

Explanation: HTTP Scale Rules in Azure Container Apps allow automatic scaling based on incoming HTTP request concurrency.

## Question 4

What is the purpose of the ChatClient in Spring AI?

- [ ] Managing database connections
- [ ] Processing HTTP requests
- [x] Interacting with language models
- [ ] Handling authentication

Explanation: The ChatClient is Spring AI's core abstraction for interacting with Large Language Models (LLMs) like Azure OpenAI.

## Question 5

Which configuration is required for Azure OpenAI integration in application.properties?

- [ ] Only API key
- [ ] Only endpoint URL
- [ ] Only deployment name
- [x] API key, endpoint, and deployment name

Explanation: Spring AI requires the API key, endpoint URL, and deployment name to properly configure Azure OpenAI integration.

## Next Steps

Congratulations on completing the knowledge check! You should now have a solid understanding of:

- Spring AI core concepts
- Azure OpenAI integration
- PostgreSQL vector storage
- Azure Container Apps deployment and scaling
