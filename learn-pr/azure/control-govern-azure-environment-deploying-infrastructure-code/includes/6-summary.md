Defining your infrastructure as code provides you with the most benefit when you deploy *all* of your infrastructure from code and use pipelines to automate the deployment process.

In this module, you learned how to plan your environments so that you can strategically target your controls where they have the most impact. Then, because deployment pipelines and code are so important, you learned how to apply controls to your pipelines and repositories. Finally, you learned how to configure your Azure environment to ensure that all changes are deployed by using your approved process, while still allowing for emergency access.

The purpose of this module is to increase your confidence in, and the security of, your Azure deployments. This module has helped you ensure that changes follow a consistent process, are audited and logged, and that only authorized users can perform them.

## More resources

- Learn more about the [considerations for platform automation](/azure/cloud-adoption-framework/ready/considerations/automation).
- To learn more about governance of your deployment processes, reference:
  - [End-to-end governance in Azure when using CI/CD](/azure/architecture/example-scenario/governance/end-to-end-governance-in-azure)
  - [DevOps considerations](/azure/cloud-adoption-framework/ready/considerations/devops-principles-and-practices) in the Cloud Adoption Framework for Azure.
- Learn more about [Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/).
- For guidance on using Bicep to deploy Azure resources, reference:
  - [Create Azure RBAC resources by using Bicep](/azure/azure-resource-manager/bicep/scenarios-rbac)
  - [Manage secrets by using Bicep](/azure/azure-resource-manager/bicep/scenarios-secrets)
  - [Create virtual network resources by using Bicep](/azure/azure-resource-manager/bicep/scenarios-virtual-networks)

### Secure your repositories and pipelines

To learn more about securing and hardening your Azure DevOps and GitHub environments, review these resources:

- Manage users, groups, and permissions:
  - [Conditional Access](/azure/active-directory/conditional-access/overview)
  - [Multifactor authentication](/azure/active-directory/authentication/concept-mfa-howitworks)
  - [Azure AD SSO integration with a GitHub Enterprise Cloud organization](/azure/active-directory/saas-apps/github-tutorial)
- Protect important code branches:
  - [Azure Repos branch policies](/azure/devops/repos/git/branch-policies)
  - [Protected branches in GitHub](https://docs.github.com/repositories/configuring-branches-and-merges-in-your-repository/defining-the-mergeability-of-pull-requests/about-protected-branches)
- Protect your pipeline's service principals:
  - [Managed identities](/azure/active-directory/managed-identities-azure-resources/overview)
  - [Workload identity federation](/azure/active-directory/develop/workload-identity-federation)
  - [Workload identity federation for GitHub Actions workflows](/azure/developer/github/connect-from-azure#use-the-azure-login-action-with-openid-connect)
  - [Azure DevOps security](/azure/devops/organizations/security/quick-reference-index-security)
- [Use audit logs in Azure DevOps](/azure/devops/organizations/audit/azure-devops-auditing)
- [Secure Azure Pipelines](/azure/devops/pipelines/security/overview)
- [Use third-party actions](https://docs.github.com/actions/security-guides/security-hardening-for-github-actions#using-third-party-actions)
- Use GitHub security features:
  - [Security hardening for GitHub Actions](https://docs.github.com//actions/security-guides/security-hardening-for-github-actions)
  - [Dependabot](https://docs.github.com/code-security/dependabot/dependabot-version-updates/about-dependabot-version-updates)
  - [Secret scanning](https://docs.github.com/code-security/secret-scanning/about-secret-scanning)
  - [GitHub security overview](https://docs.github.com/code-security/security-overview/about-the-security-overview)

### Secure your Azure environment

Azure security and governance include many elements. The following links provide more information about the subjects introduced in this module:

- [Break-glass accounts in Azure AD](/azure/active-directory/roles/security-emergency-access)
- Azure AD Privileged Identity Management
  - [What is Privileged Identity Management and why use it?](https://medium.com/@olafwrieden/what-is-privileged-identity-management-and-why-use-it-7f383b3b797a) (blog)
  - [Privileged Identity Management documentation](/azure/active-directory/privileged-identity-management/pim-configure)
- [Microsoft Sentinel](/azure/sentinel/overview)
