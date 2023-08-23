In addition to SDKs and the REST API, Azure Document Intelligence services can be accessed through a user interface called the Azure Document Intelligence Studio (preview), an online tool for visually exploring, understanding, and integrating features from the Azure Document Intelligence service. The Studio can be used to analyze form layouts, extract data from prebuilt models, and train custom models. 

> [!div class="mx-imgBorder"]
> ![Gif of Azure Document Intelligence Studio capabilities.](../media/form-recognizer-demo-v3p2.gif)

The Azure Document Intelligence Studio currently supports the following projects: 
- **Document analysis models**
    - Read: Extract printed and handwritten text lines, words, locations, and detected languages from documents and images.
    - Layout: Extract text, tables, selection marks, and structure information from documents (PDF and TIFF) and images (JPG, PNG, and BMP).
    - General Documents: Extract key-value pairs, selection marks, and entities from documents.
- **Prebuilt models**
- **Custom models**

### Build Document analysis model projects
To extract text, tables, structure, key-value pairs, and named entities with document analysis models:

- Create a Azure Document Intelligence or Azure AI Services resource
- Select either "Read", "Layout", or "General Documents" under the Document analysis models category 
- Analyze your document. You will need your Azure Document Intelligence or Azure AI service endpoint and key.

### Build prebuilt model projects
To extract data from common forms with prebuilt models:

- Create a Azure Document Intelligence or Azure AI Services resource
- Select one of the "prebuilt models" including W-2s, Invoices, Receipts, ID documents, Health insurance, vaccination, and business cards.
- Analyze your document. You will need your Azure Document Intelligence or Azure AI service endpoint and key.

### Build custom model projects
You can use Azure Document Intelligence Studio's custom service for the entire process of training and testing custom models.

When you use Azure Document Intelligence Studio to build custom models, the **ocr.json** files, **labels.json** files, and **fields.json** file needed for training are automatically created and stored in your storage account.

To train a custom model and use it to extract data with custom models:

- Create a Azure Document Intelligence or Azure AI Services resource
- Collect at least 5-6 sample forms for training and upload them to your storage account container.
- Configure cross-domain resource sharing (CORS). CORS enables Azure Document Intelligence Studio to store labeled files in your storage container.
- Create a custom model project in Azure Document Intelligence Studio. You will need to provide configurations linking your storage container and Azure Document Intelligence or Azure AI Service resource to the project.
- Use Azure Document Intelligence Studio to apply labels to text.
- Train your model. Once the model is trained, you'll receive a Model ID and Average Accuracy for tags.
- Test your model by analyzing a new form that was not used in training.

