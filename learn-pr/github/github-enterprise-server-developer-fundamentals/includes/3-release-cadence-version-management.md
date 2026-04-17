One of the most important concepts for GHES developers is version awareness. Unlike GitHub.com, which updates continuously, GHES follows a structured release model.

### In this unit, you'll learn

- How GHES releases are scheduled and delivered

- Why feature timing matters for developers

- How to find version-specific documentation

- How to avoid building workflows that depend on unavailable features

### GHES release model

GitHub Enterprise Server follows a quarterly release cadence (for example, versions 3.17, 3.18, and 3.19), rather than continuous delivery.

Each release typically includes:

- New features that have already proven stable on GitHub.com and are ready for self-hosted environments

- Security patches and performance improvements required for enterprise-grade reliability and compliance

- Deprecations and behavior changes that may affect APIs, workflows, or integrations

Because upgrades are customer-managed:

- Some organizations intentionally remain on older versions to meet validation, compliance, or change-control requirements

- Feature availability can vary significantly between enterprises, even when they all use GHES

### Version-specific documentation

GitHub Enterprise Server documentation is versioned, and developers must always reference the documentation that matches their deployed version.

For example, GHES 3.19 documentation is available at:

- https://docs.github.com/en/enterprise-server@3.19

GitHub.com documentation often describes features that do not yet exist in your GHES environment.

Using the wrong documentation can lead to:

- Incorrect assumptions about available features

- Broken workflows or unsupported configurations

- Confusion during troubleshooting or implementation

### Developer impact of version lag

Features commonly affected by GHES version differences include:

- GitHub Actions enhancements, such as new workflow syntax or job features

- Security scanning improvements, including updates to CodeQL or secret scanning behavior

- API changes and preview features, which may be unavailable or behave differently

- User interface and workflow refinements that improve usability on GitHub.com first

Practical guidance for developers:

- Always confirm your organization's current GHES version before designing workflows or automation

- Review the release notes for your version to understand what is supported and what is not

- Plan solutions that work within the constraints of your deployed environment, not the latest cloud features

Practical advice: Before designing workflows or automations, confirm your GHES version and check release notes.

Key takeaway: GHES version awareness is a core developer skill-features, APIs, and behavior depend on what your organization has deployed, not what is available on GitHub.com today.

Now that you understand how release cadence affects feature timing, the next unit looks at how these differences show up in day-to-day developer experience, including automation, integrations, and tooling constraints.