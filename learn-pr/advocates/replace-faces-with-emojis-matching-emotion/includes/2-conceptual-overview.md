There's some high-level questions worth answering before you get into setting up and writing code.

## How do you map an emotion to an emoji?

Imagine there were only two emotions, fear and happiness, with values ranging from 0 to 1. This lets you plot any face in a 2D _emotional space_ based on the emotion of the user, like so:

![A simple graph. Happiness is on the y axis, fear is on the x axis, and the same sample image of a man's face from the introduction unit is plotted about 1/4 up, 3/4 to the right in white space.](../media/graph-1.jpg)

You can use this to figure out the emotional point for each emoji just like you did for the face. After you plot the emojis in the 2D emotional space, you can figure out which emoji is closest to the emotion in the picture.

![An updated version of the previous graph is shown with various emoji plotted at different points on the happiness-to-fear scale. Some of these include a smiling emoji with heart eyes higher up the happiness axis and lower on the fear axis, a nervous emoji further on the fear axis and lower on the happiness axis, and a crying emoji low on happiness and high on fear.](../media/graph-2.png)

This calculation is called the _Euclidian distance_. You won't just use this in a 2D space, but rather in an 8D emotional space, measuring anger, contempt, disgust, fear, happiness, neutral, sadness, and surprise.

> [!Tip]
> To make like easier we used the npm package called [euclidean-distance](https://www.npmjs.com/package/euclidean-distance?azure-portal=true).

## How do you calculate the emotion of a face?

### The Face API

Calculating emotion is, surprisingly, one of the most accessible parts of your app. The Azure AI services [Face API](https://azure.microsoft.com/pricing/details/cognitive-services/face-api/) takes image input and returns information about it, including whether a face was detected and its location. If requested, it calculates and returns the emotions of the faces as well, like so:

```json
{
  "anger": 0.572,
  "contempt": 0.025,
  "disgust": 0.242,
  "fear": 0.001,
  "happiness": 0.014,
  "neutral": 0.111,
  "sadness": 0.033,
  "surprise": 0.003
}
```

Take for instance this image:

![A closeup image of a woman's face. She has brown hair, glasses, and is smiling while looking directly at the viewer.](../media/example-face.jpg)

To process this image, you make a POST request to an API endpoint, like this one:

 `https://westcentralus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=false&returnFaceLandmarks=false&returnFaceAttributes=emotion`

You provide the image in the body:

```json
{
  "url": "<path-to-image>"
}
```

> [!Note]
> The API doesn’t return the emotion by default. You need to explicitly specify the query parameter `returnFaceAttributes=emotion`.

The use of a secret key authenticates the API. You need to send this key with the header.

```
Ocp-Apim-Subscription-Key: <your-subscription-key>
```

The API with the query parameters above would return a JSON, like so:

```json
[
  {
    "faceRectangle": {
      "top": 207,
      "left": 198,
      "width": 229,
      "height": 229
    },
    "faceAttributes": {
      "emotion": {
        "anger": 0.001,
        "contempt": 0.014,
        "disgust": 0,
        "fear": 0,
        "happiness": 0.306,
        "neutral": 0.675,
        "sadness": 0.003,
        "surprise": 0.001
      }
    }
  }
]
```

It returns an array of results - one per face detected in the image. Each result contains the size and location of the face as `faceRectangle` and the emotions represented as `faceAttributes` as a number from 0 to 1.

The calls to the Face API are wrapped into convenience functions for you in the [Mojifier code repo](https://github.com/MicrosoftDocs/mslearn-the-mojifier/blob/master/shared/faceapi/index.ts?azure-portal=true)

### EmotivePoint class

If you look closely at the `EmotivePoint` class in [shared/emotivePoint.ts](https://github.com/MicrosoftDocs/mslearn-the-mojifier/blob/master/shared/models/emotivePoint.ts?azure-portal=true), you will notice a few things.

The constructor takes an object containing emotive information as input and stores it as local member variables, like so:

```typescript
 constructor({
    anger,
    contempt,
    disgust,
    fear,
    happiness,
    neutral,
    sadness,
    surprise
  }) {
    this.anger = anger;
    this.contempt = contempt;
    this.disgust = disgust;
    this.fear = fear;
    this.happiness = happiness;
    this.neutral = neutral;
    this.sadness = sadness;
    this.surprise = surprise;
  }
```

It also has a function called `distance`, which we can use to calculate the Euclidean distance between two emotive points, like so:

```typescript
  distance(other) {
    let myPoint = this.toArray();
    let otherPoint = other.toArray();
    return distance(myPoint, otherPoint);
  }
```

Using this information, you can create two emotive points and calculate how close they are:

```typescript
let a = new EmotivePoint({
  /* ... */
});
let b = new EmotivePoint({
  /* ... */
});
let distance = a.distance(b);
```

### Face class

Another helper class is the `Face` class, which combines a few different properties, including the `EmotivePoint` of a face and the `Rect` class, which is the rectangle that defines the boundaries of the face.

If you review the `Face` class constructor in [shared/face.ts](https://github.com/MicrosoftDocs/mslearn-the-mojifier/blob/master/shared/models/faces.ts?azure-portal=true), you'll see this line of code:

```typescript
this.moji = this.chooseMoji(this.emotivePoint);
```

- `emotivePoint` is the emotive point of the face itself.
- `chooseMoji` returns an appropriate emoji based on the `emotivePoint` of the face.

```typescript
  chooseMoji(point) {
    let closestMoji = null;
    let closestDistance = Number.MAX_VALUE;
    for (let moji of MOJIS) {
      let emoPoint = moji.emotiveValues;
      let distance = emoPoint.distance(point);
      if (distance < closestDistance) {
        closestMoji = moji;
        closestDistance = distance;
      }
    }
    return closestMoji;
  }
```

- `MOJIS` is the list of emotive coordinates for all the emojis. These are generated from a set a [proxy images](https://github.com/MicrosoftDocs/mslearn-the-mojifier/blob/master/shared/proxy-images?azure-portal=true) approximating the emotions of each emoji. You can generate your own set of proxy images and calibrate the set of emoji emotional coordinates later in this module, as an optional step.
- The `chooseMoji` function calculates the distance between this face and the emojis, returning the closest one.
