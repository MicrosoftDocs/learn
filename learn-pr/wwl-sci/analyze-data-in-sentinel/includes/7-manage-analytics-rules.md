

## Manage analytics rules



To adjust the noise and filter the more important threats detected, you should manage the analytics rules on an ongoing basis. This will help ensure that your rules remain useful and efficient in detecting potential security threats.



You can perform the following four actions on existing active rules:



- Edit

- Disable

- Duplicate

- Delete



## Edit rules



You can modify existing rules by selecting **Edit** in the details pane. To edit a rule, you navigate the same pages that you did in creating the rule. The previous inputs that you used to create the rule are preserved. You can change any properties of the rule to further tune the result of the threat detection.



A typical modification that you might want to implement is to attach an automated response to an already detected threat. To do this, on the **Automated Response** page, you can select one of the existing playbooks that defines the automated activity that will run if the threat is detected.



For example, your analytics rule might be detecting an incident that has already been resolved, and you want to reduce further alerts if similar activity occurs. By attaching a playbook that contains automated activity, you can change the incident status or add comments when a similar incident is detected.  



:::image type="content" source="../media/06-edit-existing-rule.png" alt-text="Screenshot of the editing existing analytics rule." border="false":::



## Disable rules



You can disable a rule when you're performing an activity that can trigger the rule alert. Disabled rules retain  their configuration, and you can enable them again at a later time.



## Duplicate rules



When you duplicate a rule, the rule contains all the configuration provided from the original rule. You can further modify the configuration based on your requirements. Don't forget to change the name of the duplicated rule because by default, the duplicate rule has the same name as the original rule with the string **Copy** appended to it.



## Delete rules



Deleting the rule prompts you for confirmation before Microsoft Sentinel Analytics removes it from the set of active rules. For example, you can delete a rule about a service or a resource that isn't in use, which eliminates the need for the rule. Be aware that deleting a rule is permanent, and there isn't an undo feature. Therefore, we recommend you first disable the rule for a period of time until you're sure you don't need it.