Until now, you manually invoked functions and prompts to accomplish tasks. However, the Semantic Kernel SDK supports planners, which use artificial intelligence (AI) to automatically call the appropriate plugins for a given scenario.

### What is a planner?

A planner is a dynamic tool that transforms a user's request into an actionable plan. A planner accepts a goal, which might be the request of the user or developer. To accomplish the goal, the planner uses AI to select and combine the plugins registered to the kernel into a series of steps.

Suppose you created plugins to recommend recipes, shopping lists, and manage the ingredients a user has in their kitchen. A planner can automatically create the workflows for dynamic user input. For example, a user might enter a request such as "What do I need to make chicken tikka masala." The planner can automatically combine the right functions without requiring you to explicitly invoke them for that scenario.

### How does it work?

Behind the scenes, the planner uses a prompt to the large language model (LLM) to generate the plan. The planner is given a set of rules to use when generating a plan. The rules include a description of all of the functions you supplied to the kernel to create the plan. This feature is part of the reason why you include descriptions to your native functions. Those descriptions help the LLM decide which functions to use when generating a plan.

Here's a snippet of the LLM prompt the Handlebars planner uses to generate a plan:

```output
## Start
Now take a deep breath and accomplish the task:
1. Keep the template short and sweet. Be as efficient as possible.
2. Do not make up helpers or functions that were not provided to you, and be especially careful to NOT assume or use any helpers or operations that were not explicitly defined already.
3. If you can't fully accomplish the goal with the available helpers, just print "{{insufficientFunctionsErrorMessage}}".
4. Always start by identifying any important values in the goal. Then, use the `\{{set}}` helper to create variables for each of these values.
5. The template should use the \{{json}} helper at least once to output the result of the final step.
6. Don't forget to use the tips and tricks otherwise the template will not work.
7. Don't close the ``` handlebars block until you're done with all the steps.
```

Using planners can help you easily create advanced applications that can handle complex scenarios.