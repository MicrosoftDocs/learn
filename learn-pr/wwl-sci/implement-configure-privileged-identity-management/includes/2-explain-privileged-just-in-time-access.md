A team creates a Global Administrator account at the start of a migration project. The project completes, the team moves on, and the account remains — permanently assigned the most powerful role in the tenant. No one is using it. The attacker who finds it doesn't need to wait.

## Standing privilege creates persistent attack surface

**Standing privilege** is a privileged role assignment that's permanently active regardless of whether the role is being used. Cloud environments create standing privilege by default when administrators receive role assignments directly — no expiration, no requirement to justify use. Because the role is always active, the credentials that control it are always a target.

The attacker's opportunity window equals the lifetime of the assignment. An account that stands for 18 months gives an attacker 18 months to break in — through phishing, credential stuffing, or token theft. You don't have to be actively using the account for the risk to remain real.

:::image type="content" source="../media/standing-privilege-timeline.png" alt-text="Diagram showing a standing privileged account active for 18 months and an attacker dwell window spanning the same period.":::

## Blast radius and the cost of overprivileged access

When standing privilege exists, the question isn't just whether credentials can be compromised — it's what an attacker can do with them. **Blast radius** is the scope of systems, data, and operations an attacker can reach when they exploit a compromised identity. For a standing Global Administrator in Microsoft Entra ID, that scope includes user accounts, group memberships, application registrations, federated trust settings, and every Azure subscription linked to the directory. Global Administrator is the most visible example, but roles like Privileged Role Administrator, Security Administrator, and User Access Administrator carry their own significant blast radius — and every one of them becomes a permanent target when left as a standing assignment.

The blast radius extends further when you factor in the **control plane** — the management layer through which cloud resources are created, configured, and deleted. A standing Owner on an Azure subscription gives an attacker control over every resource in it: virtual machines, storage accounts, key vaults, and network configurations.

> [!IMPORTANT]
> AI agents, model endpoints, and automation pipelines operate under permissions granted by the identity that configured them. A compromised standing Global Administrator account can redirect AI agent behavior, exfiltrate data the agent processes, or use the agent to escalate access to other systems. Standing privilege in the AI and cloud control plane is a force multiplier for any attacker.

## Just-in-time access as the response to standing privilege

**Just-in-time (JIT) access** provides elevated permissions that you don't hold persistently. You activate them for a specific task, and they expire after a defined period. JIT access reduces the risk that standing privilege creates through three properties.

**You don't hold access by default.** Without a standing role assignment, there are no persistent credentials for an attacker to discover or steal between sessions.

**You activate access intentionally.** You must take a deliberate action to elevate your permissions, every use of privilege becomes an explicit, auditable event rather than an ambient condition.

**Access expires automatically.** Even if a session is compromised, the attacker's window closes when it ends — not when you happen to notice a problem.

Microsoft Entra Privileged Identity Management (PIM) is the service that implements just-in-time access for both Microsoft Entra ID roles and Azure resource roles.
