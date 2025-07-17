**DSPy** is a framework that helps you build programs with Large Language Models (LLMs) by focusing on what you want the model to do rather than how to prompt it. Instead of manually writing and adjusting prompts, DSPy automatically optimizes prompts and system performance for you. Use this framework when you want systematic optimization of your LLM interactions rather than manual prompt engineering.

DSPy treats LLM interactions as programmable modules that can be composed, optimized, and reused. When you build multi-stage reasoning systems, DSPy lets you declare the behavior you need at each stage (using signatures) and automatically finds the best way to prompt the LLM to achieve that behavior.

## Explore the main components of DSPy

When you build multi-stage reasoning systems with DSPy, you work with several key components as shown in the following diagram:

:::image type="content" source="../media/dspy-framework.png" alt-text="Diagram of the main components of the DSPy framework." lightbox="../media/dspy-framework.png":::

The diagram shows the DSPy workflow:

1. **Signatures**: Replace traditional hand-written prompts with declarative specifications that define what you want the LLM to accomplish.
2. **Modules**: Serve as building blocks that handle signatures using specific prompting techniques, acting as an abstraction layer over prompts.
3. **User Input**: The input data (such as questions, documents, or context) that gets processed by your modules to produce the desired output through your DSPy program.

Beyond what's shown in the diagram, DSPy also includes **optimizers** that automatically tune the parameters of your modules to improve performance.

Let's explore the main concepts in more detail.

### Declare LLM tasks with signatures

In DSPy, **signatures** define what you want the LLM to accomplish by specifying the input and output behavior you need.

A signature describes the transformation you want to happen, using plain English field names that express semantic roles. Rather than writing specific prompts, you declare the behavior you want to achieve.

For example, signatures can specify behavior like:

- `"question -> answer"`: Convert a question into an answer.
- `"document -> summary"`: Summarize a long document.
- `"context, question -> answer"`: Generate a rational response based on a given context and question.

Signatures handle the structured formatting and parsing needed for these transformations. The DSPy compiler can turn signatures into optimized prompts or fine-tuned models that improve over time.

DSPy automatically understands what each field does by analyzing field names and input/output examples. This allows the system to apply the right logic without manual specification.

> [!Tip]
> Learn more about [signatures](https://dspy.ai/learn/programming/signatures/?azure-portal=true).

### Handle signatures with modules

In DSPy, a **module** is a building block that implements a signature using a specific prompting technique.

Each module takes a signature and applies a particular method of interacting with the LLM. Modules are reusable and can be combined to build complex programs.

DSPy includes built-in modules such as:

- `dspy.ChainOfThought`: Teaches the LLM to think step-by-step before generating the final answer.
- `dspy.ReAct`: Creates an agent that can use tools to implement the given signature.

These modules represent different prompting techniques that work with any signature.

When you use a module, you provide:

- **A signature**: Defines what the module should accomplish
- **Configuration**: Optional parameters like temperature or number of completions
- **Examples**: Optional demonstrations for few-shot learning

This modular approach makes it easy to experiment with different techniques and build scalable LLM programs.

> [!Tip]
> Learn more about [modules](https://dspy.ai/learn/programming/modules/?azure-portal=true).

### Optimize your DSPy program

DSPy **optimizers** automatically improve your program's performance by finding better ways to prompt the LLM or tune model weights.

An optimizer takes your program, a set of training examples, and a success metric, then returns an improved version of your program. This process finds the most effective prompts and examples for your specific task.

The optimizer analyzes your training data and success criteria (like accuracy or efficiency) to make targeted improvements. Different optimizers use different strategies:

- **Few-shot learning**: Finding the best examples to include in prompts
- **Instruction optimization**: Generating better natural language instructions
- **Fine-tuning**: Training smaller models based on larger model demonstrations

This automated optimization eliminates much of the manual work in prompt engineering while often achieving better results than hand-crafted prompts.

> [!Tip]
> Learn more about [optimizers](https://dspy.ai/learn/optimization/optimizers/?azure-portal=true).
