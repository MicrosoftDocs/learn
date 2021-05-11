Before building a Scene, it's important to consider what data would support the end purpose of the user experience.  In your wind farm use case, you'll be building a Unity Scene to help place wind turbines in a wind farm, then connect them to operational data, and take action when presented with operations events.  To build an immersive experience that is realistic and meaningful, you'll need to provide contextual information in addition to wind turbine model assets. 

Satellite imagery can provide contextual information to support realism and help drive decision making.  In building a Scene, you'll need to consider how large of a study area / how much data you want to retrieve.  There always is a balance between data quantity and quality, and performance. 

## Design for a big environment

To take advantage of immersive experiences, you should consider designing beyond the user's immediate view. By allowing the user to configure their environment and the objects around them, they can adapt their experience to their own physical space. Consider the base or tabletop platform for your Digital Twin experience and how a user might integrate it into their current environment. In this use case, an imagery-based terrain forms the initial foundation of the wind farm. As the entire wind farm is of equal importance, a circular form is taken to remove the notion of a focus in any one area and encourages users to navigate the terrain in Mixed Reality to investigate the wind farm from various angles. The terrain is equipped with handles to place and adjust on a suitable surface in a user's physical space.

## Place modules for comfort

To ensure comfort for the user, placement of objects must be considered. For areas of interest, the optimum placement for focus is 2 m (6½ft) from a user. To ensure maximum comfort it's critical objects throughout the Scene reside 1.25m-5m (4-16 ft) distance from the user.

In this use case, Turbine models are connected to ADT data streams and use MRTK Tooltips. These are useful objects that can be attached to assets in your Scene that provide further data points. In this tutorial, a tooltip is attached to each turbine and data streams then are connected. In another environment, you may choose to attach several tooltips to one object if it consists of many components, each needing their own data point.