## Container Design Principles

**Single Responsibility**: Design containers with single-purpose applications to maximize reusability and maintainability.

**Service Separation**: Deploy application tiers (web servers, databases, caches) in separate containers to enable independent scaling and updates.

**Horizontal Scaling**: Separate containers enable selective scaling of application components based on demand patterns.

## Image Optimization

**Minimal Dependencies**: Include only verified required packages to reduce image size, attack surface, and build times.

**Lean Base Images**: Select minimal base images like Alpine Linux or distroless images when appropriate for your application runtime.

## Base Image Selection

Choose base images that match your application requirements without excess components. Consider official images, security update frequency, and size optimization for production deployments.

## Data Management

**External Storage**: Use Docker volumes or bind mounts for persistent data to maintain container immutability and enable data persistence beyond container lifecycle.

**Stateless Design**: Design containers as stateless when possible, storing state in external databases or storage services.

For more information, see [Use multiple-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/).
