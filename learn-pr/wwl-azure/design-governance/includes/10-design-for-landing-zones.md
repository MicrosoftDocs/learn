An [Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/) provides an infrastructure environment for hosting your workloads. Landing zones ensure key foundational principles are put in place before you deploy services.

To use an analogy, shared city utilities like water, gas, and electricity are available to new homes before they're built. In the same manner, the network, identity and access management, policies, and monitoring configuration for landing zones must be ready before you try to deploy. These "utilities" for landing zones need to be active and ready to help streamline the application migration process.

### Things to know about Azure landing zones

As you plan the governance strategy for Tailwind Traders, consider these characteristics of Azure landing zones:

- Landing zones are defined by management groups and subscriptions that are designed to scale according to business needs and priorities. 

   The following diagram shows landing zones for SAP, Corporate, and Online applications. 

   :::image type="content" source="../media/landing-zones.png" alt-text="Diagram of a management group and subscription organization that uses landing zones." border="false":::

- Azure policies are associated with landing zones to ensure continued compliance with the organization platform.

- Landing zones are pre-provisioned through code. 

- A landing zone can be scoped to support application migrations and development to scale across the organization's full IT portfolio.

- The Azure landing zone accelerator can be deployed into the same Azure AD tenant for an existing Azure architecture. The accelerator is an Azure-portal-based deployment.

### Things to consider when using Azure landing zones

You're ready to finalize your governance strategy for Tailwind Traders. Consider how you can use Azure landing zones to scale your design:

- **Consider including landing zones in your design**. Include landing zones in your overall Azure infrastructure design. You can use subscriptions as a unit of management and scale that's aligned with business needs and priorities. Apply Azure Policy to provide guardrails and ensure continued compliance with your organization's platform, along with the applications that are deployed onto it. 
 
- **Consider creating landing zones through code**. Implement landing zones that are pre-provisioned through code. As your situation changes, you should expect to refactor the code. Use an iterative approach that maximizes learning opportunities and minimizes time to business success. You can minimize refactoring by having a central IT team to review both short term and long-term scenarios.  

- **Consider using the [Azure landing zone accelerator](/azure/cloud-adoption-framework/ready/landing-zone/#azure-landing-zone-accelerator)**. Use the accelerator to provide a full implementation of the conceptual architecture, along with opinionated configurations for key components like management groups and policies. 

- **Consider focusing on your applications**. Focus on application-centric migrations and development rather than pure infrastructure lift-and-shift migrations, such as moving virtual machines. 

- **Consider Azure-native design and aligning with the platform**. Favor using Azure-native platform services and capabilities, when possible. It's crucial to align with the Azure platform roadmap to ensure that new capabilities are made available within customer environments.

- **Consider scoping for both migrations and green field situations**. Scope the landing zone to support application migrations and green field development at scale in Azure. This expansion allows for a design that can scale across your organization's complete IT portfolio, which looks well beyond a short-term cloud-adoption plan.

- **Consider [transitioning existing architectures to Azure landing zones](/azure/cloud-adoption-framework/ready/enterprise-scale/transition)**. Take advantage of landing zones for existing Azure architecture. Deploy the Azure landing zone accelerator into the same Azure AD tenant in parallel with the current environment. You can create a new management group structure and ensure that the existing environment isn't affected by these changes.

> [!NOTE]
> It's recommended to conduct an [Azure landing zone review](/assessments/?mode=pre-assessment&id=21765fea-dfe6-4bc4-8bb7-db9df5a6f6c0), to host workloads that you plan to build in or migrate to the cloud. This assessment is designed for customers with two or more years of experience. If you're new to Azure, this assessment helps you identify investment areas for your adoption strategy. 

Congratulations! You now have all the information you need to design and implement a strong governance strategy.