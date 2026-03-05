The tagging strategy you choose affects deployment reliability, rollback capabilities, and image maintenance. This unit covers tagging approaches, versioning schemes, and lifecycle management practices that support production AI deployments.

## Understand tagging strategies

Tags provide human-readable references to container images. The choice between stable and unique tags determines how deployments behave when images update and whether you can reliably roll back to previous versions.

### Stable tags

Stable tags like `v1`, `v1.2`, or `latest` are reused across multiple image pushes. When you push a new image with an existing tag, the tag moves to point to the new image. The previous image remains in the registry but loses that tag reference.

Stable tags work well in specific scenarios:

- **Base images receiving security updates:** When you patch a base image and want dependent builds to pick up changes automatically
- **Development environments:** When you want the latest changes without updating deployment configurations
- **Continuous delivery:** When consumers should always receive the most current version

The tradeoff with stable tags is predictability. Different nodes might pull the same tag at different times and receive different images. For AI applications serving inference requests, this inconsistency can cause unexpected behavior when nodes run different model versions.

### Unique tags

Unique tags like `v1.2.0-build456` or `20260102-abc123` are never reused. Each image push creates a new tag, preserving all previous versions in the registry.

Unique tags work well for:

- **Production deployments:** Every node in your cluster pulls the exact same image
- **Audit trails:** You can trace exactly which image was deployed at any point in time
- **Rollback scenarios:** Reference any previous build to restore a known-good state
- **Compliance requirements:** Demonstrate which specific image version was running during an incident

The tradeoff is that unique tags require updating deployment configurations when you release new versions. This explicit update process is considered a benefit for production environments where changes should be intentional.

## Implement semantic versioning

Semantic versioning uses the `MAJOR.MINOR.PATCH` format to communicate the nature of changes to image consumers. This convention provides a clear contract about compatibility.

- **MAJOR:** Increment for breaking changes that require consumer updates, such as API changes or removed features
- **MINOR:** Increment for new features that are backward compatible
- **PATCH:** Increment for bug fixes and security patches that don't change the API

For an AI inference API, version tags might follow this progression:

```text
inference-api:1.0.0    # Initial release
inference-api:1.0.1    # Bug fix in preprocessing
inference-api:1.1.0    # Added new model endpoint
inference-api:2.0.0    # Breaking API change
```

Combine semantic versions with stable tags for flexibility. The following approach lets consumers choose their update strategy:

```text
inference-api:1        # Points to latest 1.x.x (stable tag)
inference-api:1.1      # Points to latest 1.1.x (stable tag)
inference-api:1.1.0    # Specific patch version (unique tag)
```

Consumers who reference `inference-api:1` receive automatic updates within the major version. Those referencing `inference-api:1.1.0` receive only the specific patch version they specify.

## Generate unique tags for deployments

Production deployments benefit from unique tags that guarantee consistency. Several patterns provide traceability to your build and source code.

### Build ID tags

Build IDs from your CI/CD system create a direct link between container images and the pipeline runs that produced them. When you need to investigate an issue or audit a deployment, the build ID points you to the exact pipeline execution with its logs, test results, and artifacts. Use your CI/CD system's build identifier to link images to specific pipeline runs.

```text
inference-api:build-4567
```

### Git commit SHA tags

Git commit hashes provide the most direct connection between a container image and its source code. Unlike build IDs that require access to your CI/CD system, anyone with repository access can look up the exact code state that produced the image. Tag with the short or full Git commit hash to link the image directly to source code.

```text
inference-api:abc123f
```

### Timestamp tags

Timestamps provide immediate visual context about image age without requiring lookups in external systems. When reviewing a list of images, you can quickly identify the build sequence and spot outdated versions. Include the build date and time for chronological ordering.

```text
inference-api:20260102-143022
```

### Combined approach

For production systems where traceability is critical, combining multiple identifiers in a single tag provides comprehensive information at a glance. This approach is valuable during incident response when you need to quickly determine the semantic version, locate the build pipeline, and find the source code. Combine multiple identifiers for maximum traceability.

```text
inference-api:v1.2.0-build4567-abc123f
```

When using ACR Tasks, the `{{.Run.ID}}` variable automatically generates unique identifiers for each build:

```azurecli
az acr build --registry myregistry \
  --image inference-api:v1.2.0-{{.Run.ID}} .
```

## Manage the latest tag

The `latest` tag has special behavior in Docker. When you push or pull without specifying a tag, Docker uses `latest` by default. This convenience can cause problems in production environments.

Consider these issues with `latest`:

- **Inconsistent deployments:** Different nodes might pull `latest` at different times and receive different images
- **Unpredictable updates:** Deployments change when someone pushes a new image, even without intentional deployment
- **Difficult troubleshooting:** When investigating issues, you don't know which version is running

For production deployments, specify explicit tags in Kubernetes manifests and deployment configurations:

```yaml
# Avoid this in production
image: myregistry.azurecr.io/inference-api:latest

# Use explicit versions instead
image: myregistry.azurecr.io/inference-api:v1.2.0
```

If your workflow requires `latest`, consider using it only in development environments where the convenience outweighs the consistency concerns.

## Lock deployed images

ACR allows you to lock images to prevent accidental deletion or modification. Locking is a best practice for production images actively serving traffic.

The following command locks an image by disabling write operations:

```azurecli
az acr repository update \
  --name myregistry \
  --image inference-api:v1.2.0 \
  --write-enabled false
```

Locked images have these characteristics:

- **Cannot be deleted:** Even administrators can't accidentally remove them
- **Cannot be overwritten:** Pushing a new image with the same tag fails
- **Survive retention policies:** Automatic cleanup rules don't remove locked images
- **Provide deployment assurance:** Production workloads remain stable because the image stays available

Unlock an image when you're ready to retire it:

```azurecli
az acr repository update \
  --name myregistry \
  --image inference-api:v1.2.0 \
  --write-enabled true
```

## Clean up untagged images

When you push a new image with an existing stable tag, the previous image becomes untagged. These "orphan" images consume storage, and no tag references them. Over time, untagged images accumulate and increase storage costs.

### Auto-purge untagged images

The `acr purge` command runs as a container within ACR Tasks, allowing you to clean up images on demand or as part of automated workflows. You specify filters to target specific repositories and age thresholds to protect recent images. Use the `acr purge` command to delete untagged manifests older than a specified duration:

```azurecli
az acr run --registry myregistry \
  --cmd "acr purge --filter 'inference-api:.*' --untagged --ago 30d" \
  /dev/null
```

This command removes untagged images in the `inference-api` repository that are older than 30 days. The filter uses a regular expression to match repository names.

### Schedule automatic cleanup

Automating cleanup through scheduled tasks ensures consistent registry maintenance without manual intervention. By running purge operations on a regular schedule, you prevent storage accumulation and keep costs predictable. Create a scheduled ACR Task to run cleanup automatically:

```azurecli
az acr task create \
  --registry myregistry \
  --name cleanup-untagged \
  --cmd "acr purge --filter '.*:.*' --untagged --ago 7d" \
  --schedule "0 0 * * 0" \
  --context /dev/null
```

This task runs weekly and removes untagged images older than seven days across all repositories.

### Retention policies

Retention policies offer a simpler alternative to scheduled purge tasks for Premium tier registries. Instead of managing task schedules and filters, you configure a single policy that applies registry-wide. For Premium tier registries, you can set retention policies at the registry level. These policies automatically remove untagged manifests after a specified number of days without requiring scheduled tasks.

## Best practices for tagging and versioning

Follow these practices to maintain a reliable container image strategy:

- **Use unique tags for production:** Guarantee consistency across all nodes in your deployment. Unique tags prevent surprises when images update.
- **Reserve stable tags for base images:** Allow security updates to flow automatically to dependent images through base image triggers.
- **Lock production images:** Prevent accidental deletion of images actively serving traffic. Unlock only when retiring versions.
- **Implement retention policies:** Clean up orphaned images to control storage costs. Schedule regular purge tasks.
- **Include build metadata:** Add traceability information to tags for debugging and auditing. Link images to builds and source commits.
- **Document your tagging scheme:** Ensure your team follows consistent conventions. Document which tags are stable versus unique and when to use each.

## Additional resources

- [Recommendations for tagging and versioning container images](/azure/container-registry/container-registry-image-tag-version)
- [Lock a container image in Azure Container Registry](/azure/container-registry/container-registry-image-lock)
- [Automatically purge images from an Azure container registry](/azure/container-registry/container-registry-auto-purge)
