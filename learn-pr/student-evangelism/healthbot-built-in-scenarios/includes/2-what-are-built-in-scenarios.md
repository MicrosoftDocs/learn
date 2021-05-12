Built-in scenarios (or dialogs) are hard coded bot scenarios available out of the box to your end users. Built-in scenarios enable important functionality, like showing a help menu or presenting the terms of service to your end users.

The built-in scenarios can be used in the following cases:

1. Triage/symptom checker, powered by built-in medical protocols: The end user describes a symptom to the health bot instance and the bot helps the user to understand it and suggests how to react; for example, "I have a headache."

   :::image type="content" source="../media/2-symptom-checker.png" alt-text="Triage / Symptom Checker Demo":::

2. General information about conditions, symptoms, and more: Loaded with medical content, the health bot instance can provide information about medical conditions and symptoms, and helpful medical resources; for example, "Information about diabetes",  "What are the symptoms of diabetes?", "Resources for diabetes".

   :::image type="content" source="../media/2-disease-information.png" alt-text="Information about particular diseases":::

3. Drugs and medication: The health bot instance can provide information about a type or brand of drugs; for example, "Information about aspirin".

   :::image type="content" source="../media/2-aspirin-information.png" alt-text="Information about Aspirin":::

When looking for specialists: The health bot instance can recommend the appropriate type of doctor to treat an illness; for example, "What type of doctor treats diabetes?"

## Use built-in commands in Health Bot

Below are a few built-in commands that the Health Bot supports.

### Help

If the user is unsure what actions the bot can perform, they can type the "help" command to see a helpful summary. The help summary is a configurable list of commands that are understood by the bot. By default, the summary includes system commands available to all bot instances.

:::image type="content" source="../media/2-help-command.png" alt-text="Help command":::

### Cancel

Some bot scenarios include multiple steps. Multi-step scenarios force the user to provide specific responses and do not typically allow the user to leave the flow of the scenario conversation. In some cases, the user may want to force the scenario to end. The user can use the "cancel" command to end the current scenario.

:::image type="content" source="../media/2-cancel-command.png" alt-text="Cancel command":::

### Start over

Users can use the "start over" command to restart the current scenario.

:::image type="content" source="../media/2-start-over.png" alt-text="Start over command":::

### What do you know?

The user can use the "what do you know" command to see what  the health bot instance remembers about them. The bot will display user variables that it has associated with the current user.

:::image type="content" source="../media/2-what-do-you-know.png" alt-text="What do you know command":::

### Forget me

Both the user variables and conversation history can be deleted by the end user by using the "forget me" command.

:::image type="content" source="../media/2-forget-me.png" alt-text="Forget me command":::

### Log

Users can use the "log" command to see their conversation history with the bot. The bot will group conversation history by date.

:::image type="content" source="../media/2-log.png" alt-text="Log command":::

### Feedback

Users wishing to leave feedback about their interaction with the bot can use the "feedback" command. Receiving feedback can help companies improve custom scenarios to better serve their customers. Customers can also build their own feedback flow.

:::image type="content" source="../media/2-feedback.png" alt-text="Feedback command":::

### Terms

The user can request to view terms at any point using the "terms" command. The bot will display links to the terms of service and privacy policy.

:::image type="content" source="../media/2-terms.png" alt-text="Terms command":::
