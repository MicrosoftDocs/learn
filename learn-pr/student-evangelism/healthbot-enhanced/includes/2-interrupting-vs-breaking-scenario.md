**What is an Interrupting scenario?**

:::image type="content" source="../media/2-interrupting-scenario.png" alt-text="interrupting scenario":::

Scenarios defined as "Interrupting" are allowed to interrupt other scenarios. If the active scenario receives an unexpected response that has an interrupting intention, the interruption mechanism is engaged.

The response is 'unexpected' if it doesn't comply with the data type for the current step in the scenario. For example, if a step is expecting a Yes/No response and the user types an unsuitable answer, the bot will try to identify an interrupting intention.

Scenario steps that expect a text response behave differently. They will always try to identify an interrupting intent. If the intent score is higher than 50% likelihood the interrupting scenario will be triggered.

System scenarios have modified behavior when they are interrupting. Typically, they are made shorter to minimize the extent of the interruption. For example, the help command doesn't show items that are not interrupting.

The interrupting scenario displays a returning message before resuming the parent. This message can be configured in the management portal.

**What is a breaking scenario?**

In some cases, it doesn't make sense to return to the parent scenario. For example, if a user wants to delete their data in the middle of a scenario, they can't resume after the deletion. Some interruptions are able to "break" their parents. If a scenario is configured as breaking, the parent scenario is not resumed after the child scenario has completed.
