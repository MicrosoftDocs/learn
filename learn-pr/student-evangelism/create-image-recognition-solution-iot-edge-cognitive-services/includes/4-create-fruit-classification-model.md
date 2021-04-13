The [Azure Custom Vision](https://docs.microsoft.com/azure/cognitive-services/custom-vision-service) service is a simple way to create an image classification machine learning model without being a data science or machine learning expert. You upload multiple collections of labeled images. For example, you could upload a collection of banana images and label them as 'banana'.

In this module, you use a pre-built classification model. The **Image Classification module** is created and exported from Azure Custom Vision.

## Azure Speech Services

[Azure Speech Services](https://docs.microsoft.com/azure/cognitive-services/speech-service/overview) supports both "speech to text" and "text to speech".  We're using the text to speech (F0) free tier for this solution, which is limited to 5 million characters per month. You will need to add the Speech service using the Azure Portal and "Grab your key" from the service.

Open the deployment.template.json file and update the BingKey with the key you copied from the Azure Speech service.

In this module, the **Camera Capture Module** handles scanning items using a camera. It then calls the Image Classification module to identify the item, a call is then made to the "Text to Speech" module to convert the item label to speech, and the name of the item scanned is played on the attached speaker.

