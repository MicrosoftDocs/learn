
We covered quite a bit of information in this module around face recognition and emotion. Testing using the web interface is ok for understanding how the calls to the API work but you may also want to work through the concepts using a client application.  Microsoft provides a tutorial with a sample starter application, in C#, that you can use to test these APIs from a Windows application.  You can find that tutorial here, https://docs.microsoft.com/en-us/azure/cognitive-services/computer-vision/tutorials/csharptutorial.

Face detection is just one component of the overall Vision API in Azure Cognitive Services but is one that can make your applications take advantage of the facial recognition capabilities that Microsoft provides for you use.  Once again, if the built-in functionality doesn't match your needs completely, you can make use of data science to create your own facial recognition services or you can utilize the custom vision capabilities.

## Cleanup

To avoid any unexpected costs in your Azure account, delete the **mslearn-faceapi** resource group. This will remove all of the resources we created in this module. Here's the steps you need to do.

1. Find the **mslearn-faceapi** resource group. Select **Resource groups** in the Azure sidebar to quickly locate it.

1. Select the resource group and either right-click on the row, or use the "..." button on the far-right side of the row to open the context menu.

1. Select **Delete resource group**.

1. Type the name of the resource group and click **Delete**. Azure will de-provision all of the resources for you.