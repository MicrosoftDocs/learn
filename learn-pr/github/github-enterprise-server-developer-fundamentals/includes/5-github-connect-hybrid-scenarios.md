Many organizations choose GitHub Enterprise Server (GHES) to meet strict data control and compliance requirements. However, they still want to benefit from GitHub Enterprise Cloud features. GitHub Connect helps bridge that gap. It enables hybrid workflows that let teams securely combine the power of GHES with GitHub.com.

### In this unit, you'll learn

- What GitHub Connect enables between GHES and GitHub Enterprise Cloud

- Which features can be shared or synchronized across environments

- How hybrid workflows are commonly implemented

- What to expect as a developer when GitHub Connect is enabled

### What is GitHub Connect?

GitHub Connect creates a secure link between GitHub Enterprise Server and GitHub Enterprise Cloud. When enabled by administrators, it allows specific features and data to be shared across both environments.

GitHub Connect can provide:

- License synchronization

- Unified contribution graphs that show GHES activity on GitHub.com

- Access to selected GitHub-hosted Actions

- Security and dependency insights from GitHub's advisory database

> [!NOTE]
> Not all features are enabled by default. Administrators configure what is available based on organizational needs.

### Common hybrid scenarios

GitHub Connect supports a range of hybrid setups where developers work across self-hosted and cloud environments. Common use cases include:

- **Unified contribution history:** Developer activity from GHES and GitHub.com is combined into a single contribution graph. This provides a consistent view of an individual's work across both environments. 

- **Unified search across environments:** When searching on GHES, GitHub Connect can also return relevant results from GitHub.com. This creates a single discovery experience across private and public code, helping developers find reusable components, actions, and examples without switching between platforms.

### Developer considerations

If your organization uses GitHub Connect, you may notice:

- Your contributions on GHES appear in your GitHub.com profile

- Some CI/CD workflows rely on GitHub Actions content that is hosted on GitHub.com, but execution continues to run on self-hosted runners in the GHES environment rather than using GitHub-hosted runners.

To avoid confusion, always confirm which GitHub Connect features are enabled and how they're configured within your enterprise setup.

When troubleshooting, it also helps to confirm whether a workflow is running entirely on GHES or relying on a GitHub Connect-enabled capability that may have separate requirements.

Key takeaway: GitHub Connect can enable selected hybrid capabilities, but it is optional and policy-driven-developers should verify what is enabled to avoid assuming cloud features are always available.

With GHES fundamentals in place, you are ready to move into hands-on collaboration topics-such as repositories, branching, pull requests, and developer tooling-knowing how platform differences can influence your daily workflow.