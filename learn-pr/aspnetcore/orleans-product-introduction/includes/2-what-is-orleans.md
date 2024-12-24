Orleans simplifies the process of building distributed, scalable applications. There are several key concepts to understand in order to work with Orleans effectively.

## The virtual actor model

Orleans is built around the *actor model*. This established design pattern existed since the 1970s. The actor model is a pattern that stores pieces of state data and corresponding behavior in lightweight, immutable objects called *actors*. Actors communicate with each other using asynchronous messages. Orleans manages and simplifies much of the parallel communication required by distributed apps for you. Orleans invented the *virtual actor* model. Actors exist perpetually whenever they're needed. This architecture lends itself well to cloud-native applications, which require distributed and resilient state and parallel operations.

## What are Grains?

*Grains* are the most essential primitives and building blocks of Orleans applications. They represent actors in the Actor model and define the state data and behavior of entities you define, such as shopping cart or product. Grains are each identified and tracked through user-defined keys. Other grains and clients can access grains.

:::image type="content" source="../media/grain-visual.png" alt-text="A diagram of the anatomy of a grain.":::

Grains are stored in silos, which you explore later. Grains that are currently active and in use by your application remain in memory. Inactive grains can be persisted to your desired storage. A grain becomes active again when the app needs or requests it.

Grains have a managed life cycle, which means the Orleans runtime handles activating, deactivating, storing, and locating grains as needed by the application. Developers don't have to worry about managing these concerns themselves and can write code that assumes a grain is available in memory.

:::image type="content" source="../media/grain-lifecycle.png" alt-text="A diagram of the grain life cycle.":::

## What are silos?

*Silos* are another core building block of Orleans. Silos store grains and can contain one or more grains. A group of silos is known as a *cluster*.

The cluster coordinates work between silos, allowing communication with grains as though they're all available in a single process. You can organize your data by storing different types of grains in different silos. Your application can retrieve individual grains without having to worry about the details of how they're managed within the cluster.

:::image type="content" source="../media/silos.png" alt-text="A diagram of silo architecture.":::

## Other features of Orleans

Orleans supports plenty of other features for more specific or advanced scenarios.

- **Streams**: Streams help developers process sets of data in near-real-time. Like other features of Orleans, the runtime manages streams and they're available on demand. They're loosely coupled and can apply various queue technologies, such as Azure Event Hubs.
- **Timers and Reminders**: Orleans supports scheduling operations for grains. You can ensure that various actions are completed at a given time even on inactive grains.  
- **Versioning**: Grains can be versioned to account for changes in your application. Orleans handles mapping and managing different implementations of your versioned grains across your silos and clusters.
- **ACID transactions**: Grains can have transactional state and support ACID transaction features.

You can explore these capabilities as you start to build more complex apps. Next, explore the basics of how Orleans works.
