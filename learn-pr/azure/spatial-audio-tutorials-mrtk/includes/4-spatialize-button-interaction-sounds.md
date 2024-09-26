## Audio feedback

Audio feedback is a positive loop gain that occurs when a sound loop exists between an audio input and an audio output. In this example, a signal the microphone receives is amplified and passed out of the loudspeaker. The microphone can then receive the sound from the loudspeaker again, amplify it further, and pass it out through the loudspeaker again.

## Audio Mixer

The Unity Audio Mixer allows you to mix various audio sources, apply effects, and perform mastering. Audio Mixer is a tree of Audio Mixer Groups. An Audio Mixer group is essentially a mix of audio, a signal chain which allows you to apply volume attenuation and pitch correction; it allows you to insert effects that process the audio signal and change the parameters of the effects. There's also a send and return mechanism to pass the results from one bus to another.

## Spatialization

This setting enables or disables spatialization. Custom specialized effects improve the realism of sound propagation by incorporating the binaural head-related transfer function (HRTF) such that the listener can better sense the directionality of the sound through the filtering of the head and the micro-delays between the ears.
