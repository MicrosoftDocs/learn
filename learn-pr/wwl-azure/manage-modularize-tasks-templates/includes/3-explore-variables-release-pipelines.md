Variables enable dynamic data injection across pipeline components, providing configuration flexibility and environment-specific parameter management throughout build and release processes.

Variable content adapts to deployment context, changing values across releases, stages, and job executions to support diverse environment requirements and deployment scenarios.

Azure DevOps provides predefined system variables alongside custom variable definition capabilities for comprehensive pipeline configuration management.

Variable scope determines accessibility and inheritance patterns within release pipelines, requiring strategic planning for optimal configuration management and deployment flexibility.

Environment-specific variables, such as target server configurations, demonstrate scope importance by varying values between Development, Test, and Production environments while maintaining consistent pipeline logic.

For more information, see [Release variables and debugging](/azure/devops/pipelines/release/variables).

## Predefined variables

Release pipeline execution requires contextual information from agent environments and pipeline metadata for proper task execution and environment configuration.

System-generated variables provide essential runtime information including agent directories, source locations, build identifiers, agent names, and pipeline context metadata.

Predefined variables enable task access to execution context without manual configuration, ensuring consistent information availability across all pipeline stages and environments.

## Release pipeline variables

Release pipeline variables provide global scope access across all stages and tasks within a single pipeline definition, enabling centralized value management and consistent configuration throughout the deployment process.

## Stage variables

Stage variables offer scoped access within individual pipeline stages, supporting values that remain constant across stage tasks while varying between different deployment stages.

Stage-level variables optimize configuration for environment-specific requirements that change between deployment stages but maintain consistency within each stage's task execution.

## Variable groups

Variable groups enable cross-pipeline value sharing within project scope, providing centralized configuration management for multiple pipeline definitions. Detailed variable group implementation follows in subsequent module sections.

## Normal and secret variables

Pipeline task execution utilizes environment variables for value transmission between pipeline engine and agent-based task processors, enabling dynamic configuration during runtime.

Standard variables contain plaintext values that appear in log output and system environments, creating potential security exposure for sensitive information during pipeline execution and debugging.

Variable lifecycle management includes automatic cleanup after pipeline completion, removing environment variables from agent systems to minimize security footprint.

Secret variables provide masked logging and secure value transmission, hiding sensitive information such as passwords, API keys, and authentication tokens from log output while maintaining functional access for task execution.

:::image type="content" source="../media/vars-3569d015.png" alt-text="Screenshot showing Variables tab.":::
