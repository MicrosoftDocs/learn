Azure Policy is an Azure service that helps you manage your compliance state across different Azure service. Azure Policy for Kubernetes enables you to use the same Azure policies in your Kubernetes clusters as well. This allows you to manage the compliance state of Kubernetes resources like pods, deployments and services as if they were an Azure resource.

In this unit, you'll learn about Azure Policy and Azure Policy for Kubernetes.

## Introducing Azure Policy

Azure policy allows you to manage the compliance state of your Azure services. It does this by comparing the state of your Azure resources to business rules you define. Common rules are the limitation of certain regions, the requirement for resource tags or limiting which Azure services can be used.

The way you define these business rules in Azure policy is by using policy definitions. There are many built-in policies that cover a range of common scenarios. If one of the built-in policies doesn't meet your needs, you can also define a custom policy using a JSON-based language. You can also group multiple policy definitions togethers into an initiative. 

In a policy definition you define a resource compliance condition and the effect that should be taken if that condition is met. A condition compares a resource's properties to a required value. An example of a condition could be comparing the location of a resource versus a predefined list of allowed locations. The effect of a policy can be auditing the condition, denying the resource's creation or modifying the created resource. In the example of the location of a resource, you could for example deny the creation of resources not in the list of allowed loations. For a more detailed explanation of policy definitions, please refer to the [documetation](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure).

Azure Policy works by assigning a policy definition or an iniative to a scope by making policy assignments. A scope can be either a management group, a subscription or a resource group. Policy assignments are automatically inherited to all scopes underneath the assignment, unless you make an exclusion. Multiple policy definitions can apply to a certain scope. The net result of layering policy definitions is considered to be _cumulative most restrictive_. This means that if multiple policies apply to a certain resource, that resource will only be compliant if all policy definitions applying to it are compliant.

Policy assignments get evaluated during the creation or update of Azure resources, if the definition or scope is changed and periodically (every 24 hours) for continuous monitoring. Practically, this means that when you create new resources the policy will immediately take effect. Any historical resources will also be scanned, so you get a continuous view on the compliance of all your resources.

### Integration of Azure Policy with AKS



### Understanding how Azure Policy for AKS works under the covers

