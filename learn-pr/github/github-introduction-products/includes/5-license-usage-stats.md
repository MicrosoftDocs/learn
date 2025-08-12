In this unit, you learn how to track and manage GitHub Enterprise license usage across organizations, enterprise accounts, and server instances. You also learn how to use the admin console, APIs, and best practices to optimize license allocation and cost.

As a **GitHub Enterprise administrator**, tracking **license usage** is crucial for managing costs, optimizing resources, and staying compliant. GitHub provides several ways to track seat usage across organizations, enterprise accounts, and GitHub Enterprise Server instances.

> **Note:** For prepaid (subscription-based) plans, you see a set number of available licenses. For Pay-As-You-Go (PAYG) plans—the default for new Enterprise customers—there's no concept of "available licenses." Billing is based on actual usage (active seats), and you're charged accordingly each month.

## Finding license usage for a specific organization

To find **license usage statistics** for a single **GitHub organization**:

### Method 1: Using GitHub Enterprise Cloud (GHEC) Admin Console

1. Navigate to **GitHub Enterprise Cloud Admin Panel**.
2. Go to **Settings > Billing & plans**.
3. Locate the **License usage** section.
4. View details such as:

   * Total seats assigned
   * Active seats in use
   * Pending invitations
   * Available licenses (only shown for prepaid accounts)

#### Command-line alternative (GraphQL API)

For more granular data, admins can use the **GraphQL API**:

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

## Method 2: Finding license usage across multiple organizations

For organizations under the same **enterprise account**, admins can analyze usage across all organizations.

### Using the Enterprise Account Billing Page

1. Navigate to **GitHub Enterprise Cloud > Enterprise settings**.
2. Go to **Billing > License Usage**.
3. Review license usage for **each organization under the enterprise account**.

#### GraphQL API query for all organizations

To fetch usage data for all organizations in an enterprise:

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

## Method 3: Finding license usage for enterprise accounts

For enterprises using **GitHub Enterprise Cloud or GitHub Enterprise Server**, admins can track licenses at the **enterprise level**.

### GitHub Enterprise Server (GHES) dashboard

Next, you learn how to access and view license statistics on GitHub Enterprise Server.

1. Log in to the **GitHub Enterprise Server Admin Console**.
2. Go to **Settings > License Usage**.
3. View:

   * **Total allocated licenses**
   * **Active users**
   * **Available seats**
   * **Historical license usage trends**

#### REST API alternative

For programmatic access, use the REST API:

```bash
curl -H "Authorization: token YOUR-TOKEN" \
"https://api.github.com/enterprises/YOUR-ENTERPRISE/license"
```

## Method 4: Finding license usage across multiple GitHub instances

For **large enterprises** with multiple GitHub Enterprise Server instances, admins must track **license consumption** across deployments.

### GitHub Enterprise Metrics API

1. Access **GitHub Enterprise Server** admin settings.
2. Use the **Metrics API**:

```bash
curl -H "Authorization: token YOUR-TOKEN" \
"https://api.github.com/enterprise/settings/licenses"
```

3. Extract:

   * **Total enterprise-wide licenses**
   * **Usage per GitHub instance**
   * **Available capacity per region**

## Best practices for license usage management

The following strategies help manage licenses more efficiently across your organization:

* **Automate monitoring** – Use GraphQL or REST API queries to track usage trends.
* **Optimize unused seats** – Identify inactive users and reclaim unused licenses.
* **Enable usage-based billing** – Ensure billing reflects actual consumption.
* **Regular audits** – Conduct monthly or quarterly license reviews to optimize cost.

---

**Key fixes applied:**

* Changed future tense ("you'll learn") to present tense ("you learn").
* Broke up the very long first sentence into two for clarity.
* Replaced *pre-paid* → *prepaid* consistently.
* Standardized quotation marks to straight double quotes.
* Added contractions for a less formal tone ("there is" → "there's", "you are" → "you're").
* Fixed verb forms to be consistent and grammatically correct.
* Kept terminology consistent (Pay-As-You-Go spelled as preferred).
