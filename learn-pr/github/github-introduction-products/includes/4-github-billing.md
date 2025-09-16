Now let's review billing and payments for your GitHub account.

GitHub bills accounts based on type—personal, organization, or enterprise. Personal accounts and most organizations receive separate bills, while enterprise accounts can consolidate billing across multiple organizations or route charges to different cost centers based on internal configuration.

Each bill reflects a combination of subscriptions and usage-based charges:

* **Subscriptions** include your account’s plan (such as GitHub Pro or GitHub Team) and fixed monthly costs for products like GitHub Copilot or Marketplace apps.
* **Usage-based billing** applies to products where cost scales with use—such as GitHub Actions (based on runtime minutes and artifact storage) or GitHub Packages.

  > [!NOTE]
  > Most plans include a set number of free usage minutes or storage. For example, GitHub Pro includes 3,000 free GitHub Actions minutes per month. You can manage overages by setting spending limits.

Understanding GitHub’s billing model helps you plan budgets, track usage, and manage costs across accounts. This section clarifies how seat licenses, GitHub Actions, GitHub Packages, and the billing platform work together.

## Pricing for GitHub Actions

GitHub Actions enable automation of workflows directly within repositories. Its pricing model varies based on repository visibility and account type:

* **Public repositories** – GitHub Actions usage is **free** for public repositories, providing unlimited minutes on GitHub-hosted runners.
* **Private repositories** – Each account receives a certain number of free minutes and storage for GitHub-hosted runners, depending on the account's plan. For example, GitHub Free for personal accounts includes 2,000 CI/CD minutes per month. Usage beyond the included amounts is managed by spending limits.

It's important to monitor usage to avoid unexpected costs, especially for private repositories with high activity.

## Pricing and support options for organizations

GitHub offers various plans tailored to organizational needs, each with distinct features and support options:

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

For more information about available features and pricing tiers, see GitHub’s [pricing page](https://github.com/pricing).

Organizations should evaluate their collaboration needs and security priorities to choose the plan that best fits their goals.

## Usage-based billing for licenses (metered billing)

With the enhanced billing platform, GitHub introduced a usage-based billing model for licenses:

* **Monthly billing** – Organizations are billed monthly for the exact number of GitHub Enterprise and GitHub Advanced Security licenses used.
* **Pro rata charges** – If a user starts consuming a license partway through the month, the organization is charged a pro rata amount for that user's usage.
* **Dynamic adjustments** – If a user stops consuming a license during the month, the billing for the following month reflects this change, ensuring organizations only pay for active users.

This model eliminates the need to purchase a predefined number of licenses in advance, offering flexibility, and cost efficiency.

## Billing platform’s new capabilities

GitHub's enhanced billing platform provides improved tools for financial management:

* **Granular spending controls** – Administrators can set specific spending limits for services like GitHub Actions and GitHub Packages, preventing unexpected overages.
* **Detailed usage insights** – The platform offers in-depth visibility into product usage, allowing organizations to monitor consumption patterns and optimize resource allocation.
* **Automated reporting** – Features for automating usage reporting streamline financial oversight and facilitate internal chargebacks.

## Additional considerations

* **GitHub Codespaces** – Using GitHub Codespaces incurs extra charges based on storage and compute time, depending on your plan.
* **Billing alerts** – Admins can receive alerts when approaching spending limits through the GitHub UI and by email notifications.

These capabilities enhance an organization's ability to manage expenses effectively and align GitHub usage with budgetary constraints.

---

**Changes made:**

* Changed **"will clarify"** → **"clarifies"** for present tense.
* Rewrote passive **"Usage beyond the included amounts is controlled"** → **"Usage beyond the included amounts is managed"**.
* Simplified **"Additional collaboration tools"** → **"More collaboration tools"**.
* Defined **SAML** acronym at first mention.
* Changed **"has introduced"** → **"introduced"** to avoid present perfect.
* Simplified **"Usage of GitHub Codespaces incurs additional charges"** → **"Using GitHub Codespaces incurs extra charges"**.
* Added Oxford comma to **"offering flexibility, and cost efficiency"**.
* Corrected singular/plural verb usage (**"GitHub Actions enable"** instead of **"enables"**).
* Replaced **"amount"** with **"number"** where referring to countable items.
* Corrected grammar for parallelism in list items.
