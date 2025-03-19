**DSPy** is a framework designed to help you optimize the prompt you sent to a Large Language Model (LLM), reducing the need for prompt engineering.

The DSPy framework allows you to program LLMs rather than merely prompting them. This approach shifts the focus from tweaking the LLM itself to designing a robust overarching system. Think of the LLM as a device that executes instructions through an abstraction similar to deep neural networks (DNNs).

## Explore the main components of Haystack

In the DPSy framework, hand-written prompts are replaced by **signatures** (1). A signature is handled in a **module** (2), which serves as an abstraction layer over a prompt.

:::image type="content" source="../media/dspy-framework.png" alt-text="Diagram of the main components of the DSPy framework." lightbox="../media/dspy-framework.png":::

Modules are the building blocks for the multi-stage reasoning systems, or **DSPy program** (3), you build with the DSPy framework. Finally, you can use **optimizers** to tune the parameters of one or more modules of your DSPy program.

Let's explore the main concepts in more detail.

### Declare LLM tasks with signatures

In DSPy, **signatures** play a crucial role in interacting with LLMs.

Rather than specifying how to prompt the LLM, signatures describe *what* the LLM should accomplish.

For example, a signature can specify behavior like:

- `"question -> answer"`: Convert a question into an answer.
- `"document -> summary"`: Summarize a long document.
- `"context, question -> answer"`: Generate a rational response based on a given context and question.

Signatures are responsible for managing the structured formatting and parsing logic required for these transformations. They can be compiled into self-improving and pipeline-adaptive prompts or fine-tunes, ensuring that the system evolves and adapts over time.

DSPy infers the role of fields within a signature by analyzing their names and traces (input/output examples). This inference capability allows DSPy to automatically understand the purpose of each field and apply the appropriate transformation logic.

> [!Tip]
> Learn more about [signatures](https://dspy.ai/learn/programming/signatures/?azure-portal=true).

### Handle signatures with modules

In the DSPy framework, a **module** is a parameterized *layer* that expresses a signature by abstracting a prompting technique.

A module encapsulates a specific method of interacting with an LLM, and can be reused across different tasks. Modules in DSPy are designed to be as flexible and modular as possible, allowing for easy integration and customization.

For example, DSPy includes modules like:

- `dspy.ChainOfThought`: Used for generating a sequence of thoughts or steps to arrive at an answer.
- `dspy.ReAct`: Used for generating rational responses based on a given context and question.

These modules represent different prompting techniques that can be applied to the LLM.

A module in DSPy is like a callable function. It takes several parameters, including:

- **The LLM to call**: The language model to use for the task.
- **The prompt instructions**: The specific instructions or guidelines that the LLM should follow when generating a response.
- **The demonstrations used as few-shot prompts or fine-tuning data**: The examples provided to the LLM to help it understand the task better and generate more accurate responses.

By defining modules, you use a more structured and scalable approach to working with LLMs. This modular approach makes it easier to try out different techniques and improve the LLM's performance for various tasks.

> [!Tip]
> Learn more about [modules](https://dspy.ai/learn/programming/modules/?azure-portal=true).

### Optimize your DSPy program

In DSPy, **optimizers** (formerly known as *teleprompters*) play a role in enhancing the performance of LLMs.

An optimizer takes the **program**, a **training set**, and a **metric**, and returns a new optimized program. This process ensures that the LLM is fine-tuned to perform specific tasks more effectively.

The optimizer works by analyzing the provided training set and the desired metric, which could be accuracy, efficiency, or any other relevant measure. It then adjusts the program to better align with these goals. This iterative process allows the LLM to improve over time, adapting to new data and evolving requirements.

By using optimizers, DSPy can automate the process of prompt engineering, reducing the need for manual adjustments and ensuring that the LLM remains robust and scalable. This approach not only saves time but also enhances the overall performance and reliability of the system.

> [!Tip]
> Learn more about [optimizers](https://dspy.ai/learn/optimization/optimizers/?azure-portal=true).
