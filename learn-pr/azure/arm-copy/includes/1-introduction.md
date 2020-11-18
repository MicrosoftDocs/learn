Azure Resource Manager (ARM) templates has numerous constructs able to handle everything from simpler setups to even more complex ones. These constructs help you to for example conditionally run statements, define dependencies between resources and reading secrets at deployment time.

You're on a software team that's authoring these templates for the company Tailwind Traders. You plan to deploy the described infrastructure in the templates. There are various challenges that you need to address, from secrets, assigning secrets to template resources and dealing with repetitive template syntax and more. You will also need to look into how you can express dependencies, as you want a certain deployment order, just to mention a few important scenarios.

You decide on evaluating a set of ARM features able to address the above scenarios.

In this module, you gain an understanding for how to handle more complex scenarios that you will face. You will use various complex constructs like, for example,  _copy_, and _dependsOn_, and also learn how to deal with managing secrets when deploying.

## Learning objectives

After completing this module, you'll be able to:

- Control the deployment order of resources by using the _dependsOn_ construct.
- Securely assign secrets like passwords to resources in your templates by using an Azure Key Vault and ARM template configuration.
- Conditionally deploy resources by using the _condition_ construct and parameters at deployment time.
- Deploy multiple resources of the same type by using the _copy_ construct and thereby reducing repetitive configuration.
