LUIS is intended to focus on intention and extraction, this includes being able to identify:

- What the user wants  
- What they are talking about.

To be able to understand this, it's very important to understand what utterances, intents and entities are and how the LUIS API provides conversational intelligence to chat bots to enable them to interact with a user.

## Utterances

Utterances refer to the input from the user that your app needs to interpret. These are used to train LUIS to extract intents and entities from them. It is important to capture a variety of different example utterances. It is most essential to use utterances that you think users will enter. We include utterances, which mean the same thing but are constructed with different utterance lengths, word placements, grammar etc.

Some example utterances that could go into your Azure Health Bot would be:

- Which is the closest place to get a Paracetamol?

- Where do I get a Paracetamol?

- I want to get a Paracetamol. How do I go about it?

- When can I get a Paracetamol?

It is extremely essential to give the right utterances to train your chatbot. Some good practices can be found [here](/azure/cognitive-services/luis/luis-concept-utterance).  

## Intents  

In simple words, an intent represents a task or an action that the user wants to perform. Its purpose or goal should be expressed in a user's utterance. When you input intents into your LUIS conversation app, define a set of intents that corresponds to actions that users would want to take in your application.  

Some example intents in your Azure Health Bot could be:

|App intents   |Example utterances   |
|---------|---------|
|BookAppointment      | <ul><li>"Book me an appointment with the general physician at 11 am today".</li><li> "Help me visit the general physician at 11am today".</li><li>"I need an appointment with the general physician at 11am today".</li></ul>  |
|Greeting      | <ul> <li>"Hi".</li> <li> "Hello".</li> <li>"Good morning".</li> </ul> |
|CheckAvailability      |<ul><li>"Are there any general physicians available?".</li><li> "Help me visit the general physician at 11am today".</li></ul>|
|None      |<ul><li>"Get me a cookie recipe".</li><li> "Did the Lakers win?".</li></ul>|

All applications come with the predefined intent, "None", which is the fallback intent and is typically used to provide a generic response to users when their requests don't match any other intent. You should consider always using the None intent to help handle utterances that do not map any of the utterances you have entered.  

In addition to intents that you define, you can use prebuilt intents from one of the prebuilt domains. You can check them out [here](/azure/cognitive-services/luis/howto-add-prebuilt-models).

## Entities

Entities are data you want to pull from the utterances, such as names, dates, product names, or any significant group of words.

> [!NOTE]
> An utterance can include many entities or none at all. While intents are required, entities are optional.

|Utterance|Intent predicted|Entities extracted|Explanation|
|---------|---------|---------|---------|
|Help     |  help   |-        |Nothing to extract|
|Book appointment   | bookAppointment | appointment | Nothing to extract.The model does not have a required feature to extract something in this context, and there is no recipient stated.|  
|Book an appointment with Dr.A|  bookAppointment| Dr. A, appointment|  The model extracts Dr.A by adding a required feature of prebuilt entity personName. A machine-learning entity has been used to extract appointment.|
|Book an appointment with Dr.A at 11am.|  bookAppointment | Dr. A, appointment, 11am| The two important pieces of data, Dr A and the appointment have been extracted by machine-learning entities.|

### Intents compared to entities

|Intent  |Entity  |Example Utterance  |
|---------|---------|---------|
|BookAppointment     | {"type": "appointment", "time": "11:00am", "doctor": "A", "day": "tomorrow"} |   Can you book an appointment with Dr.A at 11am tomorrow?      |
|BookAppointment     | {"type": "appointment", "time": "12:00pm", "doctor": "B", "day": "weekend"}| Help me meet with Dr. B at 12pm this weekend        |

## Using LUIS in a chat bot

After defining the entities and intents with sample utterances in your LUIS app, you can train a language model to predict intents and entities from user input - even if it doesn't match the sample utterances exactly. You can then train the model and publish it to the LUIS natural language processing endpoint API so that a client application can use it to retrieve predictions and respond appropriately whenever a request is made by the user. Learn more about the [LUIS API](https://go.microsoft.com/fwlink/?linkid=2092356).

A common client application for LUIS is a health bot. The LUIS app provides intelligence so the client application can make smart choices. LUIS does not provide those choices.  

The following example shows the typical working of the LUIS API when the user enters an utterance.

|Step  |Action  |
|---------|---------|
|1     |  The client application sends the utterance that the user typed in, *"I want to see Dr A tomorrow"* to the LUIS endpoint as a HTTP request.       |
|2     |  Machine learned language models take the user's unstructured input text and return a JSON-formatted response, with a top intent (For example: BookAppointment). The minimum JSON endpoint response to the client application contains the query utterance as well as the top scoring intent.         |
|3     | The client application uses the JSON response to make decisions about how to fulfil the user's requests. These decisions can include decision trees in the bot framework code and calls to other services.        |
