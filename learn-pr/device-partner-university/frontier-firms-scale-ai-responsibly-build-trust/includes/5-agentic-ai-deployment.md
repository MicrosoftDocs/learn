You've learned how increasingly capable AI systems change governance requirements. Now let’s apply those concepts to a real-world deployment scenario.

## Scenario

Contoso Inc.'s internal IT help desk is struggling to keep up with employee requests. Common issues such as password resets, software installation requests, device troubleshooting, and access questions generate a high volume of support tickets each day. Support engineers spend significant time answering repetitive questions, manually creating and routing tickets, and reviewing previous cases to find relevant information. As ticket volumes grow, employees can experience longer wait times and inconsistent support experiences.

To improve efficiency and help employees get answers more quickly, the organization is considering deploying an AI support agent for its internal IT help desk.

The proposed agent can:

- Search approved IT documentation.
- Search historical support tickets.
- Retrieve information about the employee submitting a request.
- Draft responses.
- Create support tickets.
- Route tickets to support teams.
- Escalate incidents based on predefined criteria.
- Update ticket status automatically.

The organization believes the agent could reduce manual work, improve response times, and help support teams focus on more complex issues. However, because the agent would have access to organizational information and could influence support workflows, they must first evaluate the risks associated with the proposed capabilities, the safeguards already in place, and any additional governance controls that may be needed before deployment.

**Your assignment**: The organization wants to determine whether the agent is ready for deployment. As a part of this assessment, you’ve been tasked with evaluating the agent and identifying any governance requirements that should be addressed before and after launch.

## Step 1: Understand the deployment

**Start by identifying how the agent will operate.**

You already know that the agent does more than generate responses. It has both **capability and authority**. It can access information, interact with systems, and perform actions that affect support workflows.

That means the agent can do things like retrieve employee information, access historical tickets, create records, route requests, and update ticket status. These capabilities could improve efficiency and reduce manual work for the IT help desk, but they also introduce governance considerations related to data access, security, accountability, and oversight.

Before deployment, it's important to understand not only what the agent can do, but also the limits that should be placed on its actions.

### Question

While performing your assessment, what questions would you ask to understand how the agent will operate within the organization? Take a moment to write down two or three questions before continuing.

### Consider

You could ask:

- **What information can the agent access?**
Can it access only approved IT documentation and support records, or can it retrieve sensitive employee information, confidential business data, or other resources that aren't required for its role?
- **Which systems can it interact with?**
Can it only work within the ticketing system, or can it also interact with identity systems, business applications, or other enterprise resources?
- **Which users can invoke it?**
Is the agent available to all employees, only IT staff, or a specific group of authorized users?
- **What actions can it perform?**
Can it only make recommendations and draft responses, or can it also create tickets, modify records, route requests, and update systems on its own?
- **Which actions can occur without human approval?**
Which tasks can be automated safely, and which actions should require human review before they are completed?

> [!TIP]
> Think about the questions you wrote down. What information are you trying to learn about the agent? Do your questions focus on areas such as access, authority, and responsibility? How could the answers influence decisions about deploying the agent?

### Analysis

**The questions you ask during an assessment can reveal important information about the agent's access, capabilities, and level of authority within the organization.**

By asking these questions, the organization can better understand the agent's capabilities, the risks associated with those capabilities, and whether additional safeguards may be needed before deployment.

The answers can help inform governance decisions about data access, user permissions, approval requirements, and monitoring. The goal is not only to determine whether the agent works as intended, but also whether it can be deployed in a way that aligns with organizational policies, security requirements, and business objectives.

## Step 2: Evaluate access and permissions

As part of the proposed deployment, the organization plans to allow the agent to search historical support tickets when responding to employee requests. At first glance, this appears beneficial. Previous tickets may contain solutions to common problems, helping the agent provide more accurate responses and reducing the need for employees to wait for a support engineer.

However, access to historical tickets also raises governance questions. Support tickets often contain information about employees, devices, software issues, access requests, security incidents, and troubleshooting activities. Not all of this information may be relevant to the task the agent is performing.

Before deployment, the organization should evaluate whether the proposed level of access is appropriate and whether permissions are aligned with the agent's intended role.

### Question

Is it appropriate for Contoso’s support agent to search all historical support tickets?

### Consider

- Do all support tickets contain information that every employee should be able to access?
- Should the agent inherit the requesting employee's permissions?
- Does the agent need access to every ticket to complete its task?
- Could historical tickets contain sensitive information unrelated to the current request?

> [!TIP]
> Consider what information the answers to these questions reveal. How could they influence decisions about what data the agent can access, what safeguards may be needed, and whether the proposed deployment aligns with organizational policies?

### Analysis

The purpose of this assessment isn't simply to determine whether the agent can access historical tickets. It's to determine whether that access is necessary and appropriate for its intended use.

For example, historical tickets might contain personal information, details about security investigations, privileged access requests, or other sensitive content that isn't required to resolve a user's current issue. If the agent has access to more information than it needs, the potential impact of an error, misuse, or unauthorized disclosure increases.

The organization should evaluate whether a more limited approach could achieve the desired business outcome. For example, the agent might be restricted to approved knowledge articles, selected categories of support tickets, or information that the requesting employee would already be authorized to access.

The assessment should also consider how permissions are applied. If the agent can access information beyond what a user is normally permitted to view, it could expose data that employees wouldn't otherwise be able to access through standard processes.

By evaluating access and permissions before deployment, the organization can help ensure the agent has the information it needs to perform its role while reducing unnecessary exposure to sensitive data. This helps balance the benefits of the agent with the need to protect information and manage risk.

## Step 3: Evaluate actions and authority

In addition to providing information, the proposed agent can perform actions within the support system. One proposed capability would allow the agent to update ticket status automatically as it processes support requests.

Automation can improve efficiency by reducing manual work for support engineers and helping tickets move through the support process more quickly. However, not all actions carry the same level of risk. Some actions have limited impact if performed incorrectly, while others could affect employees, business processes, or service outcomes.

As part of the assessment, the organization should determine which actions are appropriate for automation and which may require human oversight.

### Question

Should Contoso allow its support agent to perform every status change without human review?

### Consider

Consider the difference between:

**Routine action**

The agent updates a ticket from **New** to **In Progress** after routing it to the appropriate support team.

**Higher-impact action**

The agent closes a ticket because it determines that the issue has been resolved.

The second action may warrant additional oversight. If the agent closes the ticket incorrectly, the employee might believe the issue is still being investigated while the support team assumes the problem has been resolved. This could delay assistance, create confusion, or require additional work to reopen and resolve the issue.

> [!TIP]
> Consider the impact of each action the agent can perform. Which actions have a limited effect if performed incorrectly, and which actions could significantly affect users, business processes, or outcomes? How might those differences influence decisions about approvals, oversight, or automation?

### Analysis

The goal of this assessment is not to decide whether automation should be allowed. Instead, it’s to determine which actions can be automated safely, and which actions may require additional safeguards.

Some routine, low-impact actions may be appropriate for full automation because the consequences of an incorrect action are limited and can be easily corrected. Other actions may have a greater impact on users, records, workflows, or business operations. These actions might require human review, approval workflows, additional testing, or ongoing monitoring.

Organizations should evaluate not only what actions an agent can perform, but also the potential consequences of those actions. The level of authority granted to the agent should align with the associated level of risk.

By distinguishing between routine and higher-impact actions, organizations can help ensure that automation improves efficiency while maintaining appropriate accountability and oversight. The agent's permissions, approvals, and governance controls should reflect those distinctions.

## Step 4: Determine human oversight

As part of the proposed deployment, the organization is considering requiring human approval only when the agent identifies a critical incident. All other actions would occur automatically.

At first glance, this approach may seem reasonable. Critical incidents often have significant consequences and may require immediate escalation. However, severity alone may not be the best indicator of when human involvement is needed.

Some actions may have a meaningful impact even when they aren't classified as critical. For example, an agent could close a ticket incorrectly, provide inaccurate guidance, route a request to the wrong team, or fail to escalate an issue that requires attention. These actions could affect employees and business processes, even if the incident itself isn't considered critical.

Before deployment, the organization should determine where human oversight is needed and what role users should play when the agent is uncertain, makes recommendations, or performs actions on behalf of users.

### Question

Is Contoso's proposed oversight model sufficient if approval is required only for critical incidents?

### Consider

- Which actions could create significant consequences if performed incorrectly?
- Which actions are reversible, and which may be difficult to undo?
- Which actions affect users directly?
- Which actions require professional, technical, or organizational judgment?
- What should happen when the agent is uncertain or lacks sufficient information?

> [!TIP]
> Reflect on how you would decide when human involvement is necessary. Would you base oversight on the severity of an incident, the impact of an action, the level of uncertainty, or a combination of factors?

### Analysis

Human oversight should be determined by the potential consequences of an action, not simply whether the work is classified as critical. Even in routine processes, certain decisions may warrant human involvement if an error could affect users, expose sensitive data, disrupt business operations, or create compliance concerns. By evaluating the potential impact of mistakes, organizations can apply oversight where it matters most while still benefiting from automation.

Some low-risk activities may be suitable for automation because mistakes can be identified and corrected easily. Higher-risk activities may require additional safeguards because they affect users directly, involve sensitive information, require professional judgment, or could have significant consequences if performed incorrectly.

Organizations should also consider how an agent responds when it encounters uncertainty. Rather than proceeding automatically, the agent may need to seek additional information, escalate the request, or defer to a human decision-maker when confidence is low or the situation falls outside expected parameters.

Finally, governance decisions should clarify who is accountable for outcomes and what processes are followed when escalation occurs. Establishing these responsibilities helps organizations improve efficiency through automation while maintaining appropriate oversight and trust.

## Step 5: Establish monitoring

The organization proposes reviewing the support agent's performance once every six months after deployment. During that time, the agent will interact with employees, answer questions using organizational knowledge, and support a growing number of users.

### Question

Is Contoso's proposed monitoring approach sufficient if the system is reviewed only every six months?

### Consider

- How quickly could an inaccurate or harmful response affect users?
- What indicators could reveal unexpected behavior or declining performance?
- What user feedback should be collected and reviewed?
- Which incidents require immediate investigation?
- What changes to the agent, its data sources, or its operating environment should trigger another review?

> [!TIP]
> Monitoring is not just about scheduled reviews. Consider how the organization will detect problems between reviews. What information would help identify issues early, and what events should trigger immediate investigation or a reassessment of governance controls?

### Analysis

Governance does not end when an AI system is deployed. Organizations should establish monitoring practices that are appropriate to the system's purpose, use, and level of risk.

In this scenario, waiting six months between reviews may create significant gaps in visibility. If the agent begins providing inaccurate information, producing unexpected outputs, exposing sensitive information, or creating poor user experiences, those issues could affect many users before a formal review occurs. The organization needs a way to detect and respond to problems as they emerge rather than relying solely on periodic assessments.

Effective monitoring helps organizations identify incorrect outputs, unexpected actions, security incidents, policy violations, and other conditions that may require investigation. To detect these issues, organizations can review user feedback, track operational metrics, monitor system activity, and analyze cases where the agent provides incorrect or harmful responses.

Organizations should also consider how changes over time may affect risk. Updates to the agent, modifications to knowledge sources, new integrations, expanded responsibilities, or changes in user behavior can all alter how the system performs and whether existing governance controls remain appropriate.

When issues are identified, organizations should be able to respond and adjust the system or its governance controls. Monitoring creates a continuous feedback loop that helps organizations manage risk, improve system performance, and maintain trust as AI systems evolve.

## Step 6: Make a deployment recommendation

You've evaluated the proposed support agent's access to information, authority to take action, human oversight requirements, security controls, and monitoring approach.

### Question

Based on your assessment of Contoso's proposed deployment, would you recommend deploying the agent?

Prepare a recommendation for Contoso's leadership team. Your recommendation should explain whether the agent should be deployed as proposed, deployed with additional safeguards, or revised before deployment.

### Consider

Before making your recommendation, consider:

- The agent's access to information
- Its authority to take action
- Oversight requirements
- Security controls
- Monitoring approach
- How the deployment will be governed over time

### Analysis

Based on the information provided, Contoso could proceed with a controlled pilot after defining and validating the required access restrictions, approval rules, security controls, accountability, monitoring, and incident-response processes.

Once those controls and processes are in place and validated, Contoso could deploy the support agent, but not as an unrestricted system. Data access should be limited to approved support information, higher-impact actions should require human review, appropriate security controls should be implemented, and the system should be continuously monitored after deployment. The deployment should also be reassessed as the agent, its connected systems, and its use evolve over time.

This recommendation is based on the following governance considerations:

- **Access**: Limit data access to information necessary for the intended support scenarios and apply appropriate permissions.
- **Authority**: Separate routine actions that can be automated from higher-impact actions that require additional review.
- **Oversight**: Define approval and escalation requirements based on the potential impact of actions.
- **Security**: Establish appropriate identity, permission, and system controls for the agent's tools and connections.
- **Monitoring**: Monitor system behavior, outcomes, user feedback, and incidents after deployment.
- **Lifecycle governance**: Review the deployment as the agent, its connected systems, its use, or its surrounding risks change.

## Key takeaway

Organizations should evaluate what an AI system can access, what actions it can take, what safeguards are required, where human judgment is needed, and how the system will be monitored and governed throughout its lifecycle.
