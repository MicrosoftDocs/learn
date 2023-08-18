The Speech service is the unification of speech to text, text to speech and speech translation into a single Azure subscription. It's easy to speech enable your applications, tools and devices with the Speech CLI, Speech SDK, Speech Devices SDK, Speech Studio, or REST APIs.

## Speech recognition

The Speaker Recognition service provides algorithms that verify and identify speakers by their unique voice characteristics using voice biometry. It is used to answer the question "who is speaking?" First, you provide audio training data for a single speaker, which creates an enrollment profile based on the unique characteristics of the speaker's voice. You can then cross-check audio voice samples against this profile to verify that the speaker is the same person (speaker verification), or you can cross-check audio voice samples against a group of enrolled speaker profiles to see if it matches any profile in the group (speaker identification). In contrast, Speaker Diarization uses a batch operation to group audio streams by speaker identity, meaning different speakers would each have their own audio segments.

## Transcription

Transcription is a set of REST API operations that enable you to transcribe audio in storage. You can point to audio files with a shared access signature (SAS) URI and asynchronously receive transcription results.

## MRTK speech commands

Like Windows Speech Input, speech input providers don't create any controllers, but instead allow you to define keywords that will raise speech input events when recognized. You will configure the keywords for recognition in the Speech Commands Profile in the Input System Profile. For each command, you can also:

* Select an input action to map to the command. This way you can, for example, make the Keyword Select have the same effect as a left mouse click by mapping both to the same action.
* Specify a key code that will produce the same speech event when pressed.
* Add a localization key that will be used in UWP apps to obtain the localized keyword from the app resources.

## Speech SDK

The Speech software development kit (SDK) exposes many speech service capabilities to empower you to develop speech-enabled applications. The Speech SDK is available in many programming languages and across all platforms. The Speech SDK exposes many features (though not all) from the Speech service. The capabilities of the Speech SDK are often associated with scenarios. The Speech SDK is ideal for real-time and non-real-time scenarios, using local devices, files, Azure blob storage and even input and output streams. When a scenario is not achievable with the Speech SDK, look for a REST API alternative.

## Spatial perception

Spatial perception provides programmatic access to spatial mapping data, giving mixed-reality apps information about surfaces in application-specified regions of space near the user. Declare the spatial perception capability only when your app will explicitly use these surface meshes. The capability is not required for mixed reality apps to perform holographic rendering based on the user’s head pose.

## Internet client server

The Internet client server enables peer-to-peer (P2P) scenarios where the app needs to listen for incoming network connections.

## Private network client server

The private network client server provides inbound and outbound access to home and work networks through the firewall. This capability is typically used for games that communicate across the local area network (LAN) and for apps that share data across various local devices.
