Microsoft Security Copilot uses workspaces to organize capacity, access, and data residency settings for a team or use case. In this module, Contoso previously provisioned three workspaces to support different security functions. The SOC workspace handles threat detection, the compliance workspace meets EU data residency requirements, and the sandbox workspace gives the architecture team room to experiment. The Security Architect's next task is to govern how plugins are added across those workspaces and to deploy the first agents that automate security workflows.

You're the Cloud and AI Security Engineer responsible for configuring plugin governance settings organization-wide and deploying both Microsoft-built and partner-built agents. Some agents require procurement through the Security Store before setup can begin, and one partner agent accesses Defender data—a scenario that requires Global Administrator approval before the Security Architect can complete setup. Once deployed, those agents need ongoing management: controlling when they run, providing feedback to improve their outputs, and maintaining the memory that shapes their behavior.

In this module, you learn how to configure owner-level plugin settings to control who can add and publish custom plugins. Then you explore how to restrict preinstalled plugin access and understand its effect on embedded experiences. Finally, learn to discover, acquire, set up, and manage both Microsoft-built and Security Store partner agents.

## Learning objectives

By the end of this module, you're able to:

- Configure plugin settings to govern who can add and manage custom plugins at user and organization scope
- Restrict preinstalled plugin access to manage availability across embedded and standalone experiences
- Discover and set up Microsoft-built agents using the Security Copilot agent library
- Acquire and configure partner-built agents using Security Store, including the Global Administrator approval workflow
- Manage agents by controlling run state, editing configuration, and maintaining agent memory

## Prerequisites

- Completion of [Configure workspaces for Microsoft Security Copilot](/training/modules/configure-security-copilot-workspaces/) is recommended
- Familiarity with Microsoft Security Copilot Owner and Contributor roles
- Basic knowledge of Microsoft Entra roles
