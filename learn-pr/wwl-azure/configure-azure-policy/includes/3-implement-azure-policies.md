Azure Policy is a service in Azure that you can use to create, assign, and manage policies. You can use policies to enforce rules on your resources to meet corporate compliance standards and service level agreements. Azure Policy runs evaluations and scans on your resources to make sure they're compliant.

### Things to know about Azure Policy

The main advantages of Azure Policy are in the areas of enforcement and compliance, scaling, and remediation. Azure Policy is also important for teams that run an environment that requires different forms of governance.

| Advantage | Description |
| --- | --- |
| **Enforce rules and compliance** | Enable built-in policies, or build custom policies for all resource types. Support real-time policy evaluation and enforcement, and periodic or on-demand compliance evaluation. |
| **Apply policies at scale** | Apply policies to a management group with control across your entire organization. Apply multiple policies and aggregate policy states with policy initiative. Define an exclusion scope. |
| **Perform remediation** | Conduct real-time remediation, and remediation on your existing resources. |
| **Exercise governance** | Implement governance tasks for your environment: <br> - Support multiple engineering teams (deploying to and operating in the environment) <br> - Manage multiple subscriptions <br> - Standardize and enforce how cloud resources are configured <br> - Manage regulatory compliance, cost control, security, and design consistency |

### Things to consider when using Azure Policy

Review the following scenarios for using Azure Policy. Consider how you can implement the service in your organization.

- **Consider deployable resources**. Specify the resource types that your organization can deploy by using Azure Policy. You can specify the set of virtual machine SKUs that your organization can deploy.

- **Consider location restrictions**. Restrict the locations your users can specify when deploying resources. You can choose the geographic locations or regions that are available to your organization.

- **Consider rules enforcement**. Enforce compliance rules and configuration options to help manage your resources and user options. You can enforce a required tag on resources and define the allowed values.

- **Consider inventory audits**. Use Azure Policy with Azure Backup service on your VMs and run inventory audits. 
