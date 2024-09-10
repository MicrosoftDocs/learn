Microsoft Azure provides multiple Azure AI services that you can use to detect and analyze faces, including:

- **Azure AI Vision**, which offers face detection and some basic face analysis, such as returning the bounding box coordinates around an image.
- **Azure AI Video Indexer**, which you can use to detect and identify faces in a video.
- **Azure AI Face**, which offers pre-built algorithms that can detect, recognize, and analyze faces.

Of these, Face offers the widest range of facial analysis capabilities. 

## Face service

The Azure Face service can return the rectangle coordinates for any human faces that are found in an image, as well as a series of attributes related to those face such as:

- **Accessories**: indicates whether the given face has accessories. This attribute returns possible accessories including headwear, glasses, and mask, with confidence score between zero and one for each accessory.
- **Blur**: how blurred the face is, which can be an indication of how likely the face is to be the main focus of the image.
- **Exposure**: such as whether the image is underexposed or over exposed. This applies to the face in the image and not the overall image exposure.
- **Glasses**: whether or not the person is wearing glasses.
- **Head pose**: the face's orientation in a 3D space.
- **Mask**: indicates whether the face is wearing a mask.
- **Noise**: refers to visual noise in the image. If you have taken a photo with a high ISO setting for darker settings, you would notice this noise in the image. The image looks grainy or full of tiny dots that make the image less clear.
- **Occlusion**: determines if there might be objects blocking the face in the image.

## Responsible AI use 

>[!IMPORTANT]
>To support Microsoft's [Responsible AI Standard](https://blogs.microsoft.com/on-the-issues/2022/06/21/microsofts-framework-for-building-ai-systems-responsibly/), Azure AI Face and Azure AI Vision have a [Limited Access policy](https://aka.ms/AAh91ff).

Anyone can use the Face service to:
* Detect the location of faces in an image.
* Determine if a person is wearing glasses.
* Determine if there's occlusion, blur, noise, or over/under exposure for any of the faces.
* Return the head pose coordinates for each face in an image.

The Limited Access policy requires customers to [submit an intake form](https://aka.ms/facerecognition) to access additional Azure AI Face service capabilities including:
* The ability to compare faces for similarity.
* The ability to identify named individuals in an image. 

## Azure resources for Face

To use the Face service, you must create one of the following types of resource in your Azure subscription:

- **Face**: Use this specific resource type if you don't intend to use any other Azure AI services, or if you want to track utilization and costs for Face separately.
- **Azure AI services**: A general resource that includes Azure AI Face along with many other Azure AI services such as Azure AI Content Safety, Azure AI Language, and others. Use this resource type if you plan to use multiple Azure AI services and want to simplify administration and development.

## Tips for more accurate results

There are some considerations that can help improve the accuracy of the detection in the images:

- Image format - supported images are JPEG, PNG, GIF, and BMP.
- File size - 6 MB or smaller.
- Face size range - from 36 x 36 pixels up to 4096 x 4096 pixels. Smaller or larger faces will not be detected.
- Other issues - face detection can be impaired by extreme face angles, extreme lighting, and occlusion (objects blocking the face such as a hand).
