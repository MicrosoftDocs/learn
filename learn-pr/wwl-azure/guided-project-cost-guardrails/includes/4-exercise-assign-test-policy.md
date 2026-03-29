This guided project consists of the following exercises:

 - Apply cost-tracking tags
 - Create budget and alerts
 - **Assign and test Azure Policy**

In this exercise, you assign an Azure Policy that restricts resource creation to a specific region, test that it blocks a noncompliant deployment, and review the compliance dashboard. This demonstrates how policy enforcement prevents mistakes before they happen.

This exercise includes the following tasks:

 - Find and assign the policy
 - Validate policy enforcement
 - Review policy compliance

**Outcome:** A policy control is assigned and validated by a simple compliance test.

## Task 1: Find and assign the policy

Use Azure Policy to enforce organizational standards. Policies can deny noncompliant resource creation automatically, preventing costly mistakes before they happen.

1.  In the portal search bar, search for **Policy** and select **Policy**.
2.  In the left menu, select **Definitions**.
3.  In the search box, search for **Allowed locations**.
4.  Select the **Allowed locations** policy definition.
5.  Select **Assign**.
6.  For **Scope**, select your resource group **rg-gp-cost-guardrails**.
7.  On the **Parameters** tab, select one region as the allowed location (for example, your home region).
8.  Select **Review + create** and then select **Create**.

> [!NOTE]
> **Validation step:** Confirm the **Allowed locations** policy is assigned to **rg-gp-cost-guardrails**.

## Task 2: Validate policy enforcement

Test that the policy prevents resource creation in disallowed regions. This validation confirms that your governance control is working correctly and would protect against noncompliant deployments.

1.  In the portal search bar, search for **Storage accounts** and select **Storage accounts**.
2.  Select **+ Create**.
3.  On the **Basics** tab, select **rg-gp-cost-guardrails** as the resource group.
4.  For **Storage account name**, enter a temporary name (for example, **stgppolicytest** followed by your initials).
5.  For **Region**, select a region that is **not** the allowed location you configured in the policy.
6.  Select **Review + create**.
7.  Confirm the creation is denied with a policy error message. Note the error—it references the **Allowed locations** policy by name.
8.  Select **Previous** to return to the **Basics** tab.
9.  Change the **Region** to the allowed location.
10. Select **Review + create** again.
11. Confirm the validation passes.
12. Select **Create**.

> [!NOTE]
> **Validation step:** Confirm the policy denied creation in the disallowed region and allowed it in the permitted region.

## Task 3: Review policy compliance

Check the policy compliance dashboard to see how Azure tracks compliance across your resources. This is where administrators monitor whether organizational standards are being followed.

1.  In the portal search bar, search for **Policy** and select **Policy**.
2.  In the left menu, select **Compliance**.
3.  Find the **Allowed locations** policy assignment in the compliance list.
4.  Select it to view the compliance details, including the number of compliant and noncompliant resources.
5.  Note the compliance state—resources created in the allowed region should show as compliant.

> [!NOTE]
> **Validation step:** Confirm the Compliance dashboard shows the policy enforcement status with compliant resources in the allowed region.

> [!NOTE]
