In this unit, you’ll learn how to set up preventive measures, document vulnerabilities, leverage GitHub’s security tools (including enterprise-grade and compliance features), scrub sensitive data when needed, manage policies, and audit activity.

Imagine you’re an admin onboarding new collaborators: you want them in the right repos, reporting issues clearly, and following consistent standards. Let’s set your security policies.

:::image type="content" source="../media/setting-security-policies.png" alt-text="Three screenshots stacked on each other, slightly offset, which show community health files in a repository and settings for an organization.":::

## Why security policies matter
Security policies maintain your GitHub ecosystem’s integrity by:
- **Guiding workflows:** Secure, standardized processes
- **Reporting clarity:** Clear steps for vulnerability disclosure
- **Access control:** Least-privilege permissions to limit risk

Apply policies at the repo, org, or enterprise level—enterprise-wide rules enforce uniformity, while org-level settings let you tailor per project.

## Documenting security
Clear docs are the first defense.

### SECURITY.md
The `SECURITY.md` file tells users which versions you support, how to report issues, and any legal disclaimers or known risks.

:::image type="content" source="../media/security.md-example.png" alt-text="Cropped screenshot of SECURITY.md from the git repository.":::

### Other community health files
GitHub recognizes key community files that improve project transparency:

| File | Purpose |
|------|---------|
| CODE_OF_CONDUCT.md | Community behavior standards. |
| CONTRIBUTING.md | Contribution guidelines. |
| DISCUSSION category forms | Custom templates for community discussions. |
| FUNDING.yml | Displays sponsor options. |
| GOVERNANCE.md | Explains decision-making structure. |
| Issue/PR templates + config.yml | Standardizes contributor input. |
| README.md | Introduces and explains your project. |
| SUPPORT.md | Provides help resources. |

## Security settings & enforcement
Choose trust vs. control based on team size: small teams might use broad permissions; large teams need stricter policies.

### Configuration levels
- **Org-level:** Settings > Member privileges
- **Enterprise-level:** Your enterprises > Policies > Repository policies  
Enterprise rules override org rules; org owners can’t change locked settings.

> [!NOTE]
> Features and required interactions vary by repo type and license.

:::image type="content" source="../media/availability-interaction.png" alt-text="Diagram of a four-quadrant graph, divided by x and y axes, which categorizes security settings by availability to users (x axis) and required level of interaction (y axis).":::

### Available security tools
- **All repos:** Access controls, SECURITY.md, Dependabot alerts/updates, advisories
- **With Advanced Security:** Code scanning, secret scanning, dependency review

## Enhancing Enterprise Security with GitHub
GitHub’s enterprise features bolster your security posture and compliance.

- Security Features
  - **GitHub Advanced Security (GHAS):** Code scanning, secret scanning, dependency reviews
  - **Security Configurations:** Enforce consistent settings across all repos
- Compliance Support
  - **Compliance reports:** SOC 1 Type 2, SOC 2 Type 2, ISO/IEC 27001:2013 certifications available for audits and regulatory needs

## Scrubbing Sensitive Data from GitHub Repositories
When secrets leak, you must rewrite history or engage GitHub support.

### Rewrite history
**Legacy:** `git filter-branch` to remove files:
```bash
git filter-branch --force --index-filter \
  'git rm --cached --ignore-unmatch path/to/sensitive_file' \
  --prune-empty --tag-name-filter cat -- --all
```
**Recommended:** BFG Repo-Cleaner:
```bash
java -jar bfg.jar --delete-files path/to/sensitive_file.git
# or replace strings:
java -jar bfg.jar --replace-text passwords.txt
```
Clean up and force-push:
```bash
git reflog expire --expire=now --all
git gc --prune=now --aggressive
git push origin --force --all
```

### Contact GitHub Support
For public repos, cached indexes may persist.
1. (Optional) Delete the repo if data is critical.
2. Rewrite history & force-push.
3. Request removal via GitHub Support with repo name, commits/files, and confirmation of history rewrite to flush caches.

**Prevent leaks:**
- Use `.gitignore`
- Store secrets with GitHub Secrets or secret managers
- Scan regularly with GitGuardian or truffleHog

## Publishing security advisories
When vulnerabilities arise, use GitHub security advisories to:
- Privately collaborate on fixes
- Clearly communicate details
- Document mitigation steps

:::image type="content" source="../media/security-advisories-goals.png" alt-text="Diagram showing three steps to security advisories.":::

A good advisory lists the affected versions, severity, patch status, and CVE references. Use GitHub’s built-in workflow to manage and publish advisories efficiently.

## Enabling Secure Software Development and Ensuring Compliance

Each policy is designed to balance security and usability, offering options that range from minimal restrictions to highly controlled environments.
The table below provides an overview of various security policies categorized by their level of control.

| Control Level | Recommended Policies & Features | Use Case |
|------------|------------|----------|
| **Low Control** (Guidance & Best Practices) | Security advisories & code scanning; Dependabot alerts; Branch protection rules (optional reviews) | Teams needing flexibility with best security practices |
| **Moderate Control** (Enforced Rules) | Required branch protection; Commit signing; Org-wide security policies; Monitoring webhooks | Teams needing governance with developer autonomy |
| **High Control** (Strict Compliance & Governance) | Enforce SAML SSO & 2FA; Restrict visibility & forking; Mandatory PR approvals; Prevent force pushes; CI/CD security checks | Organizations with strict compliance requirements (e.g., SOC 2, ISO 27001) |

### Key Security and Compliance Features in GitHub Enterprise

1. Secure Code Development
   - **Code Scanning (GHAS):** Automatically detect vulnerabilities via CodeQL.
   - **Secret Scanning:** Prevent hardcoded secrets.
   - **Dependency Review & Dependabot:** Identify and update vulnerable dependencies.
2. Enforcing Compliance Policies
   - **Branch Protection Rules:** Require PR reviews, status checks, and signed commits.
   - **Security Rulesets:** Apply policies across multiple repos.
   - **Audit Logs & API Monitoring:** Track activity and changes.
3. Controlling Access & Authentication
   - **Enforce SAML SSO & 2FA:** Strong authentication for all users.
   - **Restrict Repository Visibility:** Control who can view, fork, or clone.
   - **Fine-Grained Access Control:** Assign roles per team or project.

### When to Use Different Security and Compliance Profiles
- **Startups & Agile Teams:** Moderate control with branch protection, Dependabot, and secret scanning.
- **Enterprises & Regulated Industries:** High control with SAML SSO, audit logging, security rulesets, and strict repo controls.
- **Open Source Projects:** Low to moderate control with code scanning, dependency updates, and community guidance.

## Defining Organization and Enterprise Policies

Organization policies and enterprise policies set governance, access, and workflow rules to ensure security and compliance.

### Key Aspects
1. **Security & Access Control:** SAML SSO, 2FA, RBAC, repo visibility.
2. **Compliance & Governance:** Audit logging, branch protection, commit signing.
3. **Development Workflow & Automation:** PR approvals, security rulesets, Actions policies.
4. **Code & Dependency Security:** Code scanning, secret scanning, Dependabot, action restrictions.

Any enterprise-level policy in “Your enterprises > Policies > Repository policies” overrides org-level settings under Settings > Member privileges.

## GitHub Audit Log APIs

Use REST or GraphQL to investigate missing assets and monitor security events.

### Steps to Investigate Missing Assets
1. Identify the asset (e.g., repo, team, member).
2. Query the audit log API (`repository.deleted`, etc.).
3. Filter by event type.
4. Review metadata for actor and timestamp.
5. Take corrective actions.

**Example REST request:**
```http
GET /orgs/{org}/audit-log?phrase=repository.deleted
Authorization: Bearer YOUR-TOKEN
```

**Example GraphQL query:**
```graphql
query {
  auditLogEntries(first: 10, query: "repository.deleted") {
    nodes {
      action
      actor { login }
      createdAt
    }
  }
}
```

### Use Cases for Audit Logs
- Investigate security incidents.
- Monitor compliance.
- Track changes to repos, users, and settings.
- Detect unauthorized access.

### Audit Log Streaming
Stream logs to SIEM tools (Splunk, Datadog) or storage (AWS S3, Azure Event Hubs) for real-time monitoring and long-term retention.

### Git and API Activity Logs
Monitoring Git and API activity logs is crucial for maintaining the security and integrity of your repositories. These logs provide visibility into user actions, enabling you to detect unauthorized access, investigate incidents, and ensure compliance with organizational policies.

- **Git activity:** `git.push`, `pull_request`, etc.
- **API activity:** `api.request`, include source IP for threat detection.

### Additional Events (EMUs)
Enterprise Managed Users add events like `user.login`, `repository.permissions_updated`, `repository.forked`.

### Filtering by Token
Query `?phrase=token` to find token-related actions and detect misuse.

## Key Security Features of a GitHub Repository
- **SECURITY.md:** Define reporting and supported versions.
- **Branch Protection:** Enforce reviews, status checks, and commit signing.
- **Dependabot Alerts:** Automatic vulnerability detection and updates.
- **Code Scanning:** Continuous analysis via CodeQL.
- **Secret Scanning & Push Protection:** Real-time prevention and alerts.
- **Security Advisories:** Draft, collaborate, and publish advisories.
- **Dependency Graph:** Visualize and audit dependencies.
- **2FA & RBAC:** Enforce strong authentication and least privilege.
- **Audit Logs:** Monitor, filter, and export logs for compliance.

## API Access and Integrations
| **Token Type**            | **Description** |
|----------------------------|---------------------------|
| **Personal Access Tokens (PATs)** | Tokens tied to a user account for API access. |
| **Installation Tokens**    | Tokens generated for GitHub Apps installations with fine-grained permissions.  |
| **OAuth Tokens** | Tokens used for OAuth app authentication and API access. |
| **Device Tokens** | Tokens used for device-based authentication flows. |
| **Refresh Tokens** | Tokens used to renew expired access tokens without re-authentication. |

| **Rate Limit Type**        | **Limit**  |
|--------------------------|---------------------|
| **Unauthenticated**        | 60 requests per hour. |
| **Authenticated**          | 5000 requests per hour. |
| **Apps**                   | Varies by installation, depending on the app's configuration.|

**Check via API:**
```sh
curl -H "Authorization: token YOUR_TOKEN" \
     -H "Accept: application/vnd.github.v3+json" \
     https://api.github.com/rate_limit
```

GitHub Apps offer fine-grained permissions and are ideal for organizational integrations, while Personal Access Tokens (PATs) are simpler and tied to user accounts, making them suitable for basic scripts but with less control. OAuth Apps should be granted the least privilege scopes, with event subscriptions managed and reviewed regularly. Organizations can restrict untrusted apps through settings to enhance security.

Enterprise Managed Users (EMUs) provide managed accounts with limited scope, ensuring compliance and control. Data residency policies help organizations store logs and data in specified regions, aligning with regulatory requirements. API usage should adhere to organizational policies and residency guidelines to maintain compliance.

