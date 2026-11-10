AI agents can use models, context, and tools to work toward a goal. As agents gain the ability to take actions, organizations need security boundaries appropriate to that new capability.

Contoso wants employees to benefit from AI assistance. At the same time, the company needs to determine what an agent can access and how agent activity can be controlled.

Three concepts are central to this security model:

- Containment
- Identity
- Manageability

## Containment

Containment establishes a boundary around a workload.

For an AI agent, an effective containment boundary can limit the resources available to the agent. Those resources might include files, networks, processes, or other system capabilities.

The principle is straightforward:

An agent should have access to the resources required for its assigned work, rather than automatically receiving access to every resource available to the user.

In the Contoso scenario, the employee wants help preparing a project package. That goal doesn't necessarily require access to every file, application, or network resource on the PC.

Containment allows Contoso to think about agent access in terms of the resources required for the task.

## Agent identity

Identity helps distinguish one actor from another.

When a person takes an action, the operating environment can associate the action with that person's identity. When an agent acts for a person, organizations also need a way to distinguish the agent's activity from direct user activity.

Agent identity supports clearer attribution. It helps answer questions such as:

- Did the employee initiate this operation directly?
- Did an agent perform the operation?
- Which agent performed it?
- Under what policy or boundary was the agent operating?

Identity doesn't replace containment. An agent can have an identifiable presence and still require limits on the resources it can access.

## Manageability

Organizations need a way to establish and enforce policies across managed devices.

Manageability supports organizational control over agentic workloads. It can help IT teams establish which capabilities are allowed, what resources are available, and which boundaries apply.

For Contoso, manageability connects an individual AI experience to a broader organizational security strategy. The employee sees assistance with a project package, while the IT team sees an agent operating under defined policies.

## Microsoft Execution Containers

Microsoft Execution Containers (MXCs) act as a policy-driven execution layer that enforces developer- or IT-defined resource policies at runtime. This enables consistent policies to define what is and is not available to agents within each container.

This approach helps separate the agent's effective access from the full access of the interactive user. In the Contoso scenario, for example, an agent working on the project package might need access to the selected project files and approved tools, but not to every file, application, or network resource available to the employee. Instead of assuming that the agent should inherit all of the employee's access, Contoso can define a more specific resource boundary for the task.

## Containment, identity, and manageability together

These concepts address different questions:

| **Concept** | **Question addressed** |
| :---: | :---: |
| **Containment** | Which resources can the agent access? |
| **Identity** | Which actor performed an action? |
| **Manageability** | How does the organization establish and maintain policy? |

The concepts work together.

Containment without identity could make attribution more difficult. Identity without containment could identify an agent without limiting its access. Device-level controls without organizational manageability could be difficult to apply consistently.

## Key takeaways

The employee asks, "Can an AI agent take care of this work for me?"

Contoso's IT team asks, "What access does the agent need to complete that work appropriately?"

The Windows security model for agents seeks to make useful action possible within controlled boundaries. That means Contoso can now add another part to its answer:

- Hybrid intelligence makes local and cloud resources available to AI experiences.
- Copilot can use those resources to provide more capable assistance.
- Containment, identity, and manageability help control agentic work.

One final question remains:

**What does Contoso need from its PCs to support different local AI workloads?**
