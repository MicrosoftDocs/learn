Microsoft Foundry Models includes models that are capable of using tools to find information or perform tasks. You can use tool support in models by specifying which tools you want the model to use in prompts submitted through the OpenAI *Responses* API.

![Diagram of an application configuring a model to use tools.](../media/tools.png)

When you develop a generative AI application using Microsoft Foundry, you can search Foundry Models for a model with tool calling capabilities and deploy it. Then, you can develop client applications that use the OpenAI Responses API to submit prompts to the deployed model, specifying the tools that the model can use.

> [NOTE]
> By default, the *model* chooses when to use a tool (and which one), based on the prompt. You can configure tool selection rules and use the *Instructions* (system prompt) parameter to guide this choice.

Some of the commonly used tools available in the *Responses* API, include:

- **code_interpreter**: A Python environment in which the model can generate and run code.
- **web_search**: A tool that enables the model to find general information on the Internet, which allows it to base responses on more current data than it was trained on.
- **file_search**: A tool that enables the model to search specific files that you upload to a dedicated vector search index - enabling it to ground responses in specific knowledge.
- **function**: A tool that enables the model to call custom functions in your application code.

We'll explore these tools in this module.

> [!TIP]
> These represent only *some* of the available tools; and development of tools for agentic AI solutions is a growing area. To learn more about tools supported in the OpenAI Response API, see the [OpenAI developer guide](https://developers.openai.com/api/docs/guides/tools?azure-portal=true)

## Specifying tools in the *Responses* API

You can specify one or more tools in a call to the `responses.create()` method when generating a response from a model. The following Python pseudocode example indicates where the list of callable tools is specified:

```python
from openai import OpenAI

client = OpenAI(
    base_url={openai_endpoint},
    api_key={auth_key_or_token}
)

response = client.responses.create(
    model={model_deployment},
    instructions="You are a helpful AI assistant.",
    input="Find me some information about vintage computers.",
    # Specify available tools as a JSON list
    tools=[
        { 
            # A tool definition
            "type": "{tool_type}",
            "{tool-specific-setting}": "{value}",
                ...
        },
        { 
            # Another tool definition
            "type": "{another_tool_type}",
            "{tool-specific-setting}": "{value}",
                ...
        }
    ]
)
print(response.output_text)
```

> [!TIP]
> To learn more about using the *Responses* API to submit a prompt to a model in Microsoft Foundry, see the [Develop a generative AI chat app with Microsoft Foundry](/training/modules/foundry-sdk?azure-portal=true) module.
