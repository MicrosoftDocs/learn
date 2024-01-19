
While you can store configuration and secrets together, it violates our separation of concern principle, so the recommendation is to use a different store for persisting secrets.

It allows a secure channel for sensitive configuration data, such as ConnectionStrings.

It enables the operations team to have credentials, certificates, and tokens in one repository and minimizes the security risk if the Configuration Store gets compromised.

The following diagram shows how these roles play together in a DevOps inner and outer loop.

The inner loop is focused on the developer teams iterating over their solution development; they consume the configuration published by the Outer Loop.

The Ops Engineer governs the Configuration management.

They push changes into Azure KeyVault and Kubernetes that are further isolated per environment.

:::image type="content" source="../media/devops-inner-outer-loop-f0b76371.png" alt-text="Screenshot of managing secrets in containers. The inner, and outer loops are separated.":::
