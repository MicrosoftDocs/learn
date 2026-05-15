In this module, you learned how to:

- Define autonomy levels and action boundaries so agents operate with bounded autonomy aligned to risk, security, and compliance requirements.
- Classify agent actions (low, medium, high, critical) and map each risk tier to GitHub-native enforcement controls such as rulesets, required checks, CODEOWNERS, and environments.
- Enforce governance through rulesets/branch protection, required status checks, path-based review routing, and deployment gates so policy is technically enforced and can't be bypassed.
- Design human-in-the-loop workflows that place approvals at high-impact decision points (merge, deploy, secret access) while keeping low-risk work automated for velocity.
- Apply least-privilege execution by setting read-only defaults for workflow tokens and granting write permissions only to the job(s) that require them, with secrets scoped to protected environments.
- Improve operational reliability with workflow concurrency controls, risk-based plan gating, durable evidence (logs and artifacts), drift detection, and recovery patterns (retry limits, rollback, escalation).

## Learn more

For deeper reading, use official GitHub documentation on:

- [Available rules for rulesets - GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/available-rules-for-rulesets)
- [About code owners - GitHub Docs](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)
- [Managing environments for deployment - GitHub Docs](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment)
- [Secure use reference - GitHub Docs](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)
- [Store and share data with workflow artifacts - GitHub Docs](https://docs.github.com/en/actions/using-workflows/storing-workflow-data-as-artifacts)
