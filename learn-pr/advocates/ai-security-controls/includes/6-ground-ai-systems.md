Grounding is the process of connecting an AI system's responses to verified, real-world data rather than relying solely on the model's general training knowledge. Without grounding, generative AI models draw exclusively from patterns learned during training—which may be outdated, incomplete, or incorrect for a specific use case. Grounding is both a quality control and a security control.

## Why grounding matters for security

From a security perspective, ungrounded AI systems pose several risks:

- **Fabricated outputs**: An ungrounded model is more likely to generate confidently stated but factually incorrect information, which users may act on without verification
- **Stale information**: Models trained on data from months or years ago may provide outdated guidance, particularly dangerous for security advice, compliance requirements, or product documentation
- **Unrestricted scope**: Without grounding, a model might answer questions about any topic, including areas where it lacks sufficient knowledge to be reliable

Grounding constrains the model to work with specific, verified data sources, reducing the attack surface for fabricated-output risks and helping enforce the boundaries defined in the system prompt.

## Grounding techniques

Several techniques are commonly used to ground AI systems in verified data:

### Retrieval-augmented generation (RAG)

RAG is the most widely adopted grounding technique. It works by:

1. **Retrieving** relevant documents or data from a knowledge base, database, or search index based on the user's query
2. **Augmenting** the prompt with this retrieved information
3. **Generating** a response that's informed by both the model's capabilities and the specific retrieved data

RAG enables the AI to provide current, context-specific answers without requiring the model to be retrained. For example, an AI assistant grounded with RAG can answer questions about an organization's internal policies by retrieving the latest policy documents at query time.

Security considerations for RAG implementations include:

- **Access control on source data**: Ensure that the retrieval system respects the same access controls as the user. The AI shouldn't retrieve documents that the user isn't authorized to see.
- **Source data integrity**: Protect the knowledge base from tampering. If an attacker can modify the grounding data, they can influence the AI's responses—a form of indirect manipulation.
- **Citation and traceability**: Configure the system to cite which sources informed each response, making it possible to verify accuracy and detect when the model strays from its grounding data.

### Prompt engineering for grounding

Advanced prompt engineering techniques complement RAG by instructing the model on how to use its grounding data:

- Include explicit instructions to base answers only on provided context
- Define how the model should respond when the grounding data doesn't contain the answer ("Based on the available information, I don't have an answer to that question")
- Set rules for how the model should handle conflicting information across sources

### Groundedness detection

Some AI platforms offer groundedness detection as a built-in capability. This feature evaluates the model's claims against the source materials that were provided, flagging responses that contain information not supported by the grounding data. Groundedness detection acts as a post-generation safety check, catching fabricated outputs that made it past other controls.

## Grounding best practices

When implementing grounding in AI systems:

- **Keep grounding data current**: Establish processes to regularly update the knowledge base. Stale grounding data can be as problematic as no grounding data.
- **Validate source quality**: Only use authoritative, verified sources for grounding. Grounding on unreliable data transfers that unreliability to the AI's responses.
- **Monitor groundedness metrics**: Track how often the model's responses are grounded versus ungrounded. An increase in ungrounded responses may indicate a problem with the retrieval pipeline or the grounding data itself.
- **Combine with content filters**: Use groundedness detection alongside content filters and metaprompt instructions for a layered defense approach.

:::image type="content" source="../media/rag-grounding-process.png" alt-text="Diagram of the RAG grounding process from user query through retrieval to validated response." lightbox="../media/rag-grounding-process.png":::