Running multiple security agents as one system means solving several architectural problems at once: how the agents share what they know, who decides which one runs next, and how humans stay in control when work happens at machine speed.

Project Perception is a new agentic security system designed for the realities of AI. Project Perception brings together signals, context, models, and specialized agents into a continuously learning system of defense. It can reason, prioritize, and act at machine speed while keeping humans firmly in control and empowering them with powerful new workflows.

## The Cyber Stack

What has to be in place for one agent to build on another agent's work? The Cyber Stack is Project Perception's answer.

:::image type="content" source="../media/cyber-stack.png" alt-text="Diagram of the Cyber Stack showing six layers stacked from bottom to top: Signals and sensors, Context, Models, Harness, Agents, Actuators. A 'Human always in the loop' tag spans all layers." lightbox="../media/cyber-stack.png":::

The layers, listed here from top to bottom:

- **Actuators**: Without this layer, agents produce findings but nothing changes in the environment. Actuators translate decisions into protection, connecting agent insights to actions across Microsoft Security so teams continuously reduce risk faster than simply identify it.
- **Agents**: This is the layer where the closed loop actually runs. Specialized Red team, Blue team, and Green team agents apply intelligence across security workflows, continuously discovering, evaluating, and improving security posture. You'll see the specific agent names in the next unit.
- **Harness**: This is the orchestration layer that runs coordinated playbooks, deciding which agent runs next and passing findings between them without a person handling every handoff. The harness sequences models and agents into a continuous, closed-loop system of defense.
- **Models**: No single model has to do everything. A multi-model architecture combines frontier and specialized cyber models, applying the right model to the right task to optimize for both quality and cost.
- **Context**: One agent needs to act on what a previous agent found, without rebuilding its understanding of the environment from scratch. Context provides that shared representation: a continuously updated, near-real-time view of an organization's assets, identities, relationships, risks, and activities, in a form agents can efficiently reason over.
- **Signals and sensors**: Context has nothing to correlate without broad, current signals. This layer provides awareness across the digital estate: visibility across identities, endpoints, applications, data, clouds, and AI systems.

None of the Cyber Stack layers is something an administrator configures in the Defender portal. They're the architecture Project Perception runs on.

## Red, Blue, and Green team agents

Project Perception's agents belong to three [teams](/security/agentic-security/agentic-security-agent-categories?azure-portal=true). Each team is responsible for a different mode of security work.

- **Red team agents** identify weaknesses.
- **Blue team agents** investigate and assess risk.
- **Green team agents** remediate and harden security posture.

The three teams form a closed loop. Red team findings feed Blue team investigation. Blue team findings feed Green team remediation. Green team output changes what Red team agents find on the next cycle. That's the loop the harness and shared context (two of the Cyber Stack layers you just read about) are there to run.

The next unit names the specific agents shipping in the preview and shows what each one does.

## Coordinated playbooks

A _coordinated playbook_ orchestrates the sequence of agents and capabilities needed to close a specific security objective. Trigger one from Agentic security, and Project Perception runs each agent in turn, passing output between them without manual handoffs. Without the playbook, a person has to pick which agent runs next and pass output between them, which is the same manual bottleneck coordinated defense is meant to remove.

Currently, Project Perception ships several named playbooks in the preview, each coordinating a different combination of agents and capabilities. [Playbooks are set by Microsoft](/security/agentic-security/agentic-security-concepts?azure-portal=true#playbook) and only run when every agent the playbook requires is enabled.

## Humans stay in control

The speed that makes Perception useful is the same speed at which a wrong action lands. Approval gates are where people still own decisions with real consequences. They pause a playbook before high-impact actions. Agents run under a configured identity with permissions scoped to the work they perform. During setup, administrators can create a dedicated Microsoft Entra Agent ID or connect an existing user account. Agents can only access data and take actions allowed by their configured identity and permissions. Where an approval gate is set, the agent pauses until a person approves, rejects, or redirects the action. Agent activity is recorded in immutable session records that provide an audit trail of agentic work.

That's the architecture. The next unit walks through the specific capabilities that are possible in Project Perception today.
