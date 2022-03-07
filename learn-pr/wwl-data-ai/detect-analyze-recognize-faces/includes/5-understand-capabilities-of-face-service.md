The **Face** service provides comprehensive facial detection, analysis, and recognition capabilities.

![The Face service provides a wide range of facial analysis capabilities](../media/face-service.png)

The Face service provides functionality that you can use for:

- *Face detection* - for each detected face, the results include an ID that identifies the face and the bounding box coordinates indicating its location in the image.
- *Face attribute analysis* - you can return a wide range of facial attributes, including:
    - Age (estimated age of the person in years)
    - Gender (*Male*, *Female*, or *Genderless*)
    - Emotions (normalized confidence scores for *happiness*, *sadness*, *neutral*, *anger*, *contempt*, *disgust*, *surprise*, and *fear*)
    - Smile (numeric value from 0 (no smile) to 1 (full smile))
    - Head pose (*pitch*, *roll*, and *yaw* orientation in 3D space)
    - Hair (visibility, baldness, hair color)
    - Facial hair (presence and length)
    - Glasses (*NoGlasses*, *ReadingGlasses*, *Sunglasses*, or *Swimming Goggles*)
    - Makeup (Boolean values for *eyeMakeup* and *lipMakeup*)
    - Blur (*low*, *medium*, or *high*)
    - Exposure (*underExposure*, *goodExposure*, or *overExposure*)
    - Noise (visual noise in the image)
    - Occlusion (objects obscuring the face)
- *Facial landmark location* - coordinates for key landmarks in relation to facial features (for example, eye corners, pupils, tip of nose, and so on)
- *Face comparison* - you can compare faces across multiple images for similarity (to find individuals with similar facial features) and verification (to determine that a face in one image is the same person as a face in another image)
- *Facial recognition* - you can train a model with a collection of faces belonging to specific individuals, and use the model to identify those people in new images.

You can provision **Face** as a single-service resource, or you can use the Face API in a multi-service **Cognitive Services** resource.
