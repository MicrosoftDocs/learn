In addition to SDKs and the REST API, Form Recognizer services can be accessed through a user interface called the Form OCR Test Tool (FOTT). FOTT can be used to analyze form layouts, extract data from prebuilt models, and train custom models. 

> [!NOTE]
> FOTT is in preview, as of the time this content was authored, and as a result, features and usage details may change. You should refer to the [official page](https://docs.microsoft.com/azure/cognitive-services/form-recognizer?azure-portal=true) for the service, for up-to-date information.

FOTT currently supports three types of projects: 
- Use prebuilt model to get data 
- Use Layout to get text, tables, and selection marks 
- Use Custom to train a model with labels and get key value pairs 

![Form OCR Test Tool home screen.](../media/optical-character-recognition-test-tool.jpg)

FOTT can be used in the [browser](https://fott.azurewebsites.net/) or deployed in a container. The following overview applies to FOTT in the browser. You can find instructions to use the Docker engine to run FOTT [here](https://docs.microsoft.com/en-us/azure/cognitive-services/form-recognizer/quickstarts/label-tool?tabs=v2-1#set-up-the-sample-labeling-tool). 

## Use Layout   

FOTT's Layout service enables you to upload a file, analyze it, and download the extracted data in a JSON file and table file. To use the service:  

1. Create a form recognizer or cognitive service resource
2. Go to [FOTT in the browser](https://fott-preview.azurewebsites.net/). Select "Use Layout to get text, tables and selection marks" 
3. Upload your document. You will need your form recognizer or cognitive service endpoint and key to analyze the document. You can download the results in a JSON file and table file. 
    
## Use prebuilt models  

To extract data from common forms with FOTT's prebuilt models:

1. Create a form recognizer or cognitive service resource
2. Go to [FOTT in the browser](https://fott-preview.azurewebsites.net/). Select "Use prebuilt model to get data". 
3. Upload your document. You will need your form recognizer or cognitive service endpoint and key to analyze the document. You can download the results in a JSON file and table file. 

![OCR Test Tool Prebuilt Model Results.](../media/optical-character-recognition-test-prebuilt-model-results.jpg)
    
## Use custom to train a model 

You can use FOTT's custom service for the entire process of training and testing custom models.

When you use FOTT to build custom models, the **ocr.json** files, **labels.json** files, and **fields.json** file needed for supervised training are automatically created and stored in your storage account. 

>[!NOTE]
>In other documentation, you may see the term _Sample Labeling Tool_. This refers to the component of FOTT that covers custom models. 

To train a custom model and use it to extract data with  FOTT:

1. Create a form recognizer or cognitive service resource
2. Collect at least 5-6 sample forms for training and upload them to your [storage account container](https://docs.microsoft.com/azure/storage/blobs/storage-quickstart-blobs-portal#create-a-container). 
3. Generate a shared access security (SAS) URL for the container.
4. Configure cross-domain resource sharing (CORS). CORS enables FOTT to store labeled files in your storage container. 
5. Go to [FOTT in the browser](https://fott-preview.azurewebsites.net/). Select "Use Custom to train a model with labels and get key value pairs". 
6. Start a **New Project**. You will need your storage container's SAS URL and form recognizer or cognitive service key.
7. Use FOTT [to apply labels to text](https://docs.microsoft.com/en-us/azure/cognitive-services/form-recognizer/quickstarts/label-tool?tabs=v2-1#apply-labels-to-text). 
8. Train your model. Once the model is trained, you'll receive the following information: 
    - Model ID 
    - Average Accuracy for tags      
9. Test your model by analyzing a new form that was **not** used in training. 