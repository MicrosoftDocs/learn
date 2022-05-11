To start a project with Form Recognizer services, you need to prepare the following: 

- An Azure resource subscription
- A selection of form files for data extraction

## Subscribe to a resource 
You can access Form Recognizer services via:
- A **Cognitive Service Resource**: a multi-service subscription key (used across multiple Cognitive Services) 

**OR** 
- A **Form Recognizer Resource**: a single-service subscription key (used only with a specific Cognitive Service) 
 
>[!NOTE]
>Create a Cognitive Services resource if you plan to access multiple cognitive services under a single endpoint/key. For Form Recognizer access only, create a Form Recognizer resource. Please note that you'll need a single-service resource if you intend to use Azure Active Directory authentication.

You can subscribe to a service in the Azure portal or with the Azure Command Line Interface (CLI). You can learn more about the CLI commands [here](/cli/azure/cognitiveservices/account?view=azure-cli-latest#commands). 

## Understand Form Recognizer file input requirements  
Form Recognizer works on input documents that meet these requirements:

- Format must be JPG, PNG, PDF (text or scanned), or TIFF. 
- The file size must be less than 500 MB for paid (S0) tier and 4 MB for free (F0) tier.
- Image dimensions must be between 50 x 50 pixels and 10000 x 10000 pixels.
- The total size of the training data set must be 500 pages or less.

More input requirements can be found in the [documentation](/azure/cognitive-services/form-recognizer/overview) for specific models. 

## Decide what component of Form Recognizer to use 

After you have collected your files, decide what you need to accomplish. 

- To use OCR capabilities to capture the layout of a form, use the [Layout service](/azure/cognitive-services/form-recognizer/concept-layout). The Layout API will accurately extract the structured output from documents.

- To create an application that extracts data from receipts, business cards, or invoices use a prebuilt model. These models do not need to be trained. Form Recognizer services analyze the documents and return a JSON output. 

- To create an application to extract data from your industry-specific forms, create a custom model. This model needs to be trained on sample documents. After training, the custom model can analyze new documents and return a JSON output. 


   