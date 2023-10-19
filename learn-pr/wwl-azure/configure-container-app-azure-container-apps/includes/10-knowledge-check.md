## Multiple Choice
What is the significance of configuring the container app to authenticate using a user-assigned identity?
( ) It ensures compatibility with Azure DevOps pipelines. {{Incorrect.  ???.}}
(x) It enhances the security of the container app. {{Correct!  ???.}}
( ) It establishes a connection with Azure Virtual Network. {{Incorrect.  ???.}}

## Multiple Choice
What are some common uses of Azure Container Apps?
(x) Deploying API endpoints, hosting background processing jobs, handling event-driven processing, running microservices. {{Correct. Azure Container Apps is designed to run microservices and containerized applications on a serverless platform, with common uses including deploying API endpoints, hosting background processing jobs, handling event-driven processing, and running microservices.}}
( ) Managing cloud infrastructure. {{Incorrect. Azure Container Apps is designed to abstract away the concerns of managing cloud infrastructure.}}
( ) Deploying virtual machines. {{Incorrect. Azure Container Apps is not used for deploying virtual machines.}}

## Multiple Choice
What is the purpose of Azure Container Apps?
( ) To manage the details of Kubernetes and container orchestration for you, but only for containers that use a specific runtime, programming language, or development stack. {{Incorrect. Azure Container Apps can use any runtime, programming language, or development stack of your choice.}}
(x) To manage the details of Kubernetes and container orchestration for you, and enable the use of any runtime, programming language, or development stack of your choice. {{Correct. Azure Container Apps manages the details of Kubernetes and container orchestration for you. Containers in Azure Container Apps can use any runtime, programming language, or development stack of your choice.}}
( ) To manage the details of Kubernetes and container orchestration for you, but only for containers that use a specific base image. {{Incorrect. Any Linux-based x86-64 (linux/amd64) container image with no required base image is supported.}}

## Multiple Choice
What is the purpose of Azure Container Apps?
(x) To run microservices and containerized applications on a serverless platform while leaving behind the concerns of manually configuring cloud infrastructure and complex container orchestrators. {{Correct. Azure Container Apps enables you to run microservices and containerized applications on a serverless platform while leaving behind the concerns of manually configuring cloud infrastructure and complex container orchestrators.}}
( ) To manually configure cloud infrastructure and complex container orchestrators. {{Incorrect. Azure Container Apps eliminates the need for manual configuration of cloud infrastructure and complex container orchestrators.}}
( ) To run only monolithic applications on a serverless platform. {{Incorrect. Azure Container Apps enables you to run microservices and containerized applications on a serverless platform.}}

## Multiple Choice
What is the benefit of using a managed identity in a running container app?
( ) Managed identities are only useful for workloads contained within a single resource. {{Incorrect. Managed identities can be used for workloads that run on multiple resources and need pre-authorization to a secure resource.}}
( ) Managed identities require you to manage credentials in your container app. {{Incorrect. With managed identities, you don't need to manage credentials in your container app.}}
(x) Your app connects to resources with the managed identity. You don't need to manage credentials in your container app. {{Correct. Managed identities allow your app to connect to resources without needing to manage credentials in your container app.}}

## Multiple Choice
What is the purpose of enabling ingress in Azure Container Apps?
( ) To create an Azure Load Balancer. {{Incorrect. Enabling ingress does not require creating an Azure Load Balancer.}}
( ) To restrict access to the container app's internal environment. {{Incorrect. Enabling ingress allows traffic from both the public internet and the container app's internal environment.}}
(x) To expose the container app to the public web, virtual network, and other container apps within the environment. {{Correct. Enabling ingress allows external and internal traffic to be routed to the container app, without requiring additional Azure resources like a Load Balancer or public IP address.}}

## Multiple Choice
What happens when a secret is updated or deleted in Azure Container Apps?
( ) All revisions that reference the secret are automatically updated or deleted. {{Incorrect. An updated or deleted secret doesn't automatically affect existing revisions in your app. When a secret is updated or deleted, you can respond to changes in one of two ways: deploy a new revision or restart an existing revision.}}
( ) A new revision is automatically generated for the application. {{Incorrect. Secrets are scoped to an application, outside of any specific revision of an application. Adding, removing, or changing secrets doesn't generate new revisions.}}
(x) You can respond to changes by deploying a new revision or restarting an existing revision. {{Correct. When a secret is updated or deleted, you can respond to changes in one of two ways: deploy a new revision or restart an existing revision.}}

## Multiple Choice
What is the main difference between container file system and ephemeral storage in Azure Container Apps?
( ) Container file system is visible to other containers, while ephemeral storage is only visible to processes running in the current container. {{Incorrect. Container file system storage is only visible to processes running in the current container.}}
( ) Ephemeral storage is scoped to a single replica, while container file system storage is scoped to the local container. {{Correct. Ephemeral storage is scoped to a single replica, while container file system storage is scoped to the local container. This means that files written to ephemeral storage are persisted for the lifetime of the replica, while files written to container file system storage disappear when the container is shut down or restarted.}}
( ) Ephemeral storage is permanent, while container file system is temporary. {{Incorrect. Ephemeral storage is also temporary, but scoped to a single replica.}}

## Multiple Choice
What is the purpose of Service Connector in Azure Container Apps?
( ) Service Connector is used to manage the configuration of virtual machines in Azure. {{Incorrect. Service Connector is not used to manage virtual machines in Azure.}}
(x) Service Connector is used to connect Azure services together and manage the configuration of the network settings and connection information between different services. {{Correct. Service Connector is designed to provide a simple way to create and manage connections between Azure services, configure network settings, authentication, and manage connection environment variables or properties.}}
( ) Service Connector is used to manage the configuration of network settings for on-premises servers. {{Incorrect. Service Connector is not used to manage the configuration of network settings for on-premises servers.}}
