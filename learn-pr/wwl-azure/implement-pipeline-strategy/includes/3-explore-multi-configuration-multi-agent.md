Modern software development often requires testing across multiple configurations or distributing work across several agents to improve efficiency. Azure Pipelines supports different job execution strategies to meet these needs.

## Types of job execution

Azure Pipelines offers three job execution strategies:

**Single agent jobs**: Tasks run sequentially on a single agent. This is the default behavior and works well for simple workflows.

**Multi-configuration jobs**: Run the same tasks across multiple configurations simultaneously. Each configuration runs on a separate agent in parallel. Common use cases include:

- Testing different application configurations (Debug/Release, different frameworks)
- Deploying to multiple geographic regions
- Building for different target platforms

:::image type="content" source="../media/multi-configuration-job-1-277f163a.png" alt-text="Screenshot of Multi-configuration.":::

**Multi-agent jobs**: Distribute the same set of tasks across multiple agents to reduce execution time. For example:

- Running a large test suite (1,000 tests) across 4 agents (250 tests each)
- Parallel processing of large datasets
- Concurrent builds of different components

## Planning your job strategy

When designing your pipeline job strategy, consider:

**Artifacts and dependencies**:

- Do you have artifacts from multiple sources that need coordination?
- Are there dependencies between different deployment targets?

**Deployment requirements**:

- Can deployments run simultaneously across different servers?
- Do you need to support multiple platforms or environments?

**Performance considerations**:

- How long does your current pipeline take?
- Can tasks run in parallel, or must they execute sequentially?
- Would parallel execution reduce overall build time?

For more information, see [Specify jobs in your pipeline](/azure/devops/pipelines/process/phases).
