*Utterances* are the phrases that a user might enter when interacting with an application that uses your language model. An *intent* represents a task or action the user wants to perform, or more simply the *meaning* of an utterance. You create a model by defining intents and associating them with one or more utterances.

For example, consider the following list of intents and associated utterances:

- **GetTime**:
    * "What time is it?"
    * "What is the time?"
    * "Tell me the time"
- **GetWeather**:
    * "What is the weather forecast?"
    * "Do I need an umbrella?"
    * "Will it snow?"
- **TurnOnDevice**
    * "Turn the light on."
    * "Switch on the light."
    * "Turn on the fan"
- **None**:
    * "Hello"
    * "Goodbye"

In your model, you must define the intents that you want your model to understand, so spend some time considering the *domain* your model must support and the kinds of actions or information that users might request. In addition to the intents that you define, every model includes a **None** intent that you should use to explicitly identify utterances that a user might submit, but for which there is no specific action required (for example, conversational greetings like "hello") or that fall outside of the scope of the domain for this model.

After you've identified the intents your model must support, it's important to capture various different example utterances for each intent.  Collect utterances that you think users will enter; including utterances meaning the same thing but that are constructed in different ways. Keep these guidelines in mind:

- Capture multiple different examples, or alternative ways of saying the same thing
- Vary the length of the utterances from short, to medium, to long
- Vary the location of the *noun* or *subject* of the utterance.  Place it at the beginning, the end, or somewhere in between
- Use correct grammar and incorrect grammar in different utterances to offer good training data examples
- The precision, consistency and completeness of your labeled data are key factors to determining model performance.
  - Label **precisely**: Label each entity to its right type always. Only include what you want extracted, avoid unnecessary data in your labels.
  - Label **consistently**: The same entity should have the same label across all the utterances.
  - Label **completely**: Label all the instances of the entity in all your utterances.

*Entities* are used to add specific context to intents. For example, you might define a **TurnOnDevice** intent that can be applied to multiple devices, and use entities to define the different devices.

Consider the following utterances, intents, and entities:

| Utterance | Intent | Entities |
| --- | --- | --- |
| What is the time? | GetTime | |
| What time is it in *London*? | GetTime | Location (London) |
| What's the weather forecast for *Paris*? | GetWeather | Location (Paris) |
| Will I need an umbrella *tonight*? | GetWeather | Time (tonight) |
| What's the forecast for *Seattle tomorrow*? | GetWeather | Location (Seattle), Time (tomorrow) |
| Turn the *light* on. | TurnOnDevice | Device (light) |
| Switch on the *fan*. | TurnOnDevice | Device (fan) |

You can split entities into a few different component types:

- **Learned** entities are the most flexible kind of entity, and should be used in most cases. You define a learned component with a suitable name, and then associate words or phrases with it in training utterances. When you train your model, it learns to match the appropriate elements in the utterances with the entity.
- **List** entities are useful when you need an entity with a specific set of possible values - for example, days of the week. You can include synonyms in a list entity definition, so you could define a **DayOfWeek** entity that includes the values "Sunday", "Monday", "Tuesday", and so on; each with synonyms like "Sun", "Mon", "Tue", and so on.
- **Prebuilt** entities are useful for common types such as numbers, datetimes, and names. For example, when prebuilt components are added, you will automatically detect values such as "6" or organizations such as "Microsoft". You can see this article for a list of [supported prebuilt entities](/azure/ai-services/language-service/conversational-language-understanding/prebuilt-component-reference?azure-portal=true).
