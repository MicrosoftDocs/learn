::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=b60e004a-3ffc-4535-9fde-e217fcf802d4]

> [!NOTE]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Speech synthesis—also called text-to-speech (TTS)—converts written text into spoken audio. You encounter speech synthesis when virtual assistants read notifications, navigation apps announce directions, or accessibility tools help users consume written content audibly.

Speech synthesis systems process text through four distinct stages. Each stage transforms the input incrementally, building toward a final audio waveform that sounds natural and intelligible.

## Text normalization: Standardize the text 

Text normalization prepares raw text for pronunciation by expanding abbreviations, numbers, and symbols into spoken forms.

Consider the sentence: "*Dr. Smith ordered 3 items for $25.50 on 12/15/2023.*"

A normalization system converts it to: "Doctor Smith ordered three items for twenty-five dollars and fifty cents on December fifteenth, two thousand twenty-three."

Common normalization tasks include:

- Expanding abbreviations ("Dr." becomes "Doctor", "Inc." becomes "Incorporated")
- Converting numbers to words ("3" becomes "three", "25.50" becomes "twenty-five point five zero")
- Handling dates and times ("12/15/2023" becomes "December fifteenth, two thousand twenty-three")
- Processing symbols and special characters ("$" becomes "dollars", "@" becomes "at")
- Resolving homographs based on context ("read" as present tense versus past tense)

Text normalization prevents the system from attempting to pronounce raw symbols or digits, which would produce unnatural or incomprehensible output.

> [!TIP]
> Different domains require specialized normalization rules. Medical text handles drug names and dosages differently than financial text handles currency and percentages.

## Linguistic analysis: Map text to phonemes

Linguistic analysis breaks normalized text into *phonemes* (the smallest units of sound) and determines how to pronounce each word. The linguistic analysis stage:

1. Segments text into words and syllables.
2. Looks up word pronunciations in lexicons (pronunciation dictionaries).
3. Applies G2P rules or neural models to handle unknown words.
4. Marks syllable boundaries and identifies stressed syllables.
5. Determines phonetic context for adjacent sounds.

### Grapheme-to-phoneme conversion

Grapheme-to-phoneme (G2P) conversion maps written letters (*graphemes*) to pronunciation sounds (*phonemes*). English spelling doesn't reliably indicate pronunciation, so G2P systems use both rules and learned patterns.

For example:

- The word "though" converts to /θoʊ/
- The word "through" converts to /θruː/
- The word "cough" converts to /kɔːf/

Each word contains the letters "ough", but the pronunciation differs dramatically.

Modern G2P systems use neural networks trained on pronunciation dictionaries. These models learn patterns between spelling and sound, handling uncommon words, proper names, and regional variations more gracefully than rule-based systems.

When determining phonemes, linguistic analysis often uses a *transformer* model to help consider *context*. For example, the word "*read*" is pronounced differently in "I *read* books" (present tense: /riːd/) versus "I *read* that book yesterday" (past tense: /rɛd/).

## Prosody generation: Determine pronunciation

Prosody refers to the rhythm, stress, and intonation patterns that make speech sound natural. Prosody generation determines **how** to say words, not just **which sounds** to produce.

### Elements of prosody

Prosody encompasses several vocal characteristics:

- **Pitch contours**: Rising or falling pitch patterns that signal questions versus statements
- **Duration**: How long to hold each sound, creating emphasis or natural rhythm
- **Intensity**: Volume variations that highlight important words
- **Pauses**: Breaks between phrases or sentences that aid comprehension
- **Stress patterns**: Which syllables receive emphasis within words and sentences

Prosody has a significant effect on how spoken text is interpreted. For example, consider how the following sentence changes meaning depending on which syllable or word is emphasized:

- "*I* never said he ate the cake."
- "I never said *he* ate the cake."
- "I never said he *ate* the cake."
- "I never said he ate the *cake*."

### Transformer-based prosody prediction

Modern speech synthesis systems use transformer neural networks to predict prosody. Transformers excel at understanding context across entire sentences, not just adjacent words.

#### The prosody generation process:

1. **Input encoding**: The transformer receives the phoneme sequence with linguistic features (punctuation, part of speech, sentence structure)
2. **Contextual analysis**: Self-attention mechanisms identify relationships between words (for example, which noun a pronoun references, where sentence boundaries fall)
3. **Prosody prediction**: The model outputs predicted values for pitch, duration, and energy at each phoneme
4. **Style factors**: The system considers speaking style (neutral, expressive, conversational) and speaker characteristics

Transformers predict prosody by learning from thousands of hours of recorded speech paired with transcripts. The model discovers patterns: questions rise in pitch at the end, commas signal brief pauses, emphasized words lengthen slightly, and sentence-final words often drop in pitch.

#### Factors influencing prosody choices:

- **Syntax**: Clause boundaries indicate where to pause
- **Semantics**: Important concepts receive emphasis
- **Discourse context**: Contrasting information or answers to questions may carry extra stress
- **Speaker identity**: Each voice has characteristic pitch range and speaking rate
- **Emotional tone**: Excitement, concern, or neutrality shape prosodic patterns

The prosody predictions create a target specification: "Produce the phoneme /æ/ at 180 Hz for 80 milliseconds with moderate intensity, then pause for 200 milliseconds."

> [!IMPORTANT]
> Prosody dramatically affects naturalness. Robotic-sounding speech often results from flat, monotone prosody—not from imperfect phoneme pronunciation.

## Speech synthesis: Generate audio

Speech synthesis generates the final audio waveform based on the phoneme sequence and prosody specifications.

### Waveform generation approaches

Modern systems use neural vocoders—deep learning models that generate audio samples directly. Popular vocoder architectures include WaveNet, WaveGlow, and HiFi-GAN.

#### The synthesis process:

1. **Acoustic feature generation**: An acoustic model (often a transformer) converts phonemes and prosody targets into mel-spectrograms—visual representations of sound frequencies over time
2. **Vocoding**: The neural vocoder converts mel-spectrograms into raw audio waveforms (sequences of amplitude values at 16,000-48,000 samples per second)
3. **Post-processing**: The system applies filtering, normalization, or audio effects to match target output specifications

> [!NOTE]
> What makes neural vocoders effective:
>
> - **High fidelity**: Generate audio quality approaching studio recordings
> - **Naturalness**: Capture subtle vocal characteristics like breathiness and voice quality
> - **Efficiency**: Real-time generation on modern hardware (important for interactive applications)
> - **Flexibility**: Adapt to different speakers, languages, and speaking styles

The vocoder essentially performs the inverse of what automatic speech recognition does—while speech recognition converts audio into text, the vocoder converts linguistic representations into audio.

## The complete pipeline in action

When you request speech synthesis for "Dr. Chen's appointment is at 3:00 PM":

1. **Text normalization** expands it to "Doctor Chen's appointment is at three o'clock P M"
2. **Linguistic analysis** converts it to phonemes: /ˈdɑktər ˈtʃɛnz əˈpɔɪntmənt ɪz æt θri əˈklɑk pi ɛm/
3. **Prosody generation** predicts pitch rising slightly on "appointment", a pause after "is", and emphasis on "three"
4. **Speech synthesis** generates an audio waveform matching those specifications

The entire process typically completes in under one second on modern hardware.

::: zone-end
