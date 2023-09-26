*Natural language processing* (NLP) is a common AI problem in which software must be able to work with text or speech in the natural language form that a human user would write or speak. Within the broader area of NLP, *natural language understanding* (NLU) deals with the problem of determining semantic meaning from natural language - usually by using a trained language model.

A common design pattern for a natural language understanding solution looks like this:

:::image type="content" source="../media/language-understanding-app.png" alt-text="Diagram showing an app accepts natural language input, and uses a model to determine semantic meaning before taking the appropriate action.":::

In this design pattern:

1. An app accepts natural language input from a user.
1. A language model is used to determine semantic meaning (the user's *intent*).
1. The app performs an appropriate action.

**Azure AI Language** enables developers to build apps based on language models that can be trained with a relatively small number of samples to discern a user's intended meaning.

In this module, you'll learn how to use the service to create a natural language understanding app using Azure AI Language.

After completing this module, you’ll be able to:

- Provision an Azure AI Language resource.
- Define intents, entities, and utterances.
- Use patterns to differentiate similar utterances.
- Use pre-built entity components.
- Train, test, publish, and review a model.
