Creating identification profiles is a straightforward process using Speaker Recognition API **identification management methods**.

## Using the Speaker Recognition API to Manage Identification Profiles

Just like managing speaker verification profiles, managing speaker identification profiles with the Speaker Recognition API is simply a process of **sending an authorized web request to the subscription endpoint** and **observing the information returned from the call**.

The primary methods used to create and manage identification profiles are the Speaker Identification **Create Profile** and **Create Enrollment** methods. As with speaker verification, the Create Profile method accepts a region/location parameter for provisioning a profile based on a specific locale, and returns a unique identifier for the profile, and the Create Enrollment is where the all heavy lifting occurs.

The Create Enrollment method accepts an audio file (as a binary file payload) which **must** meet the same criteria as speaker verification:

| Property | Required value |
|----------|----------------|
| **Container** | WAV |
| **Encoding**  | PCM |
| **Rate**      | 16K |
| **Sample format** | 16-bit |
| **Channels**  | Mono |

The Create Enrollment method requires a single parameter to be passed to the services, identifying the profile for which the enrollment submission should be applied, as well as an optional parameter to instruct the service to "bypass" audio length requirements:

- **identificationProfileId**: the unique identifier of the speaker identification profile, returned from the Create Profile method
- **shortAudio**: an optional "yes/no" (Boolean) value to instruct the service to waive the **recommended** minimum audio limit needed for enrollment

A parameter passed to the Speaker Identification API Create Enrollment method is typically sent in the query string, as part of the endpoint URL, optionally including the "shortAudio" flag:

```text
https://westus.api.cognitive.microsoft.com/spid/v1.0/identificationProfiles/{identificationProfileId}/enroll?shortAudio=true
```

> When enrolling for identification, audio files need to be at least 5 seconds long and no longer than 5 minutes. The **minimum** recommended amount of accumulated speech for enrollment, after removing silence, is 30 seconds. After accumulating 30 seconds of speech, the profile’s enrollment status is changed from enrolling to enrolled to indicate that it is ready for identification. When using the "shortAudio" parameter, audio files can be as short as 1 second long, however the accuracy is potentially less reliable.

## Sending an Audio Payload

To send an audio payload to the Speaker Identification Create Enrollment method, a **binary file**, such as a stream or byte array, needs to be including in the web request, and then **sent via a standard HTTP POST method**.

### Binary file payload

Creating and sending a binary file payload to the Create Enrollment method uses standard, language-specific methods for creating and sending binary content. For example, in C#, a binary payload could come from an audio file (containing a voice recording of the person speaking) located on a local computer:

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

Notice the use of the optional "shortAudio" parameter to instruct the method to waive the recommended minimum audio limit needed for enrollment, and allow audio length of as little as 1 second long.

### Return values

Creating speaker identification enrollments often takes a bit of time, depending on the length of the audio being provided. As this is the case, **the Create Enrollment method is an "operation location and result method"** meaning it's potentially **a long-running process**. In order to get the status of the enrollment operation, a few extra steps are necessary. You will be required to:

- Perform an initial request, with the specified payload
- Retrieve the **operation location** value from the initial request
- Poll the **operation location** value returned, until an **operation result** is successful
- Call the Speaker Identification **Get Profile** method

When the enrollment process is successful, information can be returned from the Speaker Identification Get Profile method as a well-formatted JSON object or array which will look something like:

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

With a speaker verification or identification profile in place, it now becomes possible to leverage the artificial intelligence and machine learning processes of  Microsoft Cognitive Service to **perform speaker recognition**.