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

## Entity types

You can define entities in a number of ways:

- **Machine learned** entities are the most flexible kind of entity, and should be used in most cases. You define a machine learned entity with a suitable name, and then associate words or phrases with it in training utterances. When you train your model, it learns to match the appropriate elements in the utterances with the entity.
- **List** entities are useful when you need an entity with a specific set of possible values - for example, days of the week. You can include synonyms in a list entity definition, so you could define a **DayOfWeek** entity that includes the values "Sunday", "Monday", "Tuesday", and so on; each with synonyms like "Sun", "Mon", "Tue", and so on.
- **Regular Expression** or **RegEx** entities are useful when an entity can be identified by matching a particular format of string. For example, a date in the format *MM/DD/YYYY*, or a flight number in the format *AB-1234*.
- **Pattern.any()** entities are used with *patterns*, which are discussed in the next topic.