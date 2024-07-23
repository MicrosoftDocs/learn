Planners are a great tool to use. A planner can effortlessly remix predefined functions and allow your code to support various complex user scenarios. However, there are important considerations to be made before using a planner. By understanding the potential drawbacks of performance, cost, and correctness, you can make the most of planners in your projects.

## Performance
You might notice that to run a plan, you must first call `CreatePlanAsync` and then invoke the plan. It takes time for the planner to consume a full list of tokens and generate a plan for the goal. It also takes time to run the plan. If you rely only on the planner's response after a user provides input, they might assume the application is unresponsive. You might want to consider providing some feedback or some initial response from the model while the user waits.

## Cost
Another consideration is cost. Prompts and generated plans can consume a significant number of tokens. This token consumption can result in high costs for your service if you're not careful, especially since planning typically requires your model to support higher token counts. You may want to use predefined plans for common scenarios, or adjust your functions to support fewer tokens.

## Correctness
It's possible for planners to generate faulty plans. For example, they may pass variables incorrectly, return malformed schemas, or perform steps that don't make sense. Some errors can be recovered by asking planner to "fix" the plan. Implementing robust error handling can help you ensure your planner is reliable.

Another way to ensure reliability is to use pregenerated plans. There may be common scenarios that your users frequently ask for. To avoid the performance hit and costs associated with a planner, you can predefine plans and serve them up to a user. To predefine your plans, you can generate plans for common scenarios offline and store them within your project. Based on the intent of the user, you can then serve the plan you created previously. Using predefined plans for common scenarios is a great strategy to improve performance, reliability, and reduce costs.

By understanding these considerations, you can make the most of planners, creating dynamic applications that efficiently cater to user needs.