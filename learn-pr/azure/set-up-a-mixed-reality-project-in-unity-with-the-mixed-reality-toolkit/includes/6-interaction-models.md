# MRTK and Interaction Models

The Mixed Reality Toolkit enables you to consume inputs from a variety of input sources such as 6DoF (degrees of freedom) controllers, articulated hands or speech. Choosing the interaction model best suited for your mixed reality experience requires you to identify your user, their goals and consider any situational or environmental factors which may impact their experience. Here you will learn about the three primary interaction models for mixed reality experiences and how each can be implemented with MRTK.

## Interaction models

There are three primary interaction models which suit the majority of mixed reality experiences.


|Model  |Example scenarios  |Fit  |
|---------|---------|---------|
|Hands and motion controllers     | 3D spatial experiences, such as spatial layout and design, content manipulation, or simulation.        |    Great for new users coupled with voice, eye tracking or head gaze. Low learning curve. Consistent UX across hand tracking and 6DoF controllers.     |
|Hands-free     |     Contextual experiences where a user's hands are occupied, such as on-the-job learning and maintenance.    |    Some learning required. If hands are unavailable, the device pairs well with voice and natural language.     |
|Gaze and commit     |     Click-through experiences, e.g. 3D presentations, demos.    |   Requires training on head mounted devices but not on mobile. Best for accessible controllers.       |

Although you could combine parts of multiple interaction models into your mixed reality experience, be aware that doing so creates the risk of competing user input, such as simultaneous hand rays and a head-gaze cursor. This can overwhelm and confuse users.

If your experience does require multiple interaction models, please keep in mind that many users might encounter difficulty when transitioning from one model to another, especially users who are new to mixed reality.

## Hands and motion controllers model

The hands and motion controllers model requires users to use one or two hands to interact with the holographic world. This model removes the boundary between virtual and physical.

Some specific scenarios include:

- Providing information workers 2D virtual screens with UI affordances to display and control content
- Providing first line workers tutorials and guides for factory assembly lines
- Developing professional tools for assisting and educating medical professionals
- Using 3D virtual objects to decorate the real world or to create a second world
- Creating location-based services and games using the real world as a background

There are three hands and motion controllers modalities:

- Direct manipulation with hands
- Point and commit with hands
- Motion controllers

### Direct manipulation with hands

Direct manipulation is an input model that involves touching holograms directly with your hands. Users are able to use the same way of manipulating real world objects to interact with virtual ones. Buttons can be activated by pressing them, objects can be picked up by grabbing them, and 2D content behaves like a virtual touchscreen. This makes direct manipulation approachable for users to learn. It's considered a "near" input model in that it's best used for interacting with content within arms reach.

With MRTK, you can achieve common manipulation behavior adding the **ObjectManipulator** script as a component to an object. With ObjectManipulator, you can grab and move objects directly with hands or with a hand ray. It also supports two-handed manipulation for scaling and rotating an object. To make the object respond to near input, add the **NearIntearctionGrabbable** script to the object as well.

### Point and commit with hands

Point and commit with hands is an input model that enables users to target, select and manipulate 2D content and 3D objects that are out of reach. This "far" interaction technique is unique to mixed reality, and is not a way humans naturally interact with the real world. Users can place holograms anywhere and still access them from any distance.

MRTK provides a hand ray prefab (**DefaultControllerPointer.prefab**) which has the same visual state as the shell's system hand ray. It is assigned in MRTK's Input profile, under Pointers. In an immersive headset, the same rays are used for the motion controllers.

### Motion controllers

Motion controllers are hardware accessories that allow users to take action in mixed reality. Motion controllers extend the user's physical capabilities by providing precise interactions across a large range of distances while using one or both hands. These hardware accessories provide shortcuts to many commonly-used interactions and provide tactile feedback for a variety of actions.

With MRTK, physical inputs are mapped to input actions in the **Controller Input Mapping Profile** under the **Input System Profile** in the **Mixed Reality Toolkit** object.

## Hands-free model

The hands-free model enables users to interact with holographic content using their hands. This approach is best to use if the user may need to use their hands to accomplish their real-world goals, and will have difficulty interacting with a hands-and-controllers based interface.

Some specific scenarios include:

- Being guided through a task, while the user's hands are busy
- Referencing materials while the user's hands are busy
- Hand fatigue
- Gloves that can't be tracked
- Carrying something in their hands
- Social awkwardness to perform large hand gestures
- Tight spaces

There are two hands-free modalities:

- Voice input
- Gaze and Dwell

### Voice input

Voice input can be a natural way to communicate your intent. Using your voice to command and control an interface offers a convenient way to operate hands-free and to use shortcuts to flexibly skip multiple steps if desired. Because users speak with a variety of dialects and accents, proper choice of speech keywords will make sure that your users' commands are interpreted unambiguously.

With MRTK, you can assign voice command on any object. Keywords are defined in MRTK's Speech Input Profile. By adding the **SpeechInputHandler** script as a component to an object, you can make any object respond to the keywords defined in the Speech Input Profile. SpeechInputHandler also provides a speech confirmation label to improve the user's confidence.

### Gaze and dwell

In some hands-free situations, using your voice is not ideal or even possible. Loud factory environments, privacy, or social norms can all be constraints. The gaze and dwell model allows the user to navigate an app without any additional input aside from their eye or head gaze. With this model, the user gazes (with their head or eyes) at the target and lingers there for a moment to activate it.

## Gaze and commit

Gaze and commit is an input model that is closely related to the way we interact with computers by using a mouse to point and click. Gaze and commit is considered a far input model with indirect manipulation. Therefore, it is best to use gaze and commit when interacting with holographic content that is out of reach. There are two types of gaze input (head- and eye-gaze) and different commit actions.

After the user uses gaze to target an object or UI element, the user can interact or click on it using a secondary input. This is known as the commit step of the input model. Commit methods include voice commands, a button press, or a hand gesture.

With MRTK, gaze functionality is provided by the **GazeProvider**. This provider can be configured in the **Pointer** section of the **Input System Profile**.

### Eye-gaze and commit

Eye-gaze and commit involves targeting an object by looking at it and then acting on it with a secondary commit input, such as a hand gesture, voice command or peripheral input (i.e. game controller). Our eyes move incredibly fast and thus are great at quickly targeting across the view. This makes eye-gaze ideal for quick gaze-and-commit actions especially when combined with fast commits such as a button press. Eye gaze is only present on systems that support eye tracking.

### Head-gaze and commit

Head-gaze and commit involves targeting an object with the direction of your head pointing forward (head-direction), and then acting on it with a secondary input, such as a voice command. Although you could target smaller objects, head-gaze often works best for larger targets. It is recommended to provide either audio or visual cues to inform the user that an object has been targeted. Such cues include visible hover effects, audio highlights or clicks, or clear alignment of a cursor with an object.

## Unity in-editor hand input simulation

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