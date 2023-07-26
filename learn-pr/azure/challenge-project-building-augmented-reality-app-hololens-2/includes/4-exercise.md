**Design Considerations:**

Consider the following design aspects while developing the app:

- User Interface (UI) and User Experience (UX): Create a visually appealing and intuitive interface that ensures a seamless user experience.
- Interaction Design: Utilize the unique capabilities of the HoloLens 2, such as gesture recognition, voice commands, spatial mapping, and object tracking, to create interactive and immersive experiences.
- 3D Asset Design: Develop or source 3D assets that align with the app's purpose and enhance the mixed reality experience.
- Color Palette and Typography: Select appropriate colors and typography that complement the app's theme and ensure readability in the MR environment.

Galaxy Explorer Example:

The team behind the Galaxy Explorer app put their design considerations into their documentation [at the Github repository](https://github.com/microsoft/GalaxyExplorer) as they discussed the Application Building Blocks.

:::image type="content" source="../media/galaxy-explorer-building-blocks.png" alt-text="Application building blocks from Galaxy Explorer app.":::

They also provided [a case study](https://learn.microsoft.com/en-us/windows/mixed-reality/out-of-scope/case-study-creating-a-galaxy-in-mixed-reality) around how they thought through the challenge of how to produce a galaxy full of stars without overloading the GPU of the device. Please note, much like Galaxy Explorer, you will be testing out various design considerations as the first interaction you create may not be feasible after doing some prototyping, so most likely this section will be iterated on throughout the process. You should assume that your project document will change over the life of the project, but be sure to include previous approaches so you remember for the next project why you decided to (or not to!) approach a design in a particular way.

**Environmental Considerations:**

Consider the surroundings and conditions in which the app will be used. Consider factors such as ambient lighting, noise, and physical space limitations. Optimize the app's performance to adapt to varying environmental conditions and ensure a consistent experience for users.

Galaxy Explorer Example:

Galaxy Explorer took on a few design assumptions such as a person would not be using the app in the middle of a field on a sunny day. Most likely they would be using it in a confined space room or within a classroom. Contrasting colors would be used where it made sense to provide more fidelity since most things such as stars would be represented in a white color.

Since the space the app would be in would be variable, they provided a menu button to allow a person to maximize or minimize the size of the galaxy as you can see in the image below. Also, the default visual size should be relative to the size and space of the room and not be occluded by any object in the room, thus why the first thing you do in the app is to place the galaxy in your real space.

:::image type="content" source="../media/galaxy-explorer-spectator-view.png" alt-text="Interaction prototyping via a storyboard.":::
