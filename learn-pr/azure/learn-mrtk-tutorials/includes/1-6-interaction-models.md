The Mixed Reality Toolkit enables you to consume inputs from various input sources such as 6DoF (degrees of freedom) controllers, articulated hands, or speech. Choosing the interaction model best suited for your mixed reality experience requires identifying your user's goals. Also, consider any environmental factors that may impact their experience. Here you'll learn about the three primary interaction models for mixed reality experiences and how to simulate input in Unity.

There are three primary interaction models which suit the majority of mixed reality experiences.

Although you could combine parts of multiple interaction models into your mixed reality experience, be aware of doing so. It creates the risk of competing user input, such as simultaneous hand rays and a head-gaze cursor. In addition, this method can overwhelm and confuse users.

If your experience requires multiple interaction models, consider that many users might find it challenging to transition from one model to another.

## Hands and motion controllers model

The hands and motion controllers model requires users to use one or two hands to interact with the holographic world. This model removes the boundary between virtual and physical.

Some specific scenarios include:

* Providing information workers 2D virtual screens with UI affordances to display and control the content
* Providing Firstline Workers tutorials and guides for factory assembly lines
* Developing professional tools for assisting and educating medical professionals
* Using 3D virtual objects to decorate the real world or to create a second world
* Creating location-based services and games using the natural world as a background

There are three hands and motion controllers modalities:

* Direct manipulation with hands
* Point and commit with hands
* Motion controllers

## Hands-free model

The hands-free model enables users to interact with holographic content using their hands. This approach is best to use if the user may need to use their hands to accomplish their real-world goals. In addition, they will have difficulty interacting with a hands-and-controllers-based interface.

Some specific scenarios include:

* Being guided through a task while the user's hands are busy
* Referencing materials while the user's hands are busy
* Hand fatigue
* Gloves that can't be tracked
* Carrying something in their hands
* Social awkwardness to make large hand gestures
* Tight spaces

There are two hands-free modalities:

* Voice input
* Gaze and Dwell

## Gaze and commit

Gaze and commit's an input model closely related to how we interact with computers by using a mouse to point and click. However, gaze and commit are considered a far-input model with indirect manipulation. Therefore, it's best to use gaze and commit when interacting with holographic content out of reach. There are two types of gaze input (head- and eye-gaze) and different commit actions.

After the user uses gaze to target an object or UI element, they can interact or click on it using a secondary input. This is known as the commit step of the input model. Commit methods include voice commands, a button press, or a hand gesture

## Unity in-editor input simulation

The Unity in-editor input simulation allows you to test holographic object behavior when using hand or eye interaction.

How to move around in the scene:

* Use **W/A/S/D** keys to move the camera forward/left/back/right.
* Use **Q/E** to move the camera vertically.
* Press and hold the **right mouse button** to rotate the camera.

How to simulate hand input:

* Press and hold the **space bar** to enable the right hand.
* While holding the space bar, move your mouse to move the hand.
* Use the **mouse scroll wheel** to adjust the depth of the hand.
* Click the **left mouse button** to simulate the pinch gesture.
* Use **T/Y** keys to make the hand persistent in the view.
* Hold the **CTRL** key and move the mouse to rotate the hand.
* Press and hold the **left shift key** to enable the left hand.
