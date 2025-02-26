Threat modeling is a great technique to help you find issues early in the development lifecycle. Choosing the right focused approach helps you tailor the threat-modeling exercise, allowing you to find more actionable threats and ways to solve them.

## System-focused approach

Your goal is to protect the entire system. Here, you look at each process, data store, data-flow, external entity, and trust boundary. With this information, you select security controls to help protect your system.

The framework helps you analyze the system and how it affects other assets, which include:

|Asset Type|Examples|
|----------|--------|
|Logical|Source code, APIs, and logical security controls|
|Physical|Servers and physical security-control assets|

## Attacker-focused approach

In the attacker-focused approach, you emphasize the attacker, their motive, means, and all the ways they can wreak havoc in your system. This approach looks at entry points, rather than the system as a whole.

This approach allows you to focus on critical assets holding highly confidential data for your system. Emphasis is placed on protecting those assets instead of the entire system.

## Asset-focused approach

Here, you evaluate risk for each asset. This approach identifies critical assets based on things like classified data handling, and focuses mostly on protecting those assets.

> [!NOTE]
> Microsoft engineers focus on protecting the system. Penetration testing teams focus on both protecting the system and understanding the attacker.
