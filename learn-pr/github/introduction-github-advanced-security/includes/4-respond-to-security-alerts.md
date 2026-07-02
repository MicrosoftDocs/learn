
:::image type="content" source="../media/security-lifecycle.png" alt-text="Screenshot of a GitHub pull request next to a conceptual diagram of developer lifecycle circle.":::

Gone are the days when security is isolated and treated as a separate phase or gate in the software development lifecycle. As we learned, this approach may lead to delayed identification and remediation of vulnerabilities, as issues are only discovered late in the development process. It can result in increased time and resources spent on fixing security issues, potentially impacting project timelines.

In today’s day and age, it is imperative that we integrate security seamlessly into each step of the software development life cycle. This approach ensures that security considerations are addressed from the project's inception, resulting in faster identification and resolution of vulnerabilities.

- Early Detection: Integrating security early allows for the detection of vulnerabilities at the source code level, minimizing the likelihood of issues reaching production.
- Efficient Remediation: Security issues can be addressed promptly as part of regular development activities, reducing the time and effort required to understand the context of the issue.
- Consistent Security Standards: Integration ensures consistent adherence to security standards across the entire development life cycle, fostering a proactive security culture within the development team.
- Improved Collaboration: Collaboration between developers, security teams, and other stakeholders is enhanced, as security becomes a shared responsibility throughout the development process.

## How GitHub organizes its security capabilities

GitHub Advanced Security brings together security capabilities that help teams detect vulnerabilities, prevent credential leaks, and manage security risk directly within their development workflows.

These capabilities are organized into three complementary solution areas:

- **Code Security** – Helps teams find and fix vulnerabilities in source code and dependencies.
- **Secret Protection** – Helps detect and prevent exposed credentials and tokens.
- **Supply Chain Security** – Helps identify and remediate risks in third-party dependencies.

Together, these solution areas provide broad protection across the most common sources of software risk.

### GitHub security platform overview

```text
                   GitHub Advanced Security
                              │
     ┌────────────────────────┼────────────────────────┐
     │                        │                        │
     ▼                        ▼                        ▼
 GitHub Code Security   GitHub Secret Protection   Supply Chain Security
     │                        │                        │
     │                        │                        │
 Code scanning          Secret scanning          Dependabot alerts
 Copilot Autofix        Push protection          Security updates
 Security campaigns     Custom patterns          Dependency review
 Dependency review      Security campaigns       Dependency graph
```

## How the three solution areas work together

Each solution area addresses a different category of risk.

### GitHub Code Security

GitHub Code Security helps developers and security teams identify and remediate vulnerabilities in application code. It includes features such as:

- Code scanning
- Copilot Autofix
- Dependency review
- Security campaigns

### GitHub Secret Protection

GitHub Secret Protection helps organizations detect and prevent exposed credentials. It includes:

- Secret scanning
- Push protection
- Custom patterns
- Security campaigns

### Supply Chain Security

Supply chain security focuses on the dependencies your application relies on. Features include:

- Dependabot alerts
- Dependabot security updates
- Dependency review
- Dependency graph

Together, these capabilities protect:

- Custom application code
- Sensitive credentials
- Open-source dependencies

## Comparing the three solution areas

| Solution area | Primary focus | Key capabilities | Typical use cases |
| --- | --- | --- | --- |
| **GitHub Code Security** | Vulnerabilities in source code and dependencies | Code scanning, Copilot Autofix, Security Campaigns, Dependency Review | Detecting and fixing insecure code patterns |
| **GitHub Secret Protection** | Exposed credentials and tokens | Secret scanning, Push Protection, Custom Patterns | Preventing accidental secret leaks |
| **Supply Chain Security** | Risks in third-party dependencies | Dependabot Alerts, Security Updates, Dependency Graph | Managing vulnerable open-source packages |

## Additional capabilities that accelerate remediation

GitHub Advanced Security not only detects security issues, but also includes capabilities that help teams remediate alerts more efficiently and coordinate large-scale improvement efforts across repositories and teams.

### Copilot Autofix

GitHub Copilot Autofix provides targeted recommendations to help developers remediate code scanning alerts. It analyzes the alert and generates suggested code changes along with explanations to help developers understand the underlying vulnerability.

### Security Campaigns

GitHub Security Campaigns helps organizations reduce security debt at scale by grouping related alerts into coordinated remediation efforts. Security teams can assign campaigns, track progress, and collaborate with developers to resolve large numbers of alerts more efficiently.

## How different roles use GitHub security

### Developer

A developer writes code and opens pull requests. Code scanning identifies vulnerabilities, push protection prevents accidental secret exposure, and Dependabot proposes dependency updates. The developer reviews and merges the recommended changes.

### Security engineer

A security engineer monitors alerts across repositories, prioritizes remediation, and creates security campaigns to coordinate fixes across teams.

### Administrator

An administrator enables security features, configures policies, manages licensing, and tracks security adoption and coverage across the organization.

By understanding and implementing these advanced security practices with the help of GHAS, organizations can significantly enhance their software development processes and create a more resilient and secure development ecosystem.

GHAS empowers DevSecOps teams to prioritize innovation and enhance developer productivity without sacrificing security. Automated security checks are run with every pull request, surfacing issues in the context of the development workflow so vulnerabilities are fixed in minutes, not months. 

Our developer-first solution unlocks your ability to keep your code, supply chain, and secrets secure before you push to production. GHAS gives security teams visibility into the cross-organizational security posture and supply chain and unparalleled access to curated security intelligence from millions of developers and security researchers around the world.

