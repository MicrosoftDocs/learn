# Title

Deploy complex Azure Container Instances inside of Virtual Networks

## Role(s)

- administrator
- developer

## Level

- advanced

## Product(s)

- Azure Container Instances
- Private Link

Other adjacent products are leveraged in the units, but are not the central topic for the module:

- Azure Storage
- Azure Files
- Private DNS Zones
- Azure SQL Database

## Prerequisites

- Ability to deploy Azure Container Instances in Azure with a basic configuration

## Summary

Roll out Azure Container Instances into an Azure Virtual Network. You will evolve a basic container group into a more sophisticated configuration leveraging sidecar and initialization containers, as well as use private link to access other Azure PaaS resources.

## Learning objectives

1. Upon completion of this module the learner will be able to deploy Azure Container Instances in Azure Virtual Networks
1. The technology the student will use to configure the Azure Container Instance is YAML (Yet Another Markup Language)
1. The student will include sidecar containers in the YAML definition
1. The student will include initialization containers in the YAML definition
1. The student will integrate an ACI with an Azure PaaS service using Private Link

## Chunk your content into subtasks

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Deploy ACI to Vnet | TODO | exercise | 1 | yes |
| Export ACI to YAML | TODO | exercise | 2 | no |
| Modify YAML and create ACI from YAML | TODO | exercise | 2 | no |
| Create nginx sidecar container | TODO | exercise | 3 | yes |
| Create azcli init container | TODO | exercise | 4 | yes |

## Units

1. **Introduction**

1. **Deploy ACI into a Virtual Network**

    Suppose you work at network provider, and you are responsible for creating Application Programmable Interface (APIs) for your customers. These APIs are a premium service for which you charge your customers, so they need to be able to launch and stop their APIs on-demand. Once a customer has started an API, they are responsible for its life cycle. A critical requirement is that APIs are not exposed to the public Internet, and that a specific customer only has access to their own API.

    - Create an Azure SQL Database (prerequisite for the container)
        - Create an Azure SQL Database with Azure CLI
    - Creating ACI into VNet
        - Create an Azure VNet with CLI
        - Deploy ACI into the created VNet
    - Test application functionality
        - Deploy a Linux VM to the same VNet
        - Access the ACI from the VM

    **Knowledge check**

    - Multiple choice ("What type of IP address does an Azure Container Instance get when deployed to a VNet?")
    - True/False ("An ACI deployed to a VNet has connectivity to the Internet")

1. **Understand ACI YAML definitions**

    YAML is a prerequisite for tasks in further units

    - Export an existing ACI into a YAML file
        - Export an existing ACI into a YAML file with Azure CLI
    - Deploy a YAML file to an ACI
        - Modify a YAML file with a text editor
        - Deploy the YAML file to Azure with Azure CLI

1. **Deploy an ACI with sidecar container**

    Your customers demand that you use HTTPS instead of HTTP. You could enhance the application code so that it supports HTTPS, but you do not have access to the original team that developed the application. An alternative is to use a sidecar container that enhances the application with the required functionality. In this unit you will use nginx, a web server that can be used as a reverse-proxy in front of a web application, to provide SSL offload functionality: Encrypted traffic will enter the ACI container group in the nginx container, and nginx will hand over the decrypted traffic to the actual application container.

    - Generate NGINX configuration
        - Generate self-signed certificates with openssl
        - Generate an nginx.config file
    - Modify YAML to include sidecar container
        - Create YAML file with right definition for the sidecar container
        - Deploy the YAML file to Azure with Azure CLI

1. **Access private-link-enabled services from ACI**

    Your customers have realized that the database behind the API is exposed with a public IP address. While they are aware that this public IP address is protected by a firewall so that only the Azure Container Instance can access it, they have asked you to use private IP addresses between the API and the database.

    - Configure private link for the Azure SQL DB created in unit 2
    - Configure a Private DNS Zone and associate it to the VNet created in unit 2
    - Verify access to the Azure SQL Database using a private IP address

1. **Deploy ACI with an initialization container**

    Your customers have asked you to be able to reach the API using a Fully Qualified Domain Name (FQDN) instead of an IP address, and to make sure that the FQDN does not change in case the container needs to be recreated. You can use init containers to provide this functionality. Some times you need to perform certain tasks before the actual application starts. These tasks could include many different things such as configuring certain services to accept inbound connectivity from the container, or injecting secrets from an Azure Key Vault into a volume. In this unit you will use an init container to update DNS so that customers can access the API using a domain name, instead of an IP address.

    - Configure prereqs for Initialization container:
        - Private DNS Zone
        - Initialization script
            - Create local file with script
            - Create Azure Files Share
            - Upload local file to Azure Files Share
        - Service Principal
    - Modify YAML to include sidecar container
        - Create YAML file with right definition for the initialization container
        - Deploy the YAML file to Azure with Azure CLI


1. **Summary**

    Suppose you work at network provider, and you are responsible for creating Application Programmable Interface (APIs) for your customers. These APIs are a premium service for which you charge your customers, so they need to be able to launch and stop their APIs on-demand. Once a customer has started an API, they are responsible for its life cycle. A critical requirement is that APIs are not exposed to the public Internet, and that a specific customer only has access to their own API.

    You chose Azure Container Instance (ACI) as the most cost-effective form factor for the API, and you deployed an ACI into each of your customer's Virtual Network to guarantee network isolation.

    Later on, your customers demand that you use HTTPS instead of HTTP. You could enhance the application code so that it supports HTTPS, but you do not have access to the original team that developed the application. You used a sidecar container that enhanced the application with the required functionality without any code changes. You deployed the ACI using a YAML description document, which provides much richer semantics than Azure CLI commands.

    Your customers then realized that the database behind the API is exposed with a public IP address. While they are aware that this public IP address is protected by a firewall so that only the Azure Container Instance can access it, they have asked you to use private IP addresses between the API and the database. You used Private Link and Private DNS Zones to make sure that the Azure Container Instance uses private IP addressing to access the Azure SQL Database.

    Finally, your customers have asked you to be able to reach the API using a Fully Qualified Domain Name (FQDN) instead of an IP address, and to make sure that the FQDN does not change in case the container needs to be recreated. You used an init containers to provide this functionality: the init container updates DNS so that customers can access the API using a domain name, instead of an IP address.

## Notes

There are many resources in this doc that are not supported by the sandbox environment for containers:

- VMs
- Azure SQL DB
- Service Principals
- Network Profiles (for ACI deployment into a VNet)