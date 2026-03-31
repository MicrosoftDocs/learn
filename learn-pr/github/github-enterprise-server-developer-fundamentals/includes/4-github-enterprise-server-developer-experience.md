From a user interface perspective, GHES looks familiar. However, the developer experience differs in meaningful ways, particularly around automation, integrations, and tooling.

### In this unit, you'll learn

- How GitHub Actions works on GHES

- What tooling developers must self-manage

- Which cloud-native features are unavailable

- How to adapt workflows to constrained environments

### GitHub actions on GHES

- GitHub Actions is supported, but workflows must use self-hosted runners.

- Your organization is responsible for provisioning, scaling, patching, and maintaining these runners.

- If runners are offline or outdated, workflows will fail-no automatic fall-back.

- Network restrictions are common; proxies or mirrors may be needed for external access.

- GHES primarily relies on self-hosted runners. GitHub-hosted runners available in GitHub Enterprise Cloud are generally not available, although some hybrid scenarios may be supported through GitHub Connect depending on enterprise configuration.

### Packages, security, and automation

- GitHub Packages (npm, Docker, etc.) are available and hosted internally in GHES.

- Advanced Security features (for example, code scanning, secret scanning) are supported with proper licensing.

- These features often require manual setup-such as installing scanning engines or enabling secret detection-though from a developer perspective, the enablement process is no different than on GitHub Enterprise Cloud (GHEC).

- Many capabilities are disabled by default and depend on coordination with your DevOps or platform teams.

### Unsupported or limited features

- GitHub Codespaces isn't supported as of GHES 3.19.

- GitHub Copilot isn't supported on GHES. Copilot can be used as a standalone feature within supported IDEs, but Copilot features aren't available on the GHES web interface, and functionality may be further limited in environments with restricted internet access.

- Accessing the library of public GitHub Actions directly from GitHub.com requires GitHub Connect. Without it, Actions must be manually synced to your local instance.

- While webhooks and SaaS tools don't use GitHub Connect, they require outbound network routing (Proxy/Firewall) to reach external endpoints.

- Feature availability varies-developers should confirm what's enabled before relying on cloud workflows.

Developers should verify availability before relying on cloud-first workflows.

Key takeaway: The GHES developer experience is shaped by self-managed infrastructure-automation, integrations, and even "available features" can depend on what is deployed, licensed, and enabled in your environment.

Now that you've seen how GHES can differ in everyday development workflows, you're ready for the next step.

The next unit introduces GitHub Connect and hybrid scenarios that extend GHES with selected GitHub.com capabilities.