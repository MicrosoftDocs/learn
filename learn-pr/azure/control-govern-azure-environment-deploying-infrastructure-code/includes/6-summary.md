Defining your infrastructure as code provides you with the most benefit when you deploy all of your infrastructure from code, and use pipelines to run your deployments. In this module, you learned how to enforce the deployment of Azure infrastructure as code, and how to apply controls and governance to secure your environment in the process.

You learned how to plan your environments so that you can strategically target your controls where they’ll have the highest impact. Then, because deployment pipelines are so important, you learned how to apply controls to your pipelines and repositories. Finally, you learned how to restrict your Azure environment to ensure that all changes are deployed by using your approved process, with the exception of emergency situations.

Now, you’re able to increase your confidence in, and the security of, your Azure deployments by ensuring that changes follow a consistent process, are audited and logged, and can only be performed by authorized users.

## More resources

- Secure your pipelines
  - Manage users, groups. and permissions
    - [Conditional Access](/azure/active-directory/conditional-access/overview)
    - [Multi-factor authentication](/azure/active-directory/authentication/concept-mfa-howitworks)
    - [Azure AD SSO integration with a GitHub Enterprise Cloud Organization](/azure/active-directory/saas-apps/github-tutorial)
  - Protect important code branches
    - [Azure Repos branch policies](/azure/devops/repos/git/branch-policies)
    - [Protected branches in GitHub](https://docs.github.com/repositories/configuring-branches-and-merges-in-your-repository/defining-the-mergeability-of-pull-requests/about-protected-branches)
  - Protect your pipeline's service principals
    - [Managed identities](/azure/active-directory/managed-identities-azure-resources/overview)
    - [Workload identity federation](/azure/active-directory/develop/workload-identity-federation)
    - [Azure DevOps security](/azure/devops/organizations/security/quick-reference-index-security)
  - Use GitHub security features
    - [Security hardening for GitHub Actions](https://docs.github.com//actions/security-guides/security-hardening-for-github-actions)
    - [Dependsabot](https://docs.github.com/code-security/dependabot/dependabot-version-updates/about-dependabot-version-updates)
    - [Secret scanning](https://docs.github.com/code-security/secret-scanning/about-secret-scanning)
    - [GitHub security overview](https://docs.github.com/code-security/security-overview/about-the-security-overview)
- Secure your Azure environment
  - [Break-glass accounts in Azure AD](/azure/active-directory/roles/security-emergency-access)
  - [Azure AD Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure)
- Bicep scenario-based documentation
  - [Create Azure RBAC resources by using Bicep](/azure/azure-resource-manager/bicep/scenarios-rbac)
  - [Manage secrets by using Bicep](/azure/azure-resource-manager/bicep/scenarios-secrets)
  - [Create virtual network resources by using Bicep](/azure/azure-resource-manager/bicep/scenarios-virtual-networks)
- [End-to-end governance in Azure when using CI/CD](/azure/architecture/example-scenario/governance/end-to-end-governance-in-azure)
