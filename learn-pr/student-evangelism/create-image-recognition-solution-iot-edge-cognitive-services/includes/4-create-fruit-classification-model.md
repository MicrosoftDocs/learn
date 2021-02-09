The [Azure Custom Vision](https://docs.microsoft.com/azure/cognitive-services/custom-vision-service/?WT.mc_id=iot-0000-dglover) service is a simple way to create an image classification machine learning model without having to be a data science or machine learning expert. You simply upload multiple collections of labelled images. For example, you could upload a collection of banana images and label them as 'banana'.

In this module, we will use pre-built image classifier model.

## Azure Speech Services

[Azure Speech Services](https://docs.microsoft.com/azure/cognitive-services/speech-service/overview/?WT.mc_id=iot-0000-dglover) supports both "speech to text" and "text to speech". For this solution, I'm using the text to speech (F0) free tier which is limited to 5 million characters per month. You will need to add the Speech service using the Azure Portal and "Grab your key" from the service.

Open the deployment.template.json file and update the BingKey with the key you copied from the Azure Speech service.

