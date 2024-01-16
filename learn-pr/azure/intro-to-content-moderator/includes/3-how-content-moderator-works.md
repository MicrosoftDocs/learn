Using the Content Moderator service requires an Azure subscription and a Content Moderator resource. The resource is required for accessing the service and provides the endpoint and access key for the service. 

Microsoft provides a free pricing tier that you can use to test the service. Using the free tier, you can determine if the Content Moderator service is the right choice for your organization.

The Content Moderator service can be accessed through REST or by using the appropriate software development kit (SDK). The currently supported languages in the SDK are:

- .NET
- Java
- Node.js
- Python
- Go

## Moderating text

You can call a single method in the API, **ModerateText**, to scan text in a file. You specify the input file and an output file in the method call. The service scans the text in the file and returns the results in the output file. The API returns a JSON formatted result back to the calling application. Using a sample text input of:

```text
"Is this a janky email abcdef@abcd.com, phone: 6657789887, IP: 255.255.255.255, 1 Microsoft Way, Redmond, WA 98052"
```

The service identifies some personal data (email, phone, IP, and address), and then classifies the text with a review recommendation.

```json
{
  "OriginalText": "Is this a janky email abcdef@abcd.com, phone: 6657789887, IP: 255.255.255.255, 1 Microsoft Way, Redmond, WA 98052",
  "NormalizedText": "   janky email abcdef@abcd.com, phone: 6657789887, IP: 255.255.255.255, 1 Microsoft Way, Redmond, WA 98052",
  "Misrepresentation": null,
  "PII": {
    "Email": [{
      "Detected": "abcdef@abcd.com",
      "SubType": "Regular",
      "Text": "abcdef@abcd.com",
      "Index": 21
    }],
    "IPA": [{
      "SubType": "IPV4",
      "Text": "255.255.255.255",
      "Index": 61
    }],
    "Phone": [{
      "CountryCode": "US",
      "Text": "6657789887",
      "Index": 45
    }],
    "Address": [{
      "Text": "1 Microsoft Way, Redmond, WA 98052",
      "Index": 78
    }],
    "SSN": []
  },
  "Classification": {
    "ReviewRecommended": true,
    "Category1": {
      "Score": 0.00040505084325559437
    },
    "Category2": {
      "Score": 0.22345089912414551
    },
    "Category3": {
      "Score": 0.98799997568130493
    }
  },
  "Language": "eng",
  "Terms": [{
    "Index": 3,
    "OriginalIndex": 10,
    "ListId": 0,
    "Term": "janky"
  }],
  "Status": {
    "Code": 3000,
    "Description": "OK",
    "Exception": null
  },
  "TrackingId": "7a6e3717-1382-4b63-a8f4-24922e041f82"
}
```

## Moderating images

Using the service for image moderation requires the images to be accessible through a URL. If you have multiple images, you place the URLs for each image as a separate line item in a text file and send that to the service. The service evaluates each image separately.

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

The image API also offers the ability to run face detection, perform OCR to scan text in the image, or perform image matching against a custom image list. Each API call is a separate function.
