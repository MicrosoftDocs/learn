Before building a Scene, it's important to consider what data supports the end purpose of the user experience. In your wind-farm use case, you'll be building a Unity Scene to help place wind turbines in a wind farm, connect them to operational data, and take action when presented with operations events. To build an immersive experience that's realistic and meaningful, you'll need to provide contextual information in addition to wind turbine model assets.

Satellite imagery can provide contextual information to support realism and help drive decision making. In building a Scene, you'll need to consider how large of a study area/how much data you want to retrieve. There's always a balance between data quantity/quality and performance.

## Design for a big environment

To take advantage of immersive experiences, you should consider designing beyond the user's immediate view. By allowing the user to configure their environment and the objects around them, they can adapt their experience to their own physical space. Consider the base or tabletop platform for your Digital Twin experience and how a user might integrate it into their current environment. In this use case, an imagery-based terrain forms the initial foundation of the wind farm. As the entire wind farm is of equal importance, a circular form is taken to remove the notion of a focus in any one area and encourage users to navigate the terrain in Mixed Reality to investigate the wind farm from various angles. The terrain is equipped with handles to place and adjust on a suitable surface in a user's physical space.

## Place modules for comfort

To ensure the user's comfort, you need to consider object placement. For areas of interest, the optimum placement for focus is 2 meters (6.5 feet) from a user. To ensure maximum comfort, it's critical that objects throughout the Scene reside 1.25-5 meters (4-16 feet) from the user.

In this use case, Turbine models are connected to ADT data streams and use MRTK Tooltips. These are useful objects you can attach to assets in your Scene that provide further data points.

:::image type="content" source="../media/windmills-tooltip.png" alt-text="Photo of multiple users wearing HoloLens devices and interacting with an immersive experience on a table showing terrain with wind turbines.":::

In this tutorial, a tooltip is attached to each turbine, and data streams then are connected. In another environment, you might choose to attach several tooltips to one object if it consists of many components, each needing their own data point.
