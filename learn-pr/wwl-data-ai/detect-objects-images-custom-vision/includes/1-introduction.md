*Object detection* is a form of machine learning based computer vision in which a model is trained to recognize individual types of object in an image, and to identify their location in the image.

For example, consider the following image:

![Various pieces of fruit](../media/produce.png)

An object detection model might be used to identify the individual objects in this image and return the following information:

![A banana, and orange, and an apple, each indicated by a bounding box and a probability score](../media/produce-objects.png)

Notice that an object detection model returns the following information:

- The *class* of each object identified in the image.
- The probability score of the object classification (which you can interpret as the *confidence* of the predicted class being correct)
- The coordinates of a *bounding box* for each object.

> [!NOTE]
> **Object detection vs. image classification**
>
> *Image classification* is a machine learning based form of computer vision in which a model is trained to categorize images based on the primary subject matter they contain. *Object detection* goes further than this to classify individual objects within the image, and to return the coordinates of a bounding box that indicates the object's location.

## Uses of object detection

Some sample applications of object detection include:

- Evaluating the safety of a building by looking for fire extinguishers or other emergency equipment.
- Creating software for self-driving cars or vehicles with *lane assist* capabilities.
- Medical imaging such as an MRI or x-rays that can detect known objects for medical diagnosis.
