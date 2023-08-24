The GPT-35-Turbo and GPT-4 models are language models that are optimized for conversational interfaces. The models behave differently than the older GPT-3 models. Previous models were text-in and text-out, meaning they accepted a prompt string and returned a completion to append to the prompt. However, the GPT-35-Turbo and GPT-4 models are conversation-in and message-out. The models expect input formatted in a specific chat-like transcript format, and return a completion that represents a model-written message in the chat.

In Azure OpenAI there are two different options for interacting with these type of models:

* Chat Completion API.
* Completion API with Chat Markup Language (ChatML).

The Chat Completion API is a new dedicated API for interacting with the GPT-35-Turbo and GPT-4 models and we'll use it as we go along here.

## Understanding the Chat Completion API roles

OpenAI trained the GPT-35-Turbo and GPT-4 models to accept input formatted as a conversation. Every input or prompt sent to the model and every response returned by the model is added to an overall conversation in the Chat Completion API.

The Chat Completion API refers to the incoming prompts and outgoing responses as messages.

The model accepts an array of message objects with a conversation organized by roles. There are 3 types of roles: System, User, and Assistant.

### The System role

The system role also known as the system message is included at the beginning of the array. This message provides the initial instructions to the model. You can provide various information in the system role including:

* A brief description of the assistant
* Personality traits of the assistant
* Instructions or rules you would like the assistant to follow
* Data or information needed for the model, such as relevant questions from an FAQ

You can customize the system role for your use case or just include basic instructions. The system role/message is optional, but it's recommended to at least include a basic one to get the best results.

### The user and assistant roles

The conversation happens between a user and the assistant. The user is the person entering prompts and interacting with the model. The responses from the model is represented by the system role.

The message the user sends to the model should follow best practices for designing prompts in order to get the highest quality responses.

## Message prompt examples

Here are a few examples of different styles of prompts that you could use with the GPT-35-Turbo and GPT-4 models. These are just a starting point and you can experiment with different prompts to customize the behavior.

### Basic example

If you want the GPT-35-Turbo model to behave similarly to [chat.openai.com](https://chat.openai.com), you can use a basic system message like "Assistant is a large language model trained by OpenAI".

We'll learn how to use the Chat Completion API's .NET SDK in the next unit, for now we'll stick with variable names as an example.

```csharp

string systemMessage = "Assistant is a large language model trained by OpenAI";
string userMessage = "Who were the founders of Microsoft?";

```

### Example with instructions

For some scenarios, you may want to give additional instructions to the model to define guardrails for what the model is able to do.

```csharp
string systemMessage = """
Assistant is an intelligent chatbot designed to help users answer their tax related questions.
Instructions: 
- Only answer questions related to taxes. 
- If you're unsure of an answer, you can say "I don't know" or "I'm not sure" and recommend users go to the IRS website for more information. 
""";

string userMessage = "When are my taxes due?";
```

## Managing conversations

The model has no memory, so it needs an updated transcript with each new question with all questions and answers otherwise it will lose context.

This means you will need to send the entire, updated conversation to the model every time you interact with it and then token limit for each model could easily be hit.

The token limit for `gpt-35-turbo` is 4096 tokens, whereas the token limits for `gpt-4` and `gpt-4-32k` are 8192 and 32768 respectively. You must stay under those limits otherwise you'll receive an error.

You can keep track of the token count and remove the oldest messages from the array sent to the model. It is best to always keep the system message and only remove assistant or user messages. However over time this method of managing the conversation can cause the conversation quality to degrade as context of earlier parts of the conversation are lost.

Alternatively, once the token limit is reached, you can prompt the user to start a new conversation.

