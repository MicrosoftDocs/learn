As we noted in the previous scenario, Tailwind Traders employs technologists with many different skills. The DevOps team is primarily concerned with keeping external systems, like the ecommerce site, up and running. This team has a Linux administration background.  They frequently need to perform administration tasks related to the health of their cloud environment.  They quickly realized that managing Azure from the Portal takes too much time and isn't repeatable.  Which tool should they use for one-off tasks?

## Which service should we choose?

Once again, we'll apply the decision criteria we learned about in a previous unit to find the right option.

Given that this scenario is almost identical to the one in the previous unit, we can skip over the first two criteria.  In other words, we can quickly eliminate ARM templates and the Azure portal as viable options for this scenario.  So, let's skip to the third decision criteria.

Choosing the right option in this scenario should be determined by the team's background.  Since this team has a Linux administration background, they would likely be most comfortable using the Azure CLI.  The Azure CLI allows them to use the Bash shell and its syntax to perform their one-off administration tasks.

The Azure CLI is the best choice for this scenario.