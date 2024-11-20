This solution uses two categories (vision and speech) of Azure AI services.

## Azure Custom Vision Services

The [Azure Custom Vision](https://azure.microsoft.com/services/cognitive-services/custom-vision-service/) service is a simple way to create an image classification machine learning model without being a data science or machine learning expert. You upload multiple collections of labeled images. For example, you could upload a collection of banana images and label them as 'banana'.

In this module, you use a pre-built classification model. The [Image Classification module](https://github.com/MicrosoftDocs/mslearn-oxford.create-image-recognition-with-azure-iot-edge/tree/main/modules/ImageClassifierService) is created and exported from Azure Custom Vision.

## Azure Speech Services

[Azure Speech Services](https://azure.microsoft.com/services/cognitive-services/speech-to-text/) supports both "speech to text" and "text to speech".  We're using the text to speech (F0) free tier for this solution, which is limited to 5 million characters per month. You will need to add the Speech service key using the Azure portal from your Speech service.

In this module, the [Camera Capture Module](https://github.com/MicrosoftDocs/mslearn-oxford.create-image-recognition-with-azure-iot-edge/tree/main/modules/CameraCaptureOpenCV) handles scanning items using a camera. It then calls the Image Classification module to identify the item, a call is then made to the "Text to Speech" module to convert the item label to speech, and the name of the item scanned is played on the attached speaker.
