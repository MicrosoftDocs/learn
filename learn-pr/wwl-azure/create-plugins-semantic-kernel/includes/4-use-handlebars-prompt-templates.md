Semantic Kernel supports using the Handlebars template syntax for prompts. Handlebars are a straightforward templating language primarily used for generating HTML, but it can also create other text formats. Handlebars templates consist of regular text interspersed with Handlebars expressions.

To use Handlebars template with Semantic Kernel, start by installing the package:

```sh
dotnet add package Microsoft.SemanticKernel.PromptTemplates.Handlebars --version 1.30.0
```

```sh
pip install --upgrade semantic-kernel
```

Next, import the package into your code:

::: zone pivot="csharp"

    ```c#
    using Microsoft.SemanticKernel.PromptTemplates.Handlebars;
    ```
    
    All of the top level statements added include the following:
    
    ```c#
    using Microsoft.SemanticKernel; // Core Semantic Kernel SDK
    using Microsoft.SemanticKernel.Connectors.AI.OpenAI; // Azure OpenAI connector
    using Microsoft.SemanticKernel.PromptTemplates; // For prompt template configuration
    using Microsoft.SemanticKernel.PromptTemplates.Handlebars; // For Handlebars template support
    using System; // For Console and basic types
    using System.Collections.Generic; // For Dictionary and KernelArguments
    using System.IO; // For file operations (e.g., loading YAML)
    using System.Threading.Tasks; // For async/await support
    ```

::: zone-end

::: zone pivot="python"

    ```python
    from semantic_kernel.prompt_template.handlebars_prompt_template import HandlebarsPromptTemplate   
    ```

    All of the top level statements added include the following:
    
    ```python
    from semantic_kernel.prompt_template import PromptTemplateConfig      # for prompt_config
    from semantic_kernel.prompt_template.handlebars_prompt_template import HandlebarsPromptTemplate  # for function
    import json      # for loading appsettings.json
    import yaml      # for loading HandlebarsPrompt.yaml
    import asyncio   # for running async main
    from semantic_kernel import Kernel      #  Needed (for kernel)
    from semantic_kernel.connectors.ai.open_ai import AzureChatCompletion  # for chat_service
    ```

::: zone-end

The following example demonstrates a chat prompt template that utilizes Handlebars syntax. The template contains Handlebars expressions, denoted by `{{` and `}}`. When the template is executed, these expressions are replaced with values from an input object.

::: zone pivot="csharp"

    ```c#
    const string HandlebarsTemplate = """
        <message role="system">You are an AI assistant designed to help with image recognition tasks.</message>
        <message role="user">
            <text>{{request}}</text>
            <image>{{imageData}}</image>
        </message>
        """;
    ```
::: zone-end

::: zone pivot="python"

    ```python
    handlebars_template = """
    <message role="system">You are an AI assistant designed to help with image recognition tasks.</message>
    <message role="user">
        <text>{{request}}</text>
        <image>{{imageData}}</image>
    </message>
    """
    ```
::: zone-end

In this example, there are two input objects:

1. `request` - Contains the request the assistant should complete.
1. `imageData` - Contains the base64 image data.

To use the prompt template, you need to create a `PromptTemplateConfig` object that contains the template and its format. Afterwards, you create a `KernelFunction` object from the template configuration and specify the Handlebars template factory. Here's an example:

::: zone pivot="csharp"

    ```c#
    // Create the prompt template configuration
    var templateFactory = new HandlebarsPromptTemplateFactory();
    var promptTemplateConfig = new PromptTemplateConfig()
    {
        Template = HandlebarsTemplate,
        TemplateFormat = "handlebars",
        Name = "Vision_Chat_Prompt",
    };

    // Create a function from the Handlebars template configuration
    var function = kernel.CreateFunctionFromPrompt(promptTemplateConfig, templateFactory);
    ```
::: zone-end

::: zone pivot="python"

    ```python
    # Load Azure OpenAI config from a JSON file
    with open('appsettings.json', 'r') as f:
        config = json.load(f)

    model_id = config["modelId"]
    endpoint = config["endpoint"]
    api_key = config["apiKey"]

    # Set up Semantic Kernel and Azure OpenAI service
    kernel = Kernel()
    chat_service = AzureChatCompletion(
        deployment_name=model_id,
        endpoint=endpoint,
        api_key=api_key
    )
    kernel.add_service(chat_service, "chat_completion")

    # Create the prompt template config and function
    prompt_config = PromptTemplateConfig(
        template=handlebars_template,
        template_format="handlebars",
        name="Vision_Chat_Prompt"
    )
    function = HandlebarsPromptTemplate(prompt_template_config=prompt_config)
    ```
::: zone-end

Now you can create the `KernelArguments` object with the input data and call your function.

::: zone pivot="csharp"

    ```c#
    var arguments = new KernelArguments(new Dictionary<string, object?>
    {
        {"request","Describe this image:"},
        {"imageData", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAAAXNSR0IArs4c6QAAACVJREFUKFNj/KTO/J+BCMA4iBUyQX1A0I10VAizCj1oMdyISyEAFoQbHwTcuS8AAAAASUVORK5CYII="}
    });

    var response = await kernel.InvokeAsync(function, arguments);
    ```
::: zone-end

::: zone pivot="python"

    ```python
    arguments = {
        "request": "Describe this image:",
        "imageData": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAAAXNSR0IArs4c6QAAACVJREFUKFNj/KTO/J+BCMA4iBUyQX1A0I10VAizCj1oMdyISyEAFoQbHwTcuS8AAAAASUVORK5CYII="
    }

    async def main():
        result = await kernel.invoke_prompt(
            prompt=prompt_config.template,
            request=arguments["request"],
            imageData=arguments["imageData"],
            service_id="chat_completion",
            template_format="handlebars"
        )
        print("Kernel result:", result)

    if __name__ == "__main__":
        import asyncio
        asyncio.run(main())
    ```
::: zone-end

The response to this prompt would be *similar* to the following output:

```output
The image is a solid block of bright red color. There are no additional features, shapes, or textures present.
```

## Use Handlebars templates in YAML prompts

You can create prompt functions from YAML files, allowing you to store your prompt templates alongside associated metadata and prompt execution settings. These files can be managed in version control, which is beneficial for tracking changes to complex prompts.

The following code is an example of the YAML representation of the chat prompt used in the earlier section:

```yml
name: Vision_Chat_Prompt
template: |
    <message role="system">
        You are an AI assistant designed to help with image recognition tasks.
    </message>
    <message role="user">
        <text>{{request}}</text>
        <image>{{imageData}}</image>
    </message>
template_format: handlebars
description: Vision chat prompt template.
input_variables:
  - name: request
    description: Request details.
    is_required: true
  - name: imageData
    description: Base64 image data.
    is_required: true
```

To use this prompt, you load it as an embedded resource, convert it to a function and then invoke it.

::: zone pivot="csharp"

    ```c#
    // Load prompt from resource
    var handlebarsPromptYaml = EmbeddedResource.Read("HandlebarsPrompt.yaml");

    // Create the prompt function from the YAML resource
    var templateFactory = new HandlebarsPromptTemplateFactory();
    var function = kernel.CreateFunctionFromPromptYaml(handlebarsPromptYaml, templateFactory);

    // Input data for the prompt rendering and execution
    var arguments = new KernelArguments(new Dictionary<string, object?>
    {
        {"request","Describe this image:"},
        {"imageData", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAAAXNSR0IArs4c6QAAACVJREFUKFNj/KTO/J+BCMA4iBUyQX1A0I10VAizCj1oMdyISyEAFoQbHwTcuS8AAAAASUVORK5CYII="}
    });

    // Invoke the prompt function
    var response = await kernel.InvokeAsync(function, arguments);
    ```
::: zone-end

::: zone pivot="python"

    ```python
    import yaml

    # Load YAML prompt from file
    with open("HandlebarsPrompt.yaml", "r") as f:
        yaml_prompt = yaml.safe_load(f)

    prompt_config = PromptTemplateConfig(
        template=yaml_prompt["template"],
        template_format="handlebars",
        name=yaml_prompt.get("name", "Vision_Chat_Prompt")
    )

    function = HandlebarsPromptTemplate(prompt_template_config=prompt_config)

    arguments = {
        "request": "Describe this image:",
        "imageData": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAAAXNSR0IArs4c6QAAACVJREFUKFNj/KTO/J+BCMA4iBUyQX1A0I10VAizCj1oMdyISyEAFoQbHwTcuS8AAAAASUVORK5CYII="
    }

    async def main():
        result = await kernel.invoke_prompt(
            prompt=prompt_config.template,
            request=arguments["request"],
            imageData=arguments["imageData"],
            service_id="chat_completion",
            template_format="handlebars"
        )
        print("Kernel result:", result)

    if __name__ == "__main__":
        import asyncio
        asyncio.run(main())
    ```
::: zone-end

Using Handlebars templates with Semantic Kernel is a simple and effective way to create dynamic prompts for your applications. The Handlebars syntax is easy to use and allows you to include variables, manage prompts in YAML for better organization, and integrate AI-driven functions seamlessly. This approach makes your prompts more flexible, reusable, and easier to maintain.

You can learn more about Handlebars prompt templates from the [Handlebars Guide](https://handlebarsjs.com/guide/).
