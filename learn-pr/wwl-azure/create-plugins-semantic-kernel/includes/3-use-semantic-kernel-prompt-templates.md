The Semantic Kernel prompt template language is a simple way to define and compose AI functions using plain text. You can use it to create natural language prompts, generate responses, extract information, invoke other prompts or perform any other task that can be expressed with text. Prompt templates are valuable because they allow you to create robust reusable prompts to expand the capabilities of your application.

The language allows you to include variables, call external functions, and pass parameters to functions, all by using curly braces {{...}} to embed expressions in your prompts. Semantic Kernel will parse your template and execute the logic behind it. Using prompt templates, you can easily integrate AI into your apps without the need for complex code.

## Create prompt templates

To use a variable in your prompt, you use the `{{$variableName}}` syntax. Spaces are ignored, so you can also use `{{ $variableName }}` if you prefer. Here is an example of a prompt template that uses a variable `city`:

`I'm traveling to {{$city}}. What is the best way to get around and explore the city?`

To call a function and use the results in your prompt, use the {{namespace.functionName}} syntax. For example, if you have a function `weather.getForecast`, you can write:

`The weather today is {{weather.getForecast}}`

You can also pass parameters to the function, either using variables or hardcoded values. For example, if `weather.getForecast` takes a city name as input, you can use the following examples:

```txt
The weather today in {{$city}} is {{weather.getForecast $city}}.
The weather today in Barcelona is {{weather.getForecast "Barcelona"}}.
```

## Running prompt templates

To run your prompt, you first need to create a `KernelFunction` object from the prompt using `kernel.CreateFunctionFromPrompt`. Then you can create a `KernelArguments` object containing any variables, and invoke your function using `InvokeAsync`. You can either call `InvokeAsync` on the kernel itself or on the `KernelFunction` object. Here's an example:

```c#
string city = "Rome";
var prompt = "I'm visiting {{$city}}. What are some activities I should do today?";

var activitiesFunction = kernel.CreateFunctionFromPrompt(prompt);
var arguments = new KernelArguments { ["city"] = city };

// InvokeAsync on the KernelFunction object
var result = await activitiesFunction.InvokeAsync(kernel, arguments);
Console.WriteLine(result);

// InvokeAsync on the kernel object
result = await kernel.InvokeAsync(activitiesFunction, arguments);
Console.WriteLine(result);
```

The Semantic Kernel prompt template language makes it easy to add AI-driven features to your apps using natural language. With support for variables, function calls, and parameters, you can create reusable and dynamic templates without complicated code. It’s a simple yet powerful way to build smarter, more adaptable applications.