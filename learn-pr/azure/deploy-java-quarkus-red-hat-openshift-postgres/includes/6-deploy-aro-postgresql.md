In this module, you'll delve into deploying the Todo application to a scalable Azure Red Hat OpenShift cluster. Upon completion, you'll have successfully established an Azure Database for PostgreSQL server and a fully functional Todo application developed in Quarkus and deployed in a cloud-native environment.

Explore the underlying technologies in more detail here:

## Azure Red Hat OpenShift

[Azure Red Hat OpenShift (ARO)](hhttps://azure.microsoft.com/en-us/products/openshift) is a fully managed Kubernetes platform as a service (PaaS) that combines the power of Red Hat OpenShift with the scale and reliability of Microsoft Azure. It provides a comprehensive environment for building, deploying, and managing containerized applications.

Key features and benefits of Azure Red Hat OpenShift include:

* **Fully managed**: Microsoft and Red Hat jointly manage the infrastructure, control plane, and application nodes, reducing operational overhead for customers.
* **Enterprise-grade**: Built on a stable and secure foundation, Azure Red Hat OpenShift offers enterprise-grade features like high availability, disaster recovery, and security.   
* **Hybrid flexibility**: Deploy OpenShift clusters on-premises or in the cloud using Azure Red Hat OpenShift Dedicated or Azure Red Hat OpenShift, respectively.   
* **Developer-friendly**: Provides a rich set of tools and features to simplify application development, deployment, and management.   
* **Integrated ecosystem**: Benefits from a vast ecosystem of tools, technologies, and partners, enabling seamless integration with existing applications and infrastructure.

## Azure Database for PostgreSQL

[Azure Database for PostgreSQL](https://azure.microsoft.com/en-us/products/postgresql) is a fully managed relational database service offered by Microsoft Azure. It provides a highly available, scalable, and secure PostgreSQL environment that is ideal for a wide range of applications.

Key features and benefits include:

* **Fully managed**: Microsoft handles the infrastructure, maintenance, and updates, allowing you to focus on your application.
* **High availability**: Built-in redundancy and automatic failover ensure your database remains accessible.
 **Scalability**: Easily scale your database up or down to meet changing demands.
* **Security**: Robust security features, including encryption, authentication, and authorization, protect your data.
* **Compatibility**: Compatible with the open-source PostgreSQL ecosystem, enabling you to leverage existing tools and skills.
* **Integration**: Seamless integration with other Azure services, such as Azure Functions, Logic Apps, and Azure Data Factory.

## Azure CLI

Azure CLI is a powerful command-line interface (CLI) tool that allows you to manage and interact with Azure resources directly from your terminal. It provides a flexible and efficient way to automate tasks, create and configure resources, and execute complex operations within the Azure cloud platform.

For example, to get the details of a subscription, you can use the following command:

```bash
az account show
```

In this module, you use the Azure CLI to spin up the Azure Red Hat Openshift cluster. Access the Azure CLI from a terminal or through Visual Studio Code. Or you can access it from [Azure Cloud Shell](https://azure.microsoft.com/get-started/azure-portal/cloud-shell). This browser-based shell experience is hosted in the cloud. In Cloud Shell, the Azure CLI is configured for use with your Azure subscription.

Find more information about using [Azure CLI to Create Azure Red Hat OpenShift](https://learn.microsoft.com/en-us/azure/openshift/create-cluster?tabs=azure-cli).

Let's see all these technologies in action by deploying the Todo application to an Azure Red Hat OpenShift cluster with Azure Database for PostgreSQL.