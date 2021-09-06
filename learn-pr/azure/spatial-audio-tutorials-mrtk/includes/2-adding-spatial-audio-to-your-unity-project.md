## HRTF offload

Processing audio using HRTF-based algorithms requires a large amount of specialized computation. HoloLens 2 includes dedicated hardware that can be utilized to avoid burdening the application processor, thus "offloading" the processing of HRTF-based algorithms. The Microsoft spatializer plugin provides an easy way for your application to take advantage of the dedicated HRTF hardware so your application can use more of the application processor for operations other than spatial audio.

## Microsoft spatializer

This component enables control over properties attached to AudioSource components for spatial sound in Unity.

Spatial sound on the HoloLens is enabled using an audio spatializer plugin. The plugin files are bundled directly into Unity so enabling spatial sound is as easy as going to Edit > Audio > Spatializer and enabling the Microsoft HRTF extension. Since Microsoft Spatial Sound only supports sampling rates of 48 kHz currently, you should also set your System Sample Rate to 48000 to prevent an HRTF failure in the rare case that your system output device isn't set to 48000 already.

## Spatial audio

Spatial audio describes a variety of sound playback technologies that make it possible to perceive sound all around you without the need for any specific multiple speaker setup.
