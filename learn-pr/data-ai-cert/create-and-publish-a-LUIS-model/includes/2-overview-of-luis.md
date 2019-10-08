Understanding language is something that even humans get wrong from time to time. A good example is the use of slang terms or localized phrases. Suppose you're in Indonesia at a public place, perhaps a mall or a restaurant, and you're searching for the restroom. Your Indonesian language lessons might have taught you to use the phrase, "*Di mana kamar kecil?*"

While this phrase is technically correct, it applies mainly to seeking the restroom in someone's house. "*Kamar kecil*" literally means "small" (*kecil*) "room" (*kamar*). In public, it's more correct to ask, "*Di mana WC?*", or "*Di mana toilette?*" But if you use "*Di mana kamar kecil?*" in public, almost all Indonesians will know what you mean.

But what happens if you ask a computer that question? Will it give you the correct answer? Or will it direct you to a "small room" that isn't a restroom?

Likewise, in English, a native English speaker might understand a phrase whose meaning isn't clear to a nonnative speaker, or even to some native English speakers. How many people understand the phrase "swing the door to"? It means the same thing as "shut the door" or "close the door," but it might not be clear to everyone.

For AI to understand language, specific aspects are critical to aiding the algorithm in making comparisons and distinctions. This area is where Language Understanding Intelligent Service (LUIS) comes in.

LUIS makes use of three key aspects for understanding language:

- **Utterances:** An utterance is input from the user that your app needs to interpret.
- **Intents:** An intent represents a task or action the user wants to do. It's a purpose or goal expressed in a user's utterance.
- **Entities:** An entity represents a word or phrase inside the utterance that you want to extract.

Here's an example. Suppose you're using LUIS in a bot to help a user book a flight. A user may use the following utterance, "Book 2 tickets on a flight to New York for New Year's Eve." If we evaluate this utterance for key aspects, we can determine the user's intent. The user wants to book a flight. We can state the intent as *BookFlight*.

Entities aren't only words or phrases, but also simply data. This data helps provide specific context for the utterance and aids the algorithm in more accurately identifying the intent. Not every utterance contains entities, though.

In the sample utterance used earlier, we can identify entities like:

- **New York:** We can classify this entity as _Location.Destination_.
- **New Year's Eve:** We can classify this entity as _Event_.
- The number **2:** This number maps to a built-in entity. In LUIS, such an entity is known as a _prebuilt entity_, specifically a prebuilt number.

With this understanding, let's look at how to create a LUIS app.