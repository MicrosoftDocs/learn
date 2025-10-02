Task groups provide task sequence encapsulation, enabling the transformation of multiple pipeline tasks into single, reusable components for build and release pipeline integration.

Parameter extraction from encapsulated tasks enables configuration variable abstraction, separating task logic from environment-specific values while maintaining task functionality.

Task groups establish standardized deployment workflows and centralized management capabilities across application portfolios, ensuring consistent deployment patterns and operational procedures.

Centralized task group modifications propagate automatically across all consuming pipeline definitions, eliminating individual pipeline maintenance overhead and ensuring consistent updates across the organization.

For more information, see [Task groups for builds and releases](/azure/devops/pipelines/library/task-groups).

> [!NOTE]
> Note: Task Groups aren't currently supported in YAML. Use templates instead. See [Template References](/azure/devops/pipelines/yaml-schema).
