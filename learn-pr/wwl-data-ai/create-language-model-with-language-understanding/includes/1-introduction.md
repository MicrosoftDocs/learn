In 1950, the British mathematician Alan Turing devised the *Imitation Game*, which has become known as the *Turing Test* and hypothesizes that if a dialog is natural enough, you may not know whether you're conversing with a human or a computer. As artificial intelligence (AI) grows ever more sophisticated, this kind of conversational interaction with applications and digital assistants is becoming more and more common, and in specific scenarios can result in human-like interactions with AI agents. Common scenarios for this kind of solution include customer support applications, reservation systems, and home automation among others. 

To realize the aspiration of the imitation game, computers need not only to be able to accept language as input (either in text or audio format), but also to be able to interpret the semantic meaning of the input - in other words, *understand* what is being said.

Microsoft Azure supports conversational language understanding through **Azure AI Language** service. To work with conversational language understanding, you need to take into account three core concepts: *utterances*, *entities*, and *intents*.

## Utterances

An utterance is an example of something a user might say, and which your application must interpret. For example, when using a home automation system, a user might use the following utterances:

> "*Switch the fan on.*"
>
> "*Turn on the light.*"

## Entities

An entity is an item to which an utterance refers. For example, **fan** and **light** in the following utterances:

> "*Switch the ***fan*** on.*"
>
> "*Turn on the ***light***.*"

You can think of the **fan** and **light** entities as being specific instances of a general **device** entity.

## Intents

An intent represents the purpose, or goal, expressed in a user's utterance. For example, for both of the previously considered utterances, the intent is to turn a device on; so in your conversational language understanding application, you might define a **TurnOn** intent that is related to these utterances.

A conversational language understanding application defines a model consisting of intents and entities. Utterances are used to train the model to identify the most likely intent and the entities to which it should be applied based on a given input. The home assistant application we've been considering might include multiple intents, like the following examples:

| Intent | Related Utterances | Entities
|---|---|---
| Greeting | "Hello" |
| | "Hi" |
| | "Hey" |
| | "Good morning" |
| TurnOn | "Switch the fan on" | fan (device)
| | "Turn the light on" | light (device)
| | "Turn on the light" | light (device)
| TurnOff | "Switch the fan off" | fan (device)
| | "Turn the light off" | light (device)
| | "Turn off the light" | light (device)
| CheckWeather | "What is the weather for today?" | today (datetime)
| | "Give me the weather forecast" |
| | "What is the forecast for Paris?" | Paris (location)
| | "What will the weather be like in Seattle tomorrow?" | Seattle (location), tomorrow (datetime)
| None | "What is the meaning of life?" |
| | "Is this thing on?" |

In this table there are numerous utterances used for each of the intents.  The intent should be a concise way of grouping the utterance tasks. Of special interest is the ***None*** intent. You should consider always using the *None* intent to help handle utterances that do not map any of the utterances you have entered.  The *None* intent is considered a fallback, and is typically used to provide a generic response to users when their requests don't match any other intent.

>[!Tip]
>In a conversational language understanding application, the **None** intent is created but left empty on purpose. The *None* intent is a required intent and can't be deleted or renamed.

After defining the entities and intents with sample utterances in your conversational language understanding application, you can train a language model to predict intents and entities from user input - even if it doesn't match the sample utterances exactly. You can then use the model from a client application to retrieve predictions and respond appropriately.

