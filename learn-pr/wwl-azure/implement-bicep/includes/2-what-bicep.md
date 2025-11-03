**Azure Bicep** is the next revision of **ARM templates** designed to solve some of the issues developers were facing when deploying their resources to **Azure**. It's an open-source tool and a domain-specific language (DSL) that provides a means to declaratively define infrastructure, describing the topology of cloud resources such as VMs, web apps, and networking interfaces. **Bicep** encourages code reuse and modularity in designing infrastructure as code files.

## Benefits of Bicep

### Simpler syntax

The new syntax allows you to write less code compared to **ARM templates**. **Bicep** is more straightforward and concise, making it easier to read and maintain.

### Automatic dependency management

**Bicep** automatically manages the dependency between resources. You don't need to explicitly define dependencies—**Bicep** infers them from resource references.

### Bicep CLI

**Azure Bicep** comes with its command line interface (**Bicep CLI**), which can be used independently or with **Azure CLI**. **Bicep CLI** allows you to **transpile** the **Bicep** files into **ARM templates** and deploy them. It can also be used to convert an existing **ARM template** to **Bicep**.

> [!NOTE]
> When converting **ARM templates** to **Bicep**, there might be issues since some features may not be fully supported.

### Visual Studio Code integration

There's excellent integration with **Visual Studio Code** that creates an enhanced authoring experience. **Azure Bicep** supports **types** that are used to validate templates at development time rather than runtime. The extension also supports **linting**, which can be used to unify the development experience between team members or across different teams.

**Key features of the VS Code extension:**

- **IntelliSense:** Auto-completion for resource types and properties.
- **Validation:** Real-time syntax and type validation.
- **Snippets:** Pre-built templates for common resources.
- **Visualization:** Graphical representation of resource dependencies.

For more information about **Azure Bicep**, see [Bicep language for deploying Azure resources](/azure/azure-resource-manager/bicep/overview).

## Next steps

In the next unit, you'll learn various ways to install **Bicep** and set up your development environment.
