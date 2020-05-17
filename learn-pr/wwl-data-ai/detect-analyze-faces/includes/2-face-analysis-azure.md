
Microsoft Azure provides multiple cognitive services that you can use to detect and analyze faces, including:

- The **Custom Vision** service, which offers face detection and some basic face analysis, such as determining gender and age.
- The **Video Indexer** service, which you can use to detect and identify faces in a video.
- The **Face** service, which offers pre-built algorithms that can detect, recognize, and analyze faces.

Of these, the Face service offers the widest range of facial analysis capabilities, so we'll focus on that service in this module.

## The Face service

Azure Face Service currently supports the following functionality:

- Face Detection
- Face Verification
- Find Similar Faces
- Group faces based on similarities
- Identify people

While you can ask the service to return the rectangle coordinates for any human faces that are found in an image, you can also request a series of attributes related to faces such as:

- the head pose - orientation in a 3D space
- the gender of the detected faces
- a guess at an age
- what emotion is displayed
- if there is facial hair or the person is wearing glasses
- whether the face in the image has makeup applied
- whether the person in the image is smiling
- blur - how blurred the face is (which can be an indication of how likely the face is to be the main focus of the image)
- exposure - aspects such as underexposed or over exposed and applies to the face in the image and not the overall image exposure
- noise - refers to visual noise in the image.  If you have taken a photo with a high ISO setting for darker settings, you would notice this noise in the image.  The image looks grainy or full of tiny dots that make the image less clear
- occlusion - determines if there may be objects blocking the face in the image

## Azure resources for the Face service

To use the Face service, you must create one of the following types of resource in your Azure subscription:

- **Face**: A specific resource for the Face service. Use this resource type if you don't intend to use any other cognitive services, or if you want to track utilization and costs for the Face service separately.
- **Cognitive Services**: A general cognitive services resource that includes Computer Vision along with many other cognitive services; such as Computer Vision, Text Analytics, Translator Text, and others. Use this resource type if you plan to use multiple cognitive services and want to simplify administration and development.

Whichever type of resource you choose to create, it will provide two pieces of information that you will need to use it:

- A **key** that is used to authenticate client applications.
- An **endpoint** that provides the HTTP address at which your resource can be accessed.

> [!NOTE]
> If you create a Cognitive Services resource, client applications use the same key and endpoint regardless of the specific service they are using.

## Tips for more accurate results

There are some considerations that can help improve the accuracy of the detection in the images.  

For still images, such as photographs, consider:

- image format - supported images are JPEG, PNG, GIF, and BMP
- file size - 4 MB or smaller
- face size range - from 36 x 36 up to 4096 x 4096.   Smaller or larger faces will not be detected
- other issues - face detection can be impaired by extreme face angles, occlusion (objects blocking the face such as sunglasses or a hand).  Best results are obtained when the faces are full-frontal or as near as possible to full-frontal

Improving detection when using video feeds can be accomplished by considering the following aspects:

- smoothing - if your video camera applies this effect, turn it off.  The potential blur between frames tends to reduce clarity of the image in individual frames.
- shutter speed - faster shutter speeds improves clarity of the images in each frame because the motion is reduced.
- shutter angle - if your camera supports shutter angle, use a lower shutter angle to produce clearer frames, resulting in better clarity for recognition.
