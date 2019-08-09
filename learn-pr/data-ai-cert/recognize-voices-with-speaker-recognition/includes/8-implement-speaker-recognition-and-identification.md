The speaker-verification process consists of three major steps:

1. Create a verification profile.
1. Create three verification phrase enrollments.
1. Attempt to verify a speaker.

To verify a speaker, you must send an authorized web request to the subscription endpoint and observe the information returned from the call via the `Verify` method in the Speaker Verification API.

The `Verify` method accepts an audio file (as a binary file payload) that *must* meet the same criteria as the files used for enrollments in both speaker verification and speaker identification. To review, these audio file requirements are:

| Property | Required value |
|----------|----------------|
| **Container** | WAV |
| **Encoding**  | PCM |
| **Rate**      | 16K |
| **Sample format** | 16-bit |
| **Channels**  | Mono |

The `Verify` method doesn't accept any additional parameters. It requires only an audio clip (as a binary file) to verify. In C#, a binary payload can come from an audio file (containing a "new" voice recording of the verification phrase) located on a local computer:

```csharp
string uri = "https://westus.api.cognitive.microsoft.com/spid/v1.0/verify?verificationProfileId={verificationProfileId}";
FileStream fileStream = new FileStream(@"c:\\Sample Audio\verification_01.wav", FileMode.Open, FileAccess.Read);
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

## Return values

The information returned from a call to the `Verify` method provides all the information necessary to verify a speaker:

- `Result`: A value of `Accept` or `Reject`
- `Confidence`: A value of `Low`, `Normal`, or `High`
- `Phrase`: The recognized verification phrase from the audio file

When verification is finished, a well-formatted JSON object or array is returned:

```json
{
  "result" : "Accept",
  "confidence" : "Normal",
  "phrase": "<Recognized phrase>"
}
```

> [!NOTE]
> The value `<Recognized phrase>` is populated with the extracted phrase that was recognized in the audio.

Depending on the scenario, the information returned might require additional logic in your app or service. For example, in highly sensitive environments, a confidence level of `Normal` might indicate the need for reverification until a confidence level of `High` is reported. Otherwise, a value of `Accept` might be sufficient by itself.

After you're familiar with the process of speaker verification, you'll find that the speaker-identification process is similar.

## Speaker identification

Like speaker verification, the speaker-identification process consists of three major steps:

1. Create an identification profile.
1. Create an identification enrollment.
1. Attempt to identify a speaker.

Similar to speaker verification, to identify a speaker, you must send an authorized web request to the subscription endpoint and observe the information returned from the call via the `Identify` method in the Speaker Identification API. The audio file you send in your request must meet the same criteria as all other audio files in the system.

The `Identify` method doesn't take any additional parameters, only an audio clip (as a binary file) that contains any manner of spoken content. In C#, a binary payload could come from an audio file (containing a "new" speech recording) located on a local computer:

```csharp
string uri = "https://westus.api.cognitive.microsoft.com/spid/v1.0/identify?identificationProfileId={identificationProfileId}";
FileStream fileStream = new FileStream(@"c:\\Sample Audio\identification_01.wav", FileMode.Open, FileAccess.Read);
BinaryReader binaryReader = new BinaryReader(fileStream);
var bytes = binaryReader.ReadBytes((int)fileStream.Length);

using (ByteArrayContent content = new ByteArrayContent(bytes))
{
    content.Headers.ContentType = new MediaTypeHeaderValue("application/octet-stream");
    //POST the binary content to the endpoint.
    response = await client.PostAsync(uri, content);
    string contentString = await response.Content.ReadAsStringAsync();
}
```

## Identification return values

The information returned from a call to the `Identify` method provides all the information necessary to identify a speaker:

- `identifiedProfileId`: The `identificationProfileId` value of the identified speaker's profile
- `Confidence`: A value of `Low`, `Normal`, or `High`

When identification is finished, a JSON object is returned:

```json
{
    "identifiedProfileId" : "00000000-0000-0000-0000-000000000000",
    "confidence" : "Normal"
}
```

> [!IMPORTANT]
> If the `identifiedProfileId` property returns a value of `00000000-0000-0000-0000-000000000000`, no speaker-identification profile has been identified. In other words, the audio file to be identified doesn't match any of the provided speaker-identification profiles.