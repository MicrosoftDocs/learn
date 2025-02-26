Custom evaluators are helpful for assessing generative AI applications for your specific criteria, as they allow for a more detailed evaluation tailored to specific, context-based requirements that conventional metrics might miss. For instance, while a conventional metric like fluency assesses the grammatical and syntactical correctness of generated content, it might not capture subtler aspects such as the friendliness or tone appropriateness of a response. 

Custom evaluators can be tailored to measure these more subjective and context-specific attributes. Custom evaluators validate that the AI not only generates fluent text but also aligns with the desired emotional and social nuances required for applications. Custom evaluators are especially crucial in domains like customer service, where the tone and manner of communication significantly affect user experience and satisfaction. While friendliness is just one example of a custom evaluator, other custom evaluators can also significantly enhance the quality and appropriateness of AI-generated content.

## Prompty

You can create a custom evaluator with Prompty, a prompt template experience within the `promptflow` package. Prompty standardizes prompts and their execution into a single asset and is composed of the specification, tooling, and runtime.

### Specification

The Prompty asset is a markdown file with a `.prompty` extension and includes a modified front matter. The front matter is in YAML format which contains several metadata fields that define model configuration and expected inputs of the Prompty. Below the front matter is the prompt template in Jinja which allows for dynamic inputs to the Prompty.

An `apology.prompty` file might resemble the following specification:

```md
---
name: Apology Evaluator
description: Apology Evaluator for QA scenario
model:
  api: chat
  configuration:
    type: azure_openai
    connection: open_ai_connection
    azure_deployment: gpt-4
  parameters:
    temperature: 0.2
    response_format: { "type":"json_object"}
inputs:
  query:
    type: string
  response:
    type: string
outputs:
  apology:
    type: int
---
system:
You are an AI tool that determines if, in a chat conversation, the assistant apologized, like say sorry.
Only provide a response of {"apology": 0} or {"apology": 1} so that the output is valid JSON.
Give a apology of 1 if apologized in the chat conversation.

```

### Tooling

The Prompty Visual Studio Code Extension helps you create, manage, and execute, your `.prompty` assets - effectively giving you a playground in the editor, to streamline your prompt engineering workflow and speed up your prototype iterations.

### Runtime

The Prompty Runtime helps you make the transition from static asset (.prompty file) to executable code (using a preferred language and framework) that you can test interactively from the command line and integrate seamlessly into end-to-end development workflows for automation.