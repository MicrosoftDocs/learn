
Performing image classification with the _Custom Vision_ service, one of many Azure Cognitive Services, is generally simpler than writing your own model training code. The Custom Vision service enables people with little or no machine learning expertise to create an effective image classification solution.   

## Azure resources for Custom Vision

Creating an image classification solution with Custom Vision consists of two main tasks. First you must use existing images to train the model, and then you must publish the model so that client applications can use it to generate predictions.

For each of these tasks, you need a resource in your Azure subscription. You can use the following types of resource to access Custom Vision services:

- **Custom Vision**: A dedicated resource for the Custom Vision service, which can be *training*, a *prediction*, or *both* resources.
- **Cognitive Services**: A general Cognitive Services resource that includes Custom Vision service capabilities along with other Cognitive Services capabilities. You can use this type of resource for *training*, *prediction*, or both.

The separation of training and prediction resources is useful if you want to track resource utilization for model training separately from client applications using the model to predict image classes. 

## When to use a Cognitive Services resource 

The simplest approach is to use a general Cognitive Services resource for both training and prediction. This means you only need to concern yourself with one *endpoint* (the HTTP address at which your service is hosted) and *key* (a secret value used by client applications to authenticate themselves). 

## When to use a Custom Vision resource 

When you use a Custom Vision resource, you can track usage specifically connected to the Custom Vision service. However, you won't be able to use its *endpoint* and *key* interchangeably with applications leveraging other Cognitive Services.

## Model training

To train a classification model, you must upload images to your training resource and label them with the appropriate class labels. Then, you must train the model and evaluate the training results.

You can perform these tasks in the [*Custom Vision portal*](https://www.customvision.ai), or if you have the necessary coding experience you can use one of the Custom Vision service programming language-specific [software development kits (SDKs)](/azure/cognitive-services/Custom-Vision-Service/quickstarts/image-classification).

One of the key considerations when using images for classification, is to ensure that you have sufficient images of the objects in question and those images should be of the object from many different angles.

## Model evaluation

Model training process is an iterative process in which the Custom Vision service repeatedly trains the model using some of the data, but holds some back to evaluate the model. At the end of the training process, the performance for the trained model is indicated by the following evaluation metrics:

- **Precision**: What percentage of the class predictions made by the model were correct? For example, if the model predicted that 10 images are oranges, of which eight were actually oranges, then the precision is 0.8 (80%).
- **Recall**: What percentage of class predictions did the model correctly identify? For example, if there are 10 images of apples, and the model found 7 of them, then the recall is 0.7 (70%).
- **Average Precision (AP)**: An overall metric that takes into account both precision and recall).

One way to improve the performance of your model is to add more images to the training set.

## Using the model for prediction

After you've trained the model, and you're satisfied with its evaluated performance, you can publish the model to your prediction resource. When you publish the model, you can assign it a name (the default is "Iteration*X*", where X is the number of times you have trained the model).

To use your model, client application developers need the following information:

- **Project ID**: The unique ID of the Custom Vision project you created to train the model.
- **Model name**: The name you assigned to the model during publishing.
- **Prediction endpoint**: The HTTP address of the endpoints for the *prediction* resource to which you published the model (***not*** the training resource).
- **Prediction key**: The authentication key for the *prediction* resource to which you published the model (***not*** the training resource).