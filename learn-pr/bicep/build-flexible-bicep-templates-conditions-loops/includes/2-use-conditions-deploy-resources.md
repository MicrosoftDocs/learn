Conditions can be used in Bicep code to only deploy resources in certain situations.

In your toy company, you need to deploy resources to different environments. When deploying to your production environment, you need to make sure that auditing is enabled for your SQL servers. But when you deploy to your development environments, you don't want to enable auditing. You want to use single template to deploy all of your environments.

In this unit, you'll learn how to conditionally deploy resources.

## Use simple conditions

When you deploy a resource in Bicep, you can provide the `if` keyword followed by a condition. The condition should resolve to a Boolean (true or false) value. If the value is true then the resource is deployed, and if the value is false then the resource is not deployed.

It's common to create conditions based on the values of parameters that you provide. The following example deploys a storage account only when the `deployStorageAccount` parameter is set to `true`:

::: code language="plaintext" source="code/2-conditional-simple.bicep" highlight="3" :::

Notice that the `if` keyword is on the same line as the resource definition.

## Use expressions as conditions

The example above was quite simple. The `deployStorageAccount` parameter was of type `bool`, so it was clear whether it had a value of true or false.

In Bicep you are also able to use expressions as condition evaluation. The following example only deploys a SQL auditing resource when the `environmentName` parameter value is equal to `Production`:

::: code language="plaintext" source="code/2-conditional-expression.bicep" range="1-5, 19-23, 27-28" highlight="7" :::

It's often a good idea to create a variable for the expression that will be used as a condition. That way, your template is easier to understand and read:

::: code language="plaintext" source="code/2-conditional-expression-variable.bicep" range="1-5, 8-9, 20-24, 28-29" highlight="1, 9" :::

## Depend on conditionally deployed resources

When resources are deployed conditionally, you sometimes need to be aware of how Bicep evaluates dependencies between resources.

Let's continue writing some Bicep code to deploy SQL auditing settings. The Bicep file also need to declare a storage account resource:

::: code language="plaintext" source="code/2-conditional-expression-variable.bicep" range="1-24, 28-29" highlight="12-19" :::

Notice that the storage account has a condition too. This means it won't be deployed for non-production environments either. The SQL server auditing settings resource can now refer to the storage account's details:

::: code language="plaintext" source="code/2-conditional-expression.bicep" range="21-29" highlight="7-8" :::

Notice that this Bicep code uses the `?` operator within the `storageEndpoint` and `storageAccountAccessKey` properties. When the Bicep code is deployed to a production environment, the expressions will be evaluated to the details from the storage account. When it's deployed to a non-production environment, the expressions evaluate to an empty string (``).

You might wonder why this is necessary, since `auditingSettings` and `auditStorageAccount` both have the same condition and so we'll never need to deploy a SQL auditing settings resource without a storage account. While this is true, Resource Manager evaluates the property expressions before conditionals, so if the Bicep code doesn't have this expression, the deployment will fail with a `ResourceNotFound` error.

> [!NOTE]
> You can't define two resources with the same name in the same Bicep file, and then conditionally deploy just one of them. The deployment will fail because Resource Manager will view this as a conflict.

If you have several resources that all have the same condition for their deployment, considering using Bicep modules. You can create a module that deploys all of the resources, and then put a condition on the module in your main Bicep file.
