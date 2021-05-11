# Configuring Built-in Scenarios

To configure the built-in scenarios of a bot, open the Configuration menu.  

 :::image type="content" source="../media/3-A.png" alt-text="Configuration Menu":::

The Configuration menu contains detailed configuration items that can control every aspect of the health bot instance functionality and apply to every scenario. The configuration items are grouped in three categories: Medical, Compliance and Conversation.

## Medical Protocols

On the medical protocols tab, you can configure the behavior of the built-in triage and symptom checking and medical information scenarios.  

Let's start with the configuration of the built-in medical triage and symptom checking scenario.

:::image type="content" source="../media/3-B.png" alt-text="Infermedica Settings":::

Under the Infermedica Settings one can configure the following parameters:

### General

Under General we can edit the:

1. Message when returning to triage from an interrupting scenario.
2. Third-person disclaimer text.  

### Pregnancy

Under pregnancy we can:

1. Turn on/off prompts for pregnancy status.
2. Specify the age range to enquire about pregnancy.

### Gender

Allows specifying the question to ask the user about their gender.

### Preassessment

Allows configuration of questions for symptom collection.

### Assessment

Allows configuration of symptom checking and triage questions.

### Triage results

Allows configuration of Title text for the suggested care, Title for the possible causes, etc.

:::image type="content" source="../media/3-C.png" alt-text="Medical Information":::

On Medical Information tab you can edit the responses for questions about conditions, symptoms and online resources.

## Compliance

Under Compliance configurations tab the following topics can be changed.

### Privacy

Configure how end users can manage their data.

:::image type="content" source="../media/3-D.png" alt-text="Privacy Tab":::

### Security

Configure security setting for your bot instance; for example, you can change the timeout duration and message and require end user authentication.

:::image type="content" source="../media/3-E.png" alt-text="Security Tab":::

### Terms and consent

Configure terms and consent to meet legal requirements; for example, if you have enabled the consent mechanism, end users will be prompted to acknowledge your terms of service and privacy policy before interacting with the bot.

:::image type="content" source="../media/3-F.png" alt-text="Agree to terms":::

## Conversation

Under Conversation configurations tab the following topics can be changed.

### Interactions

Configure built-in scenarios that interact with your end user; for example, default error or retry message, message when returning from interrupting scenarios and default reply for utterances that are not understood.

:::image type="content" source="../media/3-G.png" alt-text="Interactions":::

Additionally, you can change the automatic welcome message, which is displayed to the end user when they first enter the chat or use a custom scenario as automatic welcome scenario. The automatic welcome scenario overrides the automatic welcome message.

:::image type="content" source="../media/3-H.png" alt-text="Automatic Welcome":::

### Navigation

Configure the built-in scenarios that help end users navigate conversations; for example, cancel, start over and help commands.

:::image type="content" source="../media/3-I.png" alt-text="Navigation":::

In the “Help” section, you can control every aspect of the help menu, by adding or removing items and editing the description of each menu item.

:::image type="content" source="../media/3-J.png" alt-text="Help section":::

### Cognitive Services

Azure Health Bot provides Bing speller to pass all utterances through a spell check before processing by the natural language understanding model. If Bing speller is enabled, end user utterances are spell checked if they are not understood in their original spelling (for example, if the end user has spelling mistakes). In Cognitive Services tab, you can configure the spelling verification message that is displayed when the speller has corrected an utterance, the message that is displayed when the speller has corrected an utterance but end-user intent was not understood and the message that is displayed when end user rejects spelling verification.

:::image type="content" source="../media/3-K.png" alt-text="Spelling correction":::

### Human Handoff

The Health Bot Service can be used to provide end users with chat support from live agents. In some cases, it’s preferable to transfer end users from a bot interaction, to a human conversation. For example, a triage flow can be handed off to a doctor or nurse, support agents can resolve issues that require non-generic assistance or the end user can explicitly ask to be transferred to a human.

In Human Handoff you can enable handoff to human agents’ functionality and configure related parameters (for example, end user and agent timeout, message that is displayed when a user is waiting for an agent to connect or when an agent connects to a conversation). Handoff to live agents using Microsoft Teams and integration with Dynamics require additional configuration.

:::image type="content" source="../media/3-L.png" alt-text="Human Handoff":::
