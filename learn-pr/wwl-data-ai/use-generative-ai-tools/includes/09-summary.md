In this module, you learned how tool calling extends a generative AI model from text-only reasoning to practical, grounded action.

You explored how to configure tools in OpenAI Responses API requests and how each tool adds a different capability:

- The **code_interpreter** tool lets the model generate and run Python code for calculations, data analysis, and iterative problem solving.
- The **web_search** tool enables retrieval of current external information so responses can include timely, source-grounded content.
- The **file_search** tool helps the model answer questions from your own indexed documents and knowledge files.
- The **function** tool allows your application to run custom business logic and return results back to the model.

Across all tools, the same core implementation pattern applies: define the tool in your request, let the model decide when to use it, return tool output when required, and validate responses for correctness and safety.

As a next step, you can combine these techniques to build more capable assistants and evolve toward full agentic solutions with persisted instructions, tools, and orchestration.

### Learn more

- [OpenAI developer guide: Tools](https://developers.openai.com/api/docs/guides/tools?azure-portal=true)
- [OpenAI developers Guide: Function calling](https://developers.openai.com/api/docs/guides/function-calling)
