Creating verification profiles is a straightforward process using the Speaker Recognition API **verification management methods**.

## Using the Speaker Recognition API to Manage Verification Profiles

Managing speaker verification profiles with the Speaker Recognition API is simply a process of **sending an authorized web request to the subscription endpoint** and **observing the information returned from the call**. And remember, for most services in the Microsoft Cognitive Speech suite, information is returned in a standard JSON format.

The primary methods used to create and manage verification profiles are the Speaker Verification **Create Profile** and **Create Enrollment** methods. The Create Profile method simply accepts a region/location parameter for provisioning a profile based on a specific locale, and returns a unique identifier for the profile, however the Create Enrollment is where the real magic happens.

The Create Enrollment method accepts an audio file (as a binary file payload) which **must** meet the following criteria:

- **Container**: WAV
- **Encoding**: PCM
- **Rate**: 16K
- **Sample format**:  16-bit
- **Channels**: Mono

The Create Enrollment method requires a single parameter to be passed to the services, identifying the profile for which the enrollment submission should be applied:

- **verificationProfileId**: the unique identifier of the speaker verification profile, returned from the Create Profile method

A parameter passed to the Speaker Verification API Create Enrollment method is typically sent in the query string, as part of the endpoint URL:

```text
https://westus.api.cognitive.microsoft.com/spid/v1.0/verificationProfiles/{verificationProfileId}/enroll
```

> [!TIP]
> When providing enrollment audio via a REST-based request, the audio file should be at least 1 second long, and no longer than 15 seconds.

## Sending an Audio Payload

To send an audio payload to the Speaker Verification Create Enrollment method, a **binary file**, such as a stream or byte array, needs to be including in the web request, and then **sent via a standard HTTP POST method**.

## Binary file payload

Creating and sending a binary file payload to the Create Enrollment method uses standard, language-specific methods for creating and sending binary content. For example, in C#, a binary payload could come from an audio file (containing a voice recording of the verification phrase) located on a local computer:

```csharp
string uri = "https://westus.api.cognitive.microsoft.com/spid/v1.0/verificationProfiles/{verificationProfileId}/enroll";
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

Notice the required use of the `application/octet-stream` content type in the request header to instruct the method as to the type of content being delivered.

Notice as well that there is no parameter used to provide the selected verification phrase. The Speaker Recognition API is smart enough to _extract_ the phrase from the audio file and presents this value to you as a technique of securing verification.

### Return values

The results returned from the Speaker Recognition API are contained in JSON payloads. Here's an example of the information returned from the Speaker Verification Create Enrollment method:

```json
{
  "enrollmentStatus" : "Enrolled",
  "enrollmentsCount":3,
  "remainingEnrollments" : 0,
  "phrase" : "[Recognized verification phrase]"
}
```

> [!NOTE]
> The value `"[Recognized verification phrase]"` will be populated with the extracted verification phrase.

Managing verification profiles via the Speaker Recognition API is straightforward. Although more difficult for the system, the process of **managing identification profiles** is just as easy.