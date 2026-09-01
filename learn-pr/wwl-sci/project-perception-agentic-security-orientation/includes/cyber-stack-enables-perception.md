Coordinated multi-agent defense runs your security operations as one connected workflow at machine speed. That claim only holds if something under the agents makes cross-agent coordination technically possible. Handoffs have to be near-instant, context has to be shared, and the whole workflow has to run continuously without compute costs becoming unmanageable. The layered architecture that makes those handoffs possible is called the Cyber Stack. Its six layers combine to enable coordinated defense, and their names come back in the playbook walkthrough that follows.

:::image type="content" source="../media/cyber-stack.png" alt-text="Diagram that shows Project Perception Cyber Stack layers from Signals and sensors through Context, Models, Harness, Agents, and Actuators." lightbox="../media/cyber-stack.png":::

## How the six layers combine

The Cyber Stack combines six layers into a continuous workflow rather than six independent layers. Signals and sensors feed environmental data into security context, where it's correlated into the shared graph that everything above reasons on. Models supply the reasoning capability, and the harness sequences models and agents through security workflows. Agents run the defined security operations tasks in that sequence, and when they decide to act, actuators translate those decisions into real changes in the environment, which show up as new signals on the next pass. Humans stay in control through approval gates woven into the workflow. Each layer depends on the ones below it, which is why the stack is drawn bottom-up.

To understand how agents coordinate with each other, focus first on two layers: **security context** and **the harness**.

**Security context** turns raw signals into a shared, near-real-time understanding of the environment. Signals about assets, identities, relationships, risks, and activities are correlated into a security graph, a live map of how those elements connect that agents can reason over efficiently. When the Threat Intelligence Agent finishes its work, the Recon Agent doesn't rebuild the environment picture from scratch to run attack path analysis. It reads the same security context. Building the correlations once, in one shared graph, is what lets each agent pick up where the previous one left off without a queue in between. Without that shared graph, agents would waste time and compute reconstructing context every time they run. Accuracy would drop, and cross-agent handoffs would never close in near-real-time.

**The harness** is the orchestration layer that sits on top of that shared context. It sequences models and agents through security workflows, decides which agent runs next based on what the previous one produced, and coordinates the handoffs.

The other four layers each play a specific role in that flow. The table summarizes them from top to bottom.

| Layer | What it does |
| --- | --- |
| **Actuators** | Translate agent decisions into real changes in the environment such as configuration adjustments, detection rules, code fixes, and firewall changes. |
| **Agents** | Red, Blue, and Green team agents that handle defined security operations tasks, which the harness dispatches. |
| **Models** | Provide the intelligence and reasoning the harness sequences. Project Perception uses a **multi-model architecture**, so different security tasks can run on different models rather than a single model doing everything. Matching the model to the task means better accuracy and lower compute cost per task. |
| **Signals and sensors** | Provide visibility across endpoints, identities, applications, data, clouds, AI systems, and code repositories. Without broad, current signals, the security context has nothing to correlate. |

Together, all six layers make coordinated multi-agent defense possible.

## Where this leaves you

The Cyber Stack is the architecture Project Perception runs on. Its six layers combine to enable cross-agent coordination at machine speed. None of them is a user-configurable surface. You don't configure security context or the harness in the portal, and you don't build signals or actuators there either. When the playbook walkthrough in the next unit shows one agent handing findings to another, that handoff runs through security context, and the sequencing across the agents is the harness at work.
