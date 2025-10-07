Combined configuration and secret storage violates separation of concerns principles necessitating dedicated secret persistence stores.

Dedicated secret stores establish secure channels for sensitive configuration data including ConnectionStrings.

Operations teams maintain credentials, certificates, and tokens within unified repositories minimizing security risks following Configuration Store compromise scenarios.

Subsequent diagram illustrates role collaboration within DevOps inner and outer loop architectures.

Inner loops focus on developer team solution development iterations consuming outer loop-published configurations.

Ops Engineers govern configuration management operations.

Azure Key Vault and Kubernetes change deployments maintain environment-level isolation.

:::image type="content" source="../media/devops-inner-outer-loop-f0b76371.png" alt-text="Screenshot of managing secrets in containers. The inner, and outer loops are separated.":::
