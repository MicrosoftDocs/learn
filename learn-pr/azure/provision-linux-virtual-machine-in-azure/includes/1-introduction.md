Microsoft Azure supports several methods both to provision resources for a Linux VM and transition existing Linux-based workloads.

## Example scenario

Suppose you've been hired by a financial services company to transition their existing on-premises Linux-based workloads to Azure. You've selected Infrastructure as a service (IaaS) and Platform as a service (PaaS) as services that you'll need for the project, and you've completed planning for the resources required for deployment. You now need to select a deployment methodology that offers an optimal balance between simplicity and efficiency when provisioning the Azure VMs running Linux. Your choices include the Azure portal, the Azure CLI, and Terraform and Bicep templates.

## Review primary deployment methods

When choosing which deployment methodology to use, you should consider what each choice has to offer.

### Azure portal

The easiest approach to provision Azure resources is to use the [Azure portal](https://portal.azure.com). The _Azure portal_ is a web-based, unified console that offers a convenient alternative to command-line tools. Its browser-based graphical interface is designed to assist with resource deployment and management tasks by prompting the user for any required information, providing hints, and displaying helpful messages.

### Azure CLI

The Azure CLI is a cross-platform command-line tool that you can use to access Azure subscriptions and manage their resources. You can run Azure CLI commands interactively in a console interface, such as a Windows Command Prompt window or a Linux shell session. You also can incorporate the Azure CLI into scripts that use Bash shell commands and GNU utilities to automate the process.

### Terraform

Terraform is an open-source, multi-platform Infrastructure as Code (IaC) tool that you can use to provision and configure a wide range of environments, including multi-vendor public and private clouds. Unlike Azure CLI&mdash;which provides an _imperative_ _approach_ to resource management&mdash;Terraform follows a declarative approach.

An imperative approach involves writing scripts or running a sequence of commands. You explicitly provide the steps to run to produce a desired outcome. When you use imperative deployments, it's your responsibility to manage dependencies, error handling, and resource updates. Whereas a declarative approach involves writing a definition that describes the desired outcome, rather than the steps to implement it&mdash;the tooling determines the optimal method to deliver that outcome for you. It does this by inspecting the current state of your environment, comparing it to your target state, and then implementing the changes required to make them identical.

> [!NOTE]
> 
> Red Hat Ansible is another popular open-source tool you can use to complement the Terraform functionality. However, Ansible facilitates provisioning of cloud resources and supports both configuration management and application deployments.

### Bicep

Bicep offers an alternative declarative provisioning method to Terraform. Although it exclusively targets Azure resources, you can benefit from several integration and usability features common across Microsoft cloud-based technologies.

> [!NOTE]
> 
> For a comprehensive comparison between Bicep and Terraform, refer to the Learn document [Comparing Terraform and Bicep](/azure/developer/terraform/comparing-terraform-and-bicep).

Azure supports two types of templates for declarative provisioning:

- Azure Resource Manager template. This template uses the JavaScript Object Notation (JSON) open-standard file format.

- Bicep template. This template relies on a domain-specific language (DSL), which Microsoft developed recently to simplify the template authoring experience and enhance the resulting functionality.

You can use both these templates to deploy practically any Azure resource. These templates also easily integrate into version control systems and deployment pipelines, resulting in improved automation and reliability. However, in comparison to Azure Resource Manager templates, Bicep templates offer several additional benefits including more concise syntax and built-in dependency management.

## What will we be doing?

In this module, you'll choose the optimal deployment method of provisioning Linux VMs in Azure. Your choice will be dependent on the criteria that have been established during the deployment planning phase. 

## What is the main goal?

By the end of this module, you'll be able to provision Azure VMs running Linux by using the deployment methodology of your choice. You'll also have a better understanding of the most suitable use cases for each method.
