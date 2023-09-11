In this exercise you will add image analysis capabilities to your React application, using Azure AI Vision cognitive service.

## Specification

1. Create a new Azure AI Vision Service resource in your subscription, using the 'Computer Vision' service. You can leverage the [Azure portal](https://ms.portal.azure.com/) UI or the [Azure CLI](https://learn.microsoft.com/cli/azure/what-is-azure-cli?WT.mc_id=academic-105496-cacaste) to do that.

1. Add the code to call the Azure AI Vision service [Image Analysis 4.0 API](https://learn.microsoft.com/azure/ai-services/computer-vision/how-to/call-analyze-image-40?tabs=rest&WT.mc_id=academic-105496-cacaste&pivots=programming-language-rest-api) to your React application as a function 'analyzeImage' in a new separate module, that you can name 'azure-image-analysis.js'. Note that you can customize the visual features to be returned by the API, by embedding them in the 'features' query parameter. The function should receive as input the image URL and return the JSON response of the API.

1. Add 'analyzeImage' as a new module into your App.js and call the 'analyzeImage' function from there, in a way that the image analysis action is triggered when the 'Analyze' button is pressed. Ensure to hold the UI and to have a processing indicator while the analysis is running.

1. In your App.js file add a 'DisplayResults' function to display the results of the API call in a readable format, along with the URL of the processed image.

> [!TIP]
> Don't include the services key directly in your code, and never post it publicly. When running your app locally, you can store your credentials in environment variables. Environment variables are name-value pairs that are stored within a specific development environment.
> See the [Azure AI services security article](https://learn.microsoft.com/azure/ai-services/security-features?WT.mc_id=academic-105496-cacaste) for more authentication options.

## Check your work

To validate the work done in this exercise, run your React app locally (using `npm start` command) and open the URL <http://localhost:3000> in a browser.
Ensure you set up your environment variables with the Azure AI Vision service key and endpoint URL beforehand.
You should see the same GUI as in the previous exercise, but now when you enter the URL of an image and press the 'Analyze' button, you should see the results of the image analysis service displayed in the web page, like in the image below:
![Image Analysis result](../media/image_analysis_result.png)
The resulting json might change according to the visual features you have selected in the API call. Use the 'Caption' feature to get a single sentence description of the image.
You can use this public URL to test your app: <https://moderatorsampleimages.blob.core.windows.net/samples/sample16.png>.
