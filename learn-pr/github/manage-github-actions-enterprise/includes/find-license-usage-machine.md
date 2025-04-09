# **Finding Statistics of License Usage for Machine Accounts and Peripheral Services**


Tracking **license usage** is essential for cost optimization and security compliance. **Machine accounts** (used for automation) and **peripheral services** (such as CI/CD, integrations, and API consumers) can consume licenses, impacting enterprise costs and resource management.

---

## **1. Understanding Machine Accounts and Peripheral Services**

### **Machine Accounts**

- Machine accounts are **GitHub accounts** used for automation, running scripts, or integrating with third-party tools.
- **Characteristics**:
    - They act **independently of human users**.
    - Often used by CI/CD tools (e.g., GitHub Actions, Jenkins, CircleCI).
    - **Each machine account consumes a GitHub license**, like a standard user.

### **Peripheral Services**

- Peripheral Services are external integrations that interact with GitHub via **API requests**.
- **Examples**:
    - **CI/CD Pipelines** (e.g., GitHub Actions, GitHub Runners, Jenkins).
    - **Security Scanning Tools** (e.g., Dependabot, Snyk, CodeQL).
    - **Third-party Integrations** (e.g., Slack, Jira, Datadog).
    - **Self-hosted GitHub Runners**.

**Why Track These?**

- To **identify unused or excessive licenses**.
- To **optimize costs** and prevent unnecessary spending.
- To **monitor security risks** from inactive or misconfigured automation accounts.

---

## **2. Finding License Usage Statistics for Machine Accounts**

### **Method 1: GitHub Enterprise Admin Console**

1. **Navigate to Enterprise Settings**.
2. Select **Billing & License Management**.
3. Look for a **Machine Accounts** section (if available).
4. Identify:
    - **Number of active machine accounts**.
    - **License consumption per machine account**.
    - **Last active date**.

### **Method 2: GraphQL API Query for Machine Accounts**

To retrieve **machine account usage statistics**, use the **GraphQL API**:

```json
{
  enterprise(slug: "enterprise-name") {
    organizations(first: 50) {
      nodes {
        name
        machineAccounts {
          totalCount
          nodes {
            login
            createdAt
            lastActiveAt
          }
        }
      }
    }
  }
}

```

**Why Track These?**

- To identify **inactive machine accounts**.
- To track **when each machine account was last active**.
- To help **reduce unnecessary license allocation**.

---

## **3. Finding License Usage for Peripheral Services**

### **Method 1: GitHub Actions & Runners Usage Metrics**

1. **Go to Enterprise Settings** → **Actions**.
2. View:
    - **Total GitHub-hosted runner minutes used**.
    - **Self-hosted runner usage**.
    - **Billing for extra runner minutes**.

### **Method 2: REST API for Self-Hosted Runners**

To track **self-hosted runners** and their license usage:

```bash
curl -H "Authorization: token YOUR-TOKEN" \
"https://api.github.com/enterprises/YOUR-ENTERPRISE/actions/runners"
```

**Key Insights**:

- Identifies **how many runners are consuming licenses**.
- Tracks **idle runners that may be wasting resources**.
- Helps **optimize billing for GitHub-hosted runner minutes**.

### **Method 3: Peripheral Services API Usage Tracking**

Monitor API-based integrations using:
```bash
curl -H "Authorization: token YOUR-TOKEN" \
"https://api.github.com/enterprises/YOUR-ENTERPRISE/audit-log"
```

**This helps you:**

Detect Inactive Services: Find services no longer in use.  
Audit Third-Party Tools: Ensure external tools are necessary and properly configured.  
Reduce Costs: Disable services that are not providing value."

---

## **4. Best Practices for Managing Machine Accounts & Peripheral Services Licenses**

- **Audit Machine Accounts Regularly**: Identify and deactivate **unused machine accounts**.  
	- Over time, organizations accumulate **unused or stale machine accounts** that may still have access to repositories and systems.
	- Unused accounts **increase security risks**, as they can be exploited if compromised.
	- Regular audits ensure that only **active and necessary** machine accounts exist, reducing exposure to unauthorized access.
- **Monitor API Usage**: Track third-party tools consuming enterprise licenses.  
	- Many third-party applications, CI/CD pipelines, and integrations consume GitHub **API resources and enterprise licenses**.
	- Excessive API calls can lead to **rate limits**, affecting developers' workflows.
	- Unauthorized or unknown API usage can expose sensitive data and security vulnerabilities.
- **Optimize Runner Usage**: Identify **idle self-hosted runners** and **reduce GitHub-hosted runner costs**.  
	- Self-hosted and GitHub-hosted **runners** execute CI/CD workflows. Inefficient use leads to **unnecessary costs**.
	- Idle self-hosted runners **waste computing resources** and may expose organizations to security risks if left unmonitored.
	- GitHub-hosted runners operate on a **pay-as-you-go** basis, and optimizing usage can **significantly reduce costs**.
- **Restrict Machine Accounts**: Limit their **permissions** and **enforce security policies**.
	- Machine accounts should **not have unnecessary access** to repositories, reducing the risk of privilege escalation.
	- If compromised, machine accounts **can be exploited to manipulate source code, deploy malicious changes, or expose secrets**.
	- Enforcing security policies helps ensure compliance and **minimizes potential breaches**.

---

## **5. Conclusion**

Tracking **license usage for machine accounts and peripheral services** is crucial for **cost optimization, security, and compliance** in GitHub Enterprise. Admins should leverage **GitHub UI, GraphQL, and REST APIs** to **identify inactive accounts, optimize usage, and prevent unnecessary spending**.
