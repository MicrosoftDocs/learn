Bot navigation is a bit different from conversational flow. Navigation determines how users move around in the interaction with the bot, through a non-linear fashion. Using the conversation flow from the article in this module, Design Conversation Flow, you learned that a user can interact with dialogs. Dialogs contain the necessary activities that are a part of that conversation portion, ordering a product or searching for products. Navigation in a bot conversation is dependent on user actions.

An example of navigation can be understood by looking at a pizza order bot. A bot for this purpose might consider a waterfall approach to the conversation flow as outlined here:

- Greet user
- Ask user what they wish to order
- User selects pizza
- Prompt for pizza size
- Prompt for dough or crust type
- Prompt for sauce type
- Prompt for topping on
- Ask if an additional topping is desired
- If user answers yes, prompt for additional topping
- Repeat until user is done with toppings
- Prompt for cheese type
- Prompt for cheese coverage (full, half, etc.)
- Prompt for side orders
- Repeat until no more side orders desired
- Prompt for pickup or delivery
- Prompt for payment
- Confirm order
- End conversation

As long as the user follows this flow, they successfully navigate your bot and they place an order for the pizza they would like. What happens if the user breaks this navigation? For example, after choosing the crust type, they decide that the size of pizza needs to be changed. How does your bot handle that shift in navigation? The scenario is not a linear because the user wants to go back to a previous step.

Microsoft lists a few "types" of bots that demonstrate navigation issues that impact the user experience. Recall that your bot should present a good user experience or adoption of the bot will likely fail.  Here are some sample areas where user experience is hampered by poor navigational experience.

## Inability to change conversation direction

In our pizza example, this type of issue can best be demonstrated by a short conversation. Assume the user has reached the point in the bot conversation where they are prompted for the crust type:

Bot: Choose a crust - thin, hand-tossed, stuffed
User: Change size
Bot: Choose a crust - thin, hand-tossed, stuffed
User: Change size
Bot: Choose a crust - thin, hand-tossed, stuffed
User: Quit
Bot: Choose a crust - thin, hand-tossed, stuffed

The above example shows a bot design where the conversation flow and navigation are not user-friendly.  The bot does not allow for any other entry except to choose the responses in the order of the conversation flow.  Obviously it creates a poor user experience and results in pizzas not getting ordered.

In this case, you need to consider a design where the bot can react appropriately if the user changes the course of the conversation. You could set a maximum number of retry attempts for the same prompt to avoid this situation. The bot is not intelligently handling the conversation but at least you could restart the conversation and have the user begin the pizza order from the beginning.

## Response not aligned with user input

Using our pizza bot as an example, what happens if the user enters an invalid response for the pizza size.  Maybe they asked for a 10 foot pizza. If the bot continues the pizza order and prompts the user for the crust type, what should the user expect to receive for a pizza size?

You could design your bot to only allow legitimate sizes of pizza in one of two ways. First, you could present only viable options for the user to select from and prevent any textual input.  Doing so constrains the choices to only valid pizza sizes. If you want to allow text entry, you should design in some middleware that can evaluate the text entries for valid pizza sizes and provide a response to the user if they enter non-valid sizes.

## A mysterious bot

Rather than being a bot that creates murder mysteries, this concept is more about bot responsiveness. If a user makes a selection or enters some input during the bot conversation, be sure to at least acknowledge the response. Many times a bot is working in an asynchronous fashion. If a bot is taking some time to complete a task, related to the input, asynchronous operations permit the bot to still be "responsive" to the user from the perspective that the user can still enter more input. If you don't acknowledge the initial input, the user is left wondering if the bot is doing something or not.

Testing your bot before deployment, can identify potential issues with completing tasks in a timely manner. Most users expect a bot experience to be immediate. If your bot needs to perform a long-running task and you know about it, you can provide a response to the user informing them that it may take time for the task to complete.

All of these scenarios demonstrate where a bot has created a poor user experience. When it comes to users who interact with your bot, as much as possible, expect the unexpected from user navigation.
