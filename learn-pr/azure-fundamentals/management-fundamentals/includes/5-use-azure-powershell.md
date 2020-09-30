Tailwind Traders employs technologists with many different skills.  A team of developers and administrators build and maintain a collection of intranet applications that are vital to the business.  The team has a strong background in Windows development and network administration.  

The team moved its applications to the cloud, and it now needs a way to perform one-off testing, management, and administrative tasks in its intranet environment.  The team quickly realized that managing Azure from the portal takes too much time and is not repeatable.  Which tool should the company use for one-off tasks?

## Which service should you choose?

As you did in the preceding unit, apply the decision criteria you learned about earlier to find the right option.

First, in this scenario, does the Tailwind Traders team need to perform one-off management, administrative, or reporting actions?  Yes. However, the team already knows that it doesn't want to rely on the Azure portal for these one-off administrative tasks.  Therefore, both Azure PowerShell and the Azure CLI are candidates.  We'll home in on which tool the team should use in a moment.

Second, in this scenario, does Tailwind Traders need a repeatable and reliable means of deploying its entire infrastructure?  No, not in this scenario.  Therefore, ARM templates are not the right choice.

When it's doing scripting, does the Tailwind Traders team come from a Windows administration or Linux administration background?  This team has a Windows administration background. It would likely be most comfortable using Azure PowerShell, because this tool allows them to use the syntax the team is most comfortable with to perform one-off administration tasks.

Azure PowerShell is the best choice for this scenario.