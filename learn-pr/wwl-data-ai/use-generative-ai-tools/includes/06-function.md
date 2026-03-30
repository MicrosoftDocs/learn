The *function* tool allows your model to call developer-defined functions to retrieve data or trigger actions during a response.

## What is the function tool?

The function tool (function calling) lets a model decide when to call named tools you expose in your application. The model doesn't run your business logic directly. Instead, it returns a structured function call, your code runs the function, and then you pass the function output back to the model.

This pattern is ideal for connecting model reasoning to real-world systems like APIs, databases, business workflows, and utility functions.

Key features include:

- **Structured tool calls** - The model emits explicit function-call requests
- **Developer-controlled execution** - Your application decides how and where functions run
- **Reliable integration pattern** - Call APIs, internal services, or helper utilities safely
- **Multi-turn orchestration** - Return tool output and let the model continue reasoning
- **Grounded responses** - Answers can include live, system-generated data

## Common use cases

| Use Case | Example |
|----------|---------|
| **System Integration** | Call an internal API for account or order details |
| **Task Automation** | Trigger workflows like ticket creation or notifications |
| **Data Lookup** | Query business rules or reference tables before answering |

## A simple example

Here's an example that exposes a `get_time` function and lets the model call it when needed:

```python
import time
from openai import OpenAI

# Function to get the current time
def get_time():
    return f"The time is {time.strftime('%Y-%m-%d %H:%M:%S', time.localtime())}"


# Main function
def main():
    client = OpenAI(
        base_url={openai_endpoint},
        api_key={auth_key_or_token}
    )

    function_tools = [
        {
            "type": "function",
            "name": "get_time",
            "description": "Get the current time"
        }
    ]

    # Initialize messages with a system prompt
    messages = [
        {"role": "developer", "content": "You are an AI assistant that provides information."},
    ]

    # Loop until the user types 'quit'
    while True:
        prompt = input("\nEnter a prompt (or type 'quit' to exit)\n")
        if prompt.lower() == "quit":
            break

        # Append the user prompt to the messages
        messages.append({"role": "user", "content": prompt})

        # Get initial response
        response = client.responses.create(
            model=model_deployment,
            input=messages,
            tools=function_tools
        )

        # Append model output to the messages
        messages += response.output

        # Was there a function call?
        for item in response.output:
            if item.type == "function_call" and item.name == "get_time":
                current_time = get_time()
                messages.append({
                    "type": "function_call_output",
                    "call_id": item.call_id,
                    "output": current_time
                })

                # Get a follow up response using the tool output
                response = client.responses.create(
                    model=model_deployment,
                    instructions="Answer only with the tool output.",
                    input=messages,
                    tools=function_tools
                )

        print(response.output_text)


# Run the main function when the script starts
if __name__ == '__main__':
    main()
```

In this flow, the model decides when to call `get_time`, your code runs the function, and the model then returns a grounded final answer. Since the user can enter any prompt, the model must determine when it needs to call the function. If it does, the response to the prompt will include a function call, that the application code must implement before submitting a new prompt with the output from the function for the model to process.

The output might look something like this:

```
Enter a prompt (or type 'quit' to exit)
Hello

Hello! How can I help you today?

Enter a prompt (or type 'quit' to exit)
What time is it?

The time is 2026-03-19 17:17:41.

Enter a prompt (or type 'quit' to exit)
```

The first user prompt ("Hello") didn't require the use of the function tool, so the model responded normally. The second prompt ("What time is it?") triggered the model to select the `get_time` function, which it indicated in its response. The application code then ran the function and returned the results to the model, which then sent a second response with the results from the function.

> [!TIP]
> This example uses a single function with no parameters. You can configure the tool to use multiple functions, with or without parameters. For more information about specifying function details, see the [OpenAI developers guide](https://developers.openai.com/api/docs/guides/function-calling).

## How the function tool works

The general process for using the function tool is:

1. **You define tools** - Provide one or more function definitions in the tools array.
2. **Model evaluates the prompt** - It determines whether a function call is needed.
3. **Model emits a function call** - The response includes the function name and call metadata.
4. **Your app runs logic** - Run the matching function in your code.
5. **You return function output** - Send a `function_call_output` item with the result.
6. **Model completes the answer** - It incorporates tool results into the final response.

## Best practices

- **Keep tools focused** - Small, single-purpose functions are easier to control and test
- **Validate function inputs** - Never trust tool arguments blindly in production systems
- **Handle errors safely** - Return clear error outputs the model can reason about
- **Log tool usage** - Track calls, latency, and failure rates for debugging and governance
- **Limit sensitive operations** - Require explicit authorization for high-impact actions

## Limitations to know about

- The model requests function calls, but your application must run them
- Incorrect or unexpected tool arguments can occur and should be validated
- Tool latency can increase end-to-end response time
- Function calling improves reliability, but final outputs still need review for critical decisions

Used well, the function tool turns a model from a text generator into an orchestrator that can interact with real systems in a controlled, auditable way.
