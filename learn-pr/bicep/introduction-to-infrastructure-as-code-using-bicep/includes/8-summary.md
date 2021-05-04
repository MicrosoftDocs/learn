To stay competitive and meet customer demand, your toy company needs the ability to automate its Azure infrastructure deployments using infrastructure as code.

In this module, you learned how Infrastructure as Code (IaC) makes it possible for you to automate your infrastructure provisioning and configuration. It helps you and your organization gain higher confidence in your deployments by providing consistency. IaC can help to manage multiple environments, including new environments and non-production environments. You can gain a better understanding of your cloud resources by using IaC.

Imagine how much time it would take to deploy new environments manually using only the Azure portal. You need to deploy each resource one by one, making sure to keep configurations identical. When you want to add a new resource or change and existing resource, it has to be manually created for each environment. IaC can help you define your resources in a single place and then apply the same configuration to all of your environments.

You learned how you create your IaC code base using a declarative or imperative approach. With imperative code, you execute a sequence of commands, in a specific order, to reach an end configuration. This process defines what the code should accomplish, and it also defines how to accomplish the task. Using declarative code, you only specify the end configuration. It doesn't define how to accomplish the task.

After deciding to take a declarative approach to IaC, you learned about Azure Resource Manager (ARM) and ARM templates. These JSON and Bicep templates declaratively describe your Azure infrastructure and are used to deploy resources to your Azure subscription.

Finally, you learned about Bicep, a declarative language that lets us easily describe our Azure resources. By using Bicep we can gain all of the benefits of IaC while working in an easy, powerful language.

## References

- [Bicep on GitHub](https://github.com/Azure/bicep)
