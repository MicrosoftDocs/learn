**Azure AI Language**'s conversational language understanding feature enables you to author a language model and use it for predictions. Authoring a model involves defining entities, intents, and utterances. Generating predictions involves publishing a model so that client applications can take user input and return responses. 

## Azure resources for conversational language understanding

To use conversational language capabilities in Azure, you need a resource in your Azure subscription. You can use the following types of resource:

- **Azure AI Language**: A resource that enables you to build apps with industry-leading natural language understanding capabilities without machine learning expertise. You can use a language resource for *authoring* and *prediction*. 
- **Azure AI services**: A general resource that includes conversational language understanding along with many other Azure AI services. You can only use this type of resource for *prediction*.

The separation of resources is useful when you want to track resource utilization for Azure AI Language use separately from client applications using all Azure AI services applications.

## Authoring

After you've created an authoring resource, you can use it to train a conversational language understanding model. To train a model, start by defining the entities and intents that your application will predict as well as utterances for each intent that can be used to train the predictive model.

Conversational language understanding provides a comprehensive collection of prebuilt *domains* that include pre-defined intents and entities for common scenarios; which you can use as a starting point for your model. You can also create your own entities and intents.

When you create entities and intents, you can do so in any order. You can create an intent, and select words in the sample utterances you define for it to create entities for them; or you can create the entities ahead of time and then map them to words in utterances as you're creating the intents.

You can write code to define the elements of your model, but in most cases it's easiest to author your model using the [Language studio](https://language.cognitive.azure.com/) - a web-based interface for creating and managing Conversational Language Understanding applications.

### Training the model

After you have defined the intents and entities in your model, and included a suitable set of sample utterances; the next step is to train the model. Training is the process of using your sample utterances to teach your model to match natural language expressions that a user might say to probable intents and entities.

After training the model, you can test it by submitting text and reviewing the predicted intents. Training and testing is an iterative process. After you train your model, you test it with sample utterances to see if the intents and entities are recognized correctly. If they're not, make updates, retrain, and test again.

## Predicting

When you are satisfied with the results from the training and testing, you can publish your Conversational Language Understanding application to a prediction resource for consumption.

Client applications can use the model by connecting to the endpoint for the prediction resource, specifying the appropriate authentication key; and submit user input to get predicted intents and entities. The predictions are returned to the client application, which can then take appropriate action based on the predicted intent.