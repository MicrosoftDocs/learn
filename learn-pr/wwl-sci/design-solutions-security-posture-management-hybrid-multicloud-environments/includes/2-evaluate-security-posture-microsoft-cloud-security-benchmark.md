This unit gives a summary of the Microsoft cloud security benchmark controls in the [Posture and vulnerability management family](https://learn.microsoft.com/security/benchmark/azure/mcsb-posture-vulnerability-management?source=recommendations).

Please refer to [Introduction to Microsoft Cybersecurity Reference Architecture and cloud security benchmark](/training/modules/design-solutions-microsoft-cybersecurity-cloud-security-benchmark/1-introduction-reference-architecture-benchmark) for more background on Microsoft Cloud Security Benchmark. 

In the summary below, we have included controls from the full baseline where:

* Security controls were *supported* but *not* enabled by default
* There was explicit guidance which contained action to be taken on the part of the customer

## Security Control: Posture and vulnerability management

Posture and Vulnerability Management focuses on controls for assessing and improving cloud security posture, including vulnerability scanning, penetration testing and remediation, as well as security configuration tracking, reporting, and correction in cloud resources.

## PV-1: Define and establish secure configurations

**Security principle**: Define the security configuration baselines for different resource types in the cloud. Alternatively, use configuration management tools to establish the configuration baseline automatically before or during resource deployment so the environment can be compliant by default after the deployment.  
  
**Azure guidance**: Use Azure landing zone (and Blueprints) to accelerate the workload deployment by setting up configuration of services and application environments, including Azure Resource Manager templates, Azure RBAC controls, and Azure Policy, in a landing zone (and Blueprints) definition.

**AWS guidance**: Use AWS CloudFormation templates and AWS Config rules in AWS landing zone definition to automate deployment and configuration of services and application environments.

## PV-2: Audit and enforce secure configurations

**Security principle**: Continuously monitor and alert when there is a deviation from the defined configuration baseline. Enforce the desired configuration according to the baseline configuration by denying the non-compliant configuration or deploying a configuration.  
  
**Azure guidance**: Use Microsoft Defender for Cloud to configure Azure Policy to audit and enforce configurations of your Azure resources. Use Azure Monitor to create alerts when there is a configuration deviation detected on the resources.

Use Azure Policy [deny] and [deploy if not exist] rule to enforce secure configuration across Azure resources.

For resource configuration audit and enforcement not supported by Azure Policy, you may need to write your own scripts or use third-party tooling to implement the configuration audit and enforcement.

**AWS guidance**: Use AWS Config rule to audit configurations of your AWS resources. And you can choose to resolve the configuration drift using AWS Systems Manager Automation associated with the AWS Config rule. Use Amazon CloudWatch to create alerts when there is a configuration deviation detected on the resources.

For resource configuration audit and enforcement not supported by AWS Config, you may need to write your own scripts or use third-party tooling to implement the configuration audit and enforcement.

You can also centrally monitor your configuration drifting by onboarding your AWS account to Microsoft Defender for Cloud.

## PV-3: Define and establish secure configurations for compute resources

**Security principle**: Define the secure configuration baselines for your compute resources, such as VMs and containers. Use configuration management tools to establish the configuration baseline automatically before or during the compute resource deployment so the environment can be compliant by default after the deployment. Alternatively, use a pre-configured image to build the desired configuration baseline into the compute resource image template.  
  
**Azure guidance**: Use Azure recommended operating system security baseline (for both Windows and Linux) as a benchmark to define your compute resource configuration baseline.

Additionally, you can use custom VM image (using Azure Image Builder) or container image with Azure Policy guest configuration and Azure Automation State Configuration to establish the desired security configuration.

**AWS guidance**: Use EC2 AWS Machine Image (AMI) from trusted source on marketplace as a benchmark to define your EC2 configuration baseline.

Additionally, you can use EC2 Image Builder to build custom AMI template with Systems Manager agent to establish the desired security configuration.

For workload applications running within your EC2 instances, AWS Lambda or containers environment, you may use AWS System Manager AppConfig to establish the desired configuration baseline.

## PV-4: Audit and enforce secure configurations for compute resources

**Security principle**: Continuously monitor and alert when there is a deviation from the defined configuration baseline in your compute resources. Enforce the desired configuration according to the baseline configuration by denying the non-compliant configuration or deploying a configuration in compute resources.  

**Azure guidance**: Use Microsoft Defender for Cloud and Azure Policy guest configuration agent to regularly assess and remediate configuration deviations on your Azure compute resources, including VMs, containers, and others. In addition, you can use Azure Resource Manager templates, custom operating system images, or Azure Automation State Configuration to maintain the security configuration of the operating system. Microsoft VM templates in conjunction with Azure Automation State Configuration can assist in meeting and maintaining security requirements.

**AWS guidance**: Use AWS System Manager's State Manager feature to regularly assess and remediate configuration deviations on your EC2 instances. In addition, you can use CloudFormation templates, custom operating system images to maintain the security configuration of the operating system. AMI templates in conjunction with Systems Manager can assist in meeting and maintaining security requirements.

You can also centrally monitor and manage the operating system configuration drift through Azure Automation State Configuration for and onboard them to Azure security governance using the following methods:

- Onboard your AWS account into Microsoft Defender for Cloud
- Use Azure Arc-enabled VMs for your EC2 instance without using onboard your AWS account into Microsoft Defender for Cloud

For workload applications running within your EC2 instances, AWS Lambda or containers environment, you may use AWS System Manager AppConfig to audit and enforce the desired configuration baseline.

## PV-5: Perform vulnerability assessments

**Security principle**: Perform vulnerabilities assessment for your cloud resources at all tiers in a fixed schedule or on-demand. Track and compare the scan results to verify the vulnerabilities are remediated. The assessment should include all types of vulnerabilities, such as vulnerabilities in Azure services, network, web, operating systems, misconfigurations, and so on.

**Azure guidance**: Follow recommendations from Microsoft Defender for Cloud for performing vulnerability assessments on your Azure virtual machines, container images, and SQL servers. Microsoft Defender for Cloud has a built-in vulnerability scanner for virtual machines. Use a third-party solution for performing vulnerability assessments on network devices and applications (e.g., web applications)

Export scan results at consistent intervals and compare the results with previous scans to verify that vulnerabilities have been remediated. When using vulnerability management recommendations suggested by Microsoft Defender for Cloud, you can pivot into the selected scan solution's portal to view historical scan data.

When conducting remote scans, do not use a single, perpetual, administrative account. Consider implementing JIT (Just In Time) provisioning methodology for the scan account. Credentials for the scan account should be protected, monitored, and used only for vulnerability scanning.

**AWS guidance**: Use Amazon Inspector to scan your Amazon EC2 instances and container images residing in Amazon Elastic Container Registry (Amazon ECR) for software vulnerabilities and unintended network exposure. Use a third-party solution for performing vulnerability assessments on network devices and applications (e.g., web applications)

Refer to ES-1 Use Endpoint Detection and Response (EDR) to onboard your AWS account into Microsoft Defender for Cloud and deploy Microsoft Defender for servers (with Microsoft Defender for Endpoint integrated) in your EC2 instances. Microsoft Defender for servers provides a native threat and vulnerability management capability for your VMs. And the vulnerability scanning result will be consolidated in the Microsoft Defender for Cloud dashboard.

Track the vulnerability finding status to ensure they are properly remediated or suppressed if they're considered false positive.

When conducting remote scans, do not use a single, perpetual, administrative account. Consider implementing temporary provisioning methodology for the scan account. Credentials for the scan account should be protected, monitored, and used only for vulnerability scanning.

## PV-6: Rapidly and automatically remediate vulnerabilities

**Security principle**: Rapidly and automatically deploy patches and updates to remediate vulnerabilities in your cloud resources. Use the appropriate risk-based approach to prioritize the remediation of vulnerabilities. For example, more severe vulnerabilities in a higher value asset should be addressed as a higher priority.  
  
**Azure guidance**: Prioritize which updates to deploy first using a common risk scoring program (such as Common Vulnerability Scoring System) or the default risk ratings provided by your third-party scanning tool and tailor to your environment. You should also consider which applications present a high security risk and which ones require high uptime.

Use Azure Automation Update Management or a third-party solution to ensure that the most recent security updates are installed on your Windows and Linux VMs. For Windows VMs, ensure Windows Update has been enabled and set to update automatically.

**AWS guidance**: Use AWS Systems Manager - Patch Manager to ensure that the most recent security updates are installed on your operating systems and applications. Patch Manager supports patch baselines to allow you to define a list of approved and rejected patches for your systems.

You can also use Azure Automation Update Management to centrally manage the patches and updates of your AWS EC2 Windows and Linux instances.

## PV-7: Conduct regular red team operations

**Security principle**: Simulate real-world attacks to provide a more complete view of your organization's vulnerability. Red team operations and penetration testing complement the traditional vulnerability scanning approach to discover risks.
  
**Azure guidance**: As required, conduct penetration testing or red team activities on your Azure resources and ensure remediation of all critical security findings.

**AWS guidance**: As required, conduct penetration testing or red team activities on your AWS resources and ensure remediation of all critical security findings.