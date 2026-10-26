Azure virtual machines (VMs) provide Azure users a flexible way to deploy their new and existing Elastic workloads on cloud infrastructure. This deployment option is best for teams that need the most control over infrastructure to meet architectural or compliance constraints, such as teams whose workloads must be deployed within their Azure tenant.

Recall that the startup retailer you work for currently uses Elastic on-premises to manage sales transactions. They'd like to migrate to Azure VMs to improve data accessibility for remote workers and other departments while reducing the burden of maintaining infrastructure.

Here, you learn about the steps for deploying an Elastic workload on Azure VMs. Links to the guidance referenced in this unit are in the summary's **More info** section.

## Choose the deployment responsibility model

For a deployment in your own Azure subscription on infrastructure that you control, create Azure Linux VMs and install Elasticsearch, Kibana, and any required ingestion components using supported Elastic packages. You manage guest-OS and application updates, networking, certificates, access control, capacity, backups, and recovery. Azure manages the underlying physical infrastructure.

Use the Elastic Support Matrix and version policy to choose a supported OS and maintained Elastic release. For a new installation, use matching Elastic Stack versions following the installation compatibility guidance. A UI default isn't a release-support policy.

For Elastic-operated infrastructure, consider Elastic Cloud (Elasticsearch) - Azure Native ISV Service. Cloud Hosted provides managed Elasticsearch and Kibana with Azure integration and billing.

> [!NOTE]
> The managed service doesn't deploy Elasticsearch into your Azure tenant. A linked Azure resource isn't ownership of the backing VMs. Choose self-managed VMs when customer-controlled infrastructure is a requirement. Logstash can send data to Elastic Cloud, but the managed-service onboarding flow isn't an installer for a customer-owned Logstash VM.

See the guidance on Azure Native hosting boundaries and connecting Logstash to Elastic Cloud.

### Compare the managed-service alternative

The following overview is optional. You don't need to purchase the managed service to complete the VM exercise. To compare the managed-service alternative, follow these steps:

1. Check the current managed-service prerequisites, including subscription-level Owner/Contributor access and Marketplace purchasing eligibility. Resolve any tenant consent requirements; the deployment creator doesn't universally need to be a tenant administrator. Don't assume that Azure trial credits fund this purchase.
1. Follow the instructions in Create an Elastic application. Choose **Cloud Hosted** for this comparison, then the subscription/resource group, supported region, and appropriate plan. Review actual pricing and billing terms before **Review + create** and **Create**.
1. Open the deployment through the integration and verify Elasticsearch/Kibana access. The customer-side integration resource isn't a set of Elasticsearch VMs in your tenant. Logstash remains a separately configured sender.
1. If private access is required, follow Elastic Azure Private Link guidance, including the private endpoint, DNS, and Elastic-side connection policy. A private endpoint changes connectivity, not ownership or location of the backing service. For Cloud Hosted, Elastic Cloud-console SSO doesn't sign you in through the private Kibana endpoint; use supported stack authentication or a separately configured identity provider as described in that guide.
1. Before cleanup, inventory all deployments in the Elastic organization and check which Azure subscription receives its bill. Delete Azure-created resources through Azure and follow Elastic resource deletion guidance. Delete only the intended lab deployments; never delete unrelated deployments to stop a shared organization's bill. Follow Elastic's resource-group restrictions: don't delete the first deployment's resource group while other deployments remain billed against it.
1. Separately inspect the Marketplace SaaS subscription and its contract terms. If this was a dedicated lab SaaS subscription, cancel it using the applicable SaaS lifecycle procedure. Deleting one resource group, or even the last deployment, doesn't establish that the commercial subscription has been canceled.

## Provision and install

Create the VMs, persistent storage, and network controls in a dedicated resource group. Establish administrator connectivity and explicit outbound access for package installation. On Ubuntu, follow the Elasticsearch Debian guide, then the Kibana Debian guide. Configure optional Logstash separately.

Azure CLI and Azure PowerShell can automate Azure resource provisioning; Elastic software installation and configuration must also be implemented. Provisioning an Azure VM alone doesn't create a working Elasticsearch cluster.

The exercise uses a deliberately small four-VM configuration: three Elasticsearch nodes and one Kibana host, each with 2 vCPUs, 8 GiB RAM, and persistent managed storage. It supplies fixed package versions, a private address plan, explicit NSG rules, and a separate browser certificate. This makes the learning procedure concrete; it doesn't make those sizes a production sizing recommendation.

## Size and make the deployment resilient

Use Rally in a separate test environment to assess representative workloads. Account for Elasticsearch heap, non-heap memory, filesystem cache, storage capacity/IOPS, and failure headroom. Prefer the default automatic heap sizing unless you have a measured reason to override it.

Three data nodes that are also master-eligible are a reasonable small-cluster starting point. For ordinary indices, ensure there's at least one allocated replica and that clients can reach more than one node or an appropriate load-balanced endpoint. Three such master-eligible nodes can retain a voting majority after one node fails. Node count alone doesn't establish availability-zone resilience or replace snapshots. See the guidance on small-cluster resilience and node roles.

For production Kibana availability, use multiple instances with appropriate load balancing and consistent configuration.

> [!IMPORTANT]
> Kibana instances sharing a deployment need matching `xpack.security.encryptionKey`, `xpack.reporting.encryptionKey`, and `xpack.encryptedSavedObjects.encryptionKey` values, plus matching authentication and session configuration. Coordinate key rotation and cookie configuration as described in the Kibana high-availability guide. A second independently configured VM isn't sufficient.

Logstash is optional. Deploy it when the ingestion design needs its input, filtering, routing, or buffering capabilities. Production availability requires more than installing two copies: configure inputs for load balancing or failover, suitable persistent queues, output authentication, and TLS. Follow the Logstash deployment and scaling guidance. Persistent queues are local to each instance; don't describe a pair of instances as a replicated shared queue.

## Configure identities and encrypted connections

Elasticsearch provides a predefined `elastic` superuser. Other built-in users have specific service or monitoring purposes; you don't choose their names. Use current Kibana enrollment to configure Kibana's connection to Elasticsearch. Create appropriately scoped identities or API keys for applications, ingestion, and human access. In particular, `logstash_system` is a monitoring identity, not a pipeline output identity.

> [!IMPORTANT]
> Authentication and encryption are separate. Confirm Elasticsearch transport TLS and HTTPS for the REST API, ensure clients trust the appropriate certificate authority, and configure HTTPS for browser-to-Kibana traffic separately. Automatic Elasticsearch security setup doesn't automatically enable Kibana's browser HTTPS endpoint. Restrict network access as well as configuring TLS; never solve certificate failures by disabling verification.

See the guidance on built-in users, automatic security setup and its exceptions, Kibana HTTPS, and Logstash security.

## Decide whether this model fits the retailer

Use self-managed VMs if customer-controlled guest operating systems and infrastructure are requirements, and the team can operate them. Moving the VMs to Azure removes physical hardware management, not responsibility for the guest OS, Elastic upgrades, snapshots, certificates, or capacity. If reducing those operational responsibilities is the stronger requirement, evaluate Elastic Cloud instead. In either case, prepare and verify a separate data-migration plan before moving the retailer's existing workload.
