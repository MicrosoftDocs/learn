## Spatial audio

Spatial audio describes a variety of sound playback technologies that make it possible to perceive sound all around you without the need for any specific multiple speaker setup. For an understanding of what it means to spatialize sounds and recommendations for when it can be helpful, see [spatial sound design](/windows/mixed-reality/spatial-sound-design).

## HRTF offload

Processing audio using HRTF-based algorithms requires a large amount of specialized computation. HoloLens 2 includes dedicated hardware that can be utilized to avoid burdening the application processor, thus "offloading" the processing of HRTF-based algorithms. The Microsoft spatializer plugin provides an easy way for your application to take advantage of the dedicated HRTF hardware so your application can use more of the application processor for operations other than spatial audio.

## Microsoft spatializer

Spatial sound on the HoloLens is enabled using an audio spatializer plugin. It is recommended to use the [Microsoft Spatializer plugin](https://github.com/microsoft/spatialaudio-unity), which can be added via the Mixed Reality Feature Tool.