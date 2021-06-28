<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: none

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-learning-unit-introduction-format)
-->
WebXR is a technology that helps bring VR and AR functionality to the web. The WebXR Device API at its core handles the logic for interfacing with devices which support VR or AR. 

In the scenario of the amusement park application, the company wants the VR/AR application to be easily accessible through a browser connected to the internet. WebXR is the perfect technology to fulfill this need.

Here, you will learn about the WebXR support and features provided in Babylon.js.

<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=master)
-->

<!-- Pattern for simple chunks (repeat as needed) -->
## WebXR in Babylon.js

Babylon.js is a powerful 3D rendering engine packed into a Javascript framework. Other than its main features such as rendering 3D meshes and animations, the framework also provides support for WebXR.

The WebXR experience can be enabled for a Babylon.js scene in one line:

```javascript
await scene.createDefaultXRExperienceAsync();
```

By default, this line of code enables WebXR support in the immersive VR mode. To enable the support for WebXR support in the AR mode:

```javascript
await scene.createDefaultXRExperienceAsync({
    uiOptions: {
        sessionMode: "immersive-ar",
    },
});
```

After WebXR is enabled using this function, if the Babylon.js application is opened on a browser and device that supports WebXR in the specified mode (VR or AR), an XR button will appear in the bottom-right corner of the page:

:::image type="content" source="../media/webxr-button.jpg" alt-text="An empty Babylon J S scene with an X R button in the bottom right corner.":::

One can then enter the VR or AR session by pressing on that button.

### WebXR Session Manager
Strong lead sentence; remainder of paragraph.
Visual (image, table, list)
### WebXR Camera
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)
### AR: Background Remover
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->