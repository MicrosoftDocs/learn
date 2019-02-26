With a Speaker Recognition API **verification profile** in place, the process of performing speaker verification is easy. 

Recall that the entire process looks like this:

1. Create a **verification profile**
1. Create three **verification phrase enrollments**
1. Attempt to **verify a speaker**

Speaker verification requires sending an authorized web request to the subscription endpoint and observing the information returned from the call, via the Speaker Recognition API **Verify** method.

The Verify method accepts an audio file (as a binary file payload) which **must** meet the same criteria as both speaker verification and speaker identification. To review, these audio file requirements are:

| Property | Required value |
|----------|----------------|
| **Container** | WAV |
| **Encoding**  | PCM |
| **Rate**      | 16K |
| **Sample format** | 16-bit |
| **Channels**  | Mono |

The Verify method doesn't accept any additional parameters. It only requires an audio clip (as a binary file) to verify. In C#, a binary payload could come from an audio file (containing a "new" voice recording of the verification phrase) located on a local computer:

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

Luckily, information returned from a call to the Verify method provides all information necessary to verify a speaker:

- **Result**: a value of "Accept" or "Reject"
- **Confidence**: A value of "Low", "Normal", or "Medium"
- **Phrase**: The recognized verification phrase from the audio file

When verification has been performed, a well-formatted JSON object or array will be returned:

```json
{
  "result" : "Accept",
  "confidence" : "Normal",
  "phrase": "Recognized phrase"
}
```

> [!NOTE]
> The value `"[Recognized phrase]"` will be populated with the extracted phrase recognized in the audio.

Depending on the scenario, information returned could require additional logic in an app or service, for example, in highly sensitive environments, a confidence level of "Normal" could possibly indicate the need for reverification until a confidence level of "High" is reported. Otherwise, a value of "Accept" would typically indicate a reasonable likelihood of the speaker being matched.

Once you get the hang of the process, it's as simple to **perform speaker identification**.

## Performing Speaker Identification

With a Speaker Recognition API **identification profile** in place, the process of performing speaker identification is as easy as verification. The entire process looks like this:

1. Create an **identification profile**.
1. Create three **identification enrollments**.
1. Attempt to **identify a speaker**.

Similar to verification, speaker identification is a process of sending an authorized web request to the subscription endpoint and observing the information returned from the call, via the Speaker Recognition API **Identify** method, with an audio file meeting the same criteria as all other audio files in the system.

The Identify method also doesn't take any additional parameters - just the audio clip (as a binary file) that would typically contain any manner of spoken content. In C#, a binary payload could come from an audio file (containing a "new" recording of audio containing speech) located on a local computer:

```csharp
string uri = "https://westus.api.cognitive.microsoft.com/spid/v1.0/identify?identificationProfileId={identificationProfileId}";
FileStream fileStream = new FileStream(@"c:\\Sample Audio\identification_01.wav", FileMode.Open, FileAccess.Read);
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

## Identification Return values

Again, information returned from a call to the Verification method provides all information necessary to verify a speaker:

- **Identified Profile ID**: the identified speaker Identification Profile ID
- **Confidence**: A value of "Low", "Normal", or "Medium"

When verification is complete, a JSON object will be returned.

```json
{
    "identifiedProfileId" : "00000000-0000-0000-0000-000000000000",
    "confidence" : "Normal"
}
```

> [!IMPORTANT]
> If the Identified Profile Id returns a value of "00000000-0000-0000-0000-000000000000", this means there is no speaker identification profile identified and the audio file to be identified belongs to none of the provided speaker identification profiles.