 Designing the user experience for a bot encompasses the previous two articles that focused on conversational flow and navigation. Another critical consideration is how you present the bot and its components to the user. You can implement the following features into a bot:

- text - a typical interaction that is lightweight and involves presenting text to the user and having the user respond with text input
- buttons - presenting the user with buttons from which to select options. In a pizza order bot, you might decide to use buttons to represent the pizza sizes available. They are a visual way to represent choices to users and add more visual appeal when compared to text
- images - using images in the bot interaction adds a nice graphical appearance to the bot and can enhance the user experience
- cards - allow you to present your users with a variety of visual, audio, and/or selectable messages and help to assist conversation flow

There are some considerations to be aware of when it comes to adding these features. Different channels will render each of these components differently. If a channel doesn't support the feature, the user experience can be degraded due to poor rendering or functional impairments.

## Text

Text input from users is parsed to determine the intent. The ability to add natural language understanding to a bot is possible. Careful consideration around language understanding is important. One of the main reasons concerns how difference users will respond to a question. For example, your bot would ask "What is your name?". Users might respond with their name, such as Terry. The user may also respond with a phrase, "My name is Terry". If you want to personalize the conversation with followup prompts including the user's name, your bot logic needs to parse the response and isolate the name from the rest of the text.

Careful planning could reveal a better design option where the bot is specific in the prompt. Your bot could prompt the user with "What is your first name?". It doesn't completely eliminate ambiguity but it leans toward a more appropriate response that may not require extensive parsing logic.

Your bot can integrate different cognitive services to aid in language understanding, keyword, or phrase detection, as well as sentiment analysis. These features make you bot more "intelligent" but they also lead to response time delays if too many services are integrated for each response. Essentially, the less processing required on the user input, the less chance for misinterpretation or bot performance.  The following are recommended considerations for text input, from Microsoft.

- Whenever possible, ask specific questions that will not require natural language understanding capabilities to parse the response. It will simplify your bot and increase the success your bot will understand the user
- Designing a bot to require specific commands from the user can often provide a good user experience while also eliminating the need for natural language understanding capability.
- If you are designing a bot that will answer questions based on structured or unstructured data from databases, web pages, or documents, consider using technologies that are designed specifically to address this scenario rather than attempting to solve the problem with natural language understanding.
- When building natural language models, do not assume that users will provide all the required information in their initial query. Design your bot to specifically request the information it requires, guiding the user to provide that information by asking a series of questions, if necessary.

## Speech

You can design your bot to take advantage of speech input and output. You may decide that your bot application needs to support speech if it will be accessed from devices that do not contain keyboards or monitors. You may also design your bot for users with differing abilities to interact with computing devices.

Using speech will require your bot to interact with the Speech cognitive services to transcribe the spoken word to text, for actions by the bot, and then synthesize the text responses to speech as the output.

## Rich user controls

Buttons, images, carousels, and menus are examples of rich user controls. The advantage to using these types of controls with your bot are;

- provide a more guided experience with the bot
- emulate an application. Users are familiar with using applications on their computers or devices so it makes the bot use more "natural"
- presents the user with discrete choices resulting in less ambiguity and misinterpretation by the bot's logic
- ease of use on mobile devices where typing text is not optimal or less-preferred by users

## Cards

Cards allow you to present your users with a variety of visual, audio, and/or selectable messages and help to assist conversation flow. Cards are programmable objects containing standardized collections of rich user controls. An advantage of cards is that they are recognized across a wide range of channels. Examples of cards follow.

### The adaptive card

An open card exchange format rendered as a JSON object. Typically used for cross-channel deployment of cards. Cards adapt to the look and feel of each host channel.

:::image type="content" source="../media/adaptive-card-flight.png" alt-text="Adaptive card showing information for an airline flight":::

### The audio card

A card that can play audio files. This card could be helpful in a bot that interacts with users who have visual impairments.

:::image type="content" source="../media/audio-card.png" alt-text="Audio controls for volume, play, and pause":::

### The animation card

This card can play animated GIFs or short video files. You could this card to depict actions or status indicators.

### The HeroCard

A card that contains a single large image, one or more buttons, and text. Typically used to visually highlight a potential user selection. In this sample HeroCard, the user sees the name and image of a musical band and they can select the Purchase Tickets button to start the process of having the bot buy tickets for the concert or event.

:::image type="content" source="../media/hero-card-1.png" alt-text="HeroCard depicting a musical band and a purchase tickets button":::

### ThumbnailCard

A card that contains a single thumbnail image, one or more buttons, and text. Typically used to visually highlight the buttons for a potential user selection.

:::image type="content" source="../media/thumbnail-card.png" alt-text="Thumbnail card Image":::

### ReceiptCard

If users are able to purchase items with your bot, you can use the ReceiptCard to provide a transaction record for the user.  The receipt can contain the items purchased, unit price, taxes, and totals.

:::image type="content" source="../media/receipt-card-1.png" alt-text="Receipt card showing order details and payment method":::

### SignInCard

A card that enables a bot to request that a user sign-in. It typically contains text and one or more buttons that the user can select to initiate the sign-in process.

### SuggestedAction card

In the design considerations earlier in this article, it was indicated that offering users a discrete set of actions or options, often leads to a better user experience. The SuggestedAction card gives the user a discrete set of options from, which to choose, but is also context aware.  The actions presented are related to the next action the users needs to take and not generic in nature. The card disappears once any of the suggested actions is selected.

:::image type="content" source="../media/suggested-action.png" alt-text="Suggested Action Card image for pizza order selections":::

### VideoCard

A card that can play videos. Typically used to open a URL and stream an available video.

:::image type="content" source="../media/video-card.png" alt-text="Video card image showing video and player controls":::

### CardCarousel

A horizontally scrollable collection of cards that allows your user to easily view a series of possible user choices.

:::image type="content" source="../media/card-carousel.png" alt-text="Card carousel image":::

## Recommendations for choosing the experience options

The following table highlights some considerations for designing the user experience through choices on the elements your bot uses. The table is not exhaustive but offers some insights around decision making for a good user experience.

|Bot Scenario|User Experience Aspects|Rationale|
|---|---|---|
|Pizza Order Bot|Text, SuggestAction, AdaptiveCard, ReceiptCard|Text can be used for initial greeting and some prompting as well as input for special instructions. Using the SuggestAction card can help constrain the user to legitimate choices. The Adaptive card could be used to present the final order with details and an image of the ordered pizza. Finally, the ReceiptCard can be used to provide the user with the order receipt for their records.|
|Flight Booking|Text, SuggestAction, AdaptiveCard|Text input an allow the user to enter items such as destination city and number of passengers. Use the SuggestAction card to display a list of acceptable airports for a destination. The AdaptiveCard control can be used to display the flight details for the user to verify before making the purchase.|
|Sporting Events|HeroCard, AdaptiveCard, SuggestedAction|The HeroCard can be used to display a list of sporting events for the user's location.  It can display graphics representing team logos or perhaps a seating chart for the user to select from. The AdaptiveCard can serve as a visual validation of the seats ordered and event details. Users could print the AdaptiveCard layout as a proof of purchase as well. You could use the SuggestAction card to constrain choices to available sections, number entries ticket quantity, and event dates.|

Many of these bot scenarios could easily implement some of the other controls listed in this section. The user experience design is up to you. Apply the conversation flow and navigation principles that you learned earlier, along with these rich controls, to create a bot that users will want to interact with.
