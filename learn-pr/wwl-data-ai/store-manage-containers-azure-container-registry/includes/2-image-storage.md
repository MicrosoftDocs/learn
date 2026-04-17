Understanding how Azure Container Registry (ACR) organizes container images helps you design an effective storage strategy for AI applications. This unit explains the registry hierarchy and shows how manifests, layers, and digests enable efficient storage and retrieval of container artifacts.

## Understand Azure Container Registry

Azure Container Registry is a managed, private Docker registry service that stores and distributes container images and related artifacts. Unlike public registries such as Docker Hub, ACR provides direct control over access, geo-replication for global distribution, and integration with Azure services like Azure Kubernetes Service  and Azure Container Apps.

For AI workloads, ACR offers several important capabilities:

- **Private storage:** Keep model serving images, preprocessing containers, and inference APIs secure within your Azure environment
- **Geo-replication:** Distribute images close to deployment regions for faster pulls and reduced latency
- **Integration:** Connect directly to Azure Kubernetes Service, Azure Container Apps, and Azure App Service for seamless deployments
- **Content formats:** Store Docker images, Helm charts, and OCI artifacts in a single registry

ACR supports Basic, Standard, and Premium service tiers. Most developer workflows work identically across tiers, though features like content trust and private endpoints require Premium tier. The Basic tier works well for development and learning scenarios. Standard adds more storage and throughput for production workloads. Premium includes geo-replication, private endpoints, and content trust for enterprise deployments.

## Registry hierarchy

ACR uses a three-level hierarchy to organize content. Understanding this structure helps you plan how to arrange images for your AI applications.

### Registry

The registry is the top-level resource that hosts all container content. Each registry has a unique login server URL in the format `<registry-name>.azurecr.io`. When you create a registry, you choose a name that becomes part of this URL. For example, a registry named `contosoinference` has the login server `contosoinference.azurecr.io`.

A registry contains multiple repositories and provides authentication, access control, and management capabilities. You can configure who has access to push and pull images, set retention policies, and enable features like geo-replication at the registry level.

### Repository

A repository is a collection of container images with the same name but different tags. For example, a repository named `inference-api` contains all versions of your inference API image. Each time you push a new version with a different tag, it appears in the same repository.

Repositories support namespaces using forward slashes for organization. This feature lets you group related images logically:

- `production/inference-api` for production-ready images
- `staging/inference-api` for images under validation
- `ml-team/model-server` for team-specific images

Namespaces help with access control. You can grant a team permission to push images only to their namespace while restricting access to production images.

### Artifact

An artifact is the actual container image or other content stored in a repository. Each artifact has tags that identify it, layers that make up its content, and a manifest that describes its structure. Artifacts can include Docker images, Helm charts, or any OCI-compliant content.

## Tags, layers, and manifests

Each component of an artifact serves a specific purpose. Understanding these components helps you make informed decisions about image management.

### Tags

Tags identify specific versions of an artifact within a repository. The format `repository:tag` provides a human-readable reference. For example, `inference-api:v1.2.0` refers to version 1.2.0 of the inference API image. If you push or pull without specifying a tag, Docker uses `latest` by default.

A single artifact can have multiple tags pointing to it. You might tag an image as both `inference-api:v1.2.0` and `inference-api:stable` to indicate it's the current stable release. Both tags reference the same underlying image.

Tags are mutable. When you push a new image with an existing tag, the tag moves to point to the new image. This behavior is useful for tags like `latest` but can cause problems in production deployments where consistency matters.

### Layers

Container images consist of one or more layers. Each layer corresponds to an instruction in the Dockerfile that modifies the filesystem. For example, installing a package or copying files creates a new layer. Layers are content-addressable, meaning you can identify them by a hash of their content.

ACR shares common layers across images, reducing storage costs and speeding up pulls. When multiple images share a base layer such as `python:3.11`, only one copy exists in the registry. This deduplication is valuable for AI applications where many images might share common ML framework layers.

### Manifests

Every artifact has a manifest that lists its layers and configuration. The manifest is identified by a SHA-256 digest in the format `sha256:abc123...`. Unlike tags, digests are immutable. Once an image is pushed, its digest never changes.

Pulling by digest guarantees you get the exact image you expect, even if someone pushes a new image with the same tag. This immutability is critical for production AI deployments where you need consistency across all nodes.

## Address artifacts for push and pull operations

ACR supports two addressing formats for pushing and pulling images. Each approach has different use cases.

### By tag

Tag-based addressing uses the format `registry/repository:tag`. This approach provides human-readable references that are easy to remember and use in deployment configurations.

```azurecli
# Pull an image by tag
docker pull myregistry.azurecr.io/inference-api:v1.2.0

# Push an image with a tag
docker push myregistry.azurecr.io/inference-api:v1.2.0
```

Tag-based addressing works well during development and for images where you want to receive automatic updates. However, tags can change, so deployments using tags might not be perfectly reproducible.

### By digest

Digest-based addressing uses the format `registry/repository@sha256:hash`. This approach guarantees you reference a specific, immutable image regardless of tag changes.

```azurecli
# Pull an image by digest
docker pull myregistry.azurecr.io/inference-api@sha256:0a2e01852872580b2c2fea9380ff8d7b637d3928783c55beb3f21a6e58d5d108
```

Pull by digest when you need guaranteed reproducibility. Production deployments where consistency across nodes is critical should use digests. You can find an image's digest in the Azure portal, through the Azure CLI, or in the output when pushing an image.

## Best practices for organizing registries

Following these practices helps you maintain an organized and efficient registry:

- **Use namespaces:** Organize repositories by team, environment, or project using forward-slash notation. This structure simplifies access control and makes it easier to find related images.
- **Plan repository structure:** Group related images logically. Consider whether images belong together based on deployment patterns, team ownership, or lifecycle management needs.
- **Enable geo-replication:** For global AI deployments, replicate images to regions where your services run. This reduces pull latency and improves deployment reliability.
- **Monitor storage:** Track storage consumption and implement retention policies to remove untagged manifests. Container images accumulate over time, and cleanup policies prevent unnecessary storage costs.

## Additional resources

- [About registries, repositories, and artifacts](/azure/container-registry/container-registry-concepts)
- [Azure Container Registry service tiers](/azure/container-registry/container-registry-skus)
- [Best practices for Azure Container Registry](/azure/container-registry/container-registry-best-practices)
