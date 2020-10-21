## Manage analytics rules

Your organization can connect many data sources to Azure Sentinel and can quickly generate many security alerts. To adjust the noise and filter the important threat detection, you need to manage analytics rules on an ongoing basis. That will ensure that your rules remain useful and efficient in detecting potential security threats.

There are 4 action that you can take on existing active rules:

- Edit
- Disable
- Duplicate
- Delete

## Edit existing rules

You can modify existing rules, by clicking on the **Edit** button in the details pane blade. Editing a rule will take you through the same pages as creating the rule. The previous inputs that were used in the creation of the rule are preserved. You can change any properties of the rule to further tune the result of the threat detection.

The common modification that you want to achieve is to attach an automated response to an already detected threat. In the **Automated Response** you can select one of the existing Playbooks, that define the automated activity that will run if the threat is detected.

## Disable

You can disable the rule while you are doing some activity that can trigger the rule alert. Disabled rules keep all the configuration, and in certain point of time can be enabled again.

## Duplicate

When you duplicate the rule, you have startup configuration provided from the original rule, that can be further modify. Do not forget to change the name of the duplicated rule, because **Copy** string is appended with the name of the original rule.

## Delete

Deleting the rule will prompt for confirmation before is removed from the active rules. For example, you can delete a rule about a service or a resource that is not any more in use, so the rule is no longer needed. Keep in mind that deletion of the rule is permanent, there is no undo feature, so the good practice is that you first Disable the rule on a period of time until you realize that you don&#39;t need that rule.
