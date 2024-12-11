**Face detection** involves identifying regions of an image that contain a human face, typically by returning *bounding box* coordinates that form a rectangle around the face, like this:

![An image with two faces highlighted in rectangles](../media/face-detection.png)

With **Face analysis**, facial features can be used to train machine learning models to return other information, such as facial features such as nose, eyes, eyebrows, lips, and others.

![facial landmarks image showing data around face characteristics](../media/landmarks-1.png)
 
## Facial recognition

A further application of facial analysis is to train a machine learning model to identify known individuals from their facial features. This is known as *facial recognition*, and uses multiple images of an individual to train the model. This trains the model so that it can detect those individuals in new images on which it wasn't trained.

![A person identified as "Wendell"](../media/facial-recognition.png)

When used responsibly, facial recognition is an important and useful technology that can improve efficiency, security, and customer experiences. Next we'll explore **Azure AI Face** service, which provides pre-trained models to detect, recognize, and analyze faces. 