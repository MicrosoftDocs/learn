Built-in scenarios, or dialogs, are hard-coded bot scenarios available out of the box to your users. Built-in scenarios enable important functionality, like showing a help menu or presenting the terms of service to your users.

The built-in scenarios can be used in the following cases:

* **Triage and symptom checker, powered by built-in medical protocols:** The user describes a symptom to the Azure Health Bot instance. The bot helps the user to understand it and suggests how to react. An example is **I have a headache**.

   :::image type="content" source="../media/2-symptom-checker.png" alt-text="Screenshot that shows the Triage and symptom checker demo.":::

* **General information about conditions, symptoms, and more:** Loaded with medical content, the health bot can provide information about medical conditions and symptoms, and helpful medical resources. Some examples are **Information about diabetes**, **What are the symptoms of diabetes?**, or **Resources for diabetes**.

   :::image type="content" source="../media/2-disease-information.png" alt-text="Screenshot that shows Information about particular diseases.":::

* **Drugs and medication:** The health bot can provide information about a type or brand of drugs. An example is **Information about aspirin**.

   :::image type="content" source="../media/2-aspirin-information.png" alt-text="Screenshot that shows Information about aspirin.":::

When users look for specialists, the health bot can recommend the appropriate type of doctor to treat an illness. An example is "What type of doctor treats diabetes?"

## Use built-in commands in Health Bot

Here are a few built-in commands that Health Bot supports.

### Help

If the user is unsure what actions the bot can perform, they can enter the **help** command to see a helpful summary. The help summary is a configurable list of commands that the bot understands. By default, the summary includes system commands available to all bot instances.

:::image type="content" source="../media/2-help-command.png" alt-text="Screenshot that shows the Help command.":::

### Cancel

Some bot scenarios include multiple steps. Multistep scenarios force the user to provide specific responses and don't typically allow the user to leave the flow of the scenario conversation. In some cases, the user might want to force the scenario to end. The user can use the **cancel** command to end the current scenario.

:::image type="content" source="../media/2-cancel-command.png" alt-text="Screenshot that shows the Cancel command.":::

### Start over

Users can use the **start over** command to restart the current scenario.

:::image type="content" source="../media/2-start-over.png" alt-text="Screenshot that shows the Start over command.":::

### What do you know

The user can use the **what do you know** command to see what the health bot remembers about them. The bot displays user variables that it has associated with the current user.

:::image type="content" source="../media/2-what-do-you-know.png" alt-text="Screenshot that shows the What do you know command.":::

### Forget me

Both the user variables and conversation history can be deleted by the user by using the **forget me** command.

:::image type="content" source="../media/2-forget-me.png" alt-text="Screenshot that shows the Forget me command.":::

### Log

Users can use the **log** command to see their conversation history with the bot. The bot groups conversation history by date.

:::image type="content" source="../media/2-log.png" alt-text="Screenshot that shows the Log command.":::

### Feedback

Users who want to leave feedback about their interaction with the bot can use the **feedback** command. Receiving feedback can help companies improve custom scenarios to better serve their customers. Customers can also build their own feedback flow.

:::image type="content" source="../media/2-feedback.png" alt-text="Screenshot that shows the Feedback command.":::

### Terms

The user can request to view terms at any point by using the **terms** command. The bot displays links to the Terms of Use and Privacy policy.

:::image type="content" source="../media/2-terms.png" alt-text="Screenshot that shows the Terms command.":::
