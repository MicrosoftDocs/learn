:::image type="content" source="../media/migrate-github-enterprise-part-four.png" alt-text="Screenshot of a title slide displaying Migrate to GitHub Enterprise Part IV." lightbox="../media/migrate-github-enterprise-part-four.png":::

The migration cutover marks a major milestone-but it's not the finish line. In Phase 6, you'll shift from a "successful copy" to a stable, governed, and fully adopted GitHub Enterprise Cloud (GHEC) environment that teams trust every day.
This phase is about operationalizing your new platform:

- Resolving identity mismatches (mannequins) so contributor history is preserved
- Enforcing governance and security across all repositories
- Validating hybrid integrations like Azure Boards and Pipelines
- Equipping teams for smooth adoption from day one
- Retiring Azure DevOps (ADO) in a controlled, auditable way
- Putting in place lightweight operations to keep everything running long after the migration team steps back

Think of it as moving from project mode to product mode-establishing the ongoing care, feeding, and evolution of your developer platform.

### Learning objectives

By the end of this module, you'll be able to:
- Resolve mannequin accounts to preserve contributor attribution and PR ownership
- Apply and verify governance across your GitHub organization, including branch protections, rulesets, and security features
- Validate Azure Boards and Azure Pipelines integrations to maintain traceability and delivery continuity
- Provide teams with the checklists, scripts, and communications they need to be productive immediately
- Plan and execute a phased retirement of ADO while preserving data for audits
- Implement operational health checks and KPIs to sustain your GitHub environment

### Prerequisites

Before starting Phase 6, you should have:

**Access**
- **GHEC**: Enterprise Owner or Organization Owner (or delegated admin)  
- **ADO**: Organization Admin for integrations and exports  
- **IdP**: SAML/SCIM admin if EMU or group sync changes are needed  

**Tokens and Tools**
- **GitHub PAT** with `repo`, `admin:repo_hook`, `read:org` (and `admin:org` if required), `workflow` (for Actions)  
- **ADO PAT** with “All organizations” scope and relevant permissions for Boards, Pipelines, Code, and Work items  
- **GitHub CLI (gh)** with ADO2GH extension installed  

**Migration State**
- All target repositories migrated to GHEC  
- Authentication validated in Phase 3  
- Pilot teams ready to test workflows  

### What to expect

This module takes a practical, action-oriented approach-complete with scripts, commands, and checklists you can apply immediately. You'll learn how to transform your successful migration into a thriving, well-governed development platform that teams will want to use every day.
