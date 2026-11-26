Governed delivery connects a verified build candidate to a ready target, a permitted identity, and an evidence-based release decision. Generating deployment YAML is one part of that workflow, not a substitute for defining its controls.

For the illustrative EShopOnWeb search fix, you carry the same accepted artifact into deployment, confirm that required configuration and dependencies are available, and observe the intended search behavior before expanding exposure. Infrastructure can be prepared separately; detailed IaC design and optional integration into full CI/CD remain separate implementation work.

Your delivery-control contract records:

- **Candidate and target:** Artifact provenance, target-readiness requirements, and reusable deployment components.
- **Identity and configuration:** Separately scoped deployment/runtime identities, approved connections, configuration references, and feature state without secret values.
- **Environments and exposure:** Promotion path for the same candidate through dev/test and staging, and the supported canary, early-adopter, or blue-green exposure mechanism for production.
- **Gates:** Applicable security/quality reports, scoped exceptions, cohort health thresholds, and explicit missing-data and stop behavior.
- **Authority and evidence:** Who may propose, approve, deploy, promote, or halt, with linked results for each decision.

Copilot can draft release-specific Azure Pipelines and GitHub Actions proposals and help compare evidence with that contract. Build-only generation belongs to the build module. You still verify execution order, candidate selection, artifact handoffs, effective permissions, and the underlying measurements. A model recommendation doesn't authorize a write operation, and approval doesn't turn a failed health check into a pass.

Use this contract as input to subsequent cloud planning and implementation. Review detailed infrastructure and application changes against it rather than assume that those changes already exist. The later deployment-health and recovery material develops how to investigate degraded results and choose a compatible, authorized recovery action.
