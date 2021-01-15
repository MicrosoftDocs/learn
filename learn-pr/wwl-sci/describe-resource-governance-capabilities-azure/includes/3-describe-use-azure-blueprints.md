Azure Blueprints are a way to define a repeatable set of Azure resources.  Azure Blueprints enable development teams to rapidly provision and run new environments, with the knowledge that they are in line with the organization’s compliance requirements. With Azure Blueprints, they’re also able to provision Azure resources across several subscriptions simultaneously. All of this means they can achieve shorter development times and quicker delivery.

Blueprints are a declarative way to orchestrate the deployment of various resource templates and other artifacts such as:

- Role Assignments
- Policy Assignments
- Azure Resource Manager templates (ARM templates)
- Resource Groups

Blueprint objects are replicated to multiple Azure regions. This replication provides low latency, high availability, and consistent access to your blueprint objects, regardless of which region Azure Blueprints deploys your resources to.

Additionally, with Azure Blueprints, the relationship between the blueprint definition (*what should be deployed*) and the blueprint assignment (*what was deployed*) is preserved. This connection supports improved tracking and auditing of deployments.

Azure Blueprints helps ensure Azure resources are deployed in a way that is in line with compliance requirements. However, a service like Azure Policy should be used to continuously monitor resources and ensure that resources continue to be in line with compliance requirements.
