## Spatialization

An essential element of VR audio is spatialization: the ability to play a sound as if it's positioned at a specific point in three-dimensional space. Spatial audio is essential to deliver an immersive experience because it provides powerful cues that make the user feel they're actually in the 3D environment. The two major components to spatialization are direction and distance.

## Spatial blend

It sets how much this AudioSource is affected by 3D spatialization calculations (attenuation, doppler, and so on.). 0.0 makes the sound full 2D, 1.0 makes it full 3D.

Apart from determining if this AudioSource is heard as a 2D or 3D source, this property is useful to morph between the two modes. 3D spatial calculations are applied after stereo panning is determined and can be used with panStereo. Morphing between the two modes is useful for sounds that should be progressively heard as normal 2D sounds the closer they're to the listener.
