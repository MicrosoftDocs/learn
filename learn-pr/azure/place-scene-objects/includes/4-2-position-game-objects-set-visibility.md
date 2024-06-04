Unity enables you to place an object in the scene and then scale or rotate it. You can use the *RectTransform* feature to change the position of 2D objects, such as sprites. The *Transform* feature combines the move, rotate, and scale tools.

## Parent object

In Unity, objects use a hierarchy system where objects can become *parents* of other objects. You can create *game objects* when you want that object to perform all the transform changes concerning the parent game object instead of the game world. You can create a *parent game object* simply by dragging and dropping the game object you want as a child object onto the object you want as a parent game object. When you're developing in Unity, you'll find that you create parent game objects frequently.

## Prefab

*Prefabs* are distinct components that allow completely configured game objects to be retained in a project for future use. They are crucial elements used to carry out broad changes across the project. Any edits that you make to a Prefab asset are automatically reflected in all the instances of that Prefab. You can share these Prefabs between scenes or even other projects, without having to reconfigure them. It's a good idea to form Prefabs while you're working in Unity, so you can avoid rework in the future.

## Scene Visibility

*Scene Visibility control* allows you to hide and show game objects in the scene without changing the in-game visibility. Scene Visibility is helpful while you're working on complex scenes with a lot of game objects. Using visibility is a preferred option over deactivating the game objects, because visibility only affects the scene view. This means that you can't accidentally remove game objects from a fully rendered scene. You can hide a game object by selecting the eye icon beside its name in the hierarchy window.
