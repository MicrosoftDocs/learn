The MITRE ATT&CK matrix is a **publicly accessible knowledge base** for understanding the various **tactics** and **techniques** used by attackers during a cyberattack.

The knowledge base is organized into several categories: **pre-attack**, **initial access**, **execution**, **persistence**, **privilege escalation**, **defense evasion**, **credential access**, **discovery**, **lateral movement**, **collection**, **exfiltration**, and **command and control**.

**Tactics (T)** represent the "why" of an ATT&CK technique or sub-technique. It is the adversary's tactical goal: the reason for performing an action. **For example**, an adversary may want to achieve credential access.

**Techniques (T)** represent "how'" an adversary achieves a tactical goal by performing an action. **For example**, an adversary may dump credentials to achieve credential access.

**Common Knowledge (CK)** in ATT&CK stands for common knowledge, essentially the documented modus operandi of tactics and techniques executed by adversaries.

**Defender for Cloud** uses the MITRE Attack matrix to associate alerts with their perceived intent, helping formalize security domain knowledge.

**Example:** Pre-Attack<br>

| **MITRE Attack Tactic** | **Description**                                                                                                                                                                                                                                                                                                                           |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Pre-Attack              | Pre-Attack could be either an attempt to access a certain resource regardless of a malicious intent, or a failed attempt to gain access to a target system to gather information prior to exploitation. This step is detected as an attempt, originating from outside the network, to scan the target system and identify an entry point. |

:::image type="content" source="../media/mitre-attack-alert-sample-one-fae85e0d.png" alt-text="Screenshot showing Mitre Attack attempted logon alert example.":::


**Example:** Initial Access

| **MITRE Attack Tactic** | **Description**                                                                                                                                                                                                                                                              |
| ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Initial Access          | Initial Access is the stage where an attacker manages to get a foothold on the attacked resource. This stage is relevant for compute hosts and resources such as user accounts, certificates etc. Threat actors will often be able to control the resource after this stage. |

:::image type="content" source="../media/mitre-attack-sample-two-b448f890.png" alt-text="Screenshot showing Mitre Attack suspicious IP alert example.":::
