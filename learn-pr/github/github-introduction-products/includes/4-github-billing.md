Now let's review billing and payments for your GitHub account.

GitHub bills accounts based on type—personal, organization, or enterprise. Personal accounts and most organizations receive separate bills, while enterprise accounts can consolidate billing across multiple organizations or route charges to different cost centers based on internal configuration.

Each bill can reflect a combination of **subscription-based license charges** and **usage-based charges**:

* **Subscription and license charges** apply to products and services assigned to an account, such as GitHub Pro, GitHub Team, or GitHub Copilot seats.
* **Usage-based billing** applies to products where costs can scale with consumption, such as GitHub Actions, GitHub Packages, and supported GitHub Copilot features.

Understanding the difference between assigned licenses, product usage, and adoption metrics helps you plan budgets, track costs, and interpret GitHub's administrative dashboards accurately.

## GitHub Copilot billing

GitHub Copilot uses a combination of **license-based billing** and **usage-based billing**.

Organizations and enterprises are billed for the GitHub Copilot licenses assigned to users. More Copilot seats can be added during a billing cycle and are prorated for the period in which they're assigned. Removing a seat generally affects billing in the following billing cycle.

An assigned Copilot license shouldn't be treated as equivalent to an active user. A user can have a billable Copilot license assigned even if they haven't recently used Copilot.

For current licensing details, including how seats are assigned and billed, see the [GitHub Copilot licenses documentation](https://docs.github.com/en/enterprise-cloud@latest/billing/concepts/product-billing/github-copilot-licenses).

### Usage-based billing for GitHub Copilot

GitHub Copilot Business and GitHub Copilot Enterprise also support usage-based billing for certain AI-powered features. This usage is measured in **AI credits**.

Each assigned Copilot license contributes included AI credits to a shared pool associated with the billing entity. Supported AI-powered features consume credits from this pool as they're used. Examples include:

* Copilot Chat
* Copilot CLI
* Copilot cloud agent
* Copilot Spaces
* Copilot Spark
* Supported third-party coding agents

Code completions and next edit suggestions remain unlimited on paid Copilot plans and don't consume AI credits.

If usage exceeds the included AI-credit pool, extra charges may apply depending on the organization's or enterprise's billing policies and configured budgets. Administrators can use spending controls to manage Copilot usage at the user, organization, cost-center, and enterprise levels.

AI-credit allowances, supported features, and pricing can change over time. For the current rules and pricing, see the [GitHub Copilot billing documentation](https://docs.github.com/en/enterprise-cloud@latest/billing/concepts/product-billing/github-copilot-billing) and [usage-based billing documentation](https://docs.github.com/en/enterprise-cloud@latest/copilot/concepts/billing/usage-based-billing-for-organizations-and-enterprises).

> [!NOTE]
> Copilot license charges and AI-credit charges are billing information. They shouldn't be confused with Copilot adoption or engagement metrics shown in Copilot usage and impact dashboards.

## Pricing for GitHub Actions

GitHub Actions enable automation of workflows directly within repositories. Its pricing model varies based on repository visibility and account type:

* **Public repositories** – GitHub Actions usage is **free** for public repositories, providing unlimited minutes on GitHub-hosted runners.
* **Private repositories** – Each account receives some free minutes and storage for GitHub-hosted runners, depending on the account's plan. For example, GitHub Free for personal accounts includes 2,000 CI/CD minutes per month. Spending limits manage usage beyond the included amounts.

It's important to monitor usage to avoid unexpected costs, especially for private repositories with high activity.

## Pricing and support options for organizations

GitHub offers various plans tailored to organizational needs, each with distinct features:

* **GitHub Free for Organizations**
  **Features**:

  * Unlimited public/private repositories
  * Community support
  * 2,000 CI/CD minutes per month
* **GitHub Team**
  **Features**:

  * Everything in Free, plus:

    * More collaboration tools
    * Code owners
    * Required reviews
    * Enforced branch protections
    * Email support
* **GitHub Enterprise**
  **Features**:

  * Everything in Team, plus:

    * SAML (Security Assertion Markup Language) single sign-on
    * Advanced auditing
    * GitHub Connect
    * 24/7 support
    * Enterprise-level security features

For more information about available features and pricing tiers, see GitHub's [pricing page](https://github.com/pricing).

Organizations should evaluate their collaboration needs and security priorities to choose the plan that best fits their goals.

## Billing platform's capabilities

GitHub's billing platform provides tools for financial management across products and services:

* **Granular spending controls** – Administrators can set spending limits for supported usage-based services, helping prevent unexpected overages.
* **Detailed billing and usage insights** – Billing views provide visibility into assigned seats, license costs, AI-credit consumption, and spending.
* **Automated reporting** – Usage and billing information can support financial oversight and internal chargebacks.

When reviewing Copilot information, it's important to distinguish these billing views from the dashboards designed to measure adoption and engagement.

## Copilot usage and impact dashboards

GitHub provides separate dashboards for understanding how users adopt and engage with Copilot. These dashboards aren't billing reports.

The **Copilot usage metrics dashboard** reports adoption and engagement telemetry, helping administrators understand how Copilot is being used across an organization or enterprise. The metrics shown there shouldn't be interpreted as license or billing data. For more information, see [Viewing the Copilot usage metrics dashboard](https://docs.github.com/en/enterprise-cloud@latest/copilot/how-tos/administer-copilot/view-usage-and-adoption).

The **Copilot impact dashboard** provides another view of adoption by grouping users into adoption cohorts, including a passive segment. These cohorts are based on user activity over a rolling 28-day window. A user can therefore appear as passive or not recently active while still having a billable Copilot license assigned. For more information, see [Viewing the Copilot impact dashboard](https://docs.github.com/en/enterprise-cloud@latest/copilot/how-tos/administer-copilot/view-impact-dashboard).

In other words:

* **Billing and licensing views** show assigned seats, license costs, AI-credit consumption, and spending.
* **Copilot usage metrics** show adoption and engagement telemetry.
* **Copilot impact** groups users into adoption cohorts based on recent activity.
* **An assigned license does not mean the user is actively using Copilot.**

Keeping these views separate prevents adoption metrics from being mistaken for billing data and helps administrators make better decisions about both Copilot usage and licensing costs.

## More considerations

* **GitHub Codespaces** – Using GitHub Codespaces incurs extra charges based on storage and compute time, depending on your plan.
* **Billing alerts** – Admins can receive alerts when approaching configured spending limits through the GitHub UI and email notifications.
* **Copilot pricing and allowances** – Copilot pricing, included AI-credit allowances, and supported metered features can change. Always refer to the current [GitHub Copilot billing documentation](https://docs.github.com/en/enterprise-cloud@latest/billing/concepts/product-billing/github-copilot-billing) for authoritative information.

These capabilities help organizations manage GitHub expenses while keeping **licensing, actual product usage, and adoption metrics** distinct.
