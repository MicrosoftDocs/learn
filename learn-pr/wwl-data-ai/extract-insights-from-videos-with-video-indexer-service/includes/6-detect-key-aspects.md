As lead developer of a social network for travelers, you know that insights can relate to only part of a video. To best use the indexer results, you should understand how Video Indexer maps insights to specific scenes, shots, and keyframes.

## Understand scene, shot, and keyframe

Video indexer identifies temporal segments within the video to improve how you browse and edit indexed videos. The key aspects are extracted based on changes in color, contrast, and other semantic properties.

The detected segments are organized as a hierarchy. Video Indexer processes the video file into one or more scenes. Each scene is made up of one or more shots. Within the shot, keyframes are determined.

:::image type="content" source="../media/video-indexer-scene-hierarchy-dg.png" alt-text="Diagram showing hierarchy of video segments: scenes, shots, and keyframes.":::

The following image shows an example of this segmentation on a video with multiple scenes of ocean waves. The indexing process detected key sections of the video even though the visual is similar throughout the video.

:::image type="content" source="../media/video-indexer-scenes-ss.png" alt-text="Screen shot of detected scenes from the Video Indexer portal showing scenes, shots, and keyframes.":::

### Scene

A scene represents a single event within the video. It groups consecutive shots that are related. It will have a start time, end time, and thumbnail (first keyframe in the scene).

### Shot

A shot represents a continuous segment of the video. Transitions within the video are detected which determine how it is split into shots. Shots have a start time, end time, and list of keyframes.

### Keyframe

Keyframes are frames that represent the shot. Each one is for a specific point in time. There can be gaps in time between keyframes but together they are representative of the shot. Each keyframe can be downloaded as a high-resolution image.

### Scene segmentation in the API response

The split of a video into scenes, shots, and keyframes is included in the insights that were examined previously. The response includes several attributes for each scene, shot, and keyframe that was detected. The same information you see when browsing scenes in the portal is available in the insights JSON.
