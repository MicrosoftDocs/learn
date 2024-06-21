Now you can begin the technical implementation of your migration. To [deploy your workload](/azure/cloud-adoption-framework/migrate/deploy/) and remediate problems, use your workload architecture and assessment materials from the Assess phase. Perform detailed testing to ensure that you clearly understand how your services operate together.

## Deploy supporting services

[Deploy all services](/azure/cloud-adoption-framework/migrate/deploy/deploy-supporting-services) to ensure that your workload can operate successfully.  Your workload likely requires [services](/azure/cloud-adoption-framework/migrate/deploy/deploy-supporting-services#required-services) for resource organization, networking, identity and security, and management. Determine which [services that you can deploy early](/azure/cloud-adoption-framework/migrate/deploy/deploy-supporting-services#plan-for-supporting-service-deployment) in the process, such as core, no-cost, or consumption-based services. You can also deploy services that you can pause until you're ready to use them. Also determine which services that you can deprovision after you use them.

## Remediate assets

Identify configurations that might make an asset incompatible with your cloud provider. Perform necessary [remediation](/azure/cloud-adoption-framework/migrate/deploy/remediate) to ensure that you can properly replicate and stage your workload in the cloud.

Identify remediation tasks when you do assessments or tests, and then [track your tasks](/azure/cloud-adoption-framework/migrate/deploy/remediate#track-remediation-activities). You can use tools like Azure DevOps to create and prioritize work items and move through specific phases to help you scale out.

To prepare assets for migration, you might need to do [remediation tasks](/azure/cloud-adoption-framework/migrate/deploy/remediate#common-remediation-tasks), such as:

- Minor host upgrades.
- Minor guest operating system upgrades.
- Service-level agreement (SLA) modifications.
- Application configuration changes.
- Minor network path changes.

Some organizations might require [large-scale remediation tasks](/azure/cloud-adoption-framework/migrate/deploy/remediate#large-scale-remediation-tasks) that can interrupt the speed or consistency of a migration. For example, your organization might need to frequently upgrade hosts or guest operating systems. In that scenario, you can separate remediation into a parallel team effort, similar to the cloud adoption and cloud governance structure.

If large-scale remediations are extensive, you might find that [modernization activities](/azure/cloud-adoption-framework/migrate/deploy/remediate#address-large-scale-remediations) are more efficient and productive. Consider implementing containerization or automation or rebuilding your workload.

## Replicate assets

The [replication process](/azure/cloud-adoption-framework/migrate/deploy/replicate) consists of the following steps:

1. **Replicate**: Copy a point-in-time version of various binaries.
1. **Seed**: Copy the binary snapshots to a new platform, and deploy them onto new hardware.
1. **Synchronize**: Align the new binary and the old binary.

Replication [prerequisites](/azure/cloud-adoption-framework/migrate/deploy/replicate#prerequisites-for-replication) include:

- A subscription for your migrated resources.
- A migration tool to move the binary copies over.
- The source binaries, prepared for replication and synchronization. 
- Any dependencies for your workload that you identified during the workload architecture design step.

Consider the [potential factors](/azure/cloud-adoption-framework/migrate/deploy/replicate#replication-risks-physics-of-replication) that commonly affect migration plans, such as replication time and the cumulative effect of disk drift.

## Prepare for management activities

After you complete your migration, prepare to carry out [management activities](/azure/cloud-adoption-framework/migrate/deploy/prepare-for-management#minimum-management-goals) to prevent problems, like outages, breaches, and poor performance.

Ensure that you have a management routine in place for each workload. Plan and prepare for the following activities:

- Have logging systems that collect the appropriate logs, such as activity logs, diagnostic logs, and system logs.
- Configure alerts.
- Have backup configurations and processes to restore state.
- Have a business continuity and disaster recovery (BCDR) configuration to fail over and restore service.
- Perform security posture management and vulnerability detection.
- Enable a serial code in Azure Virtual Machines to help with troubleshooting.
- Enable automatic shutdown for virtual machines that meet business requirements.
- Deploy tags and remediate incorrect tags.
- Update virtual machines.

## Test your migration deployment in Azure

Test your architecture and your management plan. Migration testing focuses on IT activities. List the problems that you discover during testing so that you can track and remediate them.

[Perform test migrations](/azure/cloud-adoption-framework/migrate/deploy/migration-test#perform-test-migrations) in isolated environments to ensure that you don't affect production workloads. You can create a replica of your source systems that runs in parallel to the live systems.

To do tests, you need:

- An isolated network.
- Isolated network access.
- An authentication mechanism.

After you do testing, make sure that you:

- **Record problems** that you discover.
- **Triage problems** based on their severity, and identify workarounds.
- **Document workarounds**. If you can incorporate the workaround as part of the migration, you might not need to remediate the problem.
- **Start with non-workaround items**. Consider remediating items without workarounds first.



