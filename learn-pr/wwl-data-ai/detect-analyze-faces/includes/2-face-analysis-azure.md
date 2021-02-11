
Microsoft Azure provides multiple cognitive services that you can use to detect and analyze faces, including:

- **Computer Vision**, which offers face detection and some basic face analysis, such as determining age.
- **Video Indexer**, which you can use to detect and identify faces in a video.
- **Face**, which offers pre-built algorithms that can detect, recognize, and analyze faces.

Of these, Face offers the widest range of facial analysis capabilities, so we'll focus on that service in this module.

## Face 

Face currently supports the following functionality:

- Face Detection
- Face Verification
- Find Similar Faces
- Group faces based on similarities
- Identify people

Face can return the rectangle coordinates for any human faces that are found in an image, as well as a series of attributes related to those faces such as:

- **Age**: a guess at an age
- **Blur**: how blurred the face is (which can be an indication of how likely the face is to be the main focus of the image)
- **Emotion**: what emotion is displayed
- **Exposure**: aspects such as underexposed or over exposed and applies to the face in the image and not the overall image exposure
- **Facial hair**: the estimated facial hair presence
- **Glasses**: if the person is wearing glasses
- **Hair**: the hair type and hair color
- **Head pose**: the face's orientation in a 3D space
- **Makeup**: whether the face in the image has makeup applied
- **Noise**: refers to visual noise in the image.  If you have taken a photo with a high ISO setting for darker settings, you would notice this noise in the image.  The image looks grainy or full of tiny dots that make the image less clear
- **Occlusion**: determines if there may be objects blocking the face in the image
- **Smile**: whether the person in the image is smiling

## Azure resources for Face

To use Face, you must create one of the following types of resource in your Azure subscription:

- **Face**: Use this specific resource type if you don't intend to use any other cognitive services, or if you want to track utilization and costs for Face separately.
- **Cognitive Services**: A general cognitive services resource that includes Computer Vision along with many other cognitive services; such as Computer Vision, Text Analytics, Translator Text, and others. Use this resource type if you plan to use multiple cognitive services and want to simplify administration and development.

Whichever type of resource you choose to create, it will provide two pieces of information that you will need to use it:

- A **key** that is used to authenticate client applications.
- An **endpoint** that provides the HTTP address at which your resource can be accessed.

> [!NOTE]
> If you create a Cognitive Services resource, client applications use the same key and endpoint regardless of the specific service they are using.

## Tips for more accurate results

There are some considerations that can help improve the accuracy of the detection in the images:

- image format - supported images are JPEG, PNG, GIF, and BMP
- file size - 6 MB or smaller
- face size range - from 36 x 36 up to 4096 x 4096.   Smaller or larger faces will not be detected
- other issues - face detection can be impaired by extreme face angles, occlusion (objects blocking the face such as sunglasses or a hand). Best results are obtained when the faces are full-frontal or as near as possible to full-frontal
