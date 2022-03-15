The release pipeline deploys software to a target environment. But it isn't only the software that will be deployed with the release pipeline.

If you focus on Continuous Delivery, Infrastructure as Code and spinning up Infrastructure as part of your release pipeline are essential.

When we focus on the deployment of the Infrastructure, we should first consider the differences between the target environments that we can deploy to:

 -  On-Premises servers.
 -  Cloud servers or Infrastructure as a Service (IaaS). For example, Virtual machines or networks.
 -  Platform as a Service (PaaS) and Functions as a Service (FaaS). For example, Azure SQL Database in both PaaS and serverless options.
 -  Clusters.
 -  Service Connections.

Let us dive a bit further into these different target environments and connections.

## On-premises servers

In most cases, when you deploy to an on-premises server, the hardware and the operating system are already in place. The server is already there and ready.

In some cases, empty, but most of the time not. In this case, the release pipeline can focus on deploying the application only.

You might want to start or stop a virtual machine (for example, Hyper-V or VMware).

The scripts you use to start or stop the on-premises servers should be part of your source control and delivered to your release pipeline as a build artifact.

Using a task in the release pipeline, you can run the script that starts or stops the servers.

When you want to take it one step further and configure the server, you should look at technologies like PowerShell Desired State Configuration(DSC) or use tools like Puppet and Chef.

All these products will maintain your server and keep it in a particular state. When the server changes its state, they (Puppet, Chef, DSC) recover the changed configuration to the original configuration.

Integrating a tool like Puppet, Chef, or PowerShell DSC into the release pipeline is no different from any other task you add.

## Infrastructure as a service

When you use the cloud as your target environment, things change slightly. Some organizations do a lift and shift from their on-premises server to cloud servers.

Then your deployment works the same as to an on-premises server. But when you use the cloud to provide you with Infrastructure as a Service (IaaS), you can use the power of the cloud to start and create servers when you need them.

It's where Infrastructure as Code (IaC) starts playing a significant role.

By creating a script or template, you can make a server or other infrastructural components like a SQL server, a network, or an IP address.

By defining a template or using a command line and saving it in a script file, you can use that file in your release pipeline tasks to execute it on your target cloud.

As part of your pipeline, the server (or another component) will be created. After that, you can run the steps to deploy the software.

Technologies like Azure Resource Manager or Terraform are great for creating Infrastructure on demand.

## Platform as a Service

When you move from Infrastructure as a Service (IaaS) towards Platform as a Service (PaaS), you'll get the Infrastructure from the cloud you're running on.

For example: In Azure, you can choose to create a Web application. The cloud arranges the server, the hardware, the network, the public IP address, the storage account, and even the webserver.

The user only needs to take care of the web application that will run on this Platform.

The only thing you need to do is provide the templates that instruct the cloud to create a WebApp. The same goes for Functions as a Service(FaaS) or Serverless technologies.

In Azure called Azure Functions and in AWS called AWS Lambda.

You only deploy your application, and the cloud takes care of the rest. However, you need to instruct the Platform (the cloud) to create a placeholder where your application can be hosted.

You can define this template in Azure Resource Manager or Terraform. You can use the Azure CLI or command-line tools, or in AWS, use CloudFormation.

In all cases, the Infrastructure is defined in a script file and live alongside the application code in source control.

## Clusters

Finally, you can deploy your software to a cluster. A cluster is a group of servers that work together to host high-scale applications.

When you run a cluster as Infrastructure as a Service, you need to create and maintain the cluster. It means that you need to provide the templates to create a cluster.

You also need to make sure that you roll out updates, bug fixes, and patches to your cluster. It's comparable with Infrastructure as a Service.

When you use a hosted cluster, you should consider it as Platform as a Service. You instruct the cloud to create the cluster, and you deploy your software to the cluster.

When you run a container cluster, you can use the container cluster technologies like Kubernetes or Docker Swarm.

## Service connections

When a pipeline needs access to resources, you'll often need to create service connections.

## Summary

Whatever the technology you choose to host your application, your Infrastructure's creation or configuration should be part of your release pipeline and part of your source control repository.

Infrastructure as Code is a fundamental part of Continuous Delivery and gives you the freedom to create servers and environments on-demand.

## Links

 -  [AWS Cloud formation](https://aws.amazon.com/cloudformation/).
 -  [Terraform](https://www.terraform.io/).
 -  [Desired State Configuration Overview](/powershell/dsc/overview/dscforengineers?view=dsc-1.1).
 -  [AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html).
 -  [Azure Functions](https://azure.microsoft.com/services/functions).
 -  [Chef](https://www.chef.io/chef/).
 -  [Puppet](https://puppet.com/).
 -  [Azure Resource Manager](/azure/azure-resource-manager/resource-group-overview).
