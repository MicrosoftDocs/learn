Security campaigns in GitHub Advanced Security provide a structured way to coordinate remediation across repositories. After a campaign runs, GitHub surfaces aggregated security data that helps you understand how risk changed across the scoped environment.

In this unit, you learn how to interpret campaign results and use them to improve prevention-first security controls.

### Step 1: Measure how alerts changed during the campaign

To understand campaign outcomes, you focus on how security alerts changed over time within the campaign scope.
You evaluate three signals:

- **Alert volume change** - whether the total number of alerts decreased across repositories
- **Remediation speed** - how quickly alerts moved from open to resolved states
- **New alert activity** - whether new vulnerabilities continued to be introduced during the campaign

Together, these signals show whether teams reduced existing risk or simply maintained it.

### Step 2: Use GitHub insights to understand campaign impact

You use GitHub's organization-level visibility to analyze campaign outcomes.

In **Security and Quality**, you review:

- Alert trends over time to see whether risk is increasing or decreasing
- Alert counts by severity to identify whether critical issues were reduced
- Repository-level distribution to understand where remediation happened effectively

These views help you move beyond individual alerts and understand how risk behaves across the organization.

### Step 3: Interpret where risk is still present

After reviewing campaign data, you identify where security risk remains.

You focus on:

- Alert types that continue to appear after remediation
- Repositories that still generate repeated findings
- Vulnerability patterns that were not fully eliminated

This step helps you separate resolved issues from systemic issues that keep reappearing.

### Step 4: Turn campaign findings into prevention improvements

Campaign results highlight where vulnerabilities are repeatedly introduced. You use this information to strengthen prevention controls in the development workflow.

Based on findings, you improve:

- **Push protection** to stop secrets from entering repositories before commit or push
- **Pull request scanning** to detect vulnerable code before merge
- **Dependency review and updates** to reduce introduction of vulnerable packages

These controls reduce the number of new alerts created after a campaign ends.

### Step 6: How prevention changes future campaigns

When prevention-first controls are applied consistently, they directly influence the shape and scope of future security campaigns.

Instead of repeatedly addressing the same types of issues, organizations begin to reduce the introduction of new vulnerabilities during development. This changes how campaigns are used over time.

#### Iterative security model

Security campaigns become part of a continuous improvement cycle:

**Identify → Remediate → Prevent → Measure → Repeat**

- **Identify** security risks through alerts across repositories
- **Remediate** issues using pull requests and standard GitHub workflows
- **Prevent** new vulnerabilities using push protection, code scanning, and dependency controls
- **Measure** changes using campaign and Security and Quality insights
- **Repeat** the cycle with improved prevention and reduced risk volume

This model ensures that each campaign informs the next one.

#### Transition in security maturity

As organizations progress through this cycle, their approach shifts:

**Reactive → Structured → Preventive**

- **Reactive**: Teams respond to alerts as they appear in individual repositories
- **Structured**: Teams coordinate remediation through security campaigns
- **Preventive**: Teams reduce the introduction of new vulnerabilities before they become alerts

#### Impact on future campaigns

When prevention-first controls are effective, you begin to observe:

- Fewer repeated alert types across repositories
- A lower rate of new alerts being introduced over time
- More focused campaigns targeting specific or emerging risks instead of recurring issues

As a result, security campaigns evolve from broad, organization-wide remediation efforts into more targeted and efficient risk-reduction cycles.

Prevention does not remove the need for campaigns. Instead, it strengthens the system so each new campaign starts from a lower and more controlled risk baseline.