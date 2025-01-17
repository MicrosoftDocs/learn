The Cloud Adoption Framework Migrate methodology helps you prepare for and carry out a migration to the cloud.

The migration process includes four stages: prepare, assess, deploy, and release. This approach is vendor-neutral, so you can migrate workloads to any cloud service.

## Prepare for migration

Before you plan individual workload migrations, you must ready your organization and cloud resources to support the migration. Regardless of which Azure landing zone reference implementation you use, you might need to do the following tasks to prepare your landing zone for a successful migration project.

- Establish hybrid connectivity.
- Prepare identity.
- Extend Active Directory domain controllers. 
- Enable hybrid DNS.
- Configure custom DNS resolution.
- Configure an Azure Firewall DNS proxy.
- Configure the hub firewall.
- Establish routing.
- Enable subscription vending.
- Set policies to enable Microsoft Defender for Cloud.

You also need to prepare tools to assess, replicate, and track your workloads through iterations, including remediation activities. You can use resources, like:

- Azure Migrate
- Azure DevOps
- Microsoft Project
- The Migration Execution Guide

You should also create a backlog that includes:

- Business outcomes and metrics.
- Business priorities.
- Core assumptions.

You also need to properly assign roles to cover all aspects of the migration, from planning and implementation to communication and support. Each role has specific responsibilities that contribute to the overall success of the migration project.

## Assess your workload

After you establish your preparations, evaluate the readiness of your workload and plan for the migrated state. Your cloud adoption team should evaluate technical compatibility, the required architecture, performance and sizing expectations, and dependencies. Calculate the cost of operating in Azure.

Classify workloads based on how significantly an outage affects your business. Classify data in your workloads based on how a potential leak of that data affects your business or customers. Highly sensitive data increases the security risk. 

Ensure that all assets and associated dependencies are compatible with your deployment model and cloud provider. Evaluate whether you have blockers for migration, and document any necessary remediation of compatibility problems.

Design the intended migrated state of your workload. During this process, you design your:

- Application landing zone architecture
- Workload network architecture with resources
- Workload dependencies
- Confidential computing

After you design essential components, revisit your cloud estimate and make adjustments if necessary.

## Deploy your assets

Deploy all services to ensure that your workload can operate successfully. Your workload likely requires services for resource organization, networking, identity and security, and management. Identify configurations that might make an asset incompatible with your cloud provider. Perform necessary remediation to ensure that you can properly replicate and stage your workload in the cloud.

The replication process consists of the following steps:

- **Replicate:** Copy a point-in-time version of various binaries.
- **Seed:** Copy the binary snapshots to a new platform, and deploy them onto new hardware.
- **Synchronize:** Align the new binary and the old binary.

After you complete your migration, prepare to carry out management activities to prevent problems, like outages, breaches, and poor performance. Test your architecture and your management plan. Migration testing focuses on IT activities. List the problems that you discover during testing so that you can track and remediate them. Perform test migrations in an isolated environment to ensure that you don't affect production workloads. You can create a replica of your source systems that runs in parallel to the live systems.

## Release your workload

You need to complete the migration steps, communicate the upcoming changes to other teams, make final change approvals, clean up resources, and do a retrospective.

Inform your organization about upcoming changes to ensure that everyone that the migration might affect knows the process. Communicate changes for each workload because each one has dedicated users and operators.

Business users of your workload should test your new solution. Identify users that your changes might affect most. Inform those users of your business objectives, desired outcomes, and expected changes to business processes. Collect feedback, and manage the resultant technical actions.

After you promote your asset and all of its dependencies to production, you can reroute production traffic. Then the on-premises assets are obsolete, and you can decommission them. After your migration, optimize your workload based on its live data, and decommission retired assets.

Do a retrospective after your migration to discover what went well, what could have been better, and what you learned. Get insight from each member of your team so that you can apply the lessons that you learned to future migrations.