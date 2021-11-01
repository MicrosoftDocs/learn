*Utterances* are the phrases that a user might enter when interacting with an application that uses your Language Understanding model. An *intent* represents a task or action the user wants to perform, or more simply the *meaning* of an utterance. You create a model by defining intents and associating them with one or more utterances.

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

In a Language Understanding model, you must define the intents that you want your model to understand, so spend some time thinking about the *domain* your model must support, and the kinds of actions or information that users might request. In addition to the intents that you define, every model includes  **None** intent that you should use to explicitly identify utterances that a user might submit, but for which there is no specific action required (for example, conversational greetings like "hello") or that fall outside of the scope of the domain for this model.

After you've identified the intends your model must support, it's important to capture a variety of different example utterances for each intent.  Collect utterances that you think users will enter; including utterances that mean the same thing, but that are constructed in different ways. Keep these guidelines in mind:

- Capture multiple different examples, or alternative ways of saying the same thing
- Vary the length of the utterances from short, to medium, to long
- Vary the location of the *noun* or *subject* of the utterance.  Place it at the beginning, the end, or somewhere in between
- Use correct grammar and incorrect grammar in different utterances to offer good training data examples
- Follow the [good utterances](/azure/cognitive-services/luis/luis-concept-utterance) guidance  in the Language Understanding documentation.
