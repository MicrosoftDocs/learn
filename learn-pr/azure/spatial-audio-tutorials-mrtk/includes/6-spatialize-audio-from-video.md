## Transcode

When you enable transcoding, the source is transcoded into a format that's compatible with the target platform. When you disable it, the original content is used, bypassing the potentially lengthy transcoding process.

## Spatial quality

This setting dictates whether video images are reduced in size during transcoding, which means they take up less storage space. However, resizing images also results in blurriness during playback.

* **Low Spatial Quality**: The image is reduced in size during transcoding (typically to a quarter of its original dimensions) and then expanded back to its original size upon playback. This is the highest amount of resizing, meaning it saves the most storage space but results in the largest amount of blurriness upon playback.
* **Medium Spatial Quality**: The image is moderately reduced in size during transcoding (typically to half of its original dimensions) and then expanded back to its original size upon playback. Although there's some resizing, images will be less blurry than those that use the Low Spatial Quality option, and there's some reduction in required storage space.
* **High Spatial Quality**: No resizing takes place if this option is selected. This means the image isn't reduced in size during transcoding, and therefore the video’s original level of visual clarity is maintained.

## Render texture

A Render Texture is a type of Texture that Unity creates updates at run time. To use a Render Texture, create a new Render Texture using **Assets > Create > Render Texture** and assign it to Target Texture in your Camera component. Then you can use the Render Texture in a Material just like a regular Texture.
