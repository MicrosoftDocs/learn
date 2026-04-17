In this unit, you learn how to track and manage GitHub Enterprise license usage across organizations, enterprise accounts, and server instances.
You also learn how to use the admin console, APIs, and best practices to optimize license allocation and cost.

As a **GitHub Enterprise administrator**, tracking **license usage** is crucial for managing costs, optimizing resources, and staying compliant.
GitHub provides several ways to track seat usage across organizations, enterprise accounts, and GitHub Enterprise Server instances.

> [!NOTE]
> For prepaid (subscription-based) plans, you see a set number of available licenses. For Pay-As-You-Go (PAYG) plans—the default for new Enterprise customers—there’s no concept of “available licenses.” Billing is based on actual usage (active seats), and you’re charged each month according to that usage.

## Method 1: Find license usage for a specific organization

**Using the GitHub Enterprise Cloud (GHEC) Admin Console**

1. Navigate to **GitHub Enterprise Cloud Admin Panel**.
2. Go to **Settings > Billing & plans**.
3. Locate the **License usage** section.
4. Review details such as:

   * Total seats assigned
   * Active seats in use
   * Pending invitations
   * Available licenses (only shown for prepaid accounts)

**Command-line alternative (GraphQL API)**

```json
{
  organization(login: "org-name") {
    billingInfo {
      totalSeats
      seatsUsed
      seatsAvailable
    }
  }
}
```

## Method 2: Find license usage across multiple organizations

**Using the Enterprise Account Billing Page**

1. Navigate to **GitHub Enterprise Cloud > Enterprise settings**.
2. Go to **Billing > License Usage**.
3. Review license usage for each organization under the enterprise account.

**GraphQL API query for all organizations**

```json
{
  enterprise(slug: "enterprise-name") {
    organizations(first: 50) {
      nodes {
        name
        billingInfo {
          totalSeats
          seatsUsed
          seatsAvailable
        }
      }
    }
  }
}
```

## Method 3: Find license usage for enterprise accounts

**Using the GitHub Enterprise Server (GHES) dashboard**

1. Log in to the **GitHub Enterprise Server Admin Console**.
2. Go to **Settings > License Usage**.
3. Review:

   * Total allocated licenses
   * Active users
   * Available seats
   * Historical license usage trends

**REST API alternative**

```bash
curl -H "Authorization: token YOUR-TOKEN" \
"https://api.github.com/enterprises/YOUR-ENTERPRISE/license"
```

## Method 4: Find license usage across multiple GitHub instances

**Using the GitHub Enterprise Metrics API**

1. Access **GitHub Enterprise Server** admin settings.
2. Use the Metrics API:

```bash
curl -H "Authorization: token YOUR-TOKEN" \
"https://api.github.com/enterprise/settings/licenses"
```

3. Review:

   * Total enterprise-wide licenses
   * Usage per GitHub instance
   * Available capacity per region

## Best practices for license usage management

* **Automate monitoring** – Use GraphQL or REST API queries to track usage trends.
* **Reclaim unused seats** – Identify inactive users and free up unused licenses.
* **Enable usage-based billing** – Align billing with actual consumption.
* **Audit regularly** – Conduct monthly or quarterly reviews to control costs.
