Creating verification profiles is a straightforward process that uses the verification-management methods in the Speaker Verification API.

## Use the Speaker Verification API to manage verification profiles

Managing speaker-verification profiles with the Speaker Verification API is a process of:

- Sending an authorized web request to the subscription endpoint.
- Observing the information returned from the call.

Like most services in the Azure Cognitive Services suite, the Speaker Verification API returns information in a standard JSON format.

The primary methods used to create and manage verification profiles are the `Create Profile` and `Create Enrollment` methods in the Speaker Verification API. The `Create Profile` method accepts a region or locale parameter for creating a profile based on a specific locale, and it returns a unique identifier for the profile. But the `Create Enrollment` method is where the significant work happens.

The `Create Enrollment` method accepts an audio file (as a binary file payload) that *must* meet the following criteria:

- **Container:** WAV
- **Encoding:** PCM
- **Rate:** 16K
- **Sample format:**  16-bit
- **Channels:** Mono

The `Create Enrollment` method requires a single parameter to be passed to the service. This `verificationProfileId` parameter, which is returned from the `Create Profile` method, identifies which profile to apply the enrollment submission to.

A parameter passed to the `Create Enrollment` method is typically sent in the query string, as part of the endpoint URL:

```text
https://westus.api.cognitive.microsoft.com/spid/v1.0/verificationProfiles/{verificationProfileId}/enroll
```

> [!TIP]
> When you're providing enrollment audio via a REST-based request, the audio file should be at least 1 second long and no longer than 15 seconds.

## Send an audio payload

To send an audio payload to the `Create Enrollment` method, you must include a binary file, such as a stream or byte array, in the web request. You must then send the request via a standard HTTP POST method.

## Binary file payload

You create and send a binary file payload to the `Create Enrollment` method by using standard, language-specific methods for creating and sending binary content. For example, in C#, a binary payload could come from an audio file (containing a voice recording of the verification phrase) located on a local computer:

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

The `application/octet-stream` content type is required in the request header to tell the method what type of content is being delivered.

You don't need to use a parameter to provide the selected verification phrase. The Speaker Verification API extracts the phrase from the audio file and presents this value to you as a way of securing verification.

### Return values

The results returned from the Speaker Verification API are contained in JSON payloads. Here's an example of the information returned from the `Create Enrollment` method:

```json
{
  "enrollmentStatus" : "Enrolled",
  "enrollmentsCount":3,
  "remainingEnrollments" : 0,
  "phrase" : "<Recognized verification phrase>"
}
```

> [!NOTE]
> The value `"<Recognized verification phrase>"` is populated with the extracted verification phrase.

Managing verification profiles via the Speaker Verification API is straightforward. Managing identification profiles is just as easy.