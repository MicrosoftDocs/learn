Now that your organization is using Bicep so frequently, it needed to find a way to automate the publishing of reusable Bicep code. You had prepared some Bicep files to deploy security-hardened complete solutions and individual components for your colleagues to reuse.

This module described approaches to automate the publishing of template specs and Bicep modules to registries. You learned about:

- The differences between publishing reusable code and deploying regular Bicep files.
- How to repurpose aspects of deployment workflows for publishing reusable code.
- How to consider designing your deployment workflows.
- How to add versioning to your reusable Bicep code from within your workflows.

By automating the publishing of your reusable Bicep code, you can ensure that the benefits of automation apply throughout your set of Bicep code. You can also easily modify your reusable Bicep code. Those abilities can increase your confidence that the code is valid and that your organization is following its processes.

## More information

- [Semantic versioning](https://semver.org)
- Secure your workflow's identity
  - [Principle of least privilege](/entra/identity/role-based-access-control/best-practices#1-apply-principle-of-least-privilege)
  - [Azure Container Registry roles and permissions](/azure/container-registry/container-registry-roles)
- [Bicep private registries for modules](/azure/azure-resource-manager/bicep/private-module-registry)
  - [Aliases](/azure/azure-resource-manager/bicep/bicep-config-modules#aliases-for-modules)
- [Template specs](/azure/azure-resource-manager/templates/template-specs)
