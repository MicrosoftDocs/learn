There are a few core concepts that are important to understand to effectively use LLMs, namely *tokens* and *prompts*.

- **Prompt**: A prompt is a text sentence used to instruct the LLM. Depending on how you word the sentence, you get different results.
- **Token**: A token can be a single character, a fraction of a word, or an entire word. A single token can be used to represent common words, while multiple tokens are needed to represent less common words.

## Prompts

A text prompt is a sentence. An LLM understands several different languages. You can write prompts in your own language without the need to learn a specific language to work with the LLM. See the following examples of prompts:

- _Generate an image of a pink parrot with a pirate hat._

- _Create a web app in Python that handles customers._

The more specific you are about what you’re asking for, the better the result is.

## Tokens

A token is a basic unit text or code that an LLM can understand and process.

OpenAI natural language models don't operate on words or characters as units of text, but on something in-between: tokens.

OpenAI provides a useful tokenizer website that can help you understand how it tokenizes your requests. For more information, see [OpenAI tokenizer](https://platform.openai.com/tokenizer).

> [!NOTE]
> After you start typing inside the OpenAI tokenizer prompt box, a counter appears to count the total number of tokens in the box.
>
> If you're actively typing, the counter might take a few seconds to update.

## How many tokens are in the following words?

Let's try to determine the number of tokens for the following words `apple`, `blueberries`, and `Skarsgård`.

Because the word `apple` is a common word, it requires one token to be represented. On the other hand, the word `blueberries` requires two tokens (`blue` and `berries`) to be represented. Unless the word is common, proper names like `Skarsgård` require multiple tokens to be represented.

This token representation is what allows AI models to generate words that you can't find in any dictionary without having to generate text on a letter-by-letter basis.

> [!NOTE]
> A letter-by-letter text generation could easily result in gibberish.

## How does completion work?

Natural language models generate completions one token at a time in a nondeterministic manner.

At each step, the model emits a list of tokens and their associated weights. The API then samples one token from the list based on its weight. Heavily weighted tokens are more likely to be selected.

:::image type="content" source="../media/token-list.png" alt-text="Diagram showing multiple square blocks that represent n number of input tokens with an arrow beside them pointing to one square block that represents one output token.":::

The API adds the selected token to the prompt and repeats the process until the maximum length of tokens for completions is reached or until the model generates a special token called the *stop token*, which prevents the generation of new tokens.

This nondeterministic process is what makes the model generate new words each time we send a request for completions.

> [!NOTE]
> Each LLM has a limit on the number of tokens it can generate. In completions, this limit applies to the total number of tokens in the original prompt and the newly generated ones as they're added together. For more information about token limits, see the [Azure OpenAI Service models](/azure/ai-services/openai/concepts/models?azure-portal=true).
>
> Larger token limits allow for longer completions and much larger prompts.
