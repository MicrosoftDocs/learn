In some cases, a model might contain multiple intents for which utterances are likely to be similar. You can use *patterns* to disambiguate the intents while minimizing the number of sample utterances.

For example, consider the following utterances:

- "Turn the kitchen light on."
- "Is the kitchen light on?"
- "Turn the kitchen light off."

These utterances are syntactically similar, with only a few differences in words or punctuation. However, they represent three different intents (which could be named **TurnOnDevice**, **GetDeviceStatus**, and **TurnOffDevice**). Additionally, the intents could apply to a wide range of entity values. In addition to "kitchen light", the intent could apply to "living room light", "bedside lamp", "fan", television", or any other device that the model might need to support.

You could associate utterances for every possible entity with all three intents. However, a more efficient way to train the model is to define patterns that include utterance templates, like this:

- **TurnOnDevice**:
    - "Turn the {DeviceName} on."
    - "Switch the {DeviceName} on."
    - "Turn on the {DeviceName}."
- **GetDeviceStatus**:
    - "Is the {DeviceName} on[?]"
- **TurnOffDevice**:
    - "Turn the {DeviceName} off."
    - "Switch the {DeviceName} off."
    - "Turn off the {DeviceName}."

These utterances include a placeholder for a **Pattern.any()** entity named **DeviceName**. reducing the number of utterances required to train the model. Patterns can make use of optional elements, such as punctuation to provide additional cues that help identify the appropriate intent.

The patterns defined in the utterance templates, including the position of the **Pattern.any()** entity and any optional words or punctuation, help the model identify the intents and entity values from fewer samples:

| Utterance | Intent | Entity |
| --- | --- | --- |
| Turn the *kitchen light* on. | TurnOnDevice | DeviceName (kitchen light) |
| Is the *bedroom lamp* on? | GetDeviceStatus | DeviceName (bedroom lamp) |
| Switch the *TV* off. | TurnOffDevice | DeviceName (TV) |

## More information

For more information about patterns, see the [Language Understanding documentation](/azure/cognitive-services/luis/luis-concept-patterns).
