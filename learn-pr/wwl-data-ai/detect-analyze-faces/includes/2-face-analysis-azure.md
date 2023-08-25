Microsoft Azure provides multiple Azure AI services that you can use to detect and analyze faces, including:

- **Azure AI Computer Vision**, which offers face detection and some basic face analysis, such as returning the bounding box coordinates around an image.
- **Azure AI Video Indexer**, which you can use to detect and identify faces in a video.
- **Azure AI Face**, which offers pre-built algorithms that can detect, recognize, and analyze faces.

Of these, Azure AI Face offers the widest range of facial analysis capabilities. 

## Azure AI Face 

Azure AI Face can return the rectangle coordinates for any human faces that are found in an image, as well as a series of attributes related to those faces such as:

- **Blur**: how blurred the face is (which can be an indication of how likely the face is to be the main focus of the image)
- **Exposure**: aspects such as underexposed or over exposed and applies to the face in the image and not the overall image exposure
- **Glasses**: if the person is wearing glasses
- **Head pose**: the face's orientation in a 3D space
- **Noise**: refers to visual noise in the image. If you have taken a photo with a high ISO setting for darker settings, you would notice this noise in the image. The image looks grainy or full of tiny dots that make the image less clear
- **Occlusion**: determines if there may be objects blocking the face in the image

## Responsible AI use 

>[!IMPORTANT]
>To support Microsoft's [Responsible AI Standard](https://blogs.microsoft.com/on-the-issues/2022/06/21/microsofts-framework-for-building-ai-systems-responsibly/), a new [Limited Access policy](https://aka.ms/AAh91ff) has been implemented for the Azure AI Face service and Azure AI Computer Vision service.

Anyone can use the Azure AI Face service to:
* Detect the location of faces in an image
* Determine if a face is wearing glasses
* Determine if there's occlusion, blur, noise, or over/under exposure for any of the faces
* Return the head pose coordinates for each face in an image

The Limited Access policy requires customers to [submit an intake form](https://aka.ms/facerecognition) to access additional Azure AI Face service capabilities including:
* The ability to compare faces for similarity  
* The ability to identify named individuals in an image 

## Azure resources for Azure AI Face

To use Azure AI Face, you must create one of the following types of resource in your Azure subscription:

- **Face**: Use this specific resource type if you don't intend to use any other Azure AI services, or if you want to track utilization and costs for Face separately.
- **Azure AI services**: A general resource that includes Azure AI Computer Vision along with many other Azure AI services; such as Azure AI Custom Vision, Azure AI Language, and others. Use this resource type if you plan to use multiple Azure AI services and want to simplify administration and development.

Whichever type of resource you choose to create, it will provide two pieces of information that you will need to use it:

- A **key** that is used to authenticate client applications.
- An **endpoint** that provides the HTTP address at which your resource can be accessed.

> [!NOTE]
> If you create an Azure AI services resource, client applications use the same key and endpoint regardless of the specific service they are using.

## Tips for more accurate results

There are some considerations that can help improve the accuracy of the detection in the images:

- image format - supported images are JPEG, PNG, GIF, and BMP
- file size - 6 MB or smaller
- face size range - from 36 x 36 up to 4096 x 4096.   Smaller or larger faces will not be detected
- other issues - face detection can be impaired by extreme face angles, occlusion (objects blocking the face such as a hand). Best results are obtained when the faces are full-frontal or as near as possible to full-frontal.
