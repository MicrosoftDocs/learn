The ability to extract text from images is handled by the Computer Vision service, which also provides image analysis capabilities.

## Azure resources for Computer Vision

The first step towards using the Computer Vision service is to create a resource for it in your Azure subscription. You can use either of the following resource types:

- **Computer Vision**: A specific resource for the Computer Vision service. Use this resource type if you don't intend to use any other cognitive services, or if you want to track utilization and costs for your Computer Vision resource separately.
- **Cognitive Services**: A general cognitive services resource that includes Computer Vision along with many other cognitive services; such as Text Analytics, Translator Text, and others. Use this resource type if you plan to use multiple cognitive services and want to simplify administration and development.

Whichever type of resource you choose to create, it will provide two pieces of information that you will need to use it:

- A **key** that is used to authenticate client applications.
- An **endpoint** that provides the HTTP address at which your resource can be accessed.

> [!NOTE]
> If you create a Cognitive Services resource, client applications use the same key and endpoint regardless of the specific service they are using.

## Use the Computer Vision service to read text

Many times an image contains text.  It can be typewritten text or handwritten.  Some common examples are images with road signs, scanned documents that are in an image format such as JPEG or PNG file formats, or even just a picture taken of a white board that was used during a meeting.

The Computer Vision service provides two application programming interfaces (APIs) that you can use to read text in images: the **OCR** API and the **Read** API.

### The OCR API

The OCR API is designed for quick extraction of small amounts of text in images. It operates synchronously to provide immediate results, and can recognize text in numerous languages.

When you use the OCR API to process an image, it returns a hierarchy of information that consists of:

- **Regions** in the image that contain text
- **Lines** of text in each region
- **Words** in each line of text

For each of these elements, the OCR API also returns *bounding box* coordinates that define a rectangle to indicate the location in the image where the region, line, or word appears.

### The Read API

The OCR method can have issues with false positives when the image is considered text-dominate.  The Read API uses the latest recognition models and is optimized for images that have a significant amount of text or has considerable visual noise.  

The Read API is a better option for scanned documents that have a lot of text.  The Read API also has the ability to automatically determine the proper recognition model to use, taking into consideration lines of text and supporting images with printed text as well as recognizing handwriting.

Because the Read API can work with larger documents, it works asynchronously so as not to block your application while it is reading the content and returning results to your application. This means that to use the Read API, your application must use a three-step process:

1. Submit an image to the API, and retrieve an *operation ID* in response.
2. Use the operation ID to check on the status of the image analysis operation, and wait until it has completed.
3. Retrieve the results of the operation.

The results from the Read API are arranged into the following hierarchy:

- **Pages** - One for each page of text, including information about the page size and orientation.
- **Lines** - The lines of text on a page.
- **Words** - The words in a line of text.

Each line and word includes bounding box coordinates indicating its position on the page.
