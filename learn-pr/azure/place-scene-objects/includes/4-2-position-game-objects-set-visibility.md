If you want to position your game objects in an appropriate place or order, Unity helps you in moving, rotating, and scaling the game object. You can also use the RectTransform and Transform options. *RectTransform* is used for changing the position of 2D objects, such as sprites. *Transform* combines the move, rotate, and scale tools.

Positioning the game objects on the scene is a crucial step, because it helps you decide where your holograms must be placed in the surroundings. Experienced Unity developers tend to use positioning often, to place objects on the scene systematically. It's frequently used to adjust the placements of objects and place them in their rightful position. This is one practice that all developers must use during the development phase.

## Parent object

In Unity, objects use a hierarchy system where objects can become "parents" of other objects. You can create *game objects* when you want that object to perform all the transform changes concerning the parent game object instead of the game world. You can create a *parent game object* simply by dragging and dropping the game object you want as a child object onto the object you want as a parent game object. If you're developing anything in Unity, you'll find that you create parent game objects frequently.

## Prefab

*Prefabs* are distinct components that allow completely configured game objects to be retained in a project for future use. They are crucial elements used to carry out broad changes across the project. Any edits that you make to a Prefab asset are automatically reflected in the instances of that Prefab. You can share these Prefabs between scenes or even other projects, without having to reconfigure them. It's a good idea to form Prefabs while you're working in Unity, so you can avoid rework in the future.

## Scene Visibility

*Scene Visibility control* allows you to hide and show game objects in the scene without changing the in-game visibility. Scene Visibility is helpful while you're working on complex scenes with a lot of game objects. Using visibility is a preferred option over deactivating the game objects, because visibility only affects the scene view. This means that you can't accidentally remove game objects from a fully rendered scene. You can hide a game object by selecting the eye icon beside its name in the hierarchy window.
