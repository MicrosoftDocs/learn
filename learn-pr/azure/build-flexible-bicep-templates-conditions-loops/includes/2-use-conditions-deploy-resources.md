You can use conditions in your Bicep code to deploy resources only when specific constraints are in place.

For example, at your toy company, you need to deploy resources to various environments. When you deploy them to a production environment, you need to ensure that auditing is enabled for your Azure SQL logical servers. But when you deploy resources to development environments, you don't want to enable auditing. You do want to use a single template to deploy resources to all your environments.

In this unit, you learn how to deploy resources conditionally.

## Use basic conditions

When you deploy a resource in Bicep, you can provide the `if` keyword followed by a condition. The condition should resolve to a Boolean (true or false) value. If the value is *true*, the resource is deployed. If the value is *false*, the resource is not deployed.

It's common to create conditions based on the values of parameters that you provide. For example, the following code deploys a storage account only when the `deployStorageAccount` parameter is set to `true`:

::: code language="bicep" source="code/2-conditional-simple.bicep" highlight="3" :::

Notice that the `if` keyword is on the same line as the resource definition.

## Use expressions as conditions

The preceding example was quite basic. The `deployStorageAccount` parameter was of type `bool`, so it's clear whether it has a value of `true` or `false`.

In Bicep, conditions can also include expressions. In the following example, the code deploys a SQL auditing resource only when the `environmentName` parameter value is equal to `Production`:

::: code language="bicep" source="code/2-conditional-expression.bicep" highlight="7" :::

It's usually a good idea to create a variable for the expression that you're using as a condition. That way, your template is easier to understand and read. Here's an example:

::: code language="bicep" source="code/2-conditional-expression-variable.bicep" range="1-5, 8-9, 20-24, 28-29" highlight="7, 9" :::

## Depend on conditionally deployed resources

When you deploy resources conditionally, you sometimes need to be aware of how Bicep evaluates the dependencies between them.

Let's continue writing some Bicep code to deploy SQL auditing settings. The Bicep file also needs to declare a storage account resource, as shown here:

::: code language="bicep" source="code/2-conditional-expression-variable.bicep" range="1-24, 28-29" highlight="12-19" :::

Notice that the storage account has a condition too. This means that it won't be deployed for non-production environments either. The SQL auditing settings resource can now refer to the storage account details:

::: code language="bicep" source="code/2-conditional-expression-variable.bicep" range="21-29" highlight="6-7" :::

Notice that this Bicep code uses the question mark (`?`) operator within the `storageEndpoint` and `storageAccountAccessKey` properties. When the Bicep code is deployed to a production environment, the expressions are evaluated to the details from the storage account. When the code is deployed to a non-production environment, the expressions evaluate to an empty string (`''`).

You might wonder why this code is necessary, because `auditingSettings` and `auditStorageAccount` both have the same condition, and so you'll never need to deploy a SQL auditing settings resource without a storage account. Although this is true, Azure Resource Manager evaluates the property expressions before the conditionals on the resources. So, if the Bicep code doesn't have this expression, the deployment will fail with a `ResourceNotFound` error.

> [!NOTE]
> You can't define two resources with the same name in the same Bicep file and then conditionally deploy only one of them. The deployment will fail, because Resource Manager views this as a conflict.

If you have several resources, all with the same condition for deployment, consider using Bicep modules. You can create a module that deploys all the resources, and then put a condition on the module declaration in your main Bicep file.
