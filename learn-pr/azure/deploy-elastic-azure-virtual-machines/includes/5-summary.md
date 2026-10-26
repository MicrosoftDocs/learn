In the scenario for this module, the startup retailer you work for uses Elastic on-premises to manage sales transactions. The company asked you to migrate the Elastic workload to the cloud to improve data accessibility for remote workers from other departments and reduce the IT burden of maintaining infrastructure. 

You prepared a self-managed Elasticsearch cluster on Azure VMs, enrolled additional nodes, configured Kibana access, and checked the deployment with authenticated HTTPS requests and synthetic data. You also reviewed the separate responsibilities and hosting boundary of Elastic Cloud on Azure. This prepares a target environment; it doesn't migrate the retailer's existing data.

Delete the disposable exercise resources after completing the checks, and remove temporary workstation certificate/key copies and any lab CA trust entry. Don't delete shared administrator connectivity or organizational trust anchors. For a real migration, separately plan version compatibility, data transfer, validation, and recovery.

## Next steps

Before using this design for production, measure workload capacity and storage performance, design availability-zone placement and client routing, configure monitoring, and test snapshot restoration. The exercise's single Kibana VM isn't highly available.

Logstash is a separate ingestion extension, not required to complete this module. If your workload needs it, provision and budget for a separate supported host, use a matching maintained version, and follow the APT installation instructions listed in **More info**. Configure a specific input and an HTTPS Elasticsearch output with CA trust and least-privilege credentials using the Logstash connection guidance in that section. Store credentials in the supported keystore, restrict any input port and its sources, and extend the Elasticsearch HTTPS network rules to the ingestion host. `logstash_system` is a monitoring identity, not a pipeline output identity. Verify synthetic input end to end before using real data.

## More info

Explore these resources for the guidance referenced throughout this module.

### Release support and installation

Use these resources to choose supported versions and install the stack:

- [Elastic Support Matrix](https://www.elastic.co/support/matrix)
- [Elastic version policy](https://www.elastic.co/support/eol)
- [Elasticsearch downloads](https://www.elastic.co/downloads/elasticsearch)
- [Self-managed Elasticsearch installation](https://www.elastic.co/docs/deploy-manage/deploy/self-managed/installing-elasticsearch)
- [Elastic Stack version compatibility](https://www.elastic.co/docs/deploy-manage/deploy/self-managed/installing-elasticsearch#version-compatibility)
- [Elasticsearch Debian-package installation and node enrollment](https://www.elastic.co/docs/deploy-manage/deploy/self-managed/install-elasticsearch-with-debian-package)
- [Reconfigure a node to join an existing cluster](https://www.elastic.co/docs/deploy-manage/deploy/self-managed/install-elasticsearch-with-debian-package#existing-cluster)
- [Update the config files after node enrollment](https://www.elastic.co/docs/deploy-manage/deploy/self-managed/install-elasticsearch-with-debian-package#update-config-files)
- [Kibana Debian-package installation](https://www.elastic.co/docs/deploy-manage/deploy/self-managed/install-kibana-with-debian-package)
- [Logstash APT installation](https://www.elastic.co/docs/reference/logstash/installing-logstash)

### Azure infrastructure and costs

Use these resources to plan, provision, and remove the lab infrastructure:

- [Dsv5 VM sizes](/azure/virtual-machines/sizes/general-purpose/dsv5-series)
- [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator/)
- [Create a Linux VM in the Azure portal](/azure/virtual-machines/linux/quick-create-portal)
- [Static private IP configuration](/azure/virtual-network/ip-services/virtual-networks-static-private-ip#change-private-ip-address-to-static)
- [Managed disks](/azure/virtual-machines/managed-disks-overview)
- [Create a Standard NAT Gateway](/azure/nat-gateway/quickstart-create-nat-gateway#create-the-nat-gateway)
- [Azure outbound connectivity guidance](/azure/virtual-network/ip-services/default-outbound-access)
- [NSG rule evaluation](/azure/virtual-network/network-security-groups-overview)
- [VM billing states](/azure/virtual-machines/states-billing#power-states-and-billing)

### Elasticsearch configuration and security

Use these guides to configure nodes, secure connections, and create the browser certificate:

- [Elasticsearch system configuration](https://www.elastic.co/docs/deploy-manage/deploy/self-managed/important-system-configuration)
- [Virtual memory map count](https://www.elastic.co/docs/deploy-manage/deploy/self-managed/vm-max-map-count)
- [Node settings](https://www.elastic.co/docs/reference/elasticsearch/configuration-reference/node-settings)
- [Elasticsearch data paths](https://www.elastic.co/docs/reference/elasticsearch/configuration-reference/node-settings#path-data)
- [Node roles](https://www.elastic.co/docs/deploy-manage/distributed-architecture/clusters-nodes-shards/node-roles)
- [Built-in users](https://www.elastic.co/docs/deploy-manage/users-roles/cluster-or-deployment-auth/built-in-users)
- [Automatic security setup](https://www.elastic.co/docs/deploy-manage/security/self-auto-setup)
- [Automatic security setup exceptions](https://www.elastic.co/docs/deploy-manage/security/self-auto-setup#stack-skip-auto-configuration)
- [Elasticsearch certificate utility](https://www.elastic.co/docs/reference/elasticsearch/command-line-tools/certutil)

### Kibana and Logstash configuration

Use these guides to configure Kibana HTTPS and optional Logstash ingestion:

- [Kibana HTTPS](https://www.elastic.co/docs/deploy-manage/deploy/self-managed/tutorial-self-managed-secure#install-stack-demo-secure-kib-https)
- [Kibana keystore](https://www.elastic.co/docs/deploy-manage/security/secure-settings#kibana)
- [Kibana private-key passphrase setting](https://www.elastic.co/docs/reference/kibana/configuration-reference/general-settings#server-ssl-keypassphrase)
- [Multiple-node Kibana connections](https://www.elastic.co/docs/deploy-manage/production-guidance/kibana-load-balance-traffic#high-availability-across-multiple-elasticsearch-nodes)
- [Create a data view](https://www.elastic.co/docs/explore-analyze/find-and-organize/data-views/create-data-view)
- [Logstash secure connections](https://www.elastic.co/docs/reference/logstash/secure-connection)
- [Connecting Logstash to Elastic Cloud](https://www.elastic.co/docs/reference/logstash/connecting-to-cloud)

### Availability and performance

Use these resources to plan resilience and measure workloads before production:

- [Small-cluster resilience](https://www.elastic.co/docs/deploy-manage/production-guidance/availability-and-resilience/resilience-in-small-clusters)
- [Kibana high availability](https://www.elastic.co/docs/deploy-manage/production-guidance/kibana-load-balance-traffic)
- [Logstash deployment and scaling](https://www.elastic.co/docs/reference/logstash/deploying-scaling-logstash)
- [Rally](https://github.com/elastic/rally)

### Managed-service alternative

Use these resources if you choose the Elastic-operated alternative:

- [Elastic Cloud (Elasticsearch) - Azure Native ISV Service](/azure/partner-solutions/elastic/overview)
- [Azure Native hosting boundaries](https://www.elastic.co/docs/deploy-manage/deploy/elastic-cloud/azure-native-isv-service#azure-integration-azure-tenant)
- [Managed-service prerequisites](/azure/partner-solutions/elastic/create#prerequisites)
- [Create an Elastic application](/azure/partner-solutions/elastic/create)
- [Elastic Azure Private Link guidance](https://www.elastic.co/docs/deploy-manage/security/private-connectivity-azure)
- [Elastic resource deletion guidance](/azure/partner-solutions/elastic/manage#delete-elastic-resource)
- [Elastic's resource-group restrictions](https://www.elastic.co/docs/deploy-manage/deploy/elastic-cloud/azure-native-isv-service#ec-azure-integration-delete)
- [Cancel a Marketplace SaaS subscription](/marketplace/saas-subscription-lifecycle-management#cancel-a-subscription)
