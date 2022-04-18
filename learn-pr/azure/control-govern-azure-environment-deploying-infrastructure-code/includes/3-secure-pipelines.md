TODO

## Why are your pipelines important?

When you use IaC, your pipelines are very powerful and should be the only way that changes make their way into your Azure environment. Ensure that you put adequate governance and controls around your pipelines.TODO

## Manage users, groups, and permissions

Ensure that you have good practices around how your pipeline users are maintained, groups of users, and their permissions. Plan out your onboarding/offboarding processes. Use Azure AD protections like conditional access, MFA, etc.

## Handle secrets

Protect your service connections/secrets to ensure that their credentials can't be used inappropriately. Scope permissions to the minimal set required - both scope and role. Use managed identities/workload identities where you can, to avoid credentials entirely. Rotate secrets regularly. Consider having a *secret custodian* - somebody whose role is to handle and manage secrets, keys, and certificates, to avoid exposing them to other parts of the organization.

(When it's GA) Use conditional access for service principals - e.g. to look for risky sign-ins and behaviours.

Use separate SPs for each environment.

## Assess third-party components

If you use community-provided GitHub Actions or Azure DevOps extensions, ensure you understand their provenance and consider the security risk.

::: zone pivot="azuredevops"

## Use Azure DevOps security features

::: zone-end

TODO

::: zone pivot="github"

## Use GitHub security features

For example, use Dependsabot, secret scanning, auditing, etc. Use GitHub's Security Overview

::: zone-end

## Protect important code branches

Ensure you have a clear plan for how you protect important branches, like *main*. Use controls like automated checks and enforced code reviews. Ensure that you don't allow changes to your protected branches unless they follow your processes.

## Test and review your code

Make sure your team is across your expectations for reviewing and testing all code, including IaC.
