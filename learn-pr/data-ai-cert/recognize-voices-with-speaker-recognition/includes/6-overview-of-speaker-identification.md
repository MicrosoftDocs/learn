If using speaker verification is similar to the process of presenting a passport, speaker identification is like fingerprint matching: "Which, of all the fingerprints known to our system, is a match for the fingerprint discovered?"

![Checking a fingerprint](../media/6-speaker-identification-fingerprint.png)

A typically forensic analysis process might employ **text-independent** enrollment, similar to the use of a fingerprint, however using a voice print. Asking, instead, "Which, of all these voices known to our system, is a match for the voice being heard?" Speaker identification, in this way, is essentially "open ended". In this example, being fingerprinted at any time would provide your "enrollment" into the system.

Most of the fun of using speaker identification falls outside the realm of law enforcement and forensics, and is just the ability to determine a speaker in audio content, based, again, on acoustic and speech patterns, including speaking style and voice pitch.

As in speaker verification scenarios, when enrollment is complete, the Azure Cognitive Services Speaker Identification system now contains your **identification profile**.

## Identification Profiles

In Speaker Recognition API terminology, an **identification profile** is simply a grouping of text-independent enrollments for speaker identification. Contrary to speaker verification, a speaker **does not** need to choose a specific phrase to use in enrollment or identification. The result is an identification profile that contains everything necessary to perform future speaker identification.

> [!NOTE]
> Unlike speaker verification, it's not reasonable for speaker identification audio to be created with the same microphone (or even created in the same decade) so there are no requirements or recommendations around input or device specifications.

### The Profile

In the Speaker Recognition API, an identification profile includes the following properties:

- **Identification Profile ID**: A unique, profile identifier
- **Locale**: The current region/culture locale, such as "en-US"
- **Enrollment speech time**: The total number of seconds of "useful" speech detected in all enrollment audio files provided
- **Remaining enrollment speech time**: The remaining number of seconds of speech needed for a successful enrollment
- **Created date time**: The date and time the profile was created
- **Last action date time**: The date and time of the last action being taken
- **Enrollment status**: The enrollment status

### Enrollment Status

Again, the most important property (other than the identification identifier) of an identification profile, is the enrollment status, as this value represents the state of possible identification, especially the readiness for speaker identification:

- **Enrolling**: a profile is currently *enrolling* and **is not** ready for identification
- **Training**: a profile is currently training and **is not** ready for identification
- **Enrolled**: a profile is currently enrolled and **is** ready for identification