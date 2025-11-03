This module explored **dependency management** concepts and helped you identify project dependencies. You learned how to decompose your system, identify dependencies, and understand componentization approaches.

## What you accomplished

In this module, you learned:

- **Define dependency management strategy:** Understand the elements of an effective dependency management strategy, including standardization, package formats, versioning, and security considerations.
- **Identify dependencies:** Recognize different types of dependencies (external, internal, development) and systematically identify components in your codebase that should be managed as dependencies.
- **Describe elements and componentization of dependency management:** Understand the difference between source componentization and package componentization, and when to use each approach.
- **Scan your codebase for dependencies:** Apply strategies like detecting duplicate code, analyzing coupling and cohesion, identifying independent lifecycles, and using automated tools to find potential components.

## Key concepts

**Dependency management benefits:**

- **Consistency:** Standardized versions across projects reduce conflicts.
- **Efficiency:** Centralized components eliminate code duplication.
- **Governance:** Control over what dependencies are used and their versions.
- **Security:** Systematic approach to vulnerability scanning and updates.

**Componentization approaches:**

- **Source componentization:** Organizing code into logical modules within a repository.
- **Package componentization:** Distributing components as versioned packages through feeds.

**System decomposition:**

- Breaking down monolithic codebases into manageable components.
- Applying design patterns like dependency injection and abstraction.
- Balancing the benefits of componentization with the complexity of managing dependencies.

## Next steps

Now that you understand dependency management concepts, you can:

- **Define your strategy:** Establish standardized package formats and versioning schemes for your organization.
- **Audit your codebase:** Apply the scanning strategies to identify components in your current projects.
- **Start componentizing:** Begin extracting high-value components into packages.
- **Implement tooling:** Set up package feeds using **Azure Artifacts** or other package management solutions.

## Learn more

### Package management platforms

- [Azure Artifacts overview - Azure Artifacts \| Microsoft Learn](/azure/devops/artifacts/start-using-azure-artifacts)
- [Collaborate more and build faster with packages](/azure/devops/artifacts/collaborate-with-packages)

### Package management technologies

- [NuGet documentation \| Microsoft Learn](/nuget/) - Package manager for .NET.
- [npm Docs (npmjs.com)](https://docs.npmjs.com/) - Package manager for JavaScript and Node.js.
- [Maven – Welcome to Apache Maven](https://maven.apache.org/) - Build automation and dependency management for Java.

### Dependency management best practices

- [Dependency management best practices](/azure/devops/artifacts/concepts/best-practices)
- [Package versioning in Azure Artifacts](/azure/devops/artifacts/concepts/package-versioning)
