Azure Machine Learning provides workspaces to create and manage machine learning artifacts. Workspaces serve as containers for access management, cost management, and data isolation. As the administrator of an Azure Machine Learning workspace, you'll manage two aspects of authentication and authorization:

- Manage access to Azure Machine Learning workspaces giving users the ability to create new resources or use existing ones.
- Manage the authentication between Azure Machine Learning and the services it relies on.

Authentication in Azure Machine Learning workspaces can use Microsoft Entra ID or account keys or tokens. Keys and tokens are most only often used for access to external data sources that might not support Entra ID. In those scenarios, you can use Azure Key Vault to securely manage secrets. You should never include account keys or tokens directly in code.

Users authenticate to an Azure Machine Learning workspace using one of the following methods:

- **Interactive**: Users can leverage their Microsoft Entra ID to either directly authenticate, or to get a token that is used for authentication. Interactive authentication is used during experimentation and iterative development. Interactive authentication enables you to control access to resources (such as a web service) on a per-user basis.

- **Service principal**: Service principal accounts in Microsoft Entra ID can be used by services to authenticate or get a token. A service principal is used to authenticate an automated process to the service without requiring user interaction. For example, a continuous integration and deployment script that trains and tests a model every time the training code changes.

- **Azure CLI session**: The Azure CLI extension for Machine Learning (the ml extension or CLI v2) is a command line tool for working with Azure Machine Learning. Users can sign in to Azure via the Azure CLI on their local workstation, without storing credentials in Python code or prompting them to authenticate. Similarly, users can reuse the same scripts as part of continuous integration and deployment pipelines, while authenticating the Azure CLI with a service principal identity.

- **Managed identity**: When using the Azure Machine Learning SDK v2 on a compute instance or on an Azure Virtual Machine, users can use a managed identity for Azure. This workflow allows the VM to connect to the workspace using the managed identity, without storing credentials in Python code or prompting the user to authenticate. Azure Machine Learning compute clusters can also be configured to use a managed identity to access the workspace when training models. Whenever possible, using a managed identity is the preferred method and best practice.

You can use Microsoft Entra Conditional Access to further control or restrict access to the workspace for each authentication workflow. For example, you can configure conditional access so that an administrator is only able to access an Azure Machine Learning workspace from a managed device.

Azure Machine Learning can authenticate with other services using the following methods:

- Data access can happen along multiple paths depending on the data storage service and your configuration. For example, authentication to the datastore can use an account key, token, security principal, managed identity, or user identity.

- Azure Machine Learning workspaces use a managed identity to communicate with other Azure services. By default, this is a system-assigned managed identity, but you can also configure an Azure Machine Learning workspace with a user-assigned managed identity.

- Azure Machine Learning uses Azure Container Registry (ACR) to store container images used to train and deploy models. If you allow Azure Machine Learning to automatically create an ACR registry, it enables the **admin account** for that registry.

- The Azure Machine Learning compute cluster uses a **managed identity** to retrieve connection information for datastores from Azure Key Vault and to pull container images from ACR. You can also configure identity-based access to datastores, which will instead use the managed identity of the compute cluster.

- Managed online endpoints can use a managed identity to access Azure resources when performing inference.