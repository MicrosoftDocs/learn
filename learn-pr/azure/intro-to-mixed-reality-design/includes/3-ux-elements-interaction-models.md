As a designer, you go through a delightful journey of turning an abstract idea or concept into a solid working model. In addition, you convert user and business goals into great-looking visuals. You have an opportunity to identify the growth potential for the current product or explore changes to generate an entirely new design concept as you move through the UX design process. You must incorporate practical design ideas during this process to provide the best possible user experience.

## Foundational elements

Let's go back to the basics and understand the fundamentals before diving deep into mixed reality design. We start by learning about a few foundational elements that guide you through creating a tremendous mixed reality experience.

### Color, lighting, and materials

Color, lighting, and materials play a crucial role in designing visual assets for mixed reality. It's challenging and different from the familiar process of designing for nonimmersive devices. For example, you might have to use the right light and materials to set the tone for your environment or use striking colors to represent some form of action. Here are some guidelines to render assets on both immersive and holographic headsets.

:::image type="content" source="../media/color-light-material.png" alt-text="Photo of people working together with HoloLens for color, light, and material." lightbox="../media/color-light-material.png":::

- **Rendering**: Compared to holographic headsets, the content displayed in immersive headsets appears visually different. Holographic headsets, such as the HoloLens, use color-sequential, see-through RGB displays to create holograms, while immersive headsets normally render content as one would on a 2D screen.

  - **Holographic devices have additive displays**: Holograms are made by combining light from the real world with artificial light. White is seen as bright, while black appears transparent.

  - **Colors impact varies with the user's environment**: The user's space has a wide range of lighting conditions. To improve clarity, use suitable degrees of contrast in your content.

  - **Avoid dynamic lighting**: The most efficient holograms in holographic experiences are consistently lighted. Unfortunately, mobile devices are unlikely to handle complex and dynamic lighting. We recommend the Mixed Reality Toolkit standard shader<sup>2</sup>.

- **Designing with color**: Certain colors might seem different on holographic displays due to the nature of additive lighting. In certain lighting conditions, some colors stand out more than others. Warm colors jump to the foreground while cool hues fade into the background. Consider the following criteria as you examine color in your design journey:

  :::image type="content" source="../media/design-color.png" alt-text="Screenshot of designing with light and dark colors." lightbox="../media/design-color.png":::

  - **Rendering light colors**: Light colors should be used moderately because white is bright. Large, bright areas might cause eye irritation. Dark colors are recommended for the backplate of UI windows.

  - **Rendering dark colors**: Dark colors seem translucent on additive screens due to the nature of additive displays. Pure black (#000000) color is transparent and isn't displayed on the additive display.

  - **Color uniformity**: Holograms are often produced brightly to retain color consistency regardless of the background. Designers should avoid large areas of vivid and solid color. For more information, see challenges with bright color on a large surface<sup>3</sup>

- **Storytelling with light and color**: Light and color can help your holograms blend in more naturally with the user's surroundings while also providing guidance and assistance. Consider the following aspects as you explore lighting and color for holographic experiences:

  :::image type="content" source="../media/story-telling-color.png" alt-text="Screenshot of story telling with light and color." lightbox="../media/story-telling-color.png":::

  - **Vignetting**: Darkening materials with a vignette effect might draw the user's attention to the center of the field of view. This effect darkens the hologram's material at a certain distance from the user's sight vector. Viewing the holograms from an oblique or glancing angle is effective.

  - **Emphasis**: Contrast colors, brightness, and lighting to draw attention to objects or interaction points.

- **Materials**: Materials are essential in creating realistic holograms. You might create interesting holographic objects that mix well with the physical world by giving them the right visual features. Materials are also necessary for delivering visual feedback for various user input activities. Since there's no physical feedback on holographic objects, providing visual feedback through materials is essential, especially for the direct interactions with hand-tracking input. For example, the holographic button UI in HoloLens 2 offers the following elements to improve the user's interaction confidence.

  > [!VIDEO https://www.microsoft.com/videoplayer/embed/RWJHgW ]

  - Proximity light
  - Hover light
  - Compressing button box
  - Focus highlight
  - Pulse effect on trigger

### Scale

The scale plays an important role in mixed reality for creating immersive experiences. Holograms with unrealistic scaling can destroy the entire immersive experience. The key to displaying realistic holographic content is to align with the physical measurements of the real environment closely. Use visual cues to help users determine the size and composition of objects and where they are in the real world.

There are various ways to convey an object's size, some of which might affect other perceptual characteristics. The most important is to show objects in *real* size and keep to that size when a user walks about in space. Holograms, like physical objects, take up a different portion of the user's visual angle as the user moves closer or further away.

- **Use the distance of objects**: A large object placed close to the user could create discomfort issues, as the user needs to move both the head and body to see the whole object. If the objects are placed further away, the users can estimate their size by seeing the whole object in their field of view. Users could then move closer to the object for a more detailed inspection. Place objects 1-2 meters away from the user for comfortable initial discovery and observation.

  :::image type="content" source="../media/use-distance-object.png" alt-text="Screenshot of hologram depicting how to scale according to the situation." lightbox="../media/use-distance-object.png":::

- **Modify a user's real space**: Another option uses holograms to alter users' physical space by replacing existing walls or ceilings with holograms or adding holographic *holes* or *windows*. Oversized holograms can now appear to *break-through* the actual physical space.

  :::image type="content" source="../media/modify-real-space.png" alt-text="Screenshot of hologram depicting how to use real space." lightbox="../media/modify-real-space.png":::

### Typography

In your app experience, texts are essential for presenting information content. Texts need to be clear and readable, just like the typography on 2D screens. We use 2D text types for better legibility and readability, although we're designing mixed reality applications.

:::image type="content" source="../media/typography.png" alt-text="Screenshot of Periodic Table typography used in mixed reality." lightbox="../media/typography.png":::

The rules of typography in mixed reality are the same as everywhere else. The text must be readable and legible in real and virtual worlds. Texts can be displayed on a wall or superimposed on a physical object. They can also be floating alongside a digital user interface. We use the same typographic standards for reading and recognition regardless of context. Here are a few tips on how to correctly include typography in your application:

- Build contrast and hierarchy by using different type-sizes and weights.

- Avoid using more than two different font families in a single context.

- Avoid using light or semi-light font weights for type sizes under 42 pt because thin vertical strokes can vibrate and become illegible.

- Use white texts on a dark or colored backplate to improve the user's focus and minimize distractions from the physical background.

### Sounds

Including sounds in your application can create a more immersive experience for the user. Users can experience real connections with the application through sound experiences. You can use sound to inform and reinforce a user's mental model of the application's current state. When appropriate, use sound spatialization in the mixed-reality world. With audio and visuals, you can create great experiences in user interactions and thus increase user confidence in using your application.

Because mixed reality applications lack a tactile interface, adding sound can reinforce interactions, and create better-informed user experiences compared to 2D applications.

## Interaction models

The mixed reality platform is built on the philosophy of fundamental, natural, and intuitive user interactions. There are three measures to ensure that app designers and developers can provide great experiences to their customers.

:::image type="content" source="../media/interaction-model.png" alt-text="Screenshot of hologram interactions in mixed reality." lightbox="../media/interaction-model.png":::

- The sensors and input technologies combine into multimodal interaction models. These interaction models include hand and eye tracking along with natural language input.

- The interaction models work across devices, even if the input technology varies on each device. For example, far interaction on a Windows Immersive headset with a 6DoF controller and HoloLens 2 uses identical affordances and patterns. The interaction models provide a natural feel to user interactions and make cross-device application development easy.

- You should employ a single interaction model in an application intentionally. It's the best way to ensure users have a great experience going from one immersive device to another.

The interaction models are, in many ways, the user's mental models of how to go through a workflow. Each interaction model can be designed for a particular users' need. When these interaction models are used effectively in your application, users find your application convenient, powerful, and usable. 

The three core interaction models described in this table are appropriate for most mixed reality scenarios. For detailed information on each interaction model, see the specified links in the **Additional reading** section at the end of this learn module.

| Model | Example scenarios | Fit | Hardware |
| ----- | ----- | ----- | ----- |
| Hands and motion controllers<sup>4</sup> | 3D spatial experiences, such as spatial layout and design, content manipulation, or simulation. | Great for new users coupled with voice, eye tracking, or head gaze. Low learning curve. Consistent UX across hand tracking and 6DoF controllers. | HoloLens 2 Immersive headsets |
| Hands-free<sup>5</sup> | Contextual experiences where a user's hands are occupied, such as on-the-job learning and maintenance. | Some learning is required. The device pairs well with voice and natural language if hands are unavailable. | HoloLens 2, HoloLens (1st gen), and Immersive headsets |
| Gaze and commit<sup>6</sup> | Click-through experiences, for example, 3D presentations, demos. | Requires training on head-mounted displays but not on mobile. Best for accessible controllers. Best for HoloLens (1st gen). | HoloLens 2, HoloLens (1st gen), Immersive headsets, and Mobile AR |

## Controls and behaviors

Here are a few crucial building blocks for spatial interactions and UI in mixed reality. These building blocks are used in many mixed reality apps for various industrial scenarios.

### Cursors

A cursor offers continuous feedback depending on the user's current focus. The area, hologram, or point in the virtual environment that responds to input is called cursor feedback. Even though the cursor is a digital representation of where the device believes the user's attention is focused. The cursor can provide more visual feedback based on the user's different intentions or target object's capabilities, indicating grabbable, movable, resizable, etc. The cursor feedback also informs users about the system's expected replies. You can utilize the feedback to tell the device what they want, boosting user confidence.

:::image type="content" source="../media/cursor.png" alt-text="Screenshot of cursor attached to holographic objects." lightbox="../media/cursor.png":::

### Button

The button is the most fundamental UI component in mixed reality. Users can trigger immediate actions using buttons. Since no physical interaction is happening, it's essential to provide enough visual, and audio feedback to maintain user confidence. For example, HoloLens 2 integrates multiple visual affordances and audio cues that help users' depth perception and interaction in space. It's important to support different interaction options for buttons in mixed reality. By default, we recommend that you support voice commands for all button controls. In addition, HoloLens 2's button design provides a tooltip during the hover state to improve discoverability.

:::image type="content" source="../media/button.png" alt-text="Screenshot of a button." lightbox="../media/button.png":::

### Bounding box

In mixed reality, the bounding box is a standard interface for manipulating objects. This feature serves as a visual cue that the user can now manipulate and change the object. The bounding box's corners indicate that the object can scale. The scale-adjustment handles follow a well-known design. The vertical rectangular resources on the edges of the bounding box are rotation indicators. These indicators allow users to adjust the size and rotation of holograms. On HoloLens 2, the bounding box works with direct hand manipulation and responds to the user's finger proximity. In addition, visual feedback helps the user to perceive the distance from the object.

:::image type="content" source="../media/bounding-box.png" alt-text="Screenshot of bounding box." lightbox="../media/bounding-box.png":::

### Hand menu

You can also bring up the hand-attached UI with some gestures. The hand menu is one of the unique UX patterns in HoloLens 2 applications. Since it's accessible anytime and can show or hide easily, the hand menu is excellent for quick actions.

:::image type="content" source="../media/hand-menu.png" alt-text="Screenshot of the hand menu." lightbox="../media/hand-menu.png":::

Here are the best practices on what features to include on hand menus:

- Use the hand menu for quick action.

- Keep the number of buttons small.

- Consider supporting one-handed or hands-free operation.

- Avoid adding buttons near the wrist. If the hand menu buttons are placed too close to the wrist, it might accidentally trigger the home button while interacting with the hand menu.

- Display the hand menu outside the palm alongside the pinky finger and face the user. This specific menu placement allows the opposite hand to naturally and comfortably interact with the menu buttons.

### Near menu

A near menu is a group of buttons on a panel that tags-along<sup>7</sup> with your app user. The user can comfortably engage with the near menu because it keeps within a predetermined distance range and angle. To deactivate the panel's tag-along behavior, use the pin button or grab and put the menu to world-lock. When the menu is pinned, your users can focus on important tasks without being distracted. To reactivate the tag-along menu feature, press the pin button again.

:::image type="content" source="../media/near-menu.png" alt-text="Screenshot of near menu" lightbox="../media/near-menu.png":::

### Billboarding and tag-along

:::image type="content" source="../media/billboarding-tag-along.gif" alt-text="Animated gif image of billboarding and tag along." lightbox="../media/billboarding-tag-along.gif":::

**Billboarding** is a mixed reality behavioral idea that can be applied to items. Billboarded objects always face the user. Normally, as users move around in space, the users' view of static objects placed in the environment (world-locked) can be easily obstructed. Billboarding is often applied to texts and menu panels. Objects with billboarding turned on can turn towards the user. Depending on the design, they can also be restricted to a single axis.

**Tag-along** is a behavior you can apply to holograms. A tag-along object tries to stay within a distance range that allows users to interact with it easily.

Tag-along objects include parameters that can be used to fine-tune their behavior. As users move around in the physical environment, holographic content can be in or out of the user's field of view. The hologram tries to stay within the user's peripheral vision by sliding towards the view's edge. The user's movements might temporarily hide the content. When the user looks at the tag-along object, it becomes more visible. Consider the holographic content that is constantly "a glance away" that users are always aware of the direction in which the object is heading.

Numerous other UI components are exclusively supported in mixed reality - UI components<sup>8</sup>

## Reference

2-8 See the **Additional reading** section at the end of this learn module.