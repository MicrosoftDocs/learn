As described in the first unit of this module, continuous delivery offers numerous benefits, including accelerated release cycles, improved collaboration, efficient resource utilization, and increased resiliency. The last of these ties, to some extent, to the ability to deliver new software versions to their intended recipients in a gradual manner. This helps to limit the scope of a negative impact if there is undetected code quality issues and gather customer feedback that might influence the decision to continue with the delivery. The organization in the sample scenario would be able to utilize this capability in order to mitigate its current operational challenges. In this unit, you'll learn about different progressive exposure techniques that contribute to increased resiliency.

## What are progressive exposure techniques?

CD practices feature several delivery patterns for progressive exposure. Their purpose is to minimize potential damage caused by programming errors that CI-based code analysis, reviews, and automated testing failed to uncover (this objective is also commonly referred to as *controlling the blast radius*). The most commonly used techniques include:

- **Deployment rings**: A ring designates a deployment targeting a particular group of users, which is later monitored to determine their experiences. The first deployment ring is sometimes called *canary*, referencing the term *canary in the coal mine* borrowed from the old mining practice of using canaries to warn about elevated levels of carbon monoxide. CD automates transitioning from one ring to the next, although the transition might depend on a manual approval. Such practices might be required in order to comply with regulatory requirements or internal governance rules.

    :::image type="content" source="../media/4-deployment-rings.png" alt-text="Diagram of the deployment rings.":::

- **Blue/green deployments**: The two colors designate two different versions of the same application, with *blue* representing the current (known as stable) version and *green* representing an updated one (being released). The intention is to have both versions running side-by-side and using load balancing to gradually increase the volume of incoming requests from the *blue* to *green* version. If there's an issue with *green*, the incoming requests can be easily rerouted back to *blue*.

    :::image type="content" source="../media/4-blue-green.png" alt-text="Diagram of the blue/green deployments.":::

- **Feature flags** (also referred to as **feature toggles**): A feature flag designates a programming method, which involves placing throughout code conditional statements, which selectively disable or enable certain code segments. The statements are activated by setting a value of a flag, which is typically placed in an external configuration store. Effectively, it's possible to enable or disable new features on an as-needed basis without having to modify or deploy the code.

    :::image type="content" source="../media/4-feature-flags.png" alt-text="Diagram of the feature flags.":::

- **Dark launches**: Dark launches represent a deployment strategy that involves deploying new features in an inactive state and enabling them in a controlled manner after deployment. This approach typically relies on the use of feature flags.

    :::image type="content" source="../media/4-dark-launches.png" alt-text="Diagram of the dark launches.":::
