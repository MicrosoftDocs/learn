Welcome to the Azure Object Anchors module! in this tutorial series, You'll learn the principles of Azure Object Anchors (AOA), how to use them to detect an object in the physical environment and estimate its 6-DoF pose given a 3D model of that object.

:::image type="content" source="../media/hero-image.png" alt-text="Screenshot of hero image to show Azure Object Anchors." lightbox="../media/hero-image.png":::

## What is Azure Object Anchors

Azure Object Anchors is a mixed reality service that helps to create rich, immersive experiences by automatically aligning 3D content with physical objects. It enables an
application to detect an object in the physical world using a 3D model and estimate its 6DoF pose. The 6DoF (6 degrees of freedom) pose can be defined as a rotation and translation
between a 3D model and its physical counterpart or the real object.

## Where can you use Azure Object Anchors

* Imagine a scenario where you're expected to create Mixed Reality training experiences for your employees, without the need to place markers or spend time manually adjusting hologram alignment. Azure Object Anchors services will provide a markerless experience to create a Mixed Reality training experience with automated detection and tracking by ingesting your model into the Azure Object Anchors service.

* Azure Object Anchors can also be used to guide through a set of tasks; with Azure Object Anchors, you can create an experience that automatically detects the object related to the task at hand. Then, use the detected object to flow through pre-defined Mixed Reality guidance without markers or manual alignment.

* Azure Object Anchors can enable you to locate and track instances of that object in your physical environment if, you already have a 3D model of the same object in your physical space.

## How to make a 3D model

We can find 3D models everywhere. It can be found in all physical objects we encounter, also widely used by various industries. 3D model can be defined as a digital representation of a surface or an object created in specialized software. It depicts a physical body as a collection of points in three-dimensional space connected by geometric elements such as triangles, lines, and curved surfaces. A 3D model can sometimes express the size, shape, and texture of an object. 3D modeling is the term for the process of creating this representation.

While there are numerous methods for creating 3D models, the most common include developing a model in 3D modeling software or scanning an object in the real world and converting it to a digital model using a 3D scanner.

* **3D modeling**: Starting from scratch with specialized 3D modeling software is the initial option for creating 3D models. What's astonishing about this strategy is that it lets you develop something that doesn't exist yet - something unique like a new automotive component or a fantasy creature in a video game – or something that does exist but isn't scannable. You may create a model from scratch using various of 3D modeling techniques and modeling software. It all depends on the type of object you want to make and how you plan to use it.
Different 3D modeling software; that you can use are **Blender**, **Autodesk Maya**, **3ds Max**, **ZBrush** and much more.

* **3D scanning for CAD**: One use for 3D scanning is to capture the precise geometrical information about an object that has to be studied, reverse engineered, or inspected for any faults or deviations from an original CAD model or design. It's especially beneficial if you don't have access to a product's original 3D or 2D CAD data. You can scan the model and have it on your screen in minutes rather than spending hours constructing it from scratch. It will not only be faster, but it will also be more precise than traditional modeling techniques or contact-based measuring techniques like CMMs. There are many applications for scanning 3D model such as **Trnio**, **Sony 3D Creator**, **Scandy Pro**, **Qlone** and much more.
