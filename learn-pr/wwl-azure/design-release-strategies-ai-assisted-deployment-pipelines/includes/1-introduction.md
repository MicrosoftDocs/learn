A verified build answers whether a change is a suitable deployment candidate. It doesn't establish whether the target is ready, which identity may deploy, or when more users should receive the change. Those are delivery decisions that you make before asking an assistant to generate deployment automation.

Consider the illustrative EShopOnWeb work item **"Search results showing out-of-stock items"**. The team has reviewed the fix and accepted a build artifact. It now needs to deliver that same artifact, verify the search behavior in the target environment, and expand exposure only when the evidence supports doing so. The scenario illustrates the decisions; it doesn't assume that a working application, Azure environment, or deployment pipeline is supplied by another lab.

In this module, you establish a delivery-control contract covering:

- Target readiness and reusable application deployment components.
- Secretless deployment identities, runtime access, and environment-specific configuration.
- Dev/test, staging, and production promotion of the same accepted candidate.
- Canary, early-adopter, and blue-green exposure with meaningful health signals and stop conditions.
- Review of release-specific Azure Pipelines and GitHub Actions proposals without delegating approval.
- Promotion decisions linked to the actual candidate, configuration, and observed results.

Infrastructure may already exist or be prepared through a separate process. Detailed infrastructure-as-code implementation belongs to its dedicated material; integrating that automation into CI/CD is an option, not a prerequisite for application delivery.

You first define the controls, then use Copilot to propose automation and help interpret evidence against them. The outcome is a reviewable delivery contract for subsequent cloud planning and implementation, not permission for an assistant to change infrastructure or release to production.
