The conversational flow in a bot, deals with how a user interacts with the bot as a sequence of interactions. You design your conversational flow through the use of different libraries in the Bot Framework SDK. These libraries provide different options for constructing the flow of the conversation.

There are two libraries that help you design a flow where you can more closely direct the users' interaction.  The first is the *prompts* library. You can integrate this library into your bot to create an interaction that prompts the user for input. In this way, you are directing the user's response by providing specific prompting to help guide the conversation.

The *waterfall* library is used to create a sequential flow through the use of question and answer pairs. Use the waterfall approach when you want the user to select an option from a discrete set of answers. The question and answer pair constrains the bot interaction to only those options presented. You can still opt to allow for open responses but your bot logic will need to handle the cases outside of the scoped answers.

Using a *dialog control* is another option that allows you to modularize the conversational flow. Waterfall and prompt libraries still use dialogs but the dialog control allows for *component dialogs*. The ability to encapsulate and reuse a set of dialogs is the key strength for the dialog control and component dialogs.

## Conversation flow example

An example of a conversation flow in a bot can help make these concepts a little clearer. Consider a scenario where a user is interacting with your bot to search for, and order, products. In your bot, you would implement a **root dialog** as the beginning source for the user interaction. The user may want to place an order for a product so a natural flow would be for the user to need a **new order dialog**.  The **root dialog** can invoke the **new order dialog**. At this point, the **new order dialog** has control of the conversation.

If the user knows which product they want to order, they would interact with the **new order dialog** conversation flow to order the product. When they are finished, closing the **new order dialog** would result in the conversation flow reverting back to the **root dialog, which now has control of the conversation.

If the user was in the **new order dialog** and wanted to search for a product, the **new order dialog** would then be responsible for invoking the **product search dialog**, which then takes over control of the conversation. Because the **product search dialog** was invoked by the **new order dialog**, closing of the **product search dialog** will send the conversation flow back to the **new order dialog**. Closing the **new order dialog** sends control back the **root dialog**.

Users may also invoke the **product search dialog** from the **root dialog**. Closing the **product search dialog** would result in control reverting back to the **root dialog** and not the **new order dialog**. Users may also invoke the **new order dialog** from the **product search dialog**. The flow of conversation is driven by the user, but at the same time, controlled by your conversation flow logic and how to arrange the abilities of the conversation to invoke specific dialogs.

:::image type="content" source="../media/dialogs-screens.png" alt-text="Conversation flow diagram with root, new order, and product search dialogs depicted":::

## Unexpected flow

Consider an unexpected flow as an interruption to the programmed flow of the conversation. Taking the product order example from this article, a user may be in the **new order dialog** to place an order.  Your *expected* flow is that they user places the order and then closes out of that dialog or activity. A user may decide that they want to double check the other options for similar products a need to jump back to the **product search dialog** or perhaps they want to cancel the order and start all over. The user may even decide to ask a question that isn't related to the product order. The following list highlights some potential bot responses, but ultimately, you need to decide on the best course of action for your specific scenario.

- You might require the user to complete an in-progress task before handling the interruption. If you choose this option, you should also ensure the user can *undo* the actions in the current dialog if they need to
- Restart the entire conversation flow from the beginning again. Depending on how your bot is configured, it may be the only option due to state management or to prevent unwanted consequences from leaving the conversation midstream with some products ordered of sitting in a shopping cart, abandoned
- Handle the interruption and then return to the task in progress. You will likely need to implement state management for success. Stepping out of a dialog and coming back may take a significant amount of time, resulting in any cached data being lost. If it happens, you will be forced to have the user start all over again.

Designing the conversation flow is critical for creating a good user experience. Later articles will deal with dialogs and creating the conversation flow. You will gain a better understanding of the various components that make up the flow of conversation in a bot. Then you will be able to choose the correct dialog for your specific scenario. Designing to flow for a bot is similar to designing the flow of a typical application or web site that users will interact with. The components are the only differentiators in the design considerations.
