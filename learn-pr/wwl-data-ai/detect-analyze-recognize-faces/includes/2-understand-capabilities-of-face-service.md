The **Face** service provides comprehensive facial detection, analysis, and recognition capabilities.

![Diagram of Face service capabilities.](../media/face-service.png)

The Face service provides functionality that you can use for:

1. *Face detection* - for each detected face, the results include an ID that identifies the face and the bounding box coordinates indicating its location in the image.
2. *Face attribute analysis* - you can return a wide range of facial attributes, including:
    - Head pose (*pitch*, *roll*, and *yaw* orientation in 3D space)
    - Glasses (*No glasses*, *Reading glasses*, *Sunglasses*, or *Swimming Goggles*)
    - Mask (the presence of a face mask)
    - Blur (*low*, *medium*, or *high*)
    - Exposure (*under exposure*, *good exposure*, or *over exposure*)
    - Noise (visual noise in the image)
    - Occlusion (objects obscuring the face)
    - Accessories (glasses, headwear, mask)
    - QualityForRecognition (*low*, *medium*, or *high*)
3. *Facial landmark location* - coordinates for key landmarks in relation to facial features (for example, eye corners, pupils, tip of nose, and so on)
4. *Face comparison* - you can compare faces across multiple images for similarity (to find individuals with similar facial features) and verification (to determine that a face in one image is the same person as a face in another image)
5. *Facial recognition* - you can train a model with a collection of faces belonging to specific individuals, and use the model to identify those people in new images.
6. *Facial liveness* - liveness can be used to determine if the input video is a real stream or a fake to prevent bad intentioned individuals from spoofing a facial recognition system.

## Face detection and recognition models

The Azure AI Vision Face API is built on face detection and recognition models that have been pre-trained. Multiple versions of these models are available, each with specific strengths and capabilities. For example, newer models exhibit greater accuracy when working with small images; but may not provide the same breadth of facial analysis capabilities. When you use the service in an application, you must select the model you want to use based on your requirements.

> [!TIP]
> For guidance about selecting a *detection* model, see **[Specify a face detection model](/azure/ai-services/computer-vision/how-to/specify-detection-model)**. For guiidance about how to select a *recognition* model, see **[Specify a face recognition model](/azure/ai-services/computer-vision/how-to/specify-recognition-model)**.
