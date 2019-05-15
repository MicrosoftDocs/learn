If using speaker verification is like the process of presenting a passport, speaker identification is like fingerprint matching, which asks the question: "Of all the fingerprints known to our system, which one matches this fingerprint?"

![Checking a fingerprint](../media/6-speaker-identification-fingerprint.png)

Speaker identification is the ability to determine a speaker in audio content based on acoustic and speech patterns, including speaking style and voice pitch.

In a law-enforcement context, a speaker-identification system might employ *text-independent* enrollment by using voice prints, similar to the use of fingerprints. Speaker identification, in this way, is essentially "open ended." In the fingerprint example, being fingerprinted at any time would provide your "enrollment" into the system.

Many uses of speaker identification fall outside the realm of law enforcement and forensics. As in speaker-verification scenarios, when enrollment is finished, the Speaker Identification service now contains the speaker's *identification profile*.

## Identification profiles

An identification profile is a grouping of text-independent enrollments that are used for speaker identification. Contrary to speaker verification, a speaker doesn't need to choose a specific phrase to use in enrollment or identification.

> [!NOTE]
> Unlike speaker verification, it's not reasonable for speaker identification audio to be created with the same microphone (or even created in the same decade), so there are no requirements or recommendations for input device recording specifications. However, the actual submitted file must still conform to the requirements for format and bitrate.

### The profile

In the Speaker Identification API, an identification profile includes the following properties:

| Property  | Value  |
|---------|---------|
| `identificationProfileId` | A unique profile identifier
| `locale` | The region or culture locale, such as "en-US" |
| `enrollmentSpeechTime` | The total number of seconds of "useful" speech detected in all the enrollment audio files provided |
| `remainingEnrollmentSpeechTime` | The remaining number of seconds of speech needed for a successful enrollment |
| `createdDateTime` | The date and time the profile was created |
| `lastActionDateTime` | The date and time of the last action being taken |
| `enrollmentStatus` | The enrollment status |

### Enrollment status

Other than `identificationProfileId`, the most important property of an identification profile is `enrollmentStatus`. This value shows the current enrollment state and the readiness for speaker identification:

| Value  | Enrollment status |
|---------|---------|
| `enrolling` | A profile is currently enrolling and *is not* ready for identification. |
| `training` | A profile is currently training and *is not* ready for identification. |
| `enrolled` | A profile is currently enrolled and *is* ready for identification. |
