Large language models (LLMs) like GPT-3, GPT-3.5, and GPT-4 models from Azure OpenAI Service are prompt based. Users interact with prompt-based models by entering a text prompt, to which the model responds with a text completion. A text completion is a single completion that contains a prompt and a response. A chat completion is a series of prompts and completions. Chat completions allow you to simulate a conversation with an LLM, which helps the model produce more natural and accurate responses.

LLMs can produce unexpected or unwanted responses to prompts as a result of:

- Insufficient information in the training data.
- Insufficient context in the prompt.
- Lack of capability of the model itself.
- Hostile intent by the user providing the prompt, which is known as *jailbreaking*.

In this module, we tackle these issues by using prompt engineering techniques, including chat completion, system messages, and content filtering.

## Scenario: Update your chat bot

Imagine your company is running a chat bot by using an LLM. To ensure that the LLM is responding accurately, you need to make sure the model uses your company's latest data. You're looking to evaluate strategies to keep prompts up to date and to protect your model from jailbreaking.

## What you'll learn

 In this module, you'll learn how to:

- Create a chat completion.
- Explain how a chat completion works to produce better responses from an LLM.
- Use system messages to protect your model and chat from security risks.  

Your main objective is to use chat completions via the Azure AI Studio playground.