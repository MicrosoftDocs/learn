As we noted in the preceding unit, Tailwind Traders employs technologists with many different skills. The DevOps team is primarily concerned with keeping external systems, such as the company's e-commerce site, up and running. This team has a Linux administration background.  It frequently needs to perform administrative tasks related to the health of the cloud environment.  The team quickly realized that managing Azure from the portal takes too much time and isn't repeatable.  Which tool should it use for one-off tasks?

## Which service should you choose?

Once again, apply the decision criteria you learned about earlier to find the right option.

Because this scenario is almost identical to the one in the preceding unit, you can skip over the first two criteria.  In other words, you can quickly eliminate Azure Resource Manager templates (ARM templates) and the Azure portal as viable options for this scenario.  So, let's go to the third decision criterion.

Choosing the right option in this scenario should be determined by the team's background.  Because this team has a Linux administration background, it would likely be most comfortable using the Azure CLI.  The Azure CLI allows the team to use the Bash shell and its syntax to perform one-off administration tasks.

The Azure CLI is the best choice for this scenario.
