## Design for Azure Landing Zones

An [Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/) provides an infrastructure environment for hosting your workloads. Landing zones ensure key foundational principles are put in place before you deploy services.  

To use an analogy, shared city utilities such as water, gas, and electricity are available to new homes before they're constructed. Likewise, for landing zones, the network, identity and access management, policies, management, and monitoring must be readily available to help streamline the application migration process before it begins.

## Landing zone considerations

Here are a few things to think about when considering landing zones. 

- **Include landing zones in your design**. Landing zones should be part of and work with your overall Azure infrastructure design. Use subscriptions as a unit of management and scale that's aligned with business needs and priorities. Apply Azure Policy to provide guardrails and ensure continued compliance with your organization's platform, along with the applications that are deployed onto it. In this diagram, there are landing zones for SAP, Corporate, and Online applications. 

 :::image type="content" source="../media/landing-zones.png" alt-text="Illustration of a management group and subscription organization that includes landing zones.":::
 
- **Provision landing zones through code**. Landing zones are pre-provisioned through code. As your situation changes, expect that you will need to refactor the code. Use an iterative approach that maximizes learning opportunities and minimizes time to business success.  Minimize refactoring by having a central IT team to review both short term and long-term scenarios.  

- **Use the [Azure landing zone accelerator](/azure/cloud-adoption-framework/ready/landing-zone/#azure-landing-zone-accelerator)**. The accelerator is an Azure-portal-based deployment that will provide a full implementation of the conceptual architecture, along with opinionated configurations for key components such as management groups and policies. 

- **Focus on applications**. Focus on application-centric migrations and development rather than pure infrastructure lift-and-shift migrations, such as moving virtual machines. 

- **Use Azure-native design and align with the platform**. Favor using Azure-native platform services and capabilities whenever possible. It's crucial to align with the Azure platform roadmap to ensure that new capabilities are made available within customer environments.

- **Scope for both migrations and green field situations**. Scope the landing zone to support application migrations and green field development at scale in Azure. This expansion allows for design that can scale across your organization's full IT portfolio, which looks well beyond a short-term cloud-adoption plan.

- **Consider [Transitioning existing architectures to the Azure landing zones](/azure/cloud-adoption-framework/ready/enterprise-scale/transition)**. If you already have an existing Azure architecture you can still take advantage of landing zones. Deploy the Azure landing zone accelerator into the same Azure AD tenant in parallel with the current environment. This will create a new management group structure and ensures that the existing environment is not affected by these changes.

>[!NOTE]
>It is recommended you conduct a [Azure Landing Zone Review](/assessments/?mode=pre-assessment&id=21765fea-dfe6-4bc4-8bb7-db9df5a6f6c0) to host workloads that you plan to build in or migrate to the cloud. This assessment is designed for customers with two or more years' experience. If you are new to Azure, this assessment will help you identify investment areas for your adoption strategy. 





