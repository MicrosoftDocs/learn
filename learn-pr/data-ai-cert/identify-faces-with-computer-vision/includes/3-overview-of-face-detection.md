The Face API provides methods to detect human faces in images and can return face locations, landmarks, and attributes:

- **Locations**: In the image that includes a face, the Face API finds the top, left, width, and height coordinates of the face region.
- **Landmarks**: The Face API finds the position of common face elements, such as pupils, nose, and lips.
- **Attributes**: The Face API estimates face attributes such as age, gender, hair color, smile, facial hair, glasses, and emotion.

## Locations

A *face location* is another term for a collection of _face coordinates_. The location is a rectangular pixel area in the image where a face has been identified.

![A Face API face location rectangle](../media/3-face-recognition-rectangle.png)

## Landmarks

*Face landmarks* are a collection of detailed points on a face. These points identify common facial elements such as a pupil, nose, or eyebrow by using pixel coordinates.

![A chart of Face API landmarks](../media/3-face-recognition-landmarks.png)

> [!TIP]
> Face landmarks are optional attributes that you can analyze during face detection.

## Attributes

*Face attributes* are predefined properties of a face or a person represented by a face. The Face API identifies the following types of attributes:

- Age
- Gender
- Smile intensity
- Facial hair
- Head pose (3D)
- Emotion

> [!IMPORTANT]
> The Face API detection algorithms are designed to detect faces (and aspects of faces) in images. They aren't designed to do full *facial recognition* by themselves. Facial recognition identifies a _specific_ face.
