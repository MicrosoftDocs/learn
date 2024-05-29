Progressive exposure deployment, also called ring-based deployment, was first discussed in Jez Humble's Continuous Delivery book.

They support the production-first DevOps mindset and limit the impact on end users while gradually deploying and validating changes in production.

Impact (also called blast radius) is evaluated through observation, testing, analysis of telemetry, and user feedback.

In DevOps, rings are typically modeled as stages.

Rings are, in essence, an extension of the canary stage. The canary releases to a stage to measure impact. Adding another ring is essentially the same thing.:::image type="content" source="../media/rings-0fbd687d.png" alt-text="Diagram of Rings.":::


With a ring-based deployment, you first deploy your changes to risk-tolerant customers and progressively roll out to a more extensive set of customers.

The Microsoft Windows team, for example, uses these rings.

:::image type="content" source="../media/windows-deployment-rings-45ab6434.png" alt-text="Diagram of windows deployment rings.":::


When you have identified multiple groups of users and see value in investing in a ring-based deployment, you need to define your setup.

Some organizations that use canary releasing have multiple deployment slots set up as rings.

The first release of the feature to ring 0 targets a well-known set of users, mostly their internal organization.

After things have been proven stable in ring 0, they propagate the release to the next ring. It's with a limited set of users outside their organization.

And finally, the feature is released to everyone. It is often done by flipping the switch on the feature toggles in the software.

As in the other deployment patterns, monitoring and health checks are essential.

By using post-deployment release gates that check a ring for health, you can define an automatic propagation to the next ring after everything is stable.

When a ring isn't healthy, you can halt the deployment to the following rings to reduce the impact.

For more information, see also [Explore how to progressively expose your Azure DevOps extension releases in production to validate before impacting all users](/azure/devops/articles/phase-rollout-with-rings).
