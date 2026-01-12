In this module, you learned how Azure Container Registry (ACR) organizes container images using a hierarchy of registries, repositories, and artifacts. You explored how manifests, layers, and digests enable efficient storage and precise image identification. Tags provide human-readable references, while digests offer immutable identifiers for guaranteed reproducibility. You also learned to use ACR Tasks to build container images in the cloud without requiring a local Docker installation. Quick tasks enable on-demand builds from local files or Git repositories, while automatic triggers respond to source code commits and base image updates. Multi-step tasks support complex build-test-push workflows entirely within ACR. Additionally, you implemented tagging and versioning strategies that support reliable production deployments. Semantic versioning communicates the nature of changes, unique tags guarantee deployment consistency, and image locking prevents accidental deletion of production images. Finally, you applied these concepts in a hands-on exercise that demonstrated building, tagging, and running container images using the Azure CLI.

## Additional resources

- [Azure Container Registry documentation](/azure/container-registry/)
- [Tutorial: Build and deploy container images in the cloud with ACR Tasks](/azure/container-registry/container-registry-tutorial-quick-task)
- [Best practices for Azure Container Registry](/azure/container-registry/container-registry-best-practices)
- [Recommendations for tagging and versioning container images](/azure/container-registry/container-registry-image-tag-version)

