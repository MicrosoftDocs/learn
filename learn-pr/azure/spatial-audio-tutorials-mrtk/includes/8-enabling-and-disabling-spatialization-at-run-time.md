# 8. Enabling and disabling spatialization at run time

## Spatialization

An essential element of VR audio is spatialization: the ability to play a sound as if it is positioned at a specific point in three-dimensional space. Spatial audio is essential to deliver an immersive experience because it provides powerful cues that make the user feel they are actually in the 3D environment. The two key components to spatialization are direction and distance

## Spatial Blend

This sets how much this AudioSource is affected by 3D spatialisation calculations (attenuation, doppler etc). 0.0 makes the sound full 2D, 1.0 makes it full 3D.

Aside from determining if this AudioSource is heard as a 2D or 3D source, this property is useful to morph between the two modes.

3D spatial calculations are applied after stereo panning is determined and can be used in conjunction with panStereo.

Morphing between the 2 modes is useful for sounds that should be progressively heard as normal 2D sounds the closer they are to the listener.

