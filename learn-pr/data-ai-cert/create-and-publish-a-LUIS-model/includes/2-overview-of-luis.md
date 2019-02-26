Language understanding is a concept that even humans get wrong from time to time. A good example is the use of slang terms or localized phrases. If you are in Indonesia at a public place, perhaps a mall or in a restaurant, and you're searching for the restroom.  Indonesia language lessons might teach you to ask where the restroom is with the phrase, Di mana kamar kecil?  While this is technically correct, it applies mainly to seeking the restroom in someone's house because kamar kecil literally mean small (kecil) room (kamar). In public, it's more correct to ask, Di mana WC, or Di mana toilette.  However, almost all Indonesians will know what you are asking. What happens if you attempt to have a computer perform that translation to understand what you asked?  Will it get the correct answer or will it try to direct you to a "small room" somewhere that isn't actually a restroom?  

Likewise, in the English language, there are many scenarios where a human "understands" the meaning of a phrase or statement, where the subtle similarities aren't apparent to a non-native English speaker.  How many would understand the phrase "swing the door to"?  This is the same as "shut the door" or "close the door", but not everyone would understand these equivalents.  For AI to understand language, specific aspects are critical to aid the algorithm in making comparisons and distinctions.  This is where the Language Understanding Intelligent Service, LUIS, comes into play.

LUIS makes use of three key aspects for understanding language:

1. **Intent** - An intent represents a task or action the user wants to perform. It is a purpose or goal expressed in a user's utterance.
1. **Utterance** - Utterances are input from the user that your app needs to interpret.
1. **Entities** - The entity represents a word or phrase inside the utterance that you want extracted.

Let's see an example of this. One of the more common scenarios might focus around using LUIS in a Bot to help a user make a flight booking.  A user may use the following utterance, "Book 2 tickets on a flight to New York for New Year's Eve celebrations." If we evaluate this utterance for key aspects, we can determine the user's intent.  They want to book a flight. We can state the intent is "BookFlight".

Entities, as indicated above, are words or phrases, but also simply data, that help to provide specific context for the utterance and aid in more accurately identifying the intent.  Not every utterance will contain entities.  In our utterance for booking the new York flight, we can identify entities such as:

- **New York** - we can classify this entity as Location.Destination
- **New Year's Eve** - we might classify this entity as Event
- **3** - This is actually a built-in entity in LUIS known as Prebuilt number

With this understanding, let's now look at how to create a LUIS app.