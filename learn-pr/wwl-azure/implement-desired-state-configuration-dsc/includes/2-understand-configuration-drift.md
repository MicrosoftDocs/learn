**Configuration drift** is the process of a set of resources changing over time from their original deployment state.

It can be because of changes made manually by people or automatically by processes or programs.

Eventually, an environment can become a snowflake. A *snowflake* is a unique configuration that cannot be reproduced automatically and is typically a result of configuration drift.

With snowflakes, infrastructure administration and maintenance invariably involve manual processes, which can be hard to track and prone to human error.

The more an environment drifts from its original state, the more likely it is for an application to find issues.

The greater the degree of configuration drift, the longer it takes to troubleshoot and rectify issues.

:::image type="content" source="../media/configuration-drift-44f43cbe.png" alt-text="A flowchart representing how application state changes over time begins with an application state icon. An arrow with a clock representing time, points from the application state to a second, different application state, which has another clock and arrow pointing to a third, different application state.":::


## Security considerations

Configuration drift can also introduce security vulnerabilities into your environment. For example:

 -  Ports might be opened that should be kept closed.
 -  Updates and security patches might not be applied across environments consistently.
 -  The software might be installed that doesn't meet compliance requirements.

## Solutions for managing configuration drift

While eliminating configuration drift can be difficult, there are many ways you can manage it in your environments using configuration management tools and products such as:

 -  Windows PowerShell Desired State Configuration. It's a management platform in PowerShell that enables you to manage and enforce resource configurations. For more information about Windows PowerShell Desired State Configuration, go to [Windows PowerShell Desired State Configuration Overview](/powershell/scripting/dsc/overview/overview).
 -  Azure Policy. Use Azure Policy to enforce policies and compliance standards for Azure resources. For more information about Azure Policy, go to [Azure Policy](https://azure.microsoft.com/services/azure-policy/).

There are also other third-party solutions that you can integrate with Azure.
