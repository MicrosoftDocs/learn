Once an application is deployed to production, updates are a possible source of errors. In the worst case, a bad update can cause downtime. To avoid this, the deployment process must be predictable and repeatable. Deployment includes provisioning Azure resources, deploying application code, and applying configuration settings. An update may involve all three, or a subset. 

The crucial point is that manual deployments are prone to error. Therefore, it's recommended to have an automated, idempotent process that you can run on demand and rerun if something fails. Use the following tools and services for different deployment tasks:

- To automate provisioning of Azure resources, you can use Terraform, Ansible, Chef, Puppet, PowerShell, CLI, or Azure Resource Manager templates.
- Use Azure Machine Configuration to audit or configure operating-system and application settings on supported Azure VMs, with Azure Policy available for management at scale. For initial configuration of supported Linux VM images, use cloud-init.
- You can automate application deployment using Azure DevOps Services or Jenkins.

> [!NOTE]
> Azure Machine Configuration requires the Microsoft.GuestConfiguration resource provider to be registered, the machine configuration extension, and a system-assigned managed identity on Azure VMs. Applying configurations requires extension version 1.26.24 or later. Check the [supported operating systems](/azure/governance/machine-configuration/overview/01-overview-concepts#supported-client-types) and [prerequisites](/azure/governance/machine-configuration/overview/02-setup-prerequisites), including OS compatibility with current agents. For existing Azure Automation State Configuration deployments, follow Microsoft's [migration guidance](/azure/governance/machine-configuration/whats-new/migrating-from-azure-automation).

Azure Automation State Configuration is scheduled to retire on September 30, 2027.

Two concepts related to resilient deployment are _infrastructure as code_ and _immutable infrastructure_.

**Infrastructure as code** is the practice of using code to provision and configure infrastructure. Infrastructure as code can use a declarative approach or an imperative approach (or a combination of both). Resource Manager templates are an example of a declarative approach. PowerShell scripts are an example of an imperative approach.

**Immutable infrastructure** is the principle that you shouldn't modify infrastructure after it's deployed to production. Otherwise, ad hoc changes can leave you unsure of what's changed, making the system harder to reason about.

Another question is how to roll out an application update. Choose a controlled rollout method to minimize the impact of a bad deployment:

- Blue-green deployment is a technique in which an update is deployed into a production environment separate from the live application. After you validate the deployment, switch the traffic routing to the updated version. For example, Azure App Service Web Apps enables this with staging slots. 
- Canary releases are like blue-green deployments. Instead of switching all traffic to the updated version, you roll out the update to a small percentage of users, by routing a portion of the traffic to the new deployment. If there's a problem, back off and revert to the old deployment. Otherwise, route more of the traffic to the new version, until it gets 100% of the traffic.

> [!NOTE]
> App Service deployment slots require a Standard, Premium, or Isolated plan. Slots are separate live applications, but they share the plan's compute capacity. Review slot-specific settings and connection strings before swapping. When testing needs compute isolation, use a separate app in a separate App Service plan, rather than another slot in the production plan.

Define health criteria before deployment, including availability, error rates, latency, and critical user journeys. Observe each rollout stage under representative usage for a suitable period before increasing exposure; no errors during a period with no traffic isn't evidence of health. Stop promotion and initiate the recovery plan if health deteriorates.

Prepare and test a recovery plan before deployment. Retain the last-known-good application version and verify its compatibility with the database and dependent services before using it for rollback. For progressive rollouts, keep schema changes compatible with concurrently running versions and with the intended rollback version. If that isn't possible, use a coordinated deployment and stateful recovery plan instead of assuming that switching application versions is safe. Record the deployed application version in logs.

> [!IMPORTANT]
> Reverting application code or swapping deployment slots doesn't reverse database changes. Plan stateful recovery separately: depending on the change, use a tested rollback, a roll-forward fix, or a restore procedure. Account for recovery time and any data written since the deployment.
