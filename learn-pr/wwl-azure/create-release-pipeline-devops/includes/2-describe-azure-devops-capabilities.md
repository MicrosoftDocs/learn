
Azure DevOps has extended support for pipelines as code (also called YAML pipelines) for continuous deployment and started introducing various release management capabilities into pipelines as code.

The existing UI-based release management solution in Azure DevOps is referred to as classic release.

You'll find a list of capabilities and availability in YAML pipelines vs. classic build and release pipelines in the following table.

| **Feature**           | **YAML** | **Classic Build** | **Classic Release** | **Notes**                                                                                                                                                   |
| --------------------- | -------- | ----------------- | ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Agents                | Yes      | Yes               | Yes                 | Specifies a required resource on which the pipeline runs.                                                                                                   |
| Approvals             | Yes      | No                | Yes                 | Defines a set of validations required before completing a deployment stage.                                                                                 |
| Artifacts             | Yes      | Yes               | Yes                 | Supports publishing or consuming different package types.                                                                                                   |
| Caching               | Yes      | Yes               | No                  | Reduces build time by allowing outputs or downloaded dependencies from one run to be reused in later runs. In Preview, available with Azure Pipelines only. |
| Conditions            | Yes      | Yes               | Yes                 | Specifies conditions to be met before running a job.                                                                                                        |
| Container jobs        | Yes      | No                | No                  | Specifies jobs to run in a container.                                                                                                                       |
| Demands               | Yes      | Yes               | Yes                 | Ensures pipeline requirements are met before running a pipeline stage. Requires self-hosted agents.                                                         |
| Dependencies          | Yes      | Yes               | Yes                 | Specifies a requirement that must be met to run the next job or stage.                                                                                      |
| Deployment groups     | Yes      | No                | Yes                 | Defines a logical set of deployment target machines.                                                                                                        |
| Deployment group jobs | No       | No                | Yes                 | Specifies a job to release to a deployment group.                                                                                                           |
| Deployment jobs       | Yes      | No                | No                  | Defines the deployment steps. Requires Multi-stage pipelines experience.                                                                                    |
| Environment           | Yes      | No                | No                  | Represents a collection of resources targeted for deployment. Available with Azure Pipelines only.                                                          |
| Gates                 | No       | No                | Yes                 | Supports automatic collection and evaluation of external health signals before completing a release stage. Available with Azure Pipelines only.             |
| Jobs                  | Yes      | Yes               | Yes                 | Defines the execution sequence of a set of steps.                                                                                                           |
| Service connections   | Yes      | Yes               | Yes                 | Enables a connection to a remote service that is required to execute tasks in a job.                                                                        |
| Service containers    | Yes      | No                | No                  | Enables you to manage the lifecycle of a containerized service.                                                                                             |
| Stages                | Yes      | No                | Yes                 | Organizes jobs within a pipeline.                                                                                                                           |
| Task groups           | No       | Yes               | Yes                 | Encapsulates a sequence of tasks into a single reusable task. If using YAML, see templates.                                                                 |
| Tasks                 | Yes      | Yes               | Yes                 | Defines the building blocks that make up a pipeline.                                                                                                        |
| Templates             | Yes      | No                | No                  | Defines reusable content, logic, and parameters.                                                                                                            |
| Triggers              | Yes      | Yes               | Yes                 | Defines the event that causes a pipeline to run.                                                                                                            |
| Variables             | Yes      | Yes               | Yes                 | Represents a value to be replaced by data to pass to the pipeline.                                                                                          |
| Variable groups       | Yes      | Yes               | Yes                 | Use to store values that you want to control and make available across multiple pipelines.                                                                  |
