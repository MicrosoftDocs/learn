LUIS is intended to focus on intention and extraction, which includes being able to identify:

- What the user wants.
- What they're talking about.

It's important to understand what utterances, intents, and entities are and how the LUIS API provides conversational intelligence to chat bots to enable them to interact with a user.

## Utterances

Utterances refer to the input from the user that your app needs to interpret. Utterances are used to train LUIS to extract intents and entities from them. It's important to capture different example utterances. Use utterances that you think users will enter. Make sure to include utterances that mean the same thing but are constructed with different utterance lengths, word placements, and grammar.

Some example utterances for your Azure Health Bot instance might be:

- Which is the closest place to get a Paracetamol?
- Where do I get a Paracetamol?
- I want to get a Paracetamol. How do I go about it?
- When can I get a Paracetamol?

It's essential to give the right utterances to train your chat bot. Some good practices can be found at [this website](/azure/cognitive-services/luis/luis-concept-utterance).

## Intents

In simple words, an intent represents a task or an action that the user wants to perform. Its purpose or goal should be expressed in a user's utterance. When you input intents into your LUIS conversation app, define a set of intents that corresponds to actions that users would want to take in your application.

The following table shows some example intents.

|App intents   |Example utterances   |
|---------|---------|
|BookAppointment      | <ul><li>"Book me an appointment with the general physician at 11 AM today."</li><li> "Help me visit the general physician at 11 AM today."</li><li>"I need an appointment with the general physician at 11 AM today."</li></ul>  |
|Greeting      | <ul> <li>"Hi."</li> <li> "Hello."</li> <li>"Good morning."</li> </ul> |
|CheckAvailability      |<ul><li>"Are there any general physicians available?"</li><li> "Help me visit the general physician at 11 AM today."</li></ul>|
|None      |<ul><li>"Get me a cookie recipe."</li><li> "Did the Lakers win?"</li></ul>|

All applications come with the predefined intent None. This fallback intent is typically used to provide a generic response to users when their requests don't match any other intent. Use the None intent to help handle utterances that don't map to any of the utterances you've entered.

In addition to intents that you define, you can use prebuilt intents from one of the prebuilt domains. You can check them out at [this website](/azure/cognitive-services/luis/howto-add-prebuilt-models).

## Entities

Entities are data you want to pull from utterances, such as names, dates, product names, or any significant group of words.

> [!NOTE]
> An utterance can include many entities or none at all. While intents are required, entities are optional.

|Utterance|Intent predicted|Entities extracted|Explanation|
|---------|---------|---------|---------|
|Help.     |  help   |-        |Nothing to extract.|
|Book appointment.   | bookAppointment | appointment | Nothing to extract. The model doesn't have a required feature to extract something in this context, and there's no recipient stated.|  
|Book an appointment with Dr. A.|  bookAppointment| Dr. A, appointment|  The model extracts Dr. A by adding a required feature of prebuilt entity personName. A machine learning entity has been used to extract appointment.|
|Book an appointment with Dr. A at 11 AM.|  bookAppointment | Dr. A, appointment, 11 AM| The two important pieces of data, Dr. A and the appointment, have been extracted by machine learning entities.|

### Intents compared to entities

|Intent  |Entity  |Example utterance  |
|---------|---------|---------|
|BookAppointment     | {"type": "appointment", "time": "11:00 AM", "doctor": "A", "day": "tomorrow"} |   Can you book an appointment with Dr. A at 11 AM tomorrow?      |
|BookAppointment     | {"type": "appointment", "time": "12:00 PM", "doctor": "B", "day": "weekend"}| Help me meet with Dr. B at 12 PM this weekend.        |

## Use LUIS in a chat bot

After you define the entities and intents with sample utterances in your LUIS app, you can train a language model to predict intents and entities from user input, even if it doesn't match the sample utterances exactly. You can then train the model and publish it to the LUIS natural language processing endpoint API. A client application can then use it to retrieve predictions and respond appropriately whenever a request is made by the user. Learn more about the [LUIS API](https://go.microsoft.com/fwlink/?linkid=2092356).

A common client application for LUIS is a health bot. The LUIS app provides intelligence so that the client application can make smart choices. LUIS doesn't provide those choices.

The following example shows the typical working of the LUIS API when the user enters an utterance.

|Step  |Action  |
|---------|---------|
|1     |  The client application sends the utterance that the user entered, *"I want to see Dr. A tomorrow,"* to the LUIS endpoint as an HTTP request.       |
|2     |  Machine learned language models take the user's unstructured input text and return a JSON-formatted response, with a top intent. An example is BookAppointment. The minimum JSON endpoint response to the client application contains the query utterance and the top scoring intent. |
|3     | The client application uses the JSON response to make decisions about how to fulfill the user's requests. These decisions can include decision trees in the bot framework code and calls to other services. |
