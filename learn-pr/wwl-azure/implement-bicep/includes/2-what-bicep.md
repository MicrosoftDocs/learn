**Azure Bicep** is the next revision of **ARM templates** designed to solve some of the issues developers were facing when deploying their resources to Azure. It's an Open Source tool and, in fact, a domain-specific language (DSL) that provides a means to declaratively codify infrastructure, which describes the topology of cloud resources such as VMs, Web Apps, and networking interfaces. It also encourages code reuse and modularity in designing the infrastructure as code files.

The new syntax allows you to write less code compared to ARM templates, which are more straightforward and concise and automatically manage the dependency between resources. Azure Bicep comes with its command line interface (CLI), which can be used independently or with Azure CLI. **Bicep CLI** allows you to *transpile* the Bicep files into ARM templates and deploy them and can be used to convert an existing ARM template to Bicep.

> [!NOTE]
> Beware that when converting ARM templates to Bicep, there might be issues since it's still a work in progress.

There's also an excellent integration with Visual Studio Code that creates a superb authoring experience. Azure Bicep supports *types* that are used to validate templates at development time rather than runtime. The extension also supports linting, which can be used to unify the development experience between team members or across different teams.

For more information about Azure Bicep, see [Bicep language for deploying Azure resources](/azure/azure-resource-manager/bicep/overview).

## Next steps

In the next unit, you'll find out various ways to install Bicep and set up your development environment.
