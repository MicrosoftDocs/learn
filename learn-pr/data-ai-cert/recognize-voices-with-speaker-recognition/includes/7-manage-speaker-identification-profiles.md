Creating identification profiles is a straightforward process that uses the identification-management methods in the Speaker Identification API.

## Use the Speaker Identification API to manage identification profiles

Like speaker-verification profiles, you manage speaker-identification profiles with the Speaker Identification API by:

- Sending an authorized web request to the subscription endpoint.
- Observing the information returned from the call.

The primary methods you use to create and manage identification profiles are the `Create Profile` and `Create Enrollment` methods in the Speaker Identification API. As with speaker verification, the `Create Profile` method accepts a region or locale parameter for creating a profile based on a specific locale, and it returns a unique identifier for the profile. But the `Create Enrollment` method is where the significant work happens.

The `Create Enrollment` method accepts an audio file (as a binary file payload) that *must* meet the same criteria as the files used for speaker verification:

| Property | Required value |
|----------|----------------|
| **Container** | WAV |
| **Encoding**  | PCM |
| **Rate**      | 16K |
| **Sample format** | 16-bit |
| **Channels**  | Mono |

The `Create Enrollment` method requires a single parameter to be passed to the service. This `identificationProfileId` parameter, which is returned by the `Create Profile` method, identifies which profile to apply the enrollment submission to.

You can also pass an optional `shortAudio` parameter to instruct the service to bypass audio-length requirements. This parameter is a "yes" or "no" (Boolean) value that tells the service to waive the recommended minimum audio limit needed for enrollment.

A parameter passed to the Speaker Identification API `Create Enrollment` method is typically sent in the query string as part of the endpoint URL. This example includes the optional `shortAudio` parameter:

```text
https://westus.api.cognitive.microsoft.com/spid/v1.0/identificationProfiles/{identificationProfileId}/enroll?shortAudio=true
```

> [!NOTE]
> When you're enrolling a speaker for identification without using the `shortAudio` parameter, the audio files must be at least 5 seconds long and no longer than 5 minutes. The *minimum* recommended amount of accumulated speech for enrollment, after removing silence, is 30 seconds. After accumulating 30 seconds of speech, the profile’s enrollment status is changed from `enrolling` to `enrolled` to indicate that it's ready to be used for identification. When you're using the `shortAudio` parameter, audio files can be as short as 1 second long, but the accuracy of speaker identification is potentially less reliable.

## Send an audio payload

To send an audio payload to the Speaker Identification `Create Enrollment` method, you must include a binary file, such as a stream or byte array, in the web request, and then send the request via a standard HTTP POST method.

### Binary file payload

You create and send a binary file payload to the `Create Enrollment` method by using standard, language-specific methods for creating and sending binary content. For example, in C#, a binary payload could come from an audio file (containing a voice recording of the person speaking) located on a local computer:

```csharp
string uri = "https://westus.api.cognitive.microsoft.com/spid/v1.0/identificationProfiles/{identificationProfileId}/enroll?shortAudio=true";
FileStream fileStream = new FileStream(@"c:\\Sample Audio\enrollment_01.wav", FileMode.Open, FileAccess.Read);
BinaryReader binaryReader = new BinaryReader(fileStream);
var bytes = binaryReader.ReadBytes((int)fileStream.Length);

using (ByteArrayContent content = new ByteArrayContent(bytes))
{
    content.Headers.ContentType = new MediaTypeHeaderValue("application/octet-stream");
    //POST the binary content to the endpoint
    response = await client.PostAsync(uri, content);
    string contentString = await response.Content.ReadAsStringAsync();
}
```

In the prior example, the optional `shortAudio` parameter tells the method to waive the recommended minimum audio limit needed for enrollment and to allow audio files as little as 1 second long.

### Return values

If you have long audio files, creating speaker-identification enrollments can take a while. Because enrollment is potentially a long-running process, the `Create Enrollment` method is an operation location and result method.

To get the status of an enrollment operation, you need to:

- Send an initial request, with the specified payload.
- Get the **operation location** value from the initial request.
- Poll the **operation location** value that's returned, until the **operation result** value indicates that the operation is successful.
- Call the `Get Profile` method in the Speaker Identification API.

When the enrollment process is successful, the results returned from the `Get Profile` method are in a well-formatted JSON object or array that looks like this example:

```json
{
  "identificationProfileId": "e30148ba-9078-4b88-a53c-d47888ba64ce",
  "locale": "en-us",
  "enrollmentSpeechTime": 3.38,
  "remainingEnrollmentSpeechTime": 0.0,
  "createdDateTime": "2018-02-18T00:39:58.567Z",
  "lastActionDateTime": "2018-02-18T00:40:00.614Z",
  "enrollmentStatus": "Enrolled"
}
```

With a speaker verification or identification profile in place, you can now use Azure Cognitive Services to recognize that speaker.