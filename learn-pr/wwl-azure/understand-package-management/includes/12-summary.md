This module described **package management** fundamentals including package feeds, common public package sources, and practical guidance for creating and publishing packages using **Azure Artifacts**.

## What you accomplished

You learned how to:

- **Understand packages:** Recognize different package types (NuGet, npm, Maven, PyPI, Docker) and their characteristics.
- **Implement package management:** Set up package feeds and configure package sources for your projects.
- **Manage package feeds:** Create and configure feeds with appropriate visibility, upstream sources, and access control.
- **Explore package feed managers:** Use CLI tools (NuGet, npm, Maven, pip) and integrated development tools.
- **Work with public sources:** Consume packages from common public sources like NuGet.org, npmjs.com, Maven Central.
- **Compare hosting options:** Understand differences between self-hosted solutions (Nexus, Artifactory) and SaaS offerings (Azure Artifacts, MyGet).
- **Consume packages:** Configure package sources, install packages, and manage dependencies in projects.
- **Use Azure Artifacts:** Create feeds, configure upstream sources, manage permissions, and use feed views.
- **Publish packages:** Create, version, and publish packages to Azure Artifacts and other feeds.
- **Automate workflows:** Integrate package management with CI/CD pipelines.

## Key concepts

**Packages:**

- **Formalized distribution:** Packages provide a standardized way to distribute software components.
- **Metadata:** Include version, author, dependencies, and other information.
- **Types:** NuGet (.NET), npm (JavaScript), Maven (Java), PyPI (Python), Docker (containers).

**Package feeds:**

- **Centralized storage:** Store packages in feeds for easy access and distribution.
- **Versioning:** Support multiple versions of the same package.
- **Visibility:** Public feeds (open access) vs. private feeds (authentication required).

**Azure Artifacts:**

- **Multi-format support:** NuGet, npm, Maven, Python, Universal Packages in one platform.
- **Upstream sources:** Include public sources as upstream to private feeds.
- **Feed views:** Promote packages through views (@Local, @Prerelease, @Release).
- **Integration:** Seamless integration with Azure Pipelines and Azure DevOps.

**Best practices:**

- **Semantic versioning:** Use SemVer for clear version communication.
- **Upstream sources:** Use private feeds with public upstream sources for caching and control.
- **Access control:** Implement appropriate permissions for feed access.
- **Automation:** Automate package publishing and consumption in CI/CD pipelines.

## Next steps

Now that you understand package management, you can:

- **Create your first feed:** Set up an Azure Artifacts feed for your team.
- **Publish packages:** Package your internal libraries and publish them to your feed.
- **Configure CI/CD:** Integrate package management into your build and release pipelines.
- **Establish governance:** Define package management policies and standards for your organization.
- **Explore advanced features:** Investigate retention policies, package badges, and security scanning.

## Learn more

### Azure Artifacts documentation

- [Azure Artifacts overview - Azure Artifacts | Microsoft Learn](/azure/devops/artifacts/start-using-azure-artifacts) - Get started with Azure Artifacts.
- [What are feeds? - Azure Artifacts | Microsoft Learn](/azure/devops/artifacts/concepts/feeds) - Understand feed concepts and capabilities.
- [Upstream sources - Azure Artifacts | Microsoft Learn](/azure/devops/artifacts/concepts/upstream-sources) - Learn about upstream source configuration.
- [Use feed views to share your packages - Azure Artifacts | Microsoft Learn](/azure/devops/artifacts/feeds/views) - Manage package promotion with views.

### Package-specific guides

- [Get started with NuGet packages - Azure Artifacts | Microsoft Learn](/azure/devops/artifacts/get-started-nuget) - NuGet package management.
- [Get started with npm packages - Azure Artifacts | Microsoft Learn](/azure/devops/artifacts/get-started-npm) - npm package management.
- [Get started with Maven packages - Azure Artifacts | Microsoft Learn](/azure/devops/artifacts/get-started-maven) - Maven package management.
- [Get started with Python packages - Azure Artifacts | Microsoft Learn](/azure/devops/artifacts/quickstarts/python-packages) - Python package management.

### Package managers

- [NuGet documentation | Microsoft Learn](/nuget/) - Official NuGet documentation.
- [npm Docs (npmjs.com)](https://docs.npmjs.com/) - Official npm documentation.
- [Maven – Welcome to Apache Maven](https://maven.apache.org/) - Official Maven documentation.

### Best practices

- [Package versioning in Azure Artifacts](/azure/devops/artifacts/concepts/package-versioning) - Versioning strategies.
- [Best practices for Azure Artifacts](/azure/devops/artifacts/concepts/best-practices) - Recommended practices.
