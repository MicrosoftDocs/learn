An artifact is a deployable component of your application that can be deployed to one or more environments.

Build and release pipelines implement the Continuous Delivery principle of building once and deploying multiple times.

This approach ensures artifacts are deployed consistently across multiple environments. Artifacts must be stable packages to support this deployment model.

Configuration should be the only element modified when deploying an artifact to different environments.

Package contents must never change, following the principle of [immutability](/azure/devops/artifacts/artifacts-key-concepts). Package integrity ensures consistent deployments across environments.

Multiple methods exist for creating and retrieving artifacts, each suited to specific scenarios.

:::image type="content" source="../media/artifact-sources-97b67122.png" alt-text="Screenshot of multiple artifact sources to add to the pipeline.":::

Build artifacts are the most common artifact source for release pipelines.

Build pipelines compile, test, and produce immutable packages stored in secure locations (storage accounts, databases, or artifact repositories).

Release pipelines use secure connections to retrieve build artifacts and perform deployment actions to target environments.

Build artifacts provide versioned packages with automatic traceability.

Artifacts link to specific builds, enabling source code traceability for any deployed package. Version control systems offer another artifact source option.

Release pipelines can directly connect to version control systems for artifact retrieval.

Releases link to specific version control commits, providing file and script version tracking. Version information derives from version control rather than build processes.

Version control artifacts are suitable when deploying individual files without additional processing. Creating versioned packages for single files adds unnecessary complexity to the deployment process.

Helper scripts for release processes (cleanup, rename, string operations) are ideal candidates for version control artifacts.

Network shares provide another artifact source option but introduce security risks. Package integrity cannot be guaranteed due to potential unauthorized access and modification. This approach is insufficient for regulated environments requiring audit trails and compliance validation.

Container registries provide increasingly popular artifact sources. These versioned repositories store container artifacts securely. Deploying versioned containers from registries offers similar advantages to build artifacts stored in secure locations.
