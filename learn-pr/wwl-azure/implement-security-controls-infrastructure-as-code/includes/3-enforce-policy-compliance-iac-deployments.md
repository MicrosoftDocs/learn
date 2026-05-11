Pipeline scanning protects the CI/CD path, but not every deployment goes through the pipeline. In this unit, you learn how to use **Azure Policy** with the **Deny effect** to enforce compliance at the platform layer—blocking noncompliant deployments before they reach production, regardless of where they originate. You also learn how to manage policy definitions as code using the **Enterprise Policy as Code (EPAC)** framework.

| Layer | Enforcement Point | Coverage |
|-------|------------------|----------|
| Microsoft Security DevOps (MSDO) scanning | CI/CD pipeline | Templates committed through PR workflow |
| Azure Policy Deny | Azure Resource Manager API | All deployment paths (CLI, portal, API, pipeline) |

## Why pipeline scanning alone isn't enough

Contoso's DevOps team is well-governed. But what about a developer with ARM template access who deploys manually from the CLI? Or an emergency change pushed directly to ARM template without a PR? Or an external tool that directly calls the Azure Resource Manager API?

MSDO scanning protects the pipeline path. Azure Policy with the **Deny effect** protects EVERY deployment path—it operates at the Azure Resource Manager layer and intercepts all write operations before they're committed to resource state. Together, MSDO and Azure Policy form two independent defense layers that address different threat surfaces. One catches violations during code review. The other catches violations at the moment of deployment, no matter where the deployment originates.

## Azure Policy Deny effect—the platform backstop

Azure Policy with the **Deny effect** blocks noncompliant resource creation or modification at the Resource Manager level. The deployment fails immediately with an error message identifying the violated policy. The key distinction from Module 1 is that Module 1 covered policy enforcement for runtime resources already deployed. In contrast, you learn here how to author and promote policy definitions for IaC governance—a pattern often called **policy-as-code**.

The Deny effect applies BEFORE the resource is created—even before any ARM template reaches the deployment engine. For example, imagine a Bicep template deploys a storage account without `supportsHttpsTrafficOnly: true` set. If a policy with Deny effect exists for this property, the entire deployment fails. The developer sees an error message with the policy name, definition ID, and the noncompliant property. The storage account is never created.

> [!TIP]
> To minimize friction, test new policies in Audit mode in a development environment before promoting to Deny in production. Audit mode logs violations without blocking—giving you compliance visibility without breaking pipelines.

Predeployment prevention shifts enforcement from post-deployment remediation. Instead of detecting a problem after it's in production and scheduling a fix, you prevent the problem from ever reaching production.

## Policy-as-code workflow—from definition to enforcement

**Policy-as-code** means managing Azure Policy definitions, initiatives, and assignments as source-controlled code rather than as portal-only configurations. The workflow mirrors the same CI/CD practices used for infrastructure templates.

Here's the typical workflow:

1. **Author** - write the policy definition JSON (or Bicep equivalent) in source control alongside the IaC templates it governs
2. **Test in audit mode** - assign the policy in a dev or test environment with `effect: Audit` - observe compliance reports without blocking deployments
3. **Validate** - confirm the policy catches the intended violations and doesn't produce false positives
4. **Promote to Deny** - update the assignment parameter to `effect: Deny` for production environments (subscriptions or management groups)
5. **Monitor** - use Azure Policy compliance reports to track ongoing compliance

The benefits of policy-as-code are significant. Policy definitions are version-controlled alongside the infrastructure they govern, so you have a clear audit trail. Change history is visible in Git—you know who changed what policy and when. Policy assignments are repeatable and consistent across environments. And policy promotion from dev → test → prod mirrors the same CI/CD process used for infrastructure, creating consistency in governance workflows.

## Enterprise Policy as Code (EPAC)—managing at scale

For organizations with multiple management groups, subscriptions, and teams, manually maintaining hundreds of policy assignments becomes unsustainable. **Enterprise Policy as Code (EPAC)** is an open-source PowerShell module that manages Azure Policy at management group scale through a CI/CD pipeline.

EPAC provides several key capabilities. You define policy assignments in JSON files that map to management group scopes. EPAC then deploys, updates, and removes assignments consistently across environments using a single pipeline. It tracks desired state—EPAC detects and reports drift between the defined in code goal and the currently assigned in Azure configuration. It also supports GitHub Actions and Azure Pipelines natively, making it easy to integrate into existing workflows.

With EPAC, you centralize policy governance. A single pipeline deploys policy assignments to hundreds of subscriptions across multiple management groups, ensuring consistent compliance enforcement without manual portal work.

> [!NOTE]
> EPAC is maintained by the Azure community and Microsoft Teams. It's not a Defender for Cloud or Azure Policy feature itself—it's a governance layer on top of the Azure Policy API. Find it at [aka.ms/epac](https://aka.ms/epac).

## Secure Bicep authoring patterns—reducing findings at the source

When admins write Bicep templates, three patterns improve security posture before scanning even runs. These patterns reduce the number of findings MSDO and Checkov report because they eliminate the root cause of common misconfiguration patterns.

First, use the `@secure()` decorator on parameters that hold secrets or credentials. The decorator prevents values from being logged in deployment history, reducing the risk of credential exposure through deployment logs.

Second, reference Key Vault secrets using the `existing` keyword and `getSecret()` to avoid hardcoding sensitive values in parameter files. Secret references keep secrets centralized in Key Vault instead of scattered across parameter files in source control.

Third, assign managed identities to resources instead of service principal credentials. Managed identities eliminate the need to pass credentials through templates entirely, removing a common source of secret exposure in IaC templates.

PSRule for Azure documents the full set of authoring rules at [aka.ms/ps-rule-azure](https://aka.ms/ps-rule-azure). Following these patterns reduces compliance violations before they appear in scan results.

With MSDO scanning finding misconfigurations in templates before deployment, and Azure Policy blocking noncompliant deployments at the platform layer, Contoso now enforces security at every deployment path—not just through the pipeline. The knowledge check reviews how the two enforcement layers work together.
