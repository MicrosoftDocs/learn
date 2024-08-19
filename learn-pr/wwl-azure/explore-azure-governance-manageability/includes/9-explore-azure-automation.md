Azure Automation provides you with the ability to automate frequent, time-consuming, and error-prone cloud management tasks. Automation helps you focus on work that adds business value. By reducing errors and boosting efficiency, it also helps to lower your operational costs. You can integrate Azure services and other public systems that are required in deploying, configuring, and managing your end-to-end processes. The service allows you to author runbooks graphically, in PowerShell, or Python.

## Process Automation

Process automation supports the integration of Azure services and other public systems required in deploying, configuring, and managing your end-to-end processes. The service allows you to author [runbooks](/azure/automation/automation-runbook-types) graphically, in PowerShell, or using Python.

## Configuration Management

Configuration Management in Azure Automation allows access to two features:

- Change Tracking and Inventory
- Azure Automation State Configuration

### Azure Automation State Configuration

[Azure Automation State Configuration](/azure/automation/automation-dsc-overview) is a cloud-based feature for PowerShell desired state configuration (DSC) that provides services for enterprise environments. Using this feature, you can manage your DSC resources in Azure Automation and apply configurations to virtual or physical machines from a DSC pull server in the Azure cloud.

## Update management

[Update Management](/azure/automation/update-management/overview) feature, for Windows and Linux systems across hybrid environments, gives you visibility into update compliance across Azure and other clouds, and on-premises. The feature allows you to create scheduled deployments that orchestrate the installation of updates within a defined maintenance window.

## Shared capabilities

Azure Automation offers a number of shared capabilities, including shared resources, role-based access control, flexible scheduling, source control integration, auditing, and tagging.

### Shared resources

Azure Automation consists of a set of shared resources that make it easier to automate and configure your environments at scale.

### Role-based access control

Azure Automation supports Azure role-based access control (Azure RBAC) to regulate access to the Automation account and its resources. To learn more about configuring Azure RBAC on your Automation account, runbooks, and jobs, see [Role-based access control for Azure Automation](/azure/automation/automation-role-based-access-control).

### Source control integration

Azure Automation supports [source control integration](/azure/automation/source-control-integration). This feature promotes configuration as code where runbooks or configurations can be checked into a source control system.

## Heterogeneous support (Windows and Linux)

Automation is designed to work across your hybrid cloud environment and also your Windows and Linux systems. It delivers a consistent way to automate and configure deployed workloads and the operating systems that run them.

## Common scenarios for Automation

Azure Automation supports management throughout the lifecycle of your infrastructure and applications. Common scenarios include:

- **Write runbooks** \- Author PowerShell, PowerShell Workflow, graphical, Python 2, and DSC runbooks in common languages.
- **Build and deploy resources** \- Deploy virtual machines across a hybrid environment using runbooks and Azure Resource Manager templates. Integrate into development tools, such as Jenkins and Azure DevOps.
- **Configure virtual machines** \- Assess and configure Windows and Linux machines with configurations for the infrastructure and application.
- **Share knowledge** \- Transfer knowledge into the system on how your organization delivers and maintains workloads.
- **Retrieve inventory** \- Get a complete inventory of deployed resources for targeting, reporting, and compliance.
- **Find changes** \- Identify changes that can cause misconfiguration and improve operational compliance.
- **Monitor** \- Isolate machine changes that are causing issues and remediate or escalate them to management systems.
- **Protect** \- Quarantine machines if security alerts are raised. Set in-guest requirements.
- **Govern** \- Set up Azure RBAC for teams. Recover unused resources.

