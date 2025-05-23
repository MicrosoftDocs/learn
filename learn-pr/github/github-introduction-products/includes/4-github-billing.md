Now let's review billing and payments for your GitHub account.

GitHub bills accounts based on type—personal, organization, or enterprise. Personal accounts and most organizations receive separate bills, while enterprise accounts can consolidate billing across multiple organizations or route charges to different cost centers based on internal configuration.

Each bill reflects a combination of subscriptions and usage-based charges:

- **Subscriptions** include your account’s plan (such as GitHub Pro or GitHub Team) and fixed monthly costs for products like GitHub Copilot or Marketplace apps.
- **Usage-based billing** applies to products where cost scales with use—such as GitHub Actions (based on runtime minutes and artifact storage) or GitHub Packages.
  > [!NOTE]
  > Most plans include a set amount of usage for free. For example, GitHub Pro includes 3,000 free GitHub Actions minutes per month. You can manage overages by setting spending limits.

Understanding GitHub’s billing model helps you plan budgets, track usage, and manage costs across accounts. This section will clarify how seat licenses, GitHub Actions, GitHub Packages, and the billing platform work together.

## Pricing for GitHub Actions

GitHub Actions enables automation of workflows directly within repositories. Its pricing model varies based on repository visibility and account type:

- **Public Repositories**: Usage of GitHub Actions is **free** for public repositories, providing unlimited minutes on GitHub-hosted runners.
    
- **Private Repositories**: Each account receives a certain amount of free minutes and storage for GitHub-hosted runners, depending on the account's plan. For example, GitHub Free for personal accounts includes 2,000 CI/CD minutes per month. Usage beyond the included amounts is controlled by spending limits.
    
It's important to monitor usage to avoid unexpected costs, especially for private repositories with high activity.

## Pricing and Support Options for Organizations

GitHub offers various plans tailored to organizational needs, each with distinct features and support options:

- **GitHub Free for Organizations**:
    - **Features**:
        - Unlimited public/private repositories
        - Community support
        - 2,000 CI/CD minutes per month
- **GitHub Team**:
    - **Features**:
        - Everything in Free, plus:
        - Additional collaboration tools
        - Code owners
        - Required reviews
        - Enforced branch protections
        - Email support
- **GitHub Enterprise**:
    - **Features**:
        - Everything in Team, plus:
        - SAML single sign-on
        - Advanced auditing
        - GitHub Connect
        - 24/7 support
        - Enterprise-level security features
For more information about available features and pricing tiers, see GitHub’s [pricing page](https://github.com/pricing).

Organizations should evaluate their collaboration needs and security priorities to choose the plan that best fits their goals.

## Usage-Based Billing for Licenses (Metered Billing)

With the enhanced billing platform, GitHub has introduced a usage-based billing model for licenses:

- **Monthly Billing**: Organizations are billed monthly for the exact number of GitHub Enterprise and GitHub Advanced Security licenses used.
    
- **Pro Rata Charges**: If a user starts consuming a license partway through the month, the organization is charged a pro rata amount for that user's usage.
    
- **Dynamic Adjustments**: If a user stops consuming a license during the month, the billing for the following month reflects this change, ensuring organizations only pay for active users.
    

This model eliminates the need to purchase a predefined number of licenses in advance, offering flexibility and cost efficiency.

## Billing Platform’s New Capabilities

GitHub's enhanced billing platform provides improved tools for financial management:

- **Granular Spending Controls**: Administrators can set specific spending limits for services like GitHub Actions and GitHub Packages, preventing unexpected overages.
    
- **Detailed Usage Insights**: The platform offers in-depth visibility into product usage, allowing organizations to monitor consumption patterns and optimize resource allocation.
    
- **Automated Reporting**: Features for automating usage reporting streamline financial oversight and facilitate internal chargebacks.

## **Additional Considerations**

- **GitHub Codespaces**: Usage of GitHub Codespaces incurs additional charges based on storage and compute time, depending on your plan.
- **Billing Alerts**: Admins can receive alerts when approaching spending limits through the GitHub UI and email notifications.

=======
    
These capabilities enhance an organization's ability to manage expenses effectively and align GitHub usage with budgetary constraints.

