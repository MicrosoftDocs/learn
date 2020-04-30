## How to Deploy the Model

Now our model is performing "good enough" lets deploy it! There are different ways to deploy the model based on what you need. There is a one click deploy to an endpoint or you can export the model to different formats to deploy to different platforms. We will go over how to deploy to the endpoint and consume with an App.

## Option 1: One Click Deploy to an Endpoint

### Get the Prediction Url

- Select `Performance` from the top navigation in the Custom Vision portal
- Click `Publish`
- Select `Prediction Url`
- Copy the Url to either use an image url or image file
- Additionally by selecting the settings icon in the right corner will bring you to the keys and urls to call the endpoint.

### Consume the API in an App

Once the model is trained and at a satisfactory accuracy its ready to be used in your App

- Go to the Resource Group that contains the Custom Vision Resource
- There should be a resource named "YourCustomVisionResourceName_Prediction - Quick start"
- The Select "Api Reference" from the list of helpful links
- This will open a page with docs on how to call the api to get predictions from the model
- If you scroll all the way to the bottom there are code samples in multiple languages to get you started

### Test API in Postman

- Get the predction url as described above
- Select "Post" from the dropdown and paste in the url
- Go to the settings and get the Prediction Key
- In the headers add the `Prediction-key` as the key and the actual key as the value
- Auth should be set to no auth
- Select Body > Raw > Json
- Paste in the following Json
  `{ "Url": "UrlForImageGoesHere" }`
- Send Request
