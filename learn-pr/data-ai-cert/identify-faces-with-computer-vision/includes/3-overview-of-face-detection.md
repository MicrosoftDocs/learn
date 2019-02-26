
The Face API provides methods to detect human faces in images and can return specific face locations, landmarks, and attributes.

- **Locations**: The top, left, height, and width of a region in the image displaying a face.
- **Landmarks**: The position of common face elements, such as pupils, nose, and lips.
- **Attributes**: Estimated attributes of a face, such as age, gender, hair color, smile, facial hair, glasses, and emotion.

## Locations

A **face location** is another term for a collection of _face coordinates_. The location identifies the rectangular pixel area in the image where a face was identified.

![A Face API face location rectangle](../media/3-face-recognition-rectangle.png)

## Landmarks

**Face landmarks** are a collection of detailed points on a face. These points identify common facial elements such as a pupil, nose, or eyebrow in pixel coordinates.

![A chart of Face API landmarks](../media/3-face-recognition-landmarks.png)

> [!TIP]
> Face landmarks are optional attributes that can be analyzed during face detection.

## Attributes

**Face attributes** are pre-defined properties of a face or person represented by a face. The Face API identifies the following types of attributes.

- age
- gender
- smile "intensity"
- facial hair
- head pose (3D)
- emotion

> [!IMPORTANT]
> The Face API detection algorithms are designed to detect faces (and aspects of faces) in images, but aren't designed to do full **facial recognition**. Facial recognition is used to identify a _specific_ face, which this API is not designed to do by itself.
