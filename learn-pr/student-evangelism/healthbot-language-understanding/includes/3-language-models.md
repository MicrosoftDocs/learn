Language models interpret end user utterances and trigger the relevant scenario logic in response. They are fundamental components for configuring your Health Bot experience. For example, you can use a language model to trigger scheduling logic when an end user types "How do I schedule an appointment?".
  
Language models take textual unstructured utterances from end users and provide a structured response that includes the end user's intention combined with a confidence score that reflects the accuracy of the extracted intent.

Multiple models can be used in parallel. When more than one possible intent is identified, the confidence score for each intent is compared, and the highest score is used to invoke the mapped scenario. Each intent is unique and mapped to a single built-in or custom scenario.

#### Confidence score

A score between 0 -1 reflects the likelihood that a model has correctly matched an intent with the utterance provided. A score of 1 shows a high certainty that the identified intent is accurate.

## Types of language models

There are different types of language models. Some language models are built-in to your bot and come out of the box. By default, the built-in models are used to trigger the built-in scenarios, however built-in models can be repurposed and mapped to your own custom scenarios by changing their configuration. You can also build your own custom models for tailored language understanding.

### 1. Regular Expression (RegEx) Models

RegEx models are great for optimizing performance when you need to understand simple and predictable commands from end users. They extract a single intent from an utterance by matching the utterance to a RegEx pattern. For example, the RegEx pattern /.*help*./I would match the utterance "I need help".

[Learn more about Regular Expressions.](/azure/cognitive-services/luis/reference-entity-regular-expression)  

The confidence score is calculated based on the number of characters in the matched part and the full length of the utterance. The longer the match, the higher the confidence score from the RegEx model.

### 2. LUIS models

LUIS models are great for natural language understanding. They understand broader intentions and improve recognition, but they also require an HTTPS call to an external service. LUIS models return a confidence score based on mathematical models used to extract the intent.

LUIS is deeply integrated into the Azure Health Bot service and supports multiple LUIS features such as:

- **Bing speller:** Provide your Bing Speller subscription key in the endpoint URL to pass all utterances through a spell check before undergoing processing by the LUIS application.
[Learn more about the Bing Speller.](/azure/cognitive-services/bing-spell-check/overview)
- **Staging:** Use the staging version of your LUIS application if you want to prevent testing from impacting the learning of your production LUIS application.  
Learn more about the [Production and Staging slots](/azure/cognitive-services/luis/luis-concept-app-iteration#publishing-slots) for publishing your LUIS application.  
- **Verbose responses:** Typically, the response from your LUIS application includes only the highest scoring intent for the model. To include all intents and their respective scores in the response you should use the verbose setting.
  
When creating a LUIS model, you will need an account with the [LUIS.ai service](https://www.luis.ai/home).

### 3. System models

System models use proprietary recognition methods. They are not open for editing; however, you can override the default intent mapping. For example, you can use the medical complaint recognizer to trigger your own symptom checking scenarios.

The built-in medical models provide language understanding that is tuned for medical concepts and clinical terminology. All medical language models use system recognition methods. Some of them include:

- **Medical complaints**: This model understands when an end user is making a medical complaint. It extracts key information such as the medical concept, the age and gender and additional information required to diagnose a complaint and triggers the built-in triage protocols.
- **Medical Information**: This model understands when a patient is asking for information about a medical concept. For example, the user can ask about symptoms or complications of a given condition. It then triggers a scenario that displays relevant information from our medical database.
- **Drugs and medication**: This model understands when an end user is asking for information about the type or brand of a drug. It invokes a scenario that presents information about the drug in question.

### Which model(s) should you use?

Different models use different language recognition methods. Each method has its own advantages and disadvantages. When planning your implementation, you should use a combination of recognition types best suited to the type of scenarios and capabilities you need.

## Adding a RegEx model to the Azure Health Bot

1. Navigate to the home page of your Azure Health Bot. In the left pane, select 'Models' under 'Language'. Select the '+New' option near the top of the page.

   :::image type="content" source="../media/3-create-model.png" alt-text="Create a new model" lightbox="../media/3-create-model.png":::

1. The 'New Model' pane will open at the right side of the page. Under 'Method' select 'RegEx'. Give a name and description to your RegEx language model.

   Under 'Regular Expression', enter the RegEx pattern for your language model, which in this case will be **/^hello$/**.  

   Under 'Intent Mapping', you need to name your RegEx model with a unique intent that isn't used by another model. Name it as 'hello' for now and map it to the 'builtin/greeting' scenario in the dropdown menu. Click on 'Save' once done.  

   :::image type="content" source="../media/3-details.png" alt-text="Fill in details of the new model":::

1. Once you have successfully created your RegEx language model, test it out on the web chat.

   :::image type="content" source="../media/3-test-model.png" alt-text="Test your model on the web chat" lightbox="../media/3-test-model.png":::

1. Once done, exit the web chat and scroll through the various language models and find the 'Greeting' language model. On the extreme right, you will see an 'Edit' option. Click on it.

   :::image type="content" source="../media/3-greeting-model.png" alt-text="View the greeting language model":::

   The language model that we added earlier was a simpler version of the built-in 'Greeting' language model.  

1. Click on 'Cancel' once you are done viewing the 'Greeting' language model.
