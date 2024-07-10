There are some unique design requirements in order for a mixed reality application to provide an enjoyable experience to its users. To design such experiences, you need background knowledge in UX/UI, 2D and 3D visual design, and the bodystorming ideation method. Through all these disciplines combined, you can improve the user experience significantly. To best prepare you for this unique design challenge, you need a clear idea of virtual and real-world interactions.

## Get started with mixed reality design

To create a practical application in mixed reality, you need to understand some fundamental concepts of how things work. Here, let's first familiarize ourselves with the terminology and the technical aspects of mixed reality development. Then you're ready to turn your ideas and concepts into a mixed reality application. The art of "mind mapping" is a valuable practice to turn ideas into applications. To understand what is mixed reality and what is a hologram, see the prerequisite learn module Introduction to mixed reality<sup>1</sup>.

## Core concepts of design

To design immersive applications, one must be aware of several core concepts. At this point, your key priorities are to understand the users' point of view. You want to arrange objects based on this point of view, and make sure users are comfortable and safe while using the application.

It's helpful to understand some key concepts before getting into the design of your application. Each of the following sections describes an underlying component that influences and contributes to the quality of the mixed reality experience you're designing and developing.

### Spatial mapping

Spatial mapping provides a detailed representation of real-world surfaces in the environment around the HoloLens. You can compare spatial mapping to a blueprint of the environment where you can accurately place the holograms. By making holographic objects interact with the physical surfaces provided by spatial mapping, you can create a convincing mixed reality experience using spatial mapping.

:::image type="content" source="../media/spatial-mapping.png" alt-text="Screenshot of spatial mapping in the environment." lightbox="../media/spatial-mapping.png":::

### Holographic frame

A rectangular viewport powered by the user's headset allows them to see the world in mixed reality. This rectangular space on the HoloLens is known as the holographic frame, and it allows users to see digital content superimposed on the real world around them. Creating an optimized mixed reality application for the holographic frame generates opportunities, reduces obstacles, and improves the user experience.

### Coordinate systems

Mixed reality apps, at their foundation, place holograms that look and sound like physical items in your environment. To achieve this effect, you need to place and orient holograms in specific locations in the environment as your background. **Spatial coordinate systems** refer to the numerous real-world coordinate systems for describing spatial geometry that are in Windows. You can use the spatial coordinate systems to calculate hologram position, orientation, gaze ray, or hand locations.

The spatial coordinate systems are measured in meters. Therefore, items positioned two units apart in the X, Y, or Z axis are seen as 2 meters apart in mixed reality. You can easily render objects and environments in a real-world scale once you understand the spatial coordinate systems.

### Comfort

Human vision processes various kinds of information, or "cues," to understand 3D shapes and the relative positions of objects in view. Some cues, known as monocular cues, rely just on one eye. Other cues, known as binocular cues, rely on both eyes. Therefore, it's essential to produce and show content on head-mounted displays that mimics natural visual cues to ensure optimal comfort. From the physical standpoint, it's also important to create interactions that don't require tiring neck and arm movements. In the upcoming units, we cover some of the crucial design aspects to keep in mind to attain these objectives.

:::image type="content" source="../media/optimal-distance.png" alt-text="Screenshot showing the optimal distance at which the holograms must be placed." lightbox="../media/optimal-distance.png":::

## Reference

1 - See the **Additional reading** section at the end of this learn module.