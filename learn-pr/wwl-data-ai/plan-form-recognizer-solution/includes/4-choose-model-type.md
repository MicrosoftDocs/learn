Azure AI Document Intelligence uses models to describe the documents and forms to expect. You can either use one of the prebuilt models, if you have a common type of document, or create and train your own models.

In your polling company, you use many different forms for surveys for different clients. They have some fields in common, such as "Respondent Name" and "Contact Telephone" but other fields are unique to each client company or party. You want to choose which models to use in your Document Intelligence solution and plan how to create them.

In this unit, you'll learn about the prebuilt models available in Azure AI Document Intelligence and when to create your own custom and composed models.

## Prebuilt models

Document types such as invoices and receipts vary in different businesses and industry but have similar structures and key-value pairs. For example, a "Total cost" value is likely to appear on almost all invoices although it may be called "Total", "Sum", or some other name. Microsoft has provided a set of prebuilt models with Azure AI Document Intelligence to handle the most common types of documents. You don't have to train these models and you can create solutions using them very quickly.

### General document analysis models

Three of the prebuilt models are designed to handle general documents and extract words, lines, structure and other information such as the language the document is written in:

- **Read.** Use this model to extract words and lines from both printed and hand-written documents. It also detects the language used in the document.

    :::image type="content" source="../media/04-read-model.png" alt-text="Screenshot showing the read model analyzing a document in German in Azure AI Document Intelligence Studio." lightbox="../media/04-read-model.png":::

- **General document.** Use this model to extract key-value pairs and tables in your documents.

    :::image type="content" source="../media/04-general-document-model.png" alt-text="Screenshot showing the general document model analyzing a document in Azure AI Document Intelligence Studio." lightbox="../media/04-general-document-model.png":::
 
- **Layout.** Use this model to extract text, tables, and structure information from forms. It can also recognize selection marks such as check boxes and radio buttons.

    :::image type="content" source="../media/04-layout-model.png" alt-text="Screenshot showing the layout model analyzing a document in Azure AI Document Intelligence Studio." lightbox="../media/04-layout-model.png":::

> [!NOTE]
> The model screenshots above show Azure AI Document Intelligence models extracting data in Azure AI Document Intelligence Studio.

### Specific document type models

The five other prebuilt models are each designed to handle, and trained on, a specific and commonly used type of document. 

- **Invoice.** Use this model to extract key information from sales invoices in English and Spanish.

    :::image type="content" source="../media/04-invoice-model.png" alt-text="Screenshot showing the invoice model analyzing a document in Azure AI Document Intelligence Studio." lightbox="../media/04-invoice-model.png":::

- **Receipt.** Use this model to extract data from printed and handwritten receipts.

    :::image type="content" source="../media/04-receipt-model.png" alt-text="Screenshot showing the receipt model analyzing a document in Azure AI Document Intelligence Studio." lightbox="../media/04-receipt-model.png":::

- **W-2.** Use this model to extract data from United States government's W-2 tax declaration form.

    :::image type="content" source="../media/04-w2-model.png" alt-text="Screenshot showing the W-2 model analyzing a document in Azure AI Document Intelligence Studio." lightbox="../media/04-w2-model.png":::

- **ID document.** Use this model to extract data from United States driver's licenses and international passports. 
- **Business card.** Use this model to extract names and contact details from business cards.

    :::image type="content" source="../media/04-business-card-model.png" alt-text="Screenshot showing the business card model analyzing a document in Azure AI Document Intelligence Studio." lightbox="../media/04-business-card-model.png":::

> [!NOTE]
> At the time of writing, read, general document, and W-2 models are currently in preview.

## Custom models

If the prebuilt models don't suit your purposes, you can create a custom model and train it to analyze the specific type of document users will send to your Azure AI Document Intelligence service. The general document analyzer prebuilt models can extract rich information from these forms and you might be able to use them if your requirements are to obtain general data. However, by using a custom model, trained on forms with similar structures and key-value pairs, you will obtain more predictable and standardized results from your unusual form types.

To train a custom model, you must supply at least five examples of the completed form but the more examples you supply, the greater the confidence levels Azure AI Document Intelligence will return when it analyzes input. The more varied your documents are in terms of structure and terminology, the greater the number of example documents you will need to supply to train a reliable model. You can either supply a labeled dataset to describe the expected data or allow the model to identify key-value pairs and table data based on what it finds in the example forms. Also, make sure your training forms include examples that span the full range of possible input. For example, if you are expecting both hand-written and printed entries, include them both in your training.

Once you have trained a custom model in this way, Azure AI Document Intelligence can accurately and predictably identify information in your unique forms.

:::image type="content" source="../media/04-train-custom-model.png" alt-text="Screenshot showing how to train a custom model on business-specific example forms in Azure AI Document Intelligence Studio." lightbox="../media/04-train-custom-model.png":::

There are two kinds of custom model:

- **Custom template models.** A custom template model is most appropriate when the forms you want to analyze have a consistent visual template. If you remove all the user-entered data from the forms and find that the blank forms are identical, use a custom template model. Custom template models support 9 different languages for handwritten text and a wide range of languages for printed text. If you have a few different variations of the form templates, train a model for each of the variations and then compose the models together into a single model. The service will invoke the model best suited to analyze the document.
- **Custom neural models.** A custom neural model can work across the spectrum of structured to unstructured documents. Documents like contracts with no defined structure or highly structured forms can be analyzed with a neural model. Neural models work on English with the highest accuracy and a marginal drop in accuracy for Latin based languages like German, French, Italian, Spanish, and Dutch. Try using the custom neural model first if your scenario is addressed by the model. 

## Composed models

A composed model is one that consists of multiple custom models. Typical scenarios where composed models help are when you don't know the submitted document type and want to classify and then analyze it. They are also useful if you have multiple variations of a form, each with a trained individual model. When a user submits a form to the composed model, Forms Analyzer automatically classifies it to determine which of the custom models should be used in its analysis. In this approach, a user doesn't have to know what kind of document it is before submission. That can be helpful when you're using lots of similar forms or when you want to publish a single endpoint for all your form types.

> [!IMPORTANT]
> The results from a composed model include the `docType` property, which indicates the custom model that was chosen to analyze each form.

If you're using the Standard pricing tier, you can add up to 100 custom models into a single composed model. If you're using the Free pricing tier, you can only add up to 5 custom models.

## Learn more

- [Azure AI Document Intelligence models](/azure/applied-ai-services/form-recognizer/concept-model-overview)
- [Azure AI Document Intelligence custom models](/azure/applied-ai-services/form-recognizer/concept-custom)
- [Composed custom models](/azure/applied-ai-services/form-recognizer/concept-composed-models)
