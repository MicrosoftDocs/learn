## What is an interrupting scenario?

:::image type="content" source="../media/2-interrupting-scenario.png" alt-text="Diagram that illustrates an interrupting scenario.":::

Scenarios defined as *interrupting* are allowed to interrupt other scenarios. If the active scenario receives an unexpected response that has an interrupting intention, the interruption mechanism is engaged.

The response is *unexpected* if it doesn't comply with the data type for the current step in the scenario. For example, if a step is expecting a yes/no response and the user enters an unsuitable answer, the bot tries to identify an interrupting intention.

Scenario steps that expect a text response behave differently. They always try to identify an interrupting intention. If the intent score is higher than a 50 percent likelihood, the interrupting scenario is triggered.

System scenarios have modified behavior when they're interrupting. Typically, they're made shorter to minimize the extent of the interruption. For example, the help command doesn't show items that aren't interrupting.

The interrupting scenario displays a returning message before resuming the parent. You can configure this message in the Azure portal.

## What is a breaking scenario?

In some cases, it doesn't make sense to return to the parent scenario. For example, if a user wants to delete their data in the middle of a scenario, they can't resume after the deletion. Some interruptions are able to "break" their parents. If a scenario is configured as breaking, the parent scenario isn't resumed after the child scenario has finished.
