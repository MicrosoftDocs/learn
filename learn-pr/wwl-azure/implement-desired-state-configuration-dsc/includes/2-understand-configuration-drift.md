**Configuration drift** is the process of a set of resources changing over time from their original deployment state. It can occur because of changes made manually by people or automatically by processes or programs.

## What is a snowflake configuration?

Eventually, an environment can become a **snowflake**. A **snowflake** is a unique configuration that cannot be reproduced automatically and is typically a result of configuration drift. With snowflakes, infrastructure administration and maintenance invariably involve manual processes, which can be hard to track and prone to human error.

## Impact of configuration drift

The more an environment drifts from its original state, the more likely it is for an application to encounter issues. The greater the degree of **configuration drift**, the longer it takes to troubleshoot and rectify problems.

:::image type="content" source="../media/configuration-drift-44f43cbe.png" alt-text="A flowchart representing how application state changes over time begins with an application state icon. An arrow with a clock representing time, points from the application state to a second, different application state, which has another clock and arrow pointing to a third, different application state.":::

## Security considerations

**Configuration drift** can also introduce security vulnerabilities into your environment. Examples include:

- **Open ports:** Ports might be opened that should be kept closed, exposing your systems to unauthorized access.
- **Inconsistent patching:** Updates and security patches might not be applied across environments consistently, leaving some systems vulnerable.
- **Non-compliant software:** Software might be installed that doesn't meet compliance requirements, violating security policies.

## Solutions for managing configuration drift

While eliminating **configuration drift** can be difficult, there are many ways you can manage it in your environments using configuration management tools and products:

### Windows PowerShell Desired State Configuration

**Windows PowerShell Desired State Configuration (DSC)** is a management platform in **PowerShell** that enables you to manage and enforce resource configurations. For more information about **Windows PowerShell Desired State Configuration**, go to [Windows PowerShell Desired State Configuration Overview](/powershell/scripting/dsc/overview?view=powershell-7.4).

### Azure Policy

**Azure Policy** allows you to enforce policies and compliance standards for **Azure resources**. Use **Azure Policy** to prevent configuration changes that would cause drift from your desired state. For more information about **Azure Policy**, go to [Azure Policy](https://azure.microsoft.com/services/azure-policy/).

### Third-party solutions

There are also other third-party configuration management solutions that you can integrate with **Azure**, such as **Chef**, **Puppet**, and **Ansible**.
