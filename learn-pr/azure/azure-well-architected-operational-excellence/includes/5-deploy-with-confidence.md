| :::image type="icon" source="../media/goal.svg"::: Reach the desired state of deployment with predictability. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Build a workload supply chain that enables you to consistently reach the goal of predictability in all of your environments, across the workload's hosting platforms, applications, data, and configuration resources. The deployment mechanism must be capable of automation, testing, monitoring, and versioning. It should be modularized and ready to execute on demand. It shouldn't be represented as a monolithic end-to-end process. The supply chain isn't necessarily for faster execution, but to achieve consistency and self-documentation over multiple iterations.

The workload team is accountable for the supply chain as it relates to their own workload.

**Example scenario**

Contoso Manufacturing has developed a Java-based application that is used to monitor and optimize their manufacturing processes. The workload has recently been migrated to Azure and is now running on Azure Spring Apps, Azure Database for MySQL and Azure IoT Hub.

## Deploy infrastructure through code

**Use Infrastructure as Code (IaC) to define the repeatable aspects of the supply chain that are production ready. Prefer declarative approaches over imperative methods.**

Declarative IaC technologies are designed with automation and reusability in mind. You can offload infrastructure deployments from individuals into tooling and achieve consistent quality.

From an infrastructure perspective, having fewer technology choices removes variance in tooling and makes configuration drift easy to detect. Maintenance will also be easier. If you align choices with the team's existing skill set, the team can easily adopt them.

*Contoso's challenge*

- The on-premises version of the workload used a combination of scripts and manual steps to build out the infrastructure and deploy the application across environments. Early in the process of the Azure migration, the team made modifications to the existing imperative scripts to target the new platform so they could reuse as much of the existing automation codebase as possible. This approach was also taken due to a lack of expertise with Azure and IaC technologies like Bicep.
- As the migration progressed and the team became more familiar with the platform, they became convinced that using an IaC approach with Bicep was going to be a better solution longer term.

*Applying the approach and outcomes*

- Lacking knowledge in-house, the team contracted the work to migrate and extend the deployment automation scripts for the workload to experienced contractors, who worked embedded with the dev team during the initial phases of the project, while providing knowledge transfer to the rest of the team.
- The resulting Bicep-based implementation provides a more reliable, manageable, and efficient way to provision infrastructure in Azure. The code is now more readable and maintainable, with great tooling support in VSCode. It is also fully idempotent and simplifies state management, which they were never able to fully accomplish with the previous/imperative version. 

## Treat your IaC the same as your application code

**Follow software recommendations for IaC development and maintenance: Modularize in moderation, avoid custom or low-value abstractions, and follow a layered approach to reflect different lifecycles. Form foundational layers where the lower layers stay constant and the upper layers change as needed.**

**Deployment artifacts, such as application binaries, IaC templates, and parameters, are part of the attack surface. Apply assurances, such as secret management, access control, and other principles of the Security pillar.**

Artifacts experience the same level of engineering rigor as application code. Quality controls through peer reviews and testing give you confidence in deployment.

A layered approach makes maintenance easier and creates boundaries that establish clear lines of responsibility.

Adding security controls to artifacts helps harden the system during the deployment process.

*Contoso's challenge*

- The project team had a generous budget at the beginning of the migration effort, so they hired very experienced contractors that delivered with high quality and in a short period of time. The contractors used a separate repo for their development, and that repo has not been regularly audited for security whereas the main application code repo is.
- The team is getting ready to release a major redesign of the solution, and the deployment code needs significant changes. Due to a scarcity of development resources, the latest batch of changes are being made by two interns. When one of the senior developers on the team is called in to help the interns, he notices multiple commits in the repo that are not at par with the team’s development standards, including having application secrets like API keys hardcoded in the codebase.

*Applying the approach and outcomes*

- The team decides to move the build and deployment codebase to the same repo used for the application code and to start applying the same level of engineering rigor as other areas of the codebase. The code is brought to team standards before the first commit, application secrets are removed, and all other team quality standards and tools are applied to it.
- As a result, the team has secured this section of the codebase while increasing the code quality. Moving forward, changes to this area of the codebase will follow the same standards and leverage the same tools used for the core application codebase, including peer code reviews and automated scanning of the code with quality and security tooling.

## Standardize deployments on a single manifest

**Develop a common deployment manifest that's used across all environments. Use that manifest as the default mechanism for greenfield projects, incremental workload updates, or disaster recovery.**

Applying this approach will allow you to remove the overhead of maintaining multiple assets.

If there's a disaster, recovery will be quick and reliable because you can deploy a tried and tested manifest instead of creating an improvised environment.

*Contoso's challenge*

- Contoso Manufacturing uses a fully automated pipeline to deploy the infrastructure, application code, and configuration changes to the development and production environment. The application is configured to be highly available in a single region. Most application components are stateless, except for the MySQL database. The database is backed up as dictated by the established RTO/RPO and the backup is replicated to a secondary region.
- If a major or catastrophic failure occurs in the primary region, the team plans to build a new environment to host the application in the secondary region. During a planned drill to test the DR procedures, the deployment scripts fail when trying to recreate the environment in the secondary region due to the lack of availability of several resources and other service limitations. 

*Applying the approach and outcomes*

- The team mitigates the issues they encountered when trying to provision in the secondary region by replacing the use of some resources with equivalent SKUs that are available in both regions and making some options configurable so a different, but valid, value can be used in the secondary.
- The exercise has increased the confidence of the team in their ability to recover from major infrastructure failures.