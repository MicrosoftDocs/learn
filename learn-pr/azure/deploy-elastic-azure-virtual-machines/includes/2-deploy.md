Azure virtual machines (VMs) provide Azure users a flexible way to deploy their new and existing Elastic workloads on cloud infrastructure. This deployment option is best for teams that need the most control on infrastructure to meet architectural or compliance constraints, such as teams whose workloads must be deployed within their Azure tenant.

Recall that the start-up retailer you work for currently uses Elastic on-premises to manage sales transactions. They would like to migrate to Azure VMs to improve data accessibility for remote workers and other departments while reducing the burden of maintaining infrastructure.

Here, you'll learn about the steps for deploying an Elastic workload on Azure VMs.

## Start with the Elasticsearch (self-managed) template in the Azure Marketplace

The Elasticsearch (self-managed) template is an Azure Marketplace solution that provides a quick way to deploy Elastic using best practices.

The Azure Marketplace template provides a user interface (UI) within the Azure portal that guides you through a series of setup steps. During setup, you provide the minimum number of input parameters needed to deploy an Elasticsearch cluster to Azure. Following the last step, the UI feeds the provided parameter values to an Azure Resource Manager (ARM) template that deploys the requested Azure resources to a resource group. In a matter of minutes, you have a running cluster! You can also use the ARM template with Azure CLI and PowerShell to further customize your deployment.

With the template, you'll be guided through the following configuration settings:

- Basics: establish your username, authentication type (password vs. SSH public key), subscription, resource group, and region.
- Cluster settings: name the cluster and configure the virtual network and Elasticsearch nodes subnet.
- Data node configuration: select the number and size of nodes and disks. In the following exercise, we'll create a three node cluster. We'll make the data nodes master-eligible because a cluster of this size usually doesn't benefit from dedicated master nodes. For more information on node types, see the Elasticsearch guide in the references section.
- Kibana & Logstash: determine whether to deploy Kibana and/or Logstash in addition to Elasticsearch, and how the cluster can be accessed from outside of the virtual network. 
- Security: create an Elastic superuser account and accounts for Kibana, Logstash, Beats, APM, and remote monitoring.

## Can I use my existing Azure subscription?

Yes! To deploy Elastic into your own Azure subscription, use the official Elasticsearch (self-managed) Microsoft Azure Marketplace template. 
  
## Is the UI-based Elasticsearch (self-managed) Microsoft Azure Marketplace template the only method for deploying Elastic on Azure VMs?

No! You can also use both Azure CLI and Azure PowerShell to automate your Elastic deployment.

## How much Elastic do I need to deploy when starting?

You can start anywhere, monitor the deployment under the initial load, and scale accordingly. Elasticsearch is a horizontally scalable distributed system.

Elastic also offers [Rally](https://github.com/elastic/rally), a macro benchmarking framework that lets you test the performance of your initial setup and grow accordingly in a separate environment.

To start fast, we recommend following these two guidelines:

- Start with a three-node Elasticsearch cluster for a production environment. While you may be able to support your use case with single node Elasticsearch clusters, it's recommended that you start with a three-node cluster. A three-node cluster provides resiliency for the architecture and room to perform lifecycle operations such as upgrade, security patching for the underlying infrastructure, and mitigating data loss with replication. Elastic Cloud takes care of many of these issues, so you can focus on onboarding the data into Elastic and getting insights and value from it.
- Use two Kibana instances for High Availability. Kibana is the window into the Elastic stack – whether you're exploring the data in Elasticsearch or the management of the Elastic components. Given its value to all the use cases of Elastic, we recommend at least two instances of Kibana behind a load balancer to provide fault tolerance and higher chances of uninterrupted access to Elastic. If Kibana is unavailable it doesn’t necessarily lead to data loss, but it can create disruptive experiences for end users.

## Install Kibana and Logstash as part of your deployment

With every deployment of Elastic on Azure, you'll be prompted to install Kibana and Logstash, and set the VM to run each of those workloads.

### Set up Kibana

Kibana is the window into the Elastic stack that lets users visualize their data in Elasticsearch while also helping operators monitor and manage Elastic. If you use another tool or service for data analysis/reporting, you may choose to not install Kibana. However, if your use case involves running numerous data analytics, creating reports, and sharing visualizations, you may want to install Kibana as part of your initial setup. The default in the template is a good starting point for your Kibana VM size. As you monitor Kibana metrics, you can accordingly grow your VM size.

### Set up Logstash

If your use case requires transformation of the data before it's ingested into Elasticsearch, Logstash offers a flexible and powerful way of performing multiple types of transformations. It has a rich ecosystem of input and filter plug-ins that help you with the transformation. The UI template default calls for one VM for Logstash, however, in most production environments, at least two VMs are recommended for high availability in your data processing.

### Set security passwords for system users

The Azure Marketplace Elasticsearch (self-managed) template embeds the best practices when it comes to securing your Elastic deployment. These best practices include securing communication between users or applications and Elastic deployment, and between the various components of the Elastic deployment. Therefore, the final step requires you to set passwords for your system user accounts. You'll create a password for each system you've installed and to enable remote monitoring.

## How are other customers using Elastic on Azure VMs?

Devon Energy, the leading independent oil and natural gas exploration and production company wanted to augment and replace its legacy SIEM solution with a homegrown analytics and automation platform. It moved from on-premises Elasticsearch to Elastic on Azure VMs using Elasticsearch optimizations for security telemetry pipeline, and Kibana as the frontend for security and operational logs.
