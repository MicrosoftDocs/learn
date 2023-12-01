The ability to extract text from images is handled by Azure AI Vision service. One of the services in Azure AI Vision is the *Read API*. You can think of the Read API as an OCR engine that powers text extraction from images, PDFs, and TIFF files.

The Read API uses the latest recognition models and is optimized for images that have a significant amount of text or have considerable visual noise. It can automatically determine the proper recognition model to use taking into consideration the number of lines of text, images that include text, and handwriting.

The results from the Read API are arranged into the following hierarchy:

- **Pages** - One for each page of text, including information about the page size and orientation.
- **Lines** - The lines of text on a page.
- **Words** - The words in a line of text, including the bounding box coordinates and text itself.

Each line and word includes bounding box coordinates indicating its position on the page.

[Vision Studio](https://portal.vision.cognitive.azure.com/) provides a graphical user interface and enables you to try out Azure AI Vision service without writing any code.

## Create an Azure resource
To use the Azure AI Vision service you must first create a resource for it in your Azure subscription. You can use either of the following resource types:

- **Azure AI Vision**: A specific resource for vision services. Use this resource type if you don't intend to use any other AI services, or if you want to track utilization and costs for your AI Vision resource separately.
- **Azure AI services**: A general resource that includes Azure AI Vision along with many other Azure AI services such as Azure AI Language, Azure AI Speech, and others. Use this resource type if you plan to use multiple Azure AI services and want to simplify administration and development.
