
**Tactics** and **techniques** representing the **MITRE ATT&CK® Adversarial Tactics**, **Techniques**, **& Common Knowledge**) Cloud Matrix for Enterprises covering cloud-based techniques.

:::image type="content" source="../media/mitre-attack-cm-tactics-and-techniques-c63c6a25.png" alt-text="Screenshot showing the Mitre Attack Cloud Matrix.":::


**Source**: [https://attack.mitre.org/matrices/enterprise/cloud/](https://attack.mitre.org/matrices/enterprise/cloud/)

The **MITRE ATTACK Cloud Matrix** actively helps organizations to understand and respond to cloud-based cyberattacks. It offers a comprehensive list of **tactics** and **techniques** used by attackers to target cloud environments and provides guidance for detecting and responding to these attacks. By focusing on the unique security challenges of cloud computing, the Cloud Matrix provides a roadmap for improving an organization's defenses against cloud-based threats.

**Definitions:**

**Initial Access**: The adversary is trying to get into your network. Initial Access consists of techniques that use various entry vectors to gain their initial foothold within a network. Techniques used to gain a foothold include **targeted spear phishing** and **exploiting weaknesses** on **public-facing web servers**. Footholds gained through initial access may allow for continued access, like valid accounts and use of external remote services, or maybe limited use due to changing passwords.

**Execution**: The adversary is trying to run malicious code. Execution consists of techniques that result in adversary-controlled code running on a local or remote system. Techniques that run malicious code are paired with techniques from all other tactics to achieve broader goals, like exploring a network or stealing data. **For example**, an adversary might use a remote access tool to run a PowerShell script that does Remote System Discovery.

**Persistence**: The adversary is trying to maintain their foothold. Persistence consists of techniques that adversaries use to keep access to systems across restarts, changed credentials, and other interruptions that could cut off their access. Persistent techniques include any access, action, or configuration changes that let them maintain their foothold on systems, such as replacing or hijacking legitimate code or adding startup code.

**Privilege Escalation**: The adversary is trying to gain higher-level permissions. Privilege escalation consists of techniques that adversaries use to gain higher-level permissions on a system or network. Adversaries can often enter and explore a network with unprivileged access but require elevated permissions to follow through on their objectives. Common approaches are to take advantage of system weaknesses, misconfigurations, and vulnerabilities.

**Examples** of elevated access include:

 -  SYSTEM/root level
 -  local administrator
 -  user account with admin-like access
 -  user accounts with access to a specific system or perform a specific function

These techniques often overlap with Persistence techniques, as Operating System (OS) features that let an adversary persist can execute in an elevated context.

**Defense Evasion**: The adversary is trying to avoid detection. Defense Evasion consists of techniques that adversaries use to avoid detection throughout their compromise. Techniques used for defense evasion include **uninstalling/disabling security software** or **obfuscating/encrypting data** and **scripts**. Adversaries also apply and abuse trusted processes to hide and masquerade their malware. Other tactics’ techniques are cross-listed when those techniques include the added benefit of subverting defenses.

**Credential Access**: The adversary is trying to steal account names and passwords. Credential Access consists of techniques for **stealing credentials** like **account names** and **passwords**. Techniques used to get credentials include keylogging or credential dumping. Using legitimate credentials can give adversaries access to systems, make them harder to detect, and provide the opportunity to create more accounts to help achieve their goals.

**Discovery**: The adversary is trying to figure out your environment. Discovery consists of techniques an adversary may use to learn about the system and internal network. These techniques help adversaries observe the environment and orient themselves before deciding how to act. They also allow adversaries to explore what they can control and what’s around their entry point in order to discover how it could benefit their current objective. Native operating system tools are used toward this post-compromise information-gathering objective.

**Lateral Movement**: The adversary is trying to move through your environment. Lateral Movement consists of techniques that adversaries use to **enter and control remote systems on a network**. Following through on their primary objective often requires exploring the network to find their target and later gaining access to it. Reaching their objective often involves pivoting through multiple systems and accounts to gain. Adversaries might install their own remote access tools to accomplish Lateral Movement or use legitimate credentials with native network and operating system tools, which may be stealthier.

**Collection**: The adversary is trying to gather data of interest to their goal. The collection consists of techniques adversaries may use to gather information and the sources information is collected from that's relevant to following through on the adversary's objectives. Frequently, the next goal after collecting data is to steal (**exfiltrate**) the data. Common target sources include various drive types, browsers, audio, video, and email. Common collection methods include capturing screenshots and keyboard input.

**Command-and-Control**: The adversary is trying to communicate with compromised systems to control them. Command and Control consist of techniques that adversaries may use to communicate with systems under their control within a victim network. Adversaries commonly attempt to mimic normal, expected traffic to avoid detection. There are many ways an adversary can establish command and control with various levels of stealth depending on the victim’s network structure and defenses.

**Exfiltration**: The adversary is trying to steal data. Exfiltration consists of techniques that adversaries may use to steal data from your network. Once they’ve collected data, adversaries often package it to avoid detection while removing it. This includes compression and encryption. Techniques for getting data out of a target network typically include transferring it over their command-and-control channel or an alternate channel and may also include putting size limits on the transmission.

**Impact**: The adversary tries to manipulate, interrupt, or destroy your systems and data. Impact consists of techniques that adversaries use to disrupt availability or compromise integrity by manipulating business and operational processes. Techniques used for impact can include destroying or tampering with data. In some cases, business processes can look fine but have been altered to benefit the adversaries’ goals. These techniques are used by adversaries to follow through on their end goal or to provide cover for a confidentiality breach.
