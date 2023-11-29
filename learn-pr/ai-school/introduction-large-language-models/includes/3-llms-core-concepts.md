There are a few core concepts that are important to understand to work efficiently with LLMs namely tokens and prompts.

- **Prompt**. A prompt is nothing but a text sentence. Depending on how you word the sentence, you get different results.
- **Token**. A token can be a single character, a fraction of a word, or an entire word. A single token can be used to represent common words, while multiple tokens are needed to represent less common words.

## Prompt, how you instruct the LLM

A text prompt is a sentence. An LLM understands several different languages; therefore, you can write this sentence in your own language without the need to learn a specific language to work with it. An example of a prompt can look like the following texts:

_Generate an image of a pink parrot with a pirate hat._

_Create a web app in Python that handles customers_

Both of these prompts are something you can send to an LLM. The more specific you are about what you’re asking for and how, the better the result will be.

## Token, a basic unit

A token is a basic unit text or code than an LLM understands and can process.

OpenAI natural language models don't operate on words or characters as units of text, but on something in-between: tokens.

They have a useful tokenizer website that can help you understand

how it tokenizes your requests, you can navigate to [OpenAI tokenizer](https://platform.openai.com/tokenizer) and try out these examples.

> [!NOTE]
> Once you start typing inside the prompt box a counter appears there to count the total number of tokens in the box.
>
> If you are actively typing, the counter takes a few seconds to update.

## How many tokens are in the following words?

Let's try to get the number of tokens for the following words `apple`, `blueberries`, and `Skarsgård`.

As the word `apple` is a common word, it requires one token to be represented. On the other hand, the word `blueberries` requires two tokens `blue` and `berries` to be represented. Unless the word is common, proper names require multiple tokens to be represented.

This token representation is what allows AI models to generate words that you can't find in any dictionary without having to generate text on a letter-by-letter basis.

> [!NOTE]
> A letter-by-letter text generation could easily result in gibberish.

## How does completion work?

Natural Language Models generate completions one token at a time in a nondeterministic manner.

At each step, the model outputs a list of tokens and their associated weights then, the API samples one token from the list based on its weight. (Heavily weighted tokens are more likely to be selected.)

:::image type="content" source="../media/token-list.png" alt-text="Diagram showing multiple square blocks that represent n number of input tokens with an arrow beside them pointing to one square block that represents one output token.":::

The API then adds the selected token to the prompt and repeats the process until the maximum length of tokens for completions is reached or until the model generates a special token called the `stop token`, which prevents the generation of new tokens.

This nondeterministic process is what makes the model generate new words each time we send a request for completions.

> [!NOTE]
> Each Large Language Model has a limit on the number of tokens it can generate. In completions, this limit applies to the total number of tokens in the original prompt and the newly generated ones as they are added together. For more information about token limits, see the [Azure OpenAI Service models - Azure OpenAI | Microsoft Learn](https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/models).
>
> Having a larger token limit allows for longer completions and much larger prompts.
