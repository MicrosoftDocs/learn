The **Speaker Recognition** API in Azure Cognitive Services provides robust machine learning and artificial intelligence-based services focused on **identifying individual speakers** and **leveraging speech as a means of authentication**. These services can be integrated into apps and services using any programming language or operating system.

![Azure Cognitive Services Speaker Recognition](../media/2-overview-of-speaker-recognition-header.png)

Speaker Recognition is divided into two categories: **speaker verification** and **speaker identification** for scenarios such as:

- **Verification**: Automatically verify and authenticate users using their voice or speech
- **Identification**:  Automatically identify the person speaking in an audio file, given a group of prospective speakers

## The Speaker Recognition API
All life forms seem to have built-in, biologically adapted methods of communication. Whether you're a blue whale, a bumblebee, a cicada, or a human - every "voice" is unique. Our planet is filled with over 7,500,000,000 human voices - every one of them unique and distinct from the others.

The Speaker Recognition API provides algorithms, exposed as simple REST-based service calls, to verify and identify human voices, and organizing voices into manageable profiles with just a few simple API calls.

![Verification and identification](../media/2-overview-of-speaker-recognition-identity.png)

The methods provided by the Speaker Recognition API fall into three categories:

1. **Verification** - Check the likelihood that two voices belong to the same person
1. **Identification/Recognition** - Determine whether a voice is recognized as a match against other known voice
1. **Enrollment** - Registering voices to be verified or identified

The Speaker Recognition API is a perfect way to leverage the power of artificial intelligence to:

- Authenticating users before accessing apps and services
- Identifying speakers in video streams
- Identifying speakers in real-time chat scenarios
- Improving security for sensitive resources
- Replacing cumbersome legacy authentication

Speaker recognition is often referred to as "voice recognition". It is the identification of a person from characteristics of their voice. 

> [!NOTE]
> There is a difference between _speaker recognition_ and _speech recognition_. Speech recognition attempts to determine the _content of spoken words_, and speaker recognition attempts to identify the _speaker of the content_.

## Great Acoustics

As one of the earliest efforts in the field of artificial intelligence, speaker recognition is designed to evaluate the vital acoustic features of speech that differ between individuals. Determination of these acoustic patterns depends on things such as the size and shape of the throat and mouth, and identified speech patterns such as speaking style and voice pitch.  

![Great acoustics](../media/3-speaker-recognition-concepts-acoustics.png)

The scientific efforts of speaker verification have resulted in speaker recognition now being classified as "behavioral biometric". Just like the difference between speech recognition and speaker recognition, there is a difference between the act of speaker *verification* and speaker *identification*.

To put these differences in different terms:

- **Speaker verification**: An attempt to determine if a speaker has a **certain "claimed" identity**
- **Speaker identification**: An attempt to determine an **unknown speaker's identity**

In both of these cases, there need to be existing voices, or voice samples, to use for comparison. In speaker recognition terms, the process of creating voice samples is referred to as **enrollment**.

## Enrollment

In speaker recognition, **enrollment** is the process of pre-recording a speaker's voice to extract acoustic and speech patterns that form a _voice print_. A voice print is often referred to as a voice "template" or voice "model". In typical speaker verification scenarios, sample speech "utterances" are pre-recorded to use later when comparing voice prints.

Speaker *identification*, however, is quite a bit trickier - as an utterance is typically newly introduced to the system. For example, a speaker recognition system may be trained to identify the voice of a famous U.S. President, by initially providing samples of inauguration speeches, however recognizing the President from unknown content, such as a State of the Union speech, requires the spoken content to be **compared against multiple voice prints** to determine the best match.

![Identifying U.S. Presidents](../media/3-speaker-recognition-concepts-presidents.png)

Since Azure Cognitive Services Speaker Recognition services provide both verification and identification, and since the "science" behind verification and identification are different, the enrollment process for these processes are separate as well. Behind the scenes, two types of speaker recognition systems are in effect: **text-dependent** and **text-independent**.

- **Text-dependent**: Used for enrollment for verification, where prompts are known and common across all speakers.
- **Text-independent**: Used for enrollment for identification, where there is no (needed) cooperation by the speaker.

> [!NOTE]
> For text-independent scenarios, enrollment often happens without a user's knowledge, as speaker identification systems do not need to compare what was said at enrollment.

The most controlled of these, the text-dependent system, is at the core of **speaker verification**.
