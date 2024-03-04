Planners are an excellent tool to help you automatically run your functions and prompts. To use the Handlebars planner, first you need to install the add-on package:

`dotnet add package Microsoft.SemanticKernel.Planners.Handlebars --version 1.2.0-preview`

Afterwards, you create a new planner object using `CreatePlanAsync` and pass it a goal. The goal is a string that describes the desired outcome. The planner then creates a plan to accomplish the goal. `CreatePlanAsync` returns a `HandlebarsPlan` object that you can use to invoke and run the plan.

For example, suppose you have some ingredient plugins that support the following functions:

    - `GetIngredients`: Gets a list of the user's available ingredients
    - `GetRecipe`: Gets a list of ingredients for a given recipe
    - `GetMissingIngredients`: Gets a list of ingredients that are missing from the user's kitchen for a given recipe

To use a planner, you create a new `HandlebarsPlanner` object, create the plan, and then invoke it.

```c#
var planner = new HandlebarsPlanner(new HandlebarsPlannerOptions() { AllowLoops = true });

string goal = @"What ingredients is the user missing from their 
   current ingredients list to make a recipe for blueberry muffins";

var plan = await planner.CreatePlanAsync(kernel, goal);
var result = await plan.InvokeAsync(kernel);
Console.WriteLine(result);

```

The output may be similar to the following result:

```output
Based on the list of ingredients for blueberry muffins, you are missing blueberries and salt from your available ingredients.
```

You can also save the generated plan and reload it later, for example:

```c#
var plan = await planner.CreatePlanAsync(kernel, goal);
var serializedPlan = plan.ToString();

HandlebarsPlan reloadedPlan = new HandlebarsPlan(serializedPlan);

var result = await reloadedPlan.InvokeAsync(kernel);
Console.WriteLine($"Results: {result}");
```

The Handlebars planner is a powerful feature that can help developers create dynamic applications and handle complex scenarios with less code. In the next unit, you'll learn how to create and run your own plan!