Today, you'll frequently hear the term microservices. A microservice is an autonomous, independently deployable, and scalable software component.

They're small, focused on doing one thing well, and can run autonomously. If one microservice changes, it shouldn't impact any other microservices within your landscape.

By choosing a microservices architecture, you'll create a landscape of services that can be developed, tested, and deployed separately. It implies other risks and complexity.

It would be best if you created it to keep track of interfaces and how they interact. And you need to maintain multiple application lifecycles instead of one.

:::image type="content" source="../media/microservice-architecture-b9bc17db.png" alt-text="Diagram showing a microservice architecture with multiple applications.":::


In a traditional application, we can often see a multi-layer architecture.

One layer with the UI, a layer with the business logic and services, and a layer with the data services.

Sometimes there are dedicated teams for the UI and the backend. When something needs to change, it needs to change in all the layers.

When moving towards a microservices architecture, all these layers are part of the same microservice.

Only the microservice contains one specific function.

The interaction between the microservices is done asynchronously.

They don't call each other directly but use asynchronous mechanisms like queues or events.

Each microservice has its lifecycle and Continuous Delivery pipeline. If you built them correctly, you could deploy new microservice versions without impacting other system parts.

Microservice architecture is undoubtedly not a prerequisite for Continuous Delivery, but smaller software components help implement a fully automated pipeline.
