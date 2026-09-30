Not every AI deployment presents the same level of risk.

An AI system that generates a draft for a user to review can present different governance considerations from an agent that automatically changes records or makes decisions that affect users.

For this reason, effective governance should be risk-based. Risk-based governance means applying safeguards and oversight that are proportionate to the potential risk of a particular AI deployment. Higher-risk uses may require stronger controls, additional human oversight, or more frequent monitoring, while lower-risk uses may require fewer controls.

The goal is not to apply the same controls to every AI deployment. Instead, organizations assess the specific scenario and determine what safeguards are appropriate based on the system's capabilities, authority, context, and potential impact.

## Start with the scenario

Before determining controls, understand how the AI system will actually be used.

Consider:

- What is the intended use?
- Who will use the system?
- Who could be affected by its outputs or actions?
- What information will it access?
- What decisions or actions will it influence?
- What could happen if the system behaves unexpectedly?

These questions help identify the factors that contribute to risk in a particular deployment.

## Consider access and permissions

The information an AI system can access can affect the potential impact of its actions.

For example, an agent that accesses publicly available information presents different considerations from an agent that can retrieve private organizational data, like:

- Customer records.
- Financial information.
- Employee information.
- Confidential business documents.
- Intellectual property.

Organizations should determine whether access is appropriate for the intended use and whether permissions limit the system to information it needs.

For agentic systems, this consideration extends beyond data access. Organizations should also evaluate what tools and actions the system is authorized to use. An agent that can read information has a different authority level from one that can modify records or initiate transactions.

## Consider human oversight

Human oversight should reflect the potential impact of an AI system's actions. The more an action could affect a user, a business process, or an important outcome, the more likely it is to require human review.

For example, an agent could automatically categorize incoming support requests and route them to the appropriate queue. If the agent makes a mistake, the request may simply need to be rerouted.

Now consider an agent that can close a customer complaint based on its interpretation of the customer's response. An incorrect action could affect the customer's experience or prevent the complaint from receiving further attention. In this case, human review before the action occurs may be appropriate.

When determining the right level of human oversight, consider:

- Which actions can occur automatically?
- Which actions require human approval?
- What conditions should trigger escalation?
- Who is accountable for the outcome?
- What happens when the system cannot confidently complete a task?

Based on these considerations, an organization can determine the appropriate level of human oversight, such as building human review into the process or allowing the action to occur automatically.

## Consider security

Security considerations extend beyond deciding what an AI system can access or do. Organizations also need controls to protect those capabilities and detect or respond to misuse, unexpected behavior, or attacks.

Microsoft's approach can help inform how organizations think about these risks and develop their own governance practices. Microsoft's updated Responsible AI Standard integrates responsible AI governance more closely with security requirements, including the Security Development Lifecycle (SDL), which incorporates security considerations throughout the development process.

Organizations can apply the same principle to AI deployments by considering security as part of how they design, configure, deploy, and monitor AI systems, rather than treating it as a separate concern or afterthought.

For an AI deployment, consider:

- How identities are established.
- How permissions are assigned.
- Which tools the system can access.
- How actions are constrained.
- How unauthorized actions, excessive permissions, suspicious activity, or other security issues are detected.
- How incidents are handled.

Security shouldn’t be treated as a separate concern that’s added after an AI system has been designed or deployed. It’s part of determining whether the system can operate safely within its intended environment.

## Consider monitoring for change over time

AI deployments can change after they are initially configured. Data and applications can change, users can interact with the system in new ways, and new tools or capabilities can be added. The AI system itself may also be updated.

These changes can introduce new risks or change existing ones. Governance therefore needs to account for how the system operates over time, not just how it was configured when it was first deployed.

Organizations should plan to periodically review permissions, monitor system behavior, reassess risks, and update controls as the deployment changes.

## Key takeaway

Risk-based governance means matching safeguards and oversight to the potential risk of an AI deployment. Organizations should consider the deployment's capabilities, authority, context, and potential impact, then apply controls that are proportionate to those risks.

Because AI deployments can change over time, governance should also be reviewed and adjusted as the system, environment, or way it is used changes.
