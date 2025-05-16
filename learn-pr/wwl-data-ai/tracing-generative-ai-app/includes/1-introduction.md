When you first build a generative AI application, success often means to get a response that works. A functional prototype marks real progress. But as your application approaches production, generating a response isn’t enough. You need to understand how the system behaves, where it can fail, and how to improve it over time.

Generative AI systems often behave unpredictably:

- Small prompt changes can lead to different outputs.
- Errors can appear in chained logic or nested model calls.
- Debugging is hard without visibility into how the system runs.

**Monitoring** alerts you when something goes wrong. **Tracing** helps you understand what happened and where it happened.

## Understand the use case

Imagine you work at Lakeshore Retail, a company that sells outdoor gear. You recently helped launch an AI assistant called *Trail Guide*. It helps customers plan hiking trips and recommends the appropriate gear. Although it usually performs well, customers report inconsistent experiences like:

- Responses referencing discontinued products.
- Responses including contradictory advise when similar questions about a product are phrased differently.
- Response times varying between queries about common products like water bottles, compared to specialized equipment like trekking poles.
- Responses including outdated safety information despite documentation updates.

As the AI engineer, you're asked to investigate. Is it a retrieval problem where we're getting the wrong documents? Is it a prompt engineering issue? Or perhaps a token limitation causing truncated context?

To uncover the issues, you need deeper insight into the application's internal logic.

## Use tracing to analyze and debug

**Tracing with Azure AI Foundry** provides that deeper insight. Tracing lets you follow the application’s execution step by step. It captures:

- The original user input and how the app processes it.
- Each component in the workflow, from prompt creation to model execution and post-processing.
- The time taken and output produced at each step.
- Any errors or unexpected behavior during execution.

By analyzing this information, you can troubleshoot, optimize, and improve complex AI systems.

By the end of this module, you're able to trace and debug the execution flow of a generative AI application using Azure AI Foundry.
