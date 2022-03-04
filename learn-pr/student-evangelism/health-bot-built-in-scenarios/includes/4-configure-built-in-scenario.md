To configure the built-in scenarios of an Azure Health Bot instance, open the **Configuration** menu.

 :::image type="content" source="../media/3-configuration-menu.png" alt-text="Screenshot that shows the Configuration menu.":::

The **Configuration** menu contains detailed configuration items that can control every aspect of the Health Bot instance functionality and apply to every scenario. The configuration items are grouped in **Medical**, **Compliance**, and **Conversation** categories.

## Medical protocols

On the **Medical protocols** tab, you can configure the behavior of the built-in triage and symptom checking and medical information scenarios.

Let's start with the configuration of the built-in medical **Triage and symptom checking** scenario.

:::image type="content" source="../media/3-infermedica-settings.png" alt-text="Screenshot that shows the Infermedica Settings section." lightbox="../media/3-infermedica-settings.png":::

Under **Infermedica Settings**, you can configure the following parameters.

### General

Under **General**, you can edit the:

* Message when returning to triage from an interrupting scenario.
* Third-person disclaimer text.

### Pregnancy

Under **Pregnancy**, you can:

* Turn on or turn off prompts for pregnancy status.
* Specify the age range to ask about pregnancy.

### Gender

You can specify the question to ask the user about their gender.

### Preassessment

You can configure questions for symptom collection.

### Assessment

You can configure symptom checking and triage questions.

### Triage results

You can configure title text for suggested care and possible causes.

:::image type="content" source="../media/3-medical-information.png" alt-text="Screenshot that shows the Medical Information tab."  lightbox="../media/3-medical-information.png":::

On the **Medical Information** tab, you can edit the responses for questions about conditions, symptoms, and online resources.

## Compliance

Under **Compliance** configuration, the following topics can be changed.

### Privacy

Configure how users can manage their data.

:::image type="content" source="../media/3-privacy-tab.png" alt-text="Screenshot that shows the Privacy tab." lightbox="../media/3-privacy-tab.png":::

### Security

Configure the security settings for your bot instance. For example, you can change the timeout duration and message and require user authentication.

:::image type="content" source="../media/3-security-tab.png" alt-text="Screenshot that shows the Security tab." lightbox="../media/3-security-tab.png":::

### Terms and consent

Configure terms and consent to meet legal requirements. For example, if you've enabled the consent mechanism, users will be prompted to agree to your Terms of Use and Privacy policy before they can interact with the bot.

:::image type="content" source="../media/3-agree-terms.png" alt-text="Screenshot that shows Agree to terms.":::

## Conversation

Under **Conversation** configuration, the following topics can be changed.

### Interactions

Configure built-in scenarios that interact with your users. For example, you can configure:

* Default error or retry messages.
* A default message when returning from interrupting scenarios.
* A default reply for utterances that aren't understood.

   :::image type="content" source="../media/3-interactions.png" alt-text="Screenshot that shows the Interactions tab options."  lightbox="../media/3-interactions.png":::

You can also change the automatic welcome message that appears when users first enter the chat. Or, you can use a custom scenario as an automatic welcome scenario. A custom welcome scenario overrides the automatic welcome message, but note that a custom welcome scenario won't work with multi-step scenarios.

:::image type="content" source="../media/3-automatic-welcome.png" alt-text="Screenshot that shows the Automatic welcome section." lightbox="../media/3-automatic-welcome.png":::

### Navigation

Configure the built-in scenarios that help users navigate conversations. Examples include the **cancel**, **start over**, and **help** commands.

In the **Help** section, you can control every aspect of the help menu. You can add or remove items and edit the description of each menu item.

:::image type="content" source="../media/3-navigation.png" alt-text="Screenshot that shows the Navigation tab." lightbox="../media/3-navigation.png":::

### Spelling

:::image type="content" source="../media/3-spelling-section.png" alt-text="Screenshot that shows the spelling section." lightbox="../media/3-spelling-section.png":::

Health Bot provides Spelling, this allows you to Configure the built-in spelling correction available in your bot. This services pass all utterances through a spell check before processing by the natural language understanding model. If Spelling service is enabled, user utterances are spell checked if they aren't understood in their original spelling. For example, a user might have spelling mistakes.

On the **Spelling** tab, you can configure the:

* Spelling verification message that displays when the speller has corrected an utterance.
* Message that displays when the speller has corrected an utterance but user intent wasn't understood.
* Message that displays when the user rejects spelling verification.

   :::image type="content" source="../media/3-correction.png" alt-text="Screenshot that shows Spelling correction.":::

### Human Handoff

Health Bot can be used to provide users with chat support from live agents. In some cases, it's preferable to transfer users from a bot interaction to a human conversation. For example:

* A triage flow can be handed off to a doctor or nurse.
* Support agents can resolve issues that require nongeneric assistance.
* The user can ask to be transferred to a human.

On the **Human Handoff** tab, you can enable handoff to human agents' functionality and configure related parameters. Examples are user and agent timeout and messages that are displayed when a user is waiting for an agent to connect or when an agent connects to a conversation. Handoff to live agents by using Microsoft Teams and integration with Dynamics require more configuration.

:::image type="content" source="../media/3-human-handoff.png" alt-text="Screenshot that shows the Human Handoff tab."  lightbox="../media/3-human-handoff.png":::
