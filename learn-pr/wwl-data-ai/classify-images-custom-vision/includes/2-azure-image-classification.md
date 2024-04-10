You can perform image classification using Azure AI Custom Vision, available as part of the Azure AI Services offerings. This is generally easier and quicker than writing your own model training code, and enables people with little or no machine learning expertise to create an effective image classification solution.

## Azure resources for Azure AI Custom Vision

Creating an image classification solution with Azure AI Custom Vision consists of two main tasks. First you must use existing images to train the model, and then you must publish the model so that client applications can use it to generate predictions.

For each of these tasks, you need a resource in your Azure subscription. You can use the following types of resource:

- **Custom Vision**: A dedicated resource for the custom vision service, which can be *training*, a *prediction*, or *both* resources.
- **Azure AI services**: A general resource that includes Azure AI Custom Vision along with many other Azure AI services. You can use this type of resource for *training*, *prediction*, or both.

The separation of training and prediction resources is useful when you want to track resource utilization for model training separately from client applications using the model to predict image classes. However, it can make development of an image classification solution a little confusing.

The simplest approach is to use a general Azure AI services resource for both training and prediction. This means you only need to concern yourself with one *endpoint* (the HTTP address at which your service is hosted) and *key* (a secret value used by client applications to authenticate themselves).

If you choose to create a Custom Vision resource, you will be prompted to choose *training*, *prediction*, or *both* - and it's important to note that if you choose "both", then ***two*** resources are created - one for training and one for prediction.

It's also possible to take a mix-and-match approach in which you use a dedicated Custom Vision resource for training, but deploy your model to an Azure AI services resource for prediction. For this to work, the training and prediction resources must be created in the same region.

## Model training

To train a classification model, you must upload images to your training resource and label them with the appropriate class labels. Then, you must train the model and evaluate the training results.

You can perform these tasks in the *Custom Vision portal*, or if you have the necessary coding experience you can use one of the Azure AI Custom Vision service programming language-specific software development kits (SDKs).

One of the key considerations when using images for classification, is to ensure that you have sufficient images of the objects in question and those images should be of the object from many different angles.

## Model evaluation

Model training process is an iterative process in which Azure AI Custom Vision service repeatedly trains the model using some of the data, but holds some back to evaluate the model. At the end of the training process, the performance for the trained model is indicated by the following evaluation metrics:

- **Precision**: What percentage of the class predictions made by the model were correct? For example, if the model predicted that 10 images are oranges, of which eight were actually oranges, then the precision is 0.8 (80%).
- **Recall**: What percentage of class predictions did the model correctly identify? For example, if there are 10 images of apples, and the model found 7 of them, then the recall is 0.7 (70%).
- **Average Precision (AP)**: An overall metric that takes into account both precision and recall.

## Using the model for prediction

After you've trained the model, and you're satisfied with its evaluated performance, you can publish the model to your prediction resource. When you publish the model, you can assign it a name (the default is "Iteration*X*", where X is the number of times you have trained the model).

To use your model, client application developers need the following information:

- **Project ID**: The unique ID of the Custom Vision project you created to train the model.
- **Model name**: The name you assigned to the model during publishing.
- **Prediction endpoint**: The HTTP address of the endpoints for the *prediction* resource to which you published the model (***not*** the training resource).
- **Prediction key**: The authentication key for the *prediction* resource to which you published the model (***not*** the training resource).