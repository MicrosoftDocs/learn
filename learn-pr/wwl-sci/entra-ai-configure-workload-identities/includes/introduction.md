AI workload identities are often set up quickly and left running in production without validation. A client secret gets created because it's the fastest option. Broad permissions get assigned because they work. No one is listed as the identity's owner.

Consider a workload that calls AI models, reads secrets from Key Vault, and accesses user profiles through Microsoft Graph. If that identity is compromised, the attacker inherits every excess permission the workload was granted.

These consequences are amplified because a single AI workload identity often spans multiple services: an Azure OpenAI endpoint, a Key Vault, a storage account, and Microsoft Graph. One misconfigured identity means excess access across every service in that chain, and the workload runs without the interactive sign-in controls that apply to human users. Choosing the right credential model, scoping permissions to the workload's actual task, and validating the configuration before production determine whether a workload identity is a manageable security surface or an unmonitored exposure.

## Learning objectives

In this module, you'll:

- Explain what makes identity setup decisions hard to fix after a workload reaches production.
- Configure the right credential type for an AI workload based on its hosting environment.
- Assign least-privilege permissions across Azure RBAC, Microsoft Graph, and app roles.
- Select the correct roles for Key Vault, Azure AI services, storage, and downstream APIs.
- Validate the identity configuration and plan credential maintenance before production.
