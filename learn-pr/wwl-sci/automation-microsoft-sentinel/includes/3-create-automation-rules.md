Automation rules are a way to centrally manage the automation of incident handling, allowing you to perform simple automation tasks without using playbooks. For example, automation rules allow you to automatically assign incidents to the proper personnel, tag incidents to classify them, and change the status of incidents and close them. Automation rules can also automate responses for multiple analytics rules at once, control the order of actions that are executed, and run playbooks for those cases where more complex automation tasks are necessary. In short, automation rules streamline the use of automation in Microsoft Sentinel, enabling you to simplify complex workflows for your incident orchestration processes.

## Creating and managing automation rules

You can create and manage automation rules from different points in the Microsoft Sentinel experience, depending on your particular need and use case.

### Automation blade

Automation rules can be centrally managed in the new Automation blade (which replaces the Playbooks blade), under the Automation rules tab. (You can also now manage playbooks in this blade, under the Playbooks tab.) From there, you can create new automation rules and edit the existing ones. You can also drag automation rules to change the order of execution, and enable or disable them.

In the Automation blade, you see all the rules that are defined on the workspace, along with their status (Enabled/Disabled) and which analytics rules they're applied to.

When you need an automation rule that will apply to many analytics rules, create it directly in the Automation blade. From the top menu, select Create and Add new rule, which opens the Create new automation rule panel. From here you have complete flexibility in configuring the rule: you can apply it to any analytics rules (including future ones) and define the widest range of conditions and actions.

### Analytics rule wizard

In the Automated response tab of the analytics rule wizard, you can see, manage, and create automation rules that apply to the particular analytics rule being created or edited in the wizard.

When you select Create and one of the rule types (Scheduled query rule or Microsoft incident creation rule) from the top menu in the Analytics blade, or if you select an existing analytics rule and select Edit, you'll open the rule wizard. When you select the Automated response tab, you'll see a section called Incident automation, under which the automation rules that currently apply to this rule will be displayed. You can select an existing automation rule to edit, or select Add new to create a new one.

You'll notice that when you create the automation rule from here, the Create new automation rule panel shows the analytics rule condition as unavailable, because this rule is already set to apply only to the analytics rule you're editing in the wizard. All the other configuration options are still available to you.

### Incidents blade

You can also create an automation rule from the Incidents blade, in order to respond to a single, recurring incident. This is useful when creating a suppression rule for automatically closing "noisy" incidents. Select an incident from the queue and select Create automation rule from the top menu.

You'll notice that the Create new automation rule panel has populated all the fields with values from the incident. It names the rule the same name as the incident, applies it to the analytics rule that generated the incident, and uses all the available entities in the incident as conditions of the rule. It also suggests a suppression (closing) action by default, and suggests an expiration date for the rule. You can add or remove conditions and actions, and change the expiration date, as you wish.

## Components of an Automation Rule

Automation rules are made up of several components:

- **Trigger:** Automation rules are triggered by the creation of an incident.

    To review – incidents are created from alerts by analytics rules, of which there are several types, as explained in the tutorial Detect threats with built-in analytics rules in Microsoft Sentinel.

- **Conditions:** 
Complex sets of conditions can be defined to govern when actions (see below) should run. These conditions are typically based on the states or values of attributes of incidents and their entities, and they can include AND/OR/NOT/CONTAINS operators.

- **Actions:**
Actions can be defined to run when the conditions (see above) are met. You can define many actions in a rule, and you can choose the order in which they’ll run (see below). The following actions can be defined using automation rules, without the need for the advanced functionality of a playbook:

  - **Changing the status of an incident**, keeping your workflow up to date.

        When changing to “closed,” specifying the closing reason and adding a comment. This helps you keep track of your performance and effectiveness, and fine-tune to reduce false positives.

  - **Changing the severity of an incident** – you can reevaluate and reprioritize based on the presence, absence, values, or attributes of entities involved in the incident.

  - **Assigning an incident to an owner** – this helps you direct types of incidents to the personnel best suited to deal with them, or to the most available personnel.

  - **Adding a tag to an incident** – this is useful for classifying incidents by subject, by attacker, or by any other common denominator.

    Also, you can define an action to **run a playbook**, in order to take more complex response actions, including any that involve external systems. Only playbooks activated by the incident trigger are available to be used in automation rules. You can define an action to include multiple playbooks, or combinations of playbooks and other actions, and the order in which they'll run.

    Playbooks using either version of Logic Apps (Standard or Consumption) will be available to run from automation rules.

- **Expiration date:**
You can define an expiration date on an automation rule. The rule will be disabled after that date. This is useful for handling (that is, closing) "noise" incidents caused by planned, time-limited activities such as penetration testing.

- **Order:**
You can define the order in which automation rules will run. Later automation rules will evaluate the conditions of the incident according to its state after being acted on by previous automation rules.

    For example, if "First Automation Rule" changed an incident's severity from Medium to Low, and "Second Automation Rule" is defined to run only on incidents with Medium or higher severity, it won't run on that incident.

