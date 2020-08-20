Tailwind Traders employs technologists with many different skills.  A team of developers and admins build and maintain a collection of intranet applications that are vital to the business.  This team has a strong background in Windows development and network administration.  They moved their applications to the cloud and need a way to perform one-off testing, management, and administrative tasks on their intranet environment.  They quickly realized that managing Azure from the Portal takes too much time and is not repeatable.  Which tool should they use for one-off tasks?

## Which service should we choose?

Just like we did in the previous unit, let's apply the decision criteria we learned about in the previous unit to find the right option.

First, in this scenario, does Tailwind Traders need to perform one-off management / administrative / reporting actions?  Yes. However, they already identified that they do not want to rely on the Azure Portal for these one-off administration tasks.  Therefore, either PowerShell or the Azure CLI are candidates.  We'll hone in on the specific tool they should use in a moment.

Second, in this scenario, does Tailwind Traders need a repeatable and reliable means of deploying their entire infrastructure?  No, not in this scenario.  Therefore, ARM Templates are not the right choice.

When scripting, does this team at Tailwind Traders come from a Windows administration or Linux administration background?  This team has a Windows administration background, therefore they would likely be most comfortable using Azure PowerShell since it allows them to use the syntax they're most comfortable with to perform their one-off administration tasks.

Azure PowerShell is the best choice for this scenario.