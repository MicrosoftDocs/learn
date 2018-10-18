You can’t pass an image of the emoji to the Face API to get its emotion because it's not a human face. So for each emoji, you need an emotive coordinate.

We have used a very simple method of generating emotive coordinates in the module. This method

- Takes one real face with an expression approximating that of the emoji. We call this the proxy image.
- Runs it through the Azure Face API
- Uses the result of that operation as the emotive coordinates for the emoji

In this unit, we demonstrate how you can substitute your own proxy images, and re-calibrate the emoji emotive coordinates.

As an extension, you could also devise more a more rigorous method of performing this mapping, by training with many sets of images, for example.

## Proxy Images

You can see the list of proxy images for each emoji in the `shared/proxy-images` folder in the sample code.

![A set of paired images of some of the Cloud Developer Advocates making various expressive faces next to their matching mojified images.](../media/team.jpg)

These proxy images were passed to the Face API to generate emotive points, which were then associated with an emoji image. You can see the results of the supplied set of proxy images in the `MOJIS` array in the `shared/models/mojis.ts` file in the source code.

## Create your own proxy images for emojis

>[!NOTE]
> You can use your own images if you prefer. It can be fun to mojify yourself or your teammates at work in Slack!

If you plan to use your own images, then take a picture of yourself mimicking each emoji in the `shared/proxy-images` folder and replace the original set of images.

## Create an Azure function to calibrate your proxy images

Just as you did for the `MojifyImage` and the `RespondToSlackCommand` function, create another function called `Calibrate`.

Replace the index.js file with a file called index.ts, and copy the following code into this file:

```typescript
import { EmotivePoint } from "../shared/models/emotivePoint";
import { Face } from "../shared/models/faces";
import * as FaceApi from "../shared/faceapi";
import * as emojiLookup from "emoji-dictionary";

const EMOJIS_TO_TRAIN = [
  "☺️",
  "🤓",
  "😃",
  "😆",
  "😉",
  "😍",
  "😎",
  "😐",
  "😕",
  "😖",
  "😘",
  "😜",
  "😝",
  "😠",
  "😧",
  "😩",
  "😬",
  "😭",
  "😱",
  "😳",
  "😴"
];

async function getCalibrationArrayString(context) {
  let str = "[";

  for (let emoji of EMOJIS_TO_TRAIN) {
    context.log(`Processing ${emoji}`);
    // Given an emoji like 😴 returns the word version, like 'sleepy'
    let emojiName = emojiLookup.getName(emoji);
    let emotion = await FaceApi.getEmotionFromLocalProxyImage(context, emojiName);
    let point = new EmotivePoint(emotion);
    let face = new Face(point, null);
    str += `{
        emotiveValues: new EmotivePoint({
            anger: ${emotion.anger},
            contempt: ${emotion.contempt},
            disgust: ${emotion.disgust},
            fear: ${emotion.fear},
            happiness: ${emotion.happiness},
            neutral: ${emotion.neutral},
            sadness: ${emotion.sadness},
            surprise: ${emotion.surprise}
        }),
        emojiIcon: "${emoji}"
      },`;
  }
  str += "]";
  return str;
}

export async function index(context, req) {
    context.log(`Calibrate HTTP trigger`);

    const array = await getCalibrationArrayString(context);
    const body = {MOJIS: array};

    context.res = {
      status: 200,
      headers: {
        "Content-Type": "application/json"
      },
      body: body
    };
}
```

## Try it out

Now comes the fun part! We are going to run each of the images in the `shared/proxy-images` through the Face API to calculate an emotional point for that emoji in emotional space.

Make sure the function app is running by starting it from the debug menu or running it from the terminal.
```bash
func host start
```

Run the new `Calibrate` function by connecting to: http://localhost:7071/api/Calibrate.

> [!NOTE]
> The Face API restricts the rate at which it can be called. If the rate limit is exceed the code will wait 30 seconds and try again. Since the calibrate function is make calls in quick succession you may hit this rate limit, and see that the Calibrate function takes a minute or two to execute.

The output of the command is displayed in your browser window, as json array of emotive points. You can try out different proxy images, and see the change in the emotive points. You can also copy this array back into `shared/models/mojis.ts`, redeploy your function app, so that you are using your own proxy images in your slack `/mojify` command.
