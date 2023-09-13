The ability to extract text from images is handled by Azure AI Computer Vision service, which also provides image analysis capabilities.

## Azure resources for Azure AI Computer Vision

The first step towards using Azure AI Computer Vision is to create a resource for it in your Azure subscription. You can use either of the following resource types:

- **Computer Vision**: A specific resource for Azure AI Computer Vision. Use this resource type if you don't intend to use any other AI services, or if you want to track utilization and costs for your Computer Vision resource separately.
- **Azure AI services**: A general resource that includes Azure AI Computer Vision along with many other Azure AI services; such as Azure AI Language, Azure AI Custom Vision, and others. Use this resource type if you plan to use multiple Azure AI services and want to simplify administration and development.

Whichever type of resource you choose to create, it will provide two pieces of information that you will need to use it:

- A **key** that is used to authenticate client applications.
- An **endpoint** that provides the HTTP address at which your resource can be accessed.

> [!NOTE]
> If you create an Azure AI services resource, client applications use the same key and endpoint regardless of the specific service they are using.

## Use Azure AI Computer Vision to read text

Many times an image contains text. It can be typewritten text or handwritten. Some common examples are images with road signs, scanned documents that are in an image format such as JPEG or PNG file formats, or even just a picture taken of a white board that was used during a meeting.

Azure AI Computer Vision provides one application programming interface (APIs) that you can use to read text in images: the **Read** API.

### The Read API

The Read API uses the latest recognition models and is optimized for images that have a significant amount of text or has considerable visual noise.  

The Read API can handle scanned documents that have a lot of text. It also has the ability to automatically determine the proper recognition model to use, taking into consideration lines of text and supporting images with printed text as well as recognizing handwriting.

Because the Read API can work with large documents, it works asynchronously so as not to block your application while it is reading the content and returning results to your application. This means that to use the Read API, your application must use a three-step process:

1. Submit an image to the API, and retrieve an *operation ID* in response.
2. Use the operation ID to check on the status of the image analysis operation, and wait until it has completed.
3. Retrieve the results of the operation.

The results from the Read API are arranged into the following hierarchy:

- **Pages** - One for each page of text, including information about the page size and orientation.
- **Lines** - The lines of text on a page.
- **Words** - The words in a line of text, including the bounding box coordinates and text itself.

Each line and word includes bounding box coordinates indicating its position on the page.
