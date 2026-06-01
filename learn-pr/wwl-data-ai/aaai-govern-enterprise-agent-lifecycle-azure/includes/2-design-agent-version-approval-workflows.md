Microsoft Foundry stores agent configurations—model deployments, system prompts, and tool settings—as versioned artifacts managed through controlled deployment workflows. In this unit, you design the version manifests, approval gates, and tenant rollout controls that govern how those configuration changes propagate safely into production.

## Understand agent version complexity

| Version Component | Traditional Software | Multi-Agent System |
|-------------------|---------------------|-------------------|
| Code/logic | Source code commits | Orchestrator code + agent code |
| Runtime dependencies | Package versions | Model deployment versions |
| Configuration | Config files | System prompts + tool schemas |
| Quality baseline | Test suite results | Evaluation benchmark scores |

Agent versioning differs fundamentally from software versioning because the "code" that determines agent behavior includes components that change at different rates and through different processes. The orchestrator code changes when you modify agent coordination logic—perhaps adding a new agent to the pipeline or changing how outputs aggregate. This code deploys through standard CI/CD pipelines with source control and code review.

Model deployments change when Azure OpenAI releases new model versions or you switch between models for performance or cost reasons. Model version changes don't go through source control—they're configuration changes in Microsoft Foundry that point to different model endpoints. However, model changes significantly impact agent behavior. Upgrading from gpt-4o (2024-08-06) to gpt-4.1 (2025-04-14) changes response characteristics, latency, and token consumption even if the system prompt remains identical.

System prompts change when you refine agent instructions to improve accuracy, reduce bias, or add new capabilities. Prompt engineering is iterative—small wording changes can substantially alter outputs. A prompt change might say "identify potential security issues" versus "identify confirmed security vulnerabilities"—the second phrasing reduces false positives but might miss emerging threats. These changes require careful evaluation before production deployment.

Tool configurations change when you add, remove, or modify the external resources agents access. Adding a new security vulnerability database to the security analyzer's tool set changes what threats it detects. Modifying the authentication configuration for database access affects which code patterns the agent can verify. Tool changes combine software development (writing tool integration code) with operational changes (configuring access credentials and permissions).

All these components together define an agent's version. When any component changes, you create a new agent version that requires testing, approval, and controlled deployment.

## Design comprehensive version manifests

A version manifest captures the complete state of an agent at a specific version, enabling reproducibility and change tracking. The manifest is a YAML document stored in source control alongside the agent's code, creating a single source of truth for what constitutes version 2.3 of the security analyzer.

```yaml
agent_version_manifest:
  agent_id: security-analyzer
  version: 2.3.0
  created_date: 2026-04-01
  status: approved
  
  # Model deployment configuration
  model:
    deployment_name: gpt-4o-fabrikam-prod
    model_name: gpt-4o
    model_version: "2024-11-20"
    api_version: "2024-12-01-preview"  # Use the current stable API version; see Microsoft Foundry API lifecycle docs
    temperature: 0.3
    max_tokens: 2000
    endpoint: https://fabrikam-prod-eastus.openai.azure.com/
    
  # System prompt (stored as hash with reference to full text)
  system_prompt:
    version: security-prompt-v5.2
    hash: e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
    file: prompts/security-analyzer-v5.2.txt
    
  # Tool configurations
  tools:
    - name: cve-database-lookup
      version: "3.1"
      endpoint: https://cve.fabrikam.internal/api
      authentication: managed-identity
      
    - name: owasp-guidelines-search
      version: "2.0"
      endpoint: https://guidelines.fabrikam.internal/search
      authentication: api-key
      
  # Evaluation baseline (must meet or exceed)
  evaluation_baseline:
    precision: 0.95
    recall: 0.88
    f1_score: 0.91
    false_positive_rate: 0.05
    benchmark_dataset: security-eval-v2-2026q1
    evaluation_date: 2026-03-28
    
  # Approval information
  approval:
    status: approved
    approver: security-lead@fabrikam.com
    approval_date: 2026-04-01
    approval_reason: "Model upgrade improves precision by 3% with no recall degradation"
    requires_customer_approval: false
    
  # Dependencies and compatibility
  dependencies:
    orchestrator_version: ">=3.2.0"
    other_agents:
      - quality-analyzer: ">=1.8"
      - preprocessing-agent: ">=2.1"
```

This manifest enables precise version control. When investigating why agent behavior changed between February and March, you compare the manifests for versions 2.2 and 2.3. The diff shows the model version upgraded and the system prompt hash changed, immediately identifying what changed without speculating.

Version manifests also enable rollback. If version 2.3 shows unexpected behavior in production, you redeploy using the 2.2 manifest—restoring the exact model deployment, system prompt, and tool configurations that were running before the problematic change.

## Implement automated and manual approval gates

Not all agent changes carry equal risk. Updating a dependency package version or adjusting temperature from 0.3 to 0.28 (minor tuning) represents low risk and can flow through automated approval gates. Replacing the model from gpt-4o to gpt-4.1 or rewriting the system prompt represents high risk and requires manual review before production deployment.

You design tiered approval gates based on change risk assessment:

**Automated gates** verify objective quality criteria without human intervention. Every agent version must pass: unit tests verifying tool integrations work correctly, contract tests confirming the agent's output schema matches the orchestrator's expectations, evaluation benchmarks meeting or exceeding the baseline scores documented in the previous version's manifest, and security scans showing no credential leaks or vulnerable dependencies in the agent code.

If any automated gate fails, the version is rejected and doesn't proceed to manual review. The CI/CD pipeline aborts the deployment and notifies the development team. If all automated gates pass, low-risk changes (dependency updates, minor configuration tuning) automatically approve and proceed to staging deployment. High-risk changes proceed to manual approval queues.

**Manual approval gates** require explicit human review for changes that could significantly impact agent behavior or enterprise customer experience. Changes requiring manual approval include: model version upgrades (different model characteristics), system prompt rewrites (more than 20% of prompt text modified), new tool integrations (expanded agent capabilities), and evaluation baseline reductions (accepting lower precision or recall). The manual approver—typically the agent's product owner or the Responsible AI Officer—reviews the version manifest, examines evaluation results comparing new and old versions, and considers deployment risk before approving or rejecting the version.

**Customer approval gates** apply to enterprise tenants with contractual approval rights. Some enterprise customers negotiate the right to review and approve agent changes before those changes affect their tenants. When a version includes changes requiring customer approval (marked in the manifest), the version deploys to Fabrikam's internal tenants but waits in a "pending customer approval" state for enterprise customers. The customer success team notifies affected customers, provides the version manifest and evaluation comparisons, and awaits approval. Only after customer approval does the version deploy to that tenant's environment.

## Control version propagation across tenants

Once a version is approved, you control rollout timing and scope based on tenant preferences and risk tolerance. Fabrikam's enterprise customers fall into three rollout tiers reflecting their appetite for rapid updates versus stability:

**Aggressive adopters** (Tier 1) receive approved versions immediately. These customers prioritize having the latest capabilities and accept the small risk that new versions might introduce unexpected behavior. Tier 1 customers typically include Fabrikam's internal development teams and a few early-adopter enterprise customers who provide rapid feedback on new versions. When version 2.3 of the security analyzer is approved, it deploys to Tier 1 tenants within hours.

**Standard adopters** (Tier 2) receive new versions after a 7-day validation period. During this period, version 2.3 runs in Tier 1 tenants while Tier 2 tenants continue using version 2.2. You monitor telemetry, error rates, and customer feedback from Tier 1 deployments. If no issues surface during the validation period, version 2.3 automatically promotes to Tier 2 tenants. If issues arise, you hold version 2.3 in Tier 1, fix the problems in version 2.4, and that improved version eventually rolls to Tier 2.

**Conservative adopters** (Tier 3) require 30-day validation before updates. These are risk-averse customers, often in regulated industries, who prioritize stability over new features. They accept that they're running agent versions several weeks behind the latest release but gain confidence from extensive production validation in other tenants first.

The rollout schedule is enforced automatically by deployment configurations in Azure. Each tenant's configuration specifies its rollout tier. The deployment automation checks: is this tenant Tier 1 (deploy immediately)? Tier 2 (deploy if version has been stable in Tier 1 for 7+ days)? Tier 3 (deploy if version has been stable across Tiers 1 and 2 for 30+ days)? The system calculates eligibility and deploys accordingly, ensuring no tenant receives updates sooner than their tier allows.

## Enable version pinning and controlled upgrade windows

Some enterprise customers need temporary control over when updates occur. Version pinning allows a tenant to freeze on a specific agent version for a defined period, deferring updates while they complete their own testing or navigate busy periods where agent behavior changes could disrupt workflows.

The security analyzer version manifest includes a `pinning_policy` section:

```yaml
pinning_policy:
  pin_allowed: true
  max_pin_duration_days: 90
  security_exception: force-upgrade-on-critical-cve
```

When an enterprise customer requests a version pin, they specify: which agent version to pin to (must be a currently supported version, not one scheduled for retirement), the duration of the pin (maximum 90 days per policy), and the business justification (typically "deploying critical feature, need stable agent behavior for two weeks"). The customer success team approves the pin request and configures the pin in the tenant's deployment settings.

During the pin period, the tenant continues running the pinned version even as new versions roll out to other tenants. Telemetry and cost reporting continue, but version updates are deferred. When the pin expires, the tenant automatically receives the latest version appropriate for their rollout tier—not the immediate next version, but the current production version, potentially skipping several intermediate versions.

**Security exceptions** override pins. The `force-upgrade-on-critical-cve` policy means that if a critical security vulnerability is discovered in the pinned version, the pin is automatically lifted and the tenant is upgraded to a patched version within 24 hours. This ensures security response isn't delayed by version pins. The tenant receives notification of the forced upgrade along with the CVE details justifying the override.

## EU AI Act change-management obligations

For organizations deploying multi-agent AI systems in the European Union, the EU AI Act imposes change-management obligations that extend beyond the internal governance patterns covered in this unit. High-risk AI systems \u2014 a classification that may apply to agents involved in employment screening, credit scoring, or clinical decision support \u2014 must maintain a **technical file** documenting the system's design, capabilities, intended purpose, and evidence of conformity assessment.

Material changes to a high-risk AI system trigger re-assessment obligations. A "material change" includes changes that affect the system's performance characteristics, intended purpose, or the risk profile established in the original conformity assessment \u2014 exactly the changes that your version manifests, approval gates, and rollout tiers govern. The practical implication: your version manifest (system prompt hash, model deployment, evaluation baselines) becomes the technical file artifact for each approved version. Your tiered approval gate for high-risk changes maps to the conformity re-assessment trigger.

Integrate EU AI Act documentation requirements into your version manifest schema: add an `eu_ai_act_risk_classification` field, a `material_change_assessment` boolean, and a `technical_file_reference` linking to the conformity documentation. This aligns governance tooling with regulatory obligations without creating a separate parallel process.

Version governance transforms what could be an unpredictable multi-agent environment into a controlled one: every running agent traces back to an approved manifest, every customer's risk tolerance is respected through rollout tiers and version pins, and every high-risk change passes through appropriate human review before reaching production. Fair resource allocation across those tenants is the next governance challenge.

## Key takeaways

- **Version manifests** capture the complete agent state—model deployment, system prompt hash, tool configurations, and evaluation baselines—in a YAML document stored in source control.
- **Tiered approval gates** route low-risk changes through automated validation and high-risk changes through manual review by product owners or the Responsible AI Officer.
- **Rollout tiers** deploy approved versions to aggressive adopters immediately, standard adopters after 7 days, and conservative adopters after 30 days of production validation.
- **Version pinning** lets enterprise customers freeze on a specific version for up to 90 days, with security exceptions that override pins for critical CVEs.
- **EU AI Act obligations** require high-risk AI systems to maintain a technical file for each approved version; version manifests — with `eu_ai_act_risk_classification` and `material_change_assessment` fields added to the schema — serve as that artifact, aligning governance tooling with regulatory requirements.
