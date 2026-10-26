Among Elastic on Azure deployment options, Elastic on Azure VMs provides users the most control over the underlying Azure infrastructure. Teams with established orchestration practices around Azure IaaS tend to choose this option. In cases where customers want to migrate on-premises Elasticsearch on Linux deployments to Azure, they may pick this option to minimize rearchitecture. 

## Example scenario

Imagine that you work for a startup retailer that uses Elastic on-premises to manage sales transactions. The company would like to move it to the cloud to improve data accessibility for remote workers from other departments. Moving to the cloud would also reduce the IT burden of procuring and maintaining infrastructure. You help by offering to migrate the workload as-is to Azure VMs, beginning with deploying Elastic on Azure VMs.

## What will we do?

This intermediate module prepares a new self-managed Elastic deployment on Azure VMs; migrating existing application data is a separate task. The exercise uses three Elasticsearch nodes and one Kibana VM, Ubuntu Server 24.04 LTS, and matching Elastic 9.5.5 packages. You configure private networking, enroll the nodes, enable browser HTTPS, and verify a synthetic document and its replica.

You need an Azure subscription with permission and quota for the four VMs, persistent disks, and networking. You also need Linux administration and SSH skills, an approved routed administrator connection to the private lab network, and permission to use an approved server certificate or a temporary lab CA. Establish these prerequisites before the exercise; it doesn't build a VPN or configure corporate certificate policy for you.

> [!IMPORTANT]
> Estimate the cost of all exercise resources before creating them, including three Elasticsearch VMs, a Kibana VM, disks, outbound connectivity, and administrator network access. Costs vary by region, size, and runtime; this exercise isn't guaranteed to be free and doesn't provide a sandbox. Any Azure trial credit is subject to its eligibility and spending limits. After the exercise, delete the dedicated lab resources and remove temporary workstation certificates and keys.

## What's the main goal?

By the end of this module, you're able to:

- Distinguish self-managed Azure VMs from the Elastic-operated managed-service alternative.
- Deploy a private, three-node Elasticsearch cluster and enroll Kibana.
- Configure trusted HTTPS and verify cluster membership, document access, and replica allocation.
- Clean up lab resources without deleting shared infrastructure.
