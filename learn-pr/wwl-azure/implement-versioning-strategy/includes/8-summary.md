This module explained **versioning strategies** for packaging, best practices for versioning, and **package promotion** workflows. You learned essential concepts for managing package versions throughout the software development lifecycle.

## What you learned

You learned how to describe the benefits and usage of:

### Implementing a versioning strategy

- **Version importance:** Recognize why proper versioning is critical for dependency management and software stability.
- **Immutable packages:** Understand that published packages cannot be changed; only new versions can be released.
- **Version types:** Understand major, minor, and patch version increments and when to use each.
- **Package-specific versioning:** Implement versioning for different package types (NuGet, npm, Maven, Python, Universal Packages).

### Understanding semantic versioning

- **SemVer 2.0 format:** Apply Major.Minor.Patch versioning for consistent communication.
- **Breaking changes:** Use major versions to signal incompatible API changes.
- **New features:** Use minor versions for backward-compatible additions.
- **Bug fixes:** Use patch versions for backward-compatible fixes.
- **Prerelease labels:** Use labels (alpha, beta, rc) to indicate prerelease quality.
- **Version precedence:** Understand how versions are compared and ordered.

### Using Azure Artifacts views

- **Three default views:** Leverage @Local, @Prerelease, and @Release views.
- **@Local view:** Contains all packages including those from upstream sources.
- **@Prerelease view:** Filters to packages with prerelease labels.
- **@Release view:** Shows only production-ready packages.
- **View-specific URIs:** Configure package consumers to use specific views.
- **Custom views:** Create additional views for finer-grained quality levels.

### Promoting packages

- **Quality gates:** Use promotion to move packages through quality levels.
- **Promotion workflow:** Implement @Local → @Prerelease → @Release progression.
- **Automated promotion:** Use Azure Pipelines tasks to automate promotion based on test results.
- **Manual promotion:** Apply manual approval gates for critical packages.
- **Retention protection:** Understand that promoted packages are protected from deletion.
- **Upstream packages:** Manage promotion of cached upstream packages.

### Pushing packages from pipelines

- **Automated publishing:** Configure build pipelines to automatically publish packages to feeds.
- **Version generation:** Implement automated version number generation in CI/CD.
- **Package metadata:** Include comprehensive metadata in packages.
- **Source tagging:** Tag source code with package versions for traceability.

### Applying best practices

- **Documented strategy:** Maintain written versioning strategy documentation.
- **SemVer adoption:** Standardize on Semantic Versioning 2.0.
- **Single feed per repo:** Configure each repository to reference only one feed.
- **Automated publishing:** Publish packages automatically on creation.
- **Test before promote:** Always test packages before promoting to higher views.
- **Team alignment:** Integrate versioning into Definition of Done.

## Key concepts summary

### Version immutability

- **Never change published versions:** Published packages are immutable.
- **Always create new versions:** Any change requires a new version number.
- **Trust and reliability:** Consumers trust that versions don't change.

### Semantic versioning principles

- **Major.Minor.Patch:** Three-part version number.
- **Clear communication:** Version number indicates scope of changes.
- **Backward compatibility:** Minor and patch maintain compatibility.
- **Prerelease labels:** Indicate quality level with labels.

### Azure Artifacts views

- **Quality indicators:** Views separate packages by quality level.
- **Promotion workflow:** Explicit promotion moves packages through views.
- **Consumer choice:** Consumers select view based on risk tolerance.
- **Retention protection:** Promoted packages protected from deletion.

### Automation benefits

- **Consistency:** Automated processes reduce human error.
- **Speed:** Faster release cycles with automation.
- **Quality gates:** Automated testing before promotion.
- **Traceability:** Every build produces trackable artifact.

## Next steps

### Continue learning

**Enhance your versioning skills:**

- **Advanced promotion workflows:** Implement multi-stage promotion with approval gates.
- **Version range management:** Understand dependency version ranges and constraints.
- **Branching strategies:** Align versioning with branching strategies (GitFlow, trunk-based).
- **Hotfix versioning:** Handle hotfixes and backports correctly.

**Explore advanced scenarios:**

- **Monorepo versioning:** Version packages in monorepo repositories.
- **Breaking change management:** Strategies for deprecating and removing features.
- **Version pinning:** Control when consumers adopt new versions.
- **Changelog automation:** Generate changelogs automatically from commits.

### Practical application

**Start implementing:**

1.  **Document your strategy:** Write versioning guidelines for your team.
2.  **Adopt SemVer 2.0:** Standardize on Semantic Versioning.
3.  **Configure feeds and views:** Set up @Local, @Prerelease, and @Release views.
4.  **Automate versioning:** Implement automated version generation in build pipelines.
5.  **Set up promotion workflows:** Define and automate package promotion.
6.  **Train your team:** Ensure everyone understands and follows versioning strategy.

### Integration with DevOps practices

**Versioning in DevOps workflows:**

- **Continuous Integration:** Automate package building and publishing.
- **Continuous Delivery:** Use promotion workflows for controlled releases.
- **Infrastructure as Code:** Version infrastructure packages alongside application packages.
- **Feature flags:** Combine versioning with feature flags for gradual rollouts.

## Learn more

### Official documentation

- [Key concepts for Azure Artifacts](/azure/devops/artifacts/artifacts-key-concepts#immutability) - Comprehensive guide to Azure Artifacts concepts including package immutability.
- [Publish and download universal packages - Azure Artifacts \| Microsoft Learn](/azure/devops/artifacts/quickstarts/universal-packages) - Quick start guide for Universal Packages in Azure Artifacts.
- [Get started with NuGet packages - Azure Artifacts \| Microsoft Learn](/azure/devops/artifacts/get-started-nuget) - Complete guide to NuGet package management in Azure Artifacts.

### Additional resources

- [Semantic Versioning 2.0.0](https://semver.org/) - Official Semantic Versioning specification.
- [Azure Artifacts views](/azure/devops/artifacts/concepts/views) - Detailed explanation of feed views and promotion.
- [Best practices for using Azure Artifacts](/azure/devops/artifacts/concepts/best-practices) - Comprehensive best practices for Azure Artifacts.
- [Package versioning in Azure Pipelines](/azure/devops/pipelines/artifacts/nuget#package-versioning) - Guide to versioning packages in CI/CD pipelines.
- [Feed views for package promotion](/azure/devops/artifacts/feeds/views) - How to communicate package quality with views.

### Package type-specific guides

- [NuGet package versioning](/nuget/concepts/package-versioning) - NuGet-specific versioning guidelines.
- [npm semantic versioning](https://docs.npmjs.com/about-semantic-versioning) - npm and Semantic Versioning.
- [Maven versioning](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html#project-version) - Maven project versioning.
- [Python packaging version specifiers](https://packaging.python.org/en/latest/specifications/version-specifiers/) - PEP 440 version specifiers.

### Tools and automation

- [GitVersion](https://gitversion.net/) - Automated versioning from Git history.
- [semantic-release](https://semantic-release.gitbook.io/) - Fully automated version management and package publishing.
- [Azure DevOps CLI](https://docs.microsoft.com/en-us/cli/azure/artifacts) - Command-line tools for Azure Artifacts automation.

### Community and support

- **Azure DevOps Documentation:** Explore comprehensive guides and tutorials.
- **Microsoft Q&A:** Ask questions and get answers from the community.
- **Azure DevOps Blog:** Stay updated with latest features and best practices.
- **GitHub samples:** Explore example pipelines and configurations.
