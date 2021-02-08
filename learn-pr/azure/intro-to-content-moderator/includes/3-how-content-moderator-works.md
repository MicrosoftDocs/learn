Using the Content Moderator service requires an Azure subscription and a Content Moderator resource. The resource is required for accessing the service and provides the endpoint and access key for the service. 

Microsoft provides a free pricing tier that you can use to test the service. Using the free tier, you can determine if the Content Moderator service is the right choice for your organization.

The Content Moderator service can be accessed through REST or by using the appropriate software development kit (SDK). The currently supported languages in the SDK are:

- .NET
- Java
- Node.js
- Python
- Go

## Moderating text

You can call a single method in the API, **ModerateText**, to scan text in a file. You specify the input file and an output file in the method call. The service will scan the text in the file and return the results in the output file. The API will return a JSON formatted result back to the calling application. Using a sample text input of:

"Is this a crap email abcdef@abcd.com, phone: 6657789887, IP: 255.255.255.255, 1 Microsoft Way, Redmond, WA 98052"

The service will identify some personal data (email, phone, IP, and address). It will also classify the text with a review recommendation.

:::image type="content" source="../media/3-text-moderator-result.png" alt-text="text moderation results in JSON format showing identified text categories with scores and review recommended":::

## Moderating images

Using the service for image moderation requires the images to be accessible through a URL. If you have multiple images, you would place the URLs for each image as a separate line item in a text file and send that to the service.  Each image will be evaluated separately by the service.

When the image has been evaluated, a JSON result is returned indicating a score and classification for the adult and racy categories.

```json
{
  "AdultClassificationScore": 0.02518901415169239,
  "IsImageAdultClassified": false,
  "RacyClassificationScore": 0.052860850468277931,
  "IsImageRacyClassified": false,
  "Result": false,
  "AdvancedInfo": [{
    "Key": "ImageDownloadTimeInMs",
    "Value": "499"
  }, {
    "Key": "ImageSizeInBytes",
    "Value": "273405"
  }],
  "Status": {
    "Code": 3000,
    "Description": "OK",
    "Exception": null
  },
  "TrackingId": "d993e832-1bf5-48b2-b2b3-73e57b2bd6a2"
}
```

The image API also offers the ability to run the face detection, perform OCR to scan text in the image, or performing image matching against a custom image list.  Each API call is a separate function.
