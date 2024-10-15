Connecting hybrid cloud and multicloud environments to Microsoft Defender for Cloud is crucial to maintain a unified security posture across diverse IT landscapes. With Azure Arc enabled servers for non-Azure machines, the Native Cloud Connector, and the Classic Connector, you can extend the capabilities of Microsoft Defender for Cloud to non-Azure resources. This integration empowers you to monitor, detect, and respond to security threats comprehensively. Here, we provide an informative overview of the process, along with detailed requirements for a successful connection.

## Connect your non-Azure machines to Microsoft Defender for Cloud

Microsoft Defender for Cloud can monitor the security posture of your non-Azure machines, but first you need to connect them to Azure.

You can connect your non-Azure computers in any of the following ways:

 -  Onboarding with Azure Arc:
     -  By using Azure Arc-enabled servers (recommended)
     -  By using the Azure portal
 -  Onboarding directly with Microsoft Defender for Endpoint

## Connect on-premises machines by using Azure Arc

A machine that has Azure Arc-enabled servers becomes an Azure resource. When you install the Log Analytics agent on it, it appears in Defender for Cloud with recommendations, like your other Azure resources.

Azure Arc-enabled servers provide enhanced capabilities, such as enabling guest configuration policies on the machine and simplifying deployment with other Azure services. For an overview of the benefits of Azure Arc-enabled servers, see Supported cloud operations.

To deploy Azure Arc on one machine, follow the instructions in Quickstart: Connect hybrid machines with Azure Arc-enabled servers.

To deploy Azure Arc on multiple machines at scale, follow the instructions in Connect hybrid machines to Azure at scale.

Defender for Cloud tools for automatically deploying the Log Analytics agent work with machines running Azure Arc. However, this capability is currently in preview. When you connect your machines by using Azure Arc, use the relevant Defender for Cloud recommendation to deploy the agent and benefit from the full range of protections that Defender for Cloud offers:

 -  Log Analytics agent should be installed on your Linux-based Azure Arc machines
 -  Log Analytics agent should be installed on your Windows-based Azure Arc machines

## Connect your AWS account to Microsoft Defender for Cloud

Workloads commonly span multiple cloud platforms. Cloud security services must do the same. Microsoft Defender for Cloud helps protect workloads in Amazon Web Services (AWS), but you need to set up the connection between them and Defender for Cloud.

If you're connecting an AWS account that you previously connected by using the classic connector, you must remove it first. Using an AWS account that's connected by both the classic and native connectors can produce duplicate recommendations.

### Prerequisites

To complete the procedures in this article, you need:

 -  A Microsoft Azure subscription. If you don't have an Azure subscription, you can sign up for a free one.
 -  Microsoft Defender for Cloud set up on your Azure subscription.
 -  Access to an AWS account.
 -  Contributor permission for the relevant Azure subscription, and Administrator permission on the AWS account.

### Defender for Containers

If you choose the Microsoft Defender for Containers plan, you need:

 -  At least one Amazon EKS cluster with permission to access to the EKS Kubernetes API server.
 -  The resource capacity to create a new Amazon Simple Queue Service (SQS) queue, Kinesis Data Firehose delivery stream, and Amazon S3 bucket in the cluster's region.

### Defender for SQL

If you choose the Microsoft Defender for SQL plan, you need:

 -  Microsoft Defender for SQL enabled on your subscription. Learn how to protect your databases.
 -  An active AWS account, with EC2 instances running SQL Server or Relational Database Service (RDS) Custom for SQL Server.
 -  Azure Arc for servers installed on your EC2 instances or RDS Custom for SQL Server.

We recommend that you use the auto provisioning process to install Azure Arc on all of your existing and future EC2 instances. To enable the Azure Arc auto provisioning, you need Owner permission on the relevant Azure subscription.

AWS Systems Manager (SSM) manages to auto provision by using the SSM Agent. Some Amazon Machine Images already have the SSM Agent preinstalled. If your EC2 instances don't have the SSM Agent, install it by using these instructions from Amazon: Install SSM Agent for a hybrid and multicloud environment (Windows).

Ensure that your SSM Agent has the managed policy AmazonSSMManagedInstanceCore. It enables core functionality for the AWS Systems Manager service.

Enable these other extensions on the Azure Arc-connected machines:

 -  Microsoft Defender for Endpoint
 -  A vulnerability assessment solution (Threat and Vulnerability Management or Qualys)
 -  The Log Analytics agent on Azure Arc-connected machines or the Azure Monitor agent

Make sure the selected Log Analytics workspace has a security solution installed. The Log Analytics agent and the Azure Monitor agent are currently configured at the subscription level. All of your AWS accounts and Google Cloud Platform (GCP) projects under the same subscription inherit the subscription settings for the Log Analytics agent and the Azure Monitor agent.

### Defender for Servers

If you choose the Microsoft Defender for Servers plan, you need:

 -  Microsoft Defender for Servers enabled on your subscription. Learn how to enable plans in Enable enhanced security features.
 -  An active AWS account, with EC2 instances.
 -  Azure Arc for servers installed on your EC2 instances.

We recommend that you use the auto provisioning process to install Azure Arc on all of your existing and future EC2 instances. To enable the Azure Arc auto provisioning, you need Owner permission on the relevant Azure subscription.

AWS Systems Manager manages to auto provision by using the SSM Agent. Some Amazon Machine Images already have the SSM Agent preinstalled. If your EC2 instances don't have the SSM Agent, install it by using either of the following instructions from Amazon:

 -  Install SSM Agent for a hybrid and multicloud environment (Windows)
 -  Install SSM Agent for a hybrid and multicloud environment (Linux)

Ensure that your SSM Agent has the managed policy AmazonSSMManagedInstanceCore, which enables core functionality for the AWS Systems Manager service.

If you want to manually install Azure Arc on your existing and future EC2 instances, use the EC2 instances should be connected to Azure Arc recommendation to identify instances that don't have Azure Arc installed.

Enable these other extensions on the Azure Arc-connected machines:

 -  Microsoft Defender for Endpoint
 -  A vulnerability assessment solution (Threat and Vulnerability Management or Qualys)
 -  The Log Analytics agent on Azure Arc-connected machines or the Azure Monitor agent

Make sure the selected Log Analytics workspace has a security solution installed. The Log Analytics agent and the Azure Monitor agent are currently configured at the subscription level. All of your AWS accounts and GCP projects under the same subscription inherit the subscription settings for the Log Analytics agent and the Azure Monitor agent.

Defender for Servers assigns tags to your AWS resources to manage the auto provisioning process. You must have these tags properly assigned to your resources so that Defender for Cloud can manage them: `AccountId`, `Cloud`, `InstanceId`, and `MDFCSecurityConnector`.

### Defender CSPM

If you choose the Microsoft Defender Cloud Security Posture Management plan, you need:

 -  An Azure subscription. If you don't have an Azure subscription, you can sign up for a free subscription.
 -  You must enable Microsoft Defender for Cloud on your Azure subscription.
 -  Connect your non-Azure machines, AWS accounts.
 -  In order to gain access to all of the features available from the CSPM plan, the plan must be enabled by the Subscription Owner.
