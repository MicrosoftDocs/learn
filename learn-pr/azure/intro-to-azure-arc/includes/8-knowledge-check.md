
## quiz title: Check your knowledge

## Multiple Choice

What must an administrator do to register Windows Server with Azure Arc?

()Install the Log Analytics agent on the server for onboarding.{{That's incorrect. This is an optional step.}}
()Install Helm 3 on the server for onboarding.{{That's incorrect. This step is required for onboarding Kubernetes clusters.}}
(x)The administrator must install the Azure Connected Machine agent on the server for onboarding.{{That's correct. The Azure Connected Machine agent enables you to manage both Windows and Linux computers that you host on-premises or with another cloud provider.}}

## Multiple Choice

Which of the following Azure services must an organization implement to manage and evaluate compliance of its on-premises Windows Server computers?

()Azure Policy.{{That's incorrect. Azure Policy can be used only with on-premises servers that are onboarded to Azure Arc.}}
(x)Azure Arc.{{That's correct. Azure Arc provides a centralized, unified, and self-service approach to managing on-premises Windows Server computers.}}
()Azure Monitor.{{That's incorrect. Monitor enables administrators to monitor their resources, such as onboarded servers.}}

## Multiple Choice

Which of the following can an administrator use Azure Policy for when auditing Azure Arc resources?

()Configuring the time zone on the Windows operating system.{{That's incorrect. You cannot use Azure Policy to perform this function.}}
(x)Validating such settings as configurations of the operating system, applications, and environment settings.{{That's correct. You can use Azure Policy with Azure Arc resources to perform this function.}}
()Restrict the scope of access to Log Analytics data based on the permissions to the corresponding Azure resource.{{That's incorrect. This is a function of RBAC permissions in Azure Arc.}}
