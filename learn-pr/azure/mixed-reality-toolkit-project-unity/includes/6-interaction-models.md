The Mixed Reality Toolkit enables you to consume inputs from a variety of input sources such as controllers, articulated hands, or speech. Choosing the interaction model that's best suited for your mixed reality experience requires you to identify your user, their goals and consider any situational or environmental factors, which may impact their experience. Here you'll learn about the three primary interaction models for mixed reality experiences and how to simulate input in Unity.

## Interaction models

There are three primary interaction models which suit the majority of mixed reality experiences.

|Model  |Example scenarios  |Fit  |
|---------|---------|---------|
|Hands and motion controllers     | 3D spatial experiences, such as spatial layout and design, content manipulation, or simulation.        |    Great for new users coupled with voice, eye tracking or head gaze. Low learning curve. Consistent UX across hand tracking and 6DoF controllers.     |
|Hands-free     |     Contextual experiences where a user's hands are occupied, such as on-the-job learning and maintenance.    |    Some learning required. If hands are unavailable, the device pairs well with voice and natural language.     |
|Gaze and commit     |     Click-through experiences, for example, 3D presentations, demos.    |   Requires training on head-mounted devices but not on mobile. Best for accessible controllers.       |

Although you could combine parts of multiple interaction models into your mixed reality experience, be aware that doing so creates the risk of competing user input, such as simultaneous hand rays and a head-gaze cursor. This can overwhelm and confuse users.

If your experience does require multiple interaction models, keep in mind that many users might encounter difficulty when transitioning from one model to another, especially users who are new to mixed reality.

## Hands and motion controllers model

The hands and motion controllers model requires users to use one or two hands to interact with the holographic world. This model removes the boundary between virtual and physical.

Some specific scenarios include:

- Providing information workers 2D virtual screens with UI affordances to display and control content
- Providing Firstline Workers tutorials and guides for factory assembly lines
- Developing professional tools for assisting and educating medical professionals
- Using 3D virtual objects to decorate the real world or to create another world
- Creating location-based services and games using the real world as a background

There are three hands and motion controllers modalities:

- Direct manipulation with hands
- Point and commit with hands
- Motion controllers

## Hands-free model

The hands-free model enables users to interact with holographic content using their hands. This approach is best to use if the user may need to use their hands to accomplish their real-world goals, and will have difficulty interacting with a hands-and-controllers based interface.

Some specific scenarios include:

- Being guided through a task, while the user's hands are busy
- Referencing materials while the user's hands are busy
- Hand fatigue
- Gloves that can't be tracked
- Carrying something in their hands
- Social awkwardness to do large hand gestures
- Tight spaces

There are two hands-free modalities:

- Voice input
- Gaze and Dwell

## Gaze and commit

Gaze and commit is an input model that is closely related to the way we interact with computers by using a mouse to point and click. Gaze and commit is considered a far input model with indirect manipulation. Therefore, it's best to use gaze and commit when interacting with holographic content that is out of reach. There are two types of gaze input (head- and eye-gaze) and different commit actions.

After the user uses gaze to target an object or UI element, the user can interact or click on it using a secondary input. This is known as the commit step of the input model. Commit methods include voice commands, a button press, or a hand gesture.

## Unity in-editor input simulation

The Unity in-editor input simulation allows you to test holographic object behavior when using hand or eye interaction.

How to move around in the scene:

- Use **W/A/S/D** keys to move the camera forward/left/back/right.
- Use **Q/E** to move the camera vertically.
- Press and hold the **right mouse button** to rotate the camera.

How to simulate hand input:

- Press and hold the **space bar** to enable the right hand.
- While holding the space bar, move your mouse to move the hand.
- Use the **mouse scroll wheel** to adjust the depth of the hand.
- Click the **left mouse button** to simulate pinch gesture.
- Use **T/Y** keys to make the hand persistent in the view.
- Hold **CTRL** key and move the mouse to rotate the hand.
- Press and hold the **left shift key** to enable the left hand.
