While the default translation model used by the Azure AI Translator service is effective for general translation, you may need to develop a translation solution for businesses or industries in that have specific vocabularies of terms that require custom translation.

To solve this problem, you can create a custom model that maps your own sets of source and target terms for translation. To create a custom model, use the Custom Azure AI Translator portal to:

1. Create a workspace linked to your Azure AI Translator resource
2. Create a project
3. Upload training data files
4. Train a model

![The Custom Azure AI Translator portal](../media/custom-translator.png)

Your custom model is assigned a unique **category Id**, which you can specify in **translate** calls to your **Translator** resource by using the **category** parameter, causing translation to be performed by your custom model instead of the default model.

> [!NOTE]
> For more information about custom translation, see the [Azure AI Translator service documentation](/azure/cognitive-services/translator/custom-translator/overview).
