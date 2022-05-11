Azure's Form Recognizer service supports supervised machine learning. You can train custom models and create composite models with form documents _and_ JSON documents. 

![Form documents needed for custom model training](../media/labeled-form-documents.png)

To train a custom model:

1. Store sample forms in an Azure blob container, along with JSON files containing layout and label field information.
    - You can generate an **ocr.json** file for each sample form using the Form Recognizer's **Analyze Layout** function. Additionally, you need a single **fields.json** file describing the fields you want to extract, and a **labels.json** file for each sample form mapping the fields to their location in that form.  
2. Generate a shared access security (SAS) URL for the container. 
3. Use the **Train Custom Model** REST API function (or equivalent SDK method). 
4. Use the **Get Custom Model** REST API function (or equivalent SDK method) to get the trained **model ID**.

**OR**

5. Use the Form Recognizer Studio to label and train.
    ![Supervised learning workflow diagram.](../media/supervised-learning-workflow.png)
