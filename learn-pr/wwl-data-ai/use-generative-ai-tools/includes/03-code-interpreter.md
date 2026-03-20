The *code_interpreter* tool provides your model with a Python runtime in which it can generate and run Python code.

## What is the code_interpreter tool?

The code_interpreter tool enables generative AI models to write and run Python code dynamically during a conversation. Rather than just discussing code or algorithms, the model can test its logic, process data, and return actual results from code. This transforms the model from a thinker into a doer.

Key features include:

- **Dynamic Python Execution**: The model writes and runs Python code in a sandboxed environment
- **File Handling**: Upload, process, and download files (CSV, JSON, images, and so on)
- **Data Analysis**: Perform calculations, statistical analysis, and data transformations on the fly
- **Real-time Feedback**: The model sees code execution results and can iterate or fix errors
- **Complex Problem Solving**: Tackle math problems, simulations, and logic puzzles through executable code

## Common Use Cases

| Use Case | Example |
|----------|---------|
| **Data Analysis** | Parse a CSV file and generate summary statistics |
| **Math & Physics** | Solve differential equations or simulate physics scenarios |
| **File Conversion** | Convert between data formats (JSON ↔ CSV, and so on) |
| **Prototyping** | Test algorithms and ideas before formal implementation |

## A simple example

Here's how to use code_interpreter with the OpenAI Responses API:

```python
from openai import OpenAI

client = OpenAI(
    base_url={openai_endpoint},
    api_key={auth_key_or_token}
)

# Get response using the code_interpreter tool
response = client.responses.create(
    model={model_deployment},
    instructions="You are an AI assistant that provides information. Use the python tool to run code for math problems.",
    input="What is the square root of 16?",
    tools=[{"type": "code_interpreter",
            "container": {"type": "auto"}}]
)
print(response.output_text)
```

The output from this code is similar to this:

```
The square root of 16 is 4.
```

More importantly, inspecting the details of the **response** object returned by the model reveals that the result was calculated and returned to the model using dynamically generated Python code like this:

```python
import math

# Calculate the square root of 16
square_root = math.sqrt(16)
square_root
```

## How the code_interpreter tool works

The general process for using the code_interpreter tool is:

1. **You send a request**: Include code_interpreter in your tools array.
2. **Model analyzes the task**: The model determines if code execution is needed.
3. **Model generates code**: The model writes Python code to accomplish the task.
4. **Code runs**: The code runs in a sandboxed environment with access to common libraries (for example, *pandas*, *numpy*, and *math*).
5. **Results returned**: The model receives the output and incorporates it into its response.

## Best Practices

- **Be specific**: Describe the data format and expected output clearly. Many models internally use the name *python tool* to identify the code_interpreter tool - so use this language in your instructions.
- **Provide context**: Include relevant domain knowledge in your prompts
- **Validate results**: Always review AI-generated code for correctness before using in production
- **Monitor costs**: Code execution adds tokens; complex operations may use more resources
- **Leverage libraries**: Common packages like pandas, numpy, and matplotlib are pre-installed
- **Error handling**: The model can see errors and will attempt to fix them automatically

## Limitations to know about

- Executions run in a **sandboxed environment** with no external network access
- Some libraries may not be available; let the model know if a standard library fails
- **Timeout limits** apply to long-running operations
- Code runs with **memory constraints**—massive datasets may need streaming or chunking
