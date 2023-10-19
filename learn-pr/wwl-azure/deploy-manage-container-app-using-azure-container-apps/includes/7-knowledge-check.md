## Multiple Choice
In this module, what is the main benefit that the team achieves by switching from Azure Kubernetes Service (AKS) to Azure Container Apps?
( ) AKS provides better custom service mesh capabilities than Azure Container Apps. {{Incorrect. While AKS provides custom service mesh capabilities, the team believes that they're not making use of the advance features of AKS like custom service mesh or autoscaling.}}
( ) Azure Container Apps is more complex than AKS. {{Incorrect. The team believes that switching to Azure Container Apps will reduce the complexity of their current devops implementation.}}
(x) Azure Container Apps enables the automation and validation of the creation and teardown of environments to help deliver secure and stable application hosting platforms. {{Correct. The team believes that switching to Azure Container Apps will improve their ability to publish and run containerized apps at scale, reduce the complexity of their current devops implementation, and save resources by using scale-to-zero and built-in autoscaling capabilities.}}

## Multiple Choice
What is the principle of least privilege?
( ) Limiting access to only one resource in a system. {{Incorrect. This is too restrictive and does not provide enough access for users to complete their tasks.}}
( ) Giving users access to all resources in a system. {{Incorrect. This violates the principle of least privilege by giving users more access than they need.}}
(x) Limiting access to only the resources necessary to complete a user's task. {{Correct. The principle of least privilege ensures that users only have access to the resources they need to complete their tasks, reducing the risk of unauthorized access or accidental damage to other resources.}}

## Multiple Choice
What is the purpose of Azure Container Apps?
(x) Enables the automation and validation of the creation and teardown of environments to help deliver secure and stable application hosting platforms. {{Correct. Azure Container Apps enables the automation and validation of the creation and teardown of environments to help deliver secure and stable application hosting platforms.}}
( ) To deploy a container app from an image in the Azure Kubernetes Service platform. {{Incorrect. Azure Container Apps is a separate platform from Azure Kubernetes Service.}}
( ) To deploy a container app from an image in the Azure Virtual Machine platform. {{Incorrect. Azure Container Apps is a separate platform from Azure Virtual Machines.}}

## Multiple Choice
What is the purpose of configuring a continuous integration environment for Container Apps?
( ) To create a new container registry instance that contains one image. {{Incorrect. A container registry instance must already exist with at least one image.}}
( ) To deploy a container app from an image in the Azure Container Registry to the Azure Container Apps platform manually. {{Incorrect. This process is automated through continuous integration.}}
(x) To automate and validate the deployment of a container image from a container registry to a container app using a self-hosted agent pool. {{Correct. Continuous integration automates and validates the deployment of a container image from a container registry to a container app using a self-hosted agent pool.}}

## Multiple Choice
What is the purpose of setting the revision management to multiple in Azure Container Apps?
(x) To allow several revisions to be active simultaneously. {{Correct. Setting the revision management to multiple allows several revisions to be active simultaneously, which is necessary for configuring traffic splitting.}}
( ) To configure traffic splitting between two labeled revisions. {{Incorrect. Setting the revision management to multiple is not related to configuring traffic splitting.}}
( ) To deploy a new revision of the container app. {{Incorrect. Setting the revision management to multiple allows several revisions to be active simultaneously.}}

## Multiple Choice
As part of the setup process for the Azure Container Apps deployment, what tool should be installed to enable the creation and management of container images?
(x) Install Docker Desktop. {{Correct. Docker Desktop is a tool that enables the creation and management of container images.}}
( ) Install Azure CLI with `containerapp` extension {{Incorrect. Azure CLI with `containerapp` extension is used for managing Azure Container Apps, not for creating and managing container images.}}
( ) Install Visual Studio Code. {{Incorrect. Visual Studio Code is used for developing and deploying applications, not for creating and managing container images.}}

## Multiple Choice
What is the purpose of configuring a user-assigned managed identity in this exercise?
(x) To enable the container registry to use the managed identity to pull artifacts. {{Correct. Configuring a user-assigned managed identity allows the container registry to use the managed identity to pull artifacts.}}
( ) To configure a private endpoint connection for the container registry. {{Incorrect. Configuring a user-assigned managed identity is a separate task from configuring a private endpoint connection.}}
( ) To create a new Azure subscription. {{Incorrect. Configuring a user-assigned managed identity does not involve creating a new Azure subscription.}}

## Multiple Choice
What is the purpose of configuring a connection between the container app and Service Bus?
(x) To establish communication between the container app and the Service Bus instance. {{Correct. Configuring a connection between the container app and Service Bus allows the container app to connect and communicate with the Service Bus instance.}}
( ) To create HTTP scale rules for the container app. {{Incorrect. Configuring a connection between the container app and Service Bus is not related to creating HTTP scale rules.}}
( ) To authenticate the container app using a user-assigned managed identity. {{Incorrect. This is the purpose of configuring the container app to authenticate using the user assigned identity.}}

## Multiple Choice
What is the purpose of configuring `Pipeline1` to use the self-hosted agent pool?
( ) To verify the configuration of the continuous integration environment for Container Apps. {{Incorrect. The purpose of configuring `Pipeline1` to use the self-hosted agent pool is not related to verifying the configuration.}}
( ) To deploy a container image from the Azure Container Registry to the Azure Container Apps platform. {{Incorrect. This is the purpose of configuring `Pipeline1` with an Azure Container Apps deployment task.}}
(x) To enable `Pipeline1` to deploy a container image from the container registry to the container app using a self-hosted agent pool. {{Correct. Configuring `Pipeline1` to use the self-hosted agent pool enables it to deploy a container image from the container registry to the container app.}}

## Multiple Choice
What is the purpose of setting the revision management to multiple in Azure Container Apps?
(x) To enable the automation and validation of the creation and teardown of environments to help deliver secure and stable application hosting platforms. {{Correct. Setting the revision management to multiple enables the automation and validation of the creation and teardown of environments to help deliver secure and stable application hosting platforms.}}
( ) To deploy a new revision of the container app with a v2 suffix. {{Incorrect. Setting the revision management to multiple is not related to deploying a new revision with a v2 suffix.}}
( ) To configure traffic splitting between labeled revisions. {{Incorrect. Setting the revision management to multiple is not related to configuring traffic splitting between labeled revisions.}}
