Dialogs are considered the building blocks of bot functionality. Each dialog will contain instructions that dictate how the bot should react to user input. In other words, the dialog helps you manage the conversation objectives. If you are using the SDK, you would write code to implement dialog functionality in your bot. Using the Bot Framework Composer, you can take advantage of the visual designer and the environment, to add and configure dialogs, without the need to write code.

There are two types if dialogs that you can implement in Composer. The first is a *main dialog*. The *main dialog* is initialized by default when you create a new bot. The second type is a *child dialog*. *Child dialogs* are used to organize the dialog system for your bot. You don't have to create any child dialogs at all if your bot is simple but they offer the ability to create complex bot conversations.

Understanding the anatomy of a dialog will help in understanding how interactions work with the dialog.

:::image type="content" source="../media/adaptive-dialog-anatomy.png" alt-text="dialog anatomy depicting triggers, memory, recognizer, actions, and language generation components":::

In the anatomy of the dialog, there are various components as listed here:

- LU Recognizer - the recognizer component is responsible for interpreting what the user wants, based on the input. There are three options for a recognizer, *None*, *LUIS*, and *Regular Expression*. The **LUIS** recognizer utilizes the language understanding service to understand the user's intent through analysis of the *utterance* entered by the user. LUIS is the default recognizer if no other is selected. The *regular expression* type will use industry standard regex formulations to determine the user's intent.
- Trigger - Once a message is processed in the input and the recognizer, the **intent** and **entity values** are passed onto triggers. **Intents** are values that represent a user intention such as **BookFlight** of **GetWeather**. **Entity values** are key data aspects of the utterances (phrases) that a user enters. **Triggers** contain rules that direct the bot's actions for processing incoming messages. **Triggers** also help direct the bot behavior and are used for situations where users request help or you need to handle custom events.

When creating a trigger in your dialog, you select from the available trigger types: *Intent recognized*, *Unknown intent*, *Dialog events*, *Activities*, *Custom events*. **Triggers** consist of a name, an action, and a condition. The trigger types are listed here:

- Intent triggers - An intent is either a recognized intent or an unknown intent. The incoming message is passed to the recognizer and either the intent is detected or it is unknown. If the intent is recognized, it gets passed to the trigger, along with any entities contained in the message and the trigger dictates the action(s) to take. If the intent is unknown, then an **Unknown intent** trigger is fired. The logic in the **Unknown intent** trigger is designed to handle unknown intents.
- Dialog events - The base type of triggers are dialog triggers. Almost all events start as dialog events that are related to the "lifecycle" of the dialog. Currently there are four different dialog events triggers in Composer:

    - Dialog started (Begin dialog event)
    - Dialog canceled (Cancel dialog event)
    - Error occurred(Error event)
    - Reprompt for input(Reprompt dialog event)

    Most dialogs include a trigger configured to respond to the BeginDialog event, which fires when the dialog begins. It allows the bot to respond immediately.

    You use dialog triggers to:

    - Take actions immediately when the dialog starts, even before the recognizer is called.
    - Take actions when a "cancel" signal is detected.
    - Take actions on messages received or sent.
    - Evaluate the content of the incoming activity.
- Activities - Typical activities are when a user joins a conversation with a bot. The **Greeting** activity is an example and is realized through the **ConversationUpdate activity**. You use activities for the following scenarios:
    - A new conversation is started with the bot
    - Take action on receipt of any of these activity types: *EndOfConversation*, *Event*, *HandOff*, *Invoke*, *Typing*
    - Take action on message activity such as: *MessageReceived*, *MessageUpdated*, *MessageDelete*, or *MessageReaction*
- Custom Events - Custom events are created by you to handle non-default conditions or to control an action associated with a trigger. Custom events are not covered in this content.

Triggers typically contain a series of **actions** that are performed to satisfy the user request. You will implement various types of **actions** as a part of your dialogs. Typical examples of **actions** would be *sending a response*, *ask a question*, *create a condition*, *perform looping*, *dialog management tasks*, *manage properties for the dialog*, *access external resources*, and *configure debugging options*.

The **Language Generator (LG)** is used to construct messages from variables and templates. For example, you could create a variable to accept a user's name during the initial conversation. **LG** can use that variable in responses to the user making the response seem more personal.

Finally, **memory** is where various properties and values will be stored during the bot conversation. They allow you to access pertinent values and property information for the duration of the conversation.
