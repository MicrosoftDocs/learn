*Object detection* is a form of computer vision in which a model is trained to detect the presence and location of one or more classes of object in an image. For example, an AI-enabled checkout system in a grocery store might need to identify the type and location of items being purchased by a customer.

![An image with the location and type of fruits detected](../media/object-detection.png)

There are two components to an object detection prediction:

- The class label of each object detected in the image. For example, you might ascertain that an image contains one apple and two oranges.
- The location of each object within the image, indicated as coordinates of a *bounding box* that encloses the object.

## Use the Custom Vision service for object detection

You can use the **Custom Vision** cognitive service to train an object detection model. To use the Custom Vision service, you must provision two kinds of Azure resource:

- A *training* resource (used to train your models). This can be:
    - A **Cognitive Services** resource.
    - A **Custom Vision (Training)** resource.
- A *prediction* resource, used by client applications to get predictions from your model. This can be:
    - A **Cognitive Services** resource.
    - A **Custom Vision (Prediction)** resource.

You can use a single **Cognitive Services** resource for both training and prediction, and you can mix-and-match resource types (for example, using a **Custom Vision (Training)** resource to train a model that you then publish using a **Cognitive Services** resource).
