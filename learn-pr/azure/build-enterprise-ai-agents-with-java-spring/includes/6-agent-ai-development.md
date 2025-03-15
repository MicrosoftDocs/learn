In this unit, you learn about AI agents, which are autonomous entities capable of making decisions and performing tasks based on their environment and objectives. Also, you explore various *agentic patterns* - including the Evaluator Optimizer pattern - to improve the performance and decision-making capabilities of AI systems by evaluating and refining outputs.

## What is an AI Agent?

An AI agent is a software entity designed to perform tasks autonomously or semi-autonomously by receiving input, processing information, and taking actions to achieve specific goals.

Agents can send and receive messages, generating responses using a combination of models, tools, human inputs, and other customizable components.

## What problems do AI agents solve?

AI agents offer several advantages for application development by enabling the creation of modular components that collaborate to reduce manual intervention in complex tasks. These advantage include the following key benefits:

- Modular components: define specialized agents for tasks like data scraping, API interaction, and natural language processing. This modularity makes it easier to adapt the application as requirements evolve.

- Collaboration: multiple agents can work together. One might handle data collection, another might perform analysis, while yet another might make decisions, creating distributed intelligence.

- Human-agent collaboration: agents can work alongside humans to augment decision-making - for example, by preparing analyses that humans review and refine.

- Process orchestration: agents can coordinate tasks across systems, tools, and APIs, automating end-to-end processes such as cloud orchestration, deployments, and creative workflows.

## Agent workflows and patterns

Modern AI applications can be designed using various agentic patterns. The Spring AI blog post on Agentic Patterns outlines several key workflows:

- Chain workflow: breaks complex tasks into a series of sequential steps. Each step processes the output of the previous one, enabling gradual transformation and refinement of data.

- Parallelization workflow: executes multiple large language model (LLM) calls concurrently using techniques like thread pools and futures. This pattern is ideal for processing large volumes of independent items or obtaining diverse perspectives through majority voting.

- Routing workflow: directs inputs to specialized handlers based on content. By classifying the input and routing it to a corresponding prompt, the system ensures that each type of task is handled optimally.

- Orchestrator-Workers workflow: uses a central orchestrator to decompose a complex task into subtasks that are handled by specialized worker agents. This pattern supports distributed problem solving while maintaining overall process control.

- Evaluator Optimizer workflow: focused on iterative refinement, this dual-model approach uses a generator (writer) to produce an initial output and an evaluator (editor) to review and suggest improvements. The process repeats until the output meets defined quality standards.

## Advanced content generation with the Evaluator Optimizer Agent pattern

Building on the core RAG functionality, advanced AI applications benefit from iterative refinement for generating high-quality content. The Evaluator Optimizer Agent pattern employs a dual-model process:

- Generator (Writer): produces an initial draft, such as a blog post.
- Evaluator (Editor): reviews the draft, providing detailed feedback and identifying areas for improvement.

### How it works

The following steps describe how this pattern works:

1. Initial generation: the writer creates a draft based on the given topic.

1. Evaluation: the evaluator reviews the draft against criteria such as clarity, engagement, and structure.

1. Iterative refinement: if improvements are needed, feedback is incorporated and the writer generates a revised draft.

1. Loop until approved: the process repeats until the content meets the desired quality standards or a maximum number of iterations is reached.

### Example application: blog post generation

In the exercise, you extend the RAG application by implementing a Blog Writer agent that uses the Evaluator Optimizer pattern. The Blog Writer service demonstrates how to:

- Generate an initial blog post draft.
- Evaluate the draft and extract actionable feedback.
- Refine the draft iteratively until the content is approved.

## Unit summary

In this unit you learn about AI agents and various agentic patterns, including Chain, Parallelization, Routing, and Orchestrator-Workers workflows. However, the module focuses exclusively on the Evaluator Optimizer Agent pattern - a dual-LLM approach that iteratively refines generated content, as demonstrated in the Blog Writer agent use case. In the next exercise, you implement this pattern in the RAG application to provide enhanced content generation capabilities.
