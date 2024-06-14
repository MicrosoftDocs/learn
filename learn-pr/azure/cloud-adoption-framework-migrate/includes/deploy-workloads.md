Begin technical implementation of your migration. Use the workload architecture and assessment materials from the assess phase to begin deployment and remediation of problems. Perform detailed testing to ensure that you clearly understand how your services operate together.

## Deploy supporting services

Deploy all services to ensure that your workload can operate successfully. Determine which services that you can deploy early in the process, such as no-cost or consumption-based services and services that you can pause until you're ready to use them. Also determine which services that you can deprovision after you use them. Your workload likely requires services for resource organization, networking, identity and security, and management.

## Remediate assets

Identify configurations that might make an asset incompatible with your cloud provider. Perform any remediation necessary to ensure that you can properly replicate and stage your workload in the cloud. Also perform remediation for configuration incompatibilities that you discover during testing.

Identify remediation tasks when you do assessments or tests. Track your tasks. You can use tools like Azure DevOps to create and prioritize work items and move through specific phases to help you scale out.

Common remediation tasks that you might need to do to prepare assets for migration include:

- Minor host upgrades.
- Minor guest operating system upgrades.
- Service-level agreement (SLA modifications.
- Application configuration changes.
- Minor network path changes.

Some organizations might require large-scale remediation tasks that can interrupt the speed or consistency of a migration. For example, your organization might need to frequently upgrade hosts or guest operating systems. In that scenario, you can separate remediation into a parallel effort and team similar to cloud adoption and cloud governance.

If large-scale remediations are too extensive, you might find that modernization activities are more efficient and productive. Consider implementing containerization or automation or rebuilding your workload.

## Replicate assets

The replication process consists of the following steps:

1. Copy a point-in-time version of various binaries.
1. Copy the binary snapshots to a new platform and deploy them onto new hardware.
1. Align the new binary and the old binary.

Replication prerequisites include:

- A subscription for your migrated resources.
- A migration tool to move the binary copies over.
- The source binaries, prepared for replication and synchronization. 
- Any dependencies for your workload that you identified during the workload architecture design step.

## Prepare for management activities

Prepare to carry out management activities after you complete your migration to prevent problems, like outages, breaches, or poor performance.

Ensure that you:

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

Now you can test your architecture and your management plan. Migration testing focuses on IT activities. Identify problems that you might discover during testing so that you can track and remediate them.

Perform test migrations in isolated environments to ensure that you don't affect production workloads. You can create a replica of your source systems that runs in parallel to the live systems.

To do tests, you need:

- An isolated network.
- Isolated network access.
- An authentication mechanism.




