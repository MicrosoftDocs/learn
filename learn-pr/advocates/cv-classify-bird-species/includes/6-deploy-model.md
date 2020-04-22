Now our model is performing "good enough" lets deploy it!

## Ways to deploy with custom vision

## Export to diff format

### Get the Prediction Url

- Select "Performace" from the top navigation in the Custom Vision portal
- Select "Prediction Url"
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

## Deploy to IoT Board
