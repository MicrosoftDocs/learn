
**Azure AI Language** includes a *question answering* capability, which enables you to define a *knowledge base* of question and answer pairs that can be queried using natural language input. The knowledge base can be published to a REST endpoint and consumed by client applications, commonly *bots*.

:::image type="content" source="../media/diagram.png" alt-text="A diagram showing how a conversational app uses a knowledge base of questions and answers." border="false":::

The knowledge base can be created from existing sources, including:

- Web sites containing frequently asked question (FAQ) documentation.
- Files containing structured text, such as brochures or user guides.
- Built-in *chit chat* question and answer pairs that encapsulate common conversational exchanges.

> [!NOTE]
> The question answering capability of Azure AI Language is a newer version of the **QnA Service**, which still exists as a standalone service. To learn how to migrate a QnA Maker knowledge base to Azure AI Language, see the [migration guide](/azure/ai-services/language-service/question-answering/how-to/migrate-qnamaker).
