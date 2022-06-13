Here you'll explore the features Language Studio offers and then use the demo-like environment to test a pre-configured sentiment model. You'll then see the steps to create, train and deploy a custom model for conversational language understanding.

## Language Studio features

Language Studio groups its features into three areas:

1. Classify text
1. Understand questions and conversational language
1. Extract information

#### Classify text
:::row:::
    :::column:::
        :::image type="icon" source="../media/analyze-sentiment-logo.svg" border="false":::
        **Analyze sentiment**
    :::column-end:::
    :::column:::
        :::image type="icon" source="../media/detect-language-demo-logo.svg" border="false":::
        **Detect language**
    :::column-end:::
    :::column:::
        :::image type="icon" source="../media/custom-text-classification-logo.svg" border="false":::
        **Custom text classification***
    :::column-end:::
:::row-end:::

#### Understand questions and conversational language
:::row:::
    :::column:::
        :::image type="icon" source="../media/summarization-documents-logo.svg" border="false":::
        **Summarize documents**
    :::column-end:::
    :::column:::
        :::image type="icon" source="../media/answer-questions-logo.svg" border="false":::
        **Answer questions**
    :::column-end:::
    :::column:::
        :::image type="icon" source="../media/custom-question-answering-logo.svg" border="false":::
        **Custom question answering***
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
    :::column-end:::
    :::column:::
        :::image type="icon" source="../media/custom-conversation-logo.svg" border="false":::
        **Conversational language understanding***
    :::column-end:::
    :::column:::

    :::column-end:::
:::row-end:::

#### Extract information
:::row:::
    :::column:::
        :::image type="icon" source="../media/extract-pii-logo.svg" border="false":::
        **Extract PII**
    :::column-end:::
    :::column:::
        :::image type="icon" source="../media/extract-key-phrases-logo.svg" border="false":::
        **Extract key phrases**
    :::column-end:::
    :::column:::
        :::image type="icon" source="../media/find-linked-entities-logo.svg" border="false":::
        **Find linked entities**        
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        :::image type="icon" source="../media/extract-named-entities-logo.svg" border="false":::
        **Extract named entries**
    :::column-end:::
    :::column:::
        :::image type="icon" source="../media/extract-health-logo.svg" border="false":::
        **Extract health information**      
    :::column-end:::
    :::column:::
        :::image type="icon" source="../media/custom-entity-extraction-logo.svg" border="false":::
        **Custom entity extraction***
    :::column-end:::

:::row-end:::

Features can be either pre-configured or customizable. Pre-configured features can be tested straight away with a demo-like environment directly inside Language Studio. You can use them straight out of the box.

The other features with **\*** and green cogs in their logo need user customization. They require you to train their models so they fit your data better. After you have train them, you deploy and can then can use them to power your apps or use the same demo-like testing environment.

### Test and use pre-configured language features

1. Go to the [Language Studio](https://aka.ms/languageStudio) and sign in with your Azure account.
1. If you haven't got a language resource, create one.

    :::image type="content" source="../media/select-analyze-sentiment.png" alt-text="A screenshot showing selecting analyze sentiment.":::

1. Scroll down to the classify text section, then select **Analyze sentiment and mine options**.
1. Scroll down, then select **Sample 1**.

    :::image type="content" source="../media/analyze-sentiment-demo-environment.png" alt-text="A screenshot of the demo-like testing environment.":::

    Read the review text, how positive do you think it is?
1. Select **I acknowledge that running this demo will incur usage and may incur costs to my Azure resource**.

1. Select **Run**.
1. Examine the results.

    :::image type="content" source="../media/analyzed-sentiment.png" alt-text="A screenshot showing the results of analyzing the sentiment.":::

You can see how the sentiment model has identified words that help it calculate an overall positive score. In the sample text the model returns an **85% positive** result for the whole document.

You can also drill down into individual sentences for more detail. Language Studio then gives you guidance for how to use the model in your own apps.

For example, you can get the same JSON response from the model by using this curl statement in your development environment:


```bash
 curl -v -X POST "https://westeurope.api.cognitive.microsoft.com/language/:analyze-text?api-version=2022-05-01" -H "Content-Type: application/json" -H "Ocp-Apim-Subscription-Key: c47715a603c24423b66a2ae861cb65de" --data-ascii "{\"kind\":\"SentimentAnalysis\",\"analysisInput\":{\"documents\":[{\"id\":\"documentId\",\"text\":\"We went to Contoso foodplace located at downtown Seattle last week for a dinner party, and we adore the spot! They provide marvelous food and they have a great menu. The chief cook happens to be the owner (I think his name is John Doe) and he is super nice, coming out of the kitchen and greeted us all. We enjoyed very much dining in the place! The pasta I ordered was tender and juicy, and the place was impeccably clean. You can even pre-order from their online menu at www.contosofoodplace.com, call 112-555-0176 or send email to order@contosofoodplace.com! The only complaint I have is the food didn't come fast enough. Overall I highly recommend it!\",\"language\":\"en\"}]},\"parameters\":{\"opinionMining\":true}}" 
```

### Create, train, and deploy a conversation language understanding model

Each of the customizable features in Language Studio need different steps to create the models. In this example you'll see how to create a conversation language understanding model.

Conversational language understanding aims to build a model that predicts intention from conversational text. For example, imagine an email app that you can chat with to send email messages or flag emails. You train the model on sentences like "please add a flag to that email" or "okay, ready to send". These would be translated to intents for `flag email` and `send email`.

Follow these steps in Language Studio.

1. From the home page, select **Conversational Language Understanding**.
1. Select **Create new project**.
1. Enter a name for the new project.
1. Enter a description.
1. Select your language, then select **Next**.
1. Select **Create**.

    :::image type="content" source="../media/conversational-language-project.png" alt-text="A screenshot of the created conversationla language project.":::

Language Studio guides you through the remaining steps. Follow the left navigation from top to bottom to:

1. Create your schema definition. This involves adding all the intents and entities that your app is interested in.
1. Label data. You provide example chats and utterances along with how they map to entities and intents.
1. Train your model. Once you've added the data labeling information you can start training your model. You can either split all your data with 80% for training and 20% for testing. Or you can create your own manual split.
1. Review the performance of your model.
1. Deploy your model. When you are happy with the performance of your model you deploy it. This makes it available to be called as an API from your app and test it.
1. Test your deployment. This option allows you to test your model in the same way as pre-configured models.

    :::image type="content" source="../media/testing-deployments.png" alt-text="A screenshot of testing a conversational language understanding model.":::

Whichever feature your use you end up with a model that you can use in apps to add language understanding.

In the context of Azure Cognitive Search these models can help us enrich our search indexes to create better search experiences. Or provide answers when users ask questions.