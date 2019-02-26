To draw on common experience, imagine traveling to another country. Millions of people have had this common experience, and if you're a veteran of traveling abroad, you're used to presenting government-issued documents when visiting a new country. **Speaker verification** is very much like the process of entering a new country with a passport.

![Checking a passport](../media/4-speaker-verification-passport.png)

In this example, a passport provides your "enrollment" into the system, and when you present the passport to the Customs Officer, you're making a "claim" that the person represented in the document (which includes a regulated photo) is you. Just as there are guidelines around "how" this photo is presented (and what the passport document contains) there are (usually) guidelines in the speaker verification process,  around what your voice print "looks" like. To be more specific, what you would "say" to generate your voice print, is regulated. To this end, most systems, including Azure Cognitive Services Speaker Recognition, use the concept of **verification phrases**.

## Verification Phrases

In the Speaker Recognition service, **verification phrases are pre-defined phrases used to extract relevant speech and acoustic patterns and features**. The Speaker Recognition service currently supports the following 10 (10) verification phrases, for the locale of English (United States):

- "I am going to make them an offer they cannot refuse."
- "Houston we have a problem."
- "My voice is my passport verify me."
- "Apple juice tastes funny after toothpaste."
- "You can get in without your password."
- "You can activate security system now."
- "My voice is stronger than passwords."
- "My password is not your business."
- "My name is unknown to you."
- "Be yourself everyone else is already taken."

> [!NOTE]
> The Speaker Recognition API does not currently support custom verification phrases, however it's highly likely custom phrases will be able to be provisioned in later releases.

Speaker verification enrollment requires the recording and **submission of three (3) samples of an identical phrase**. So for example, a speaker would be required to repeat the phrase, "Houston we have a problem." three separate times, and then submit these samples to the system.

Once the identically phrased samples are submitted, an enrollment is considered complete, and future speaker verification is possible, again, using an identical verification phrase.

Now, you may be wondering why an identical verification phrase is required. Why can't the system analyze and evaluate the speech and acoustic patterns to determine the likelihood of a voice "match"? Actually, **the system can identify a voice match without the use of an identical verification phrase**, however, if a system were to allow an "open ended" voice sample, the system would no longer be secure, as ill-meaning people could record your voice and "get in" to the system. Requiring the use of an exactly phrased sample is very much like remembering a password, mother's maiden name, name of your first pet, or the city in which you were born - only better.

When enrollment is complete, the Azure Cognitive Services Speaker Recognition system now contains your **verification profile**.

## Verification Profiles

In Speaker Recognition API terminology, **a verification profile is simply a grouping of text-dependent enrollments for speaker verification**. This means a speaker needs to choose a specific phrase to use in both enrollment and verification, and the result (the verification profile) contains everything necessary to perform future speaker verification.

> [!TIP]
> Although not absolutely necessary, it's recommended to use the same microphone for both enrollment and verification.

### The Profile

In the Speaker Recognition API, a verification profile includes the following properties:

- **Verification Profile ID**: A unique, profile identifier
- **Locale**: The current region/culture locale, such as "en-US"
- **Enrollment count**: The total number of enrollments created
- **Remaining enrollment count**: The remaining number of enrollments needed for completion
- **Created date time**: The date and time the profile was created
- **Last action date time**: The date and time of the last action being taken
- **Enrollment status**: The enrollment status

### Enrollment Status

The most important property, other than the verification identifier, of a verification profile, is the enrollment status, as this value represents the state of possible verification - especially the readiness for speaker verification:

- **Enrolling**: a profile is currently *enrolling* and **is not** ready for verification
- **Training**: a profile is currently training and **is not** ready for verification
- **Enrolled**: a profile is currently enrolled and **is** ready for verification