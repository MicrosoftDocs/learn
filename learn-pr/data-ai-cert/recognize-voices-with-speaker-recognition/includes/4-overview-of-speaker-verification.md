If you're a veteran of traveling abroad, you're used to presenting government-issued documents when visiting a new country. Speaker verification is very much like the process of entering a new country with a passport.

![Checking a passport](../media/4-speaker-verification-passport.png)

When you present your passport to the immigration officer, you're claiming that the person in the passport's photo is you. Just like there are regulations for how this photo must be taken, the speaker-verification process usually has guidelines for what your voice print "looks" like. In other words, what you say to generate your voice print is regulated. Most systems use the concept of *verification phrases*.

## Verification phrases

The Speaker Recognition service uses predefined verification phrases to determine the speaker's relevant speech and acoustic patterns and features. The Speaker Recognition service currently supports the following 10 verification phrases for the locale of English (United States):

- "I am going to make them an offer they cannot refuse."
- "Houston, we have a problem."
- "My voice is my passport. Verify me."
- "Apple juice tastes funny after toothpaste."
- "You can get in without your password."
- "You can activate the security system now."
- "My voice is stronger than passwords."
- "My password is not your business."
- "My name is unknown to you."
- "Be yourself. Everyone else is already taken."

> [!NOTE]
> The Speaker Recognition API doesn't currently support custom verification phrases.

Speaker-verification enrollment requires you to record and submit three samples of an identical phrase. For example, you'd be required to repeat the phrase, "Houston, we have a problem," three separate times and then submit those samples to the system.

After you submit the identically phrased samples, your enrollment is considered complete. You can now be verified by using the identical verification phrase.

You might be wondering why an identical verification phrase is required. Why can't the system analyze and evaluate the speech and acoustic patterns of the speaker to determine a voice match? Actually, the system can identify a voice match without the use of an identical verification phrase.

But if any voice sample was allowed, the system would no longer be secure. Someone could record your voice and use that recording to get into the system. Requiring you to remember and use an exactly phrased sample is very much like requiring you to remember a password, your mother's maiden name, the name of your first pet, or the city in which you were born--only better.

When enrollment is complete, the Speaker Recognition system now contains your *verification profile*.

## Verification profiles

A verification profile is a grouping of text-dependent enrollments used for speaker verification. Because a speaker must choose a specific phrase for both enrollment and verification, the resulting profile contains everything necessary for future speaker verification.

> [!TIP]
> Although not absolutely necessary, we recommend using the same microphone for both enrollment and verification.

### The properties of a verification profile

In the Speaker Recognition APIs, a verification profile includes the following properties:

| Property | Value |
|---------|---------|
| `verificationProfileId` | A unique profile identifier |
| `locale` | The region or culture locale, such as "en-US" |
| `enrollmentsCount` | The total number of enrollments created |
| `remainingEnrollmentsCount` | The remaining number of enrollments needed for completion |
| `createdDateTime` | The date and time the profile was created |
| `lastActionDateTime` | The date and time of the last action being taken |
| `enrollmentStatus` | The enrollment status |

### Enrollment status property

Other than `verificationProfileId`, the most important property of a verification profile is `enrollmentStatus`. This value shows the current enrollment state and the readiness for speaker verification:

| Value  | Verification state |
|---------|---------|
| `enrolling` | A profile is currently enrolling and *is not* ready for verification. |
| `training` | A profile is currently training and *is not* ready for verification. |
| `enrolled` | A profile is currently enrolled and *is* ready for verification. |