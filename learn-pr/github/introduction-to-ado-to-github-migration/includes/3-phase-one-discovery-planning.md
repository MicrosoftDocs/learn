Are you excited to get started with your migration?  Before beginning the technical work, you need to establish a solid foundation with proper discovery and planning. This phase sets the stage for a successful migration by aligning stakeholders, defining objectives, and preparing the necessary tools and processes.

### Migration Objectives

Starting with clear Migration Objectives will help your stakeholders feel confident that this migration is in their best interest. 

-	Migrate repositories from Azure DevOps to GitHub Enterprise Cloud
-	Maintain data integrity and complete history
-	Ensure minimal business disruption
-	Establish proper governance and security controls
-	Enable seamless team transition

### Key Success Criteria

Similar to Migration Objectives, Key Success Criteria should be on everyone's minds during the migration to ensure minimal business disruption and success for the future environment.

**Success metrics:**
- 100% code preservation with complete history
- Zero data loss during migration
- Successful user authentication and access
- Working integrations (if retained)
- Team productivity maintained post-migration

## Pre-kickoff meeting checklist

Here is a checklist to complete before your kickoff meeting.

### Required access & credentials

#### Azure DevOps

- [ ] Organization Administrator access
- [ ] Personal Access Token with full permissions
- [ ] Service connection details
- [ ] User and team membership lists

#### GitHub Enterprise Cloud

- [ ] Enterprise Owner or Organization Owner access
- [ ] Personal Access Token with migration permissions
- [ ] **Pre-configured Authentication:** SAML/SSO already operational
- [ ] **Environment Type Confirmed:** GHEC Standard, EMU, or Data Residency
- [ ] Billing and licensing information
- [ ] User provisioning and team sync validated (if EMU)

#### Identity Provider

- [ ] Azure AD/Entra ID Administrator access (if changes needed)
- [ ] SCIM provisioning operational (for EMU environments)
- [ ] Group management permissions for team synchronization
- [ ] **Authentication Testing Completed:** SSO login verified

### Tools & Software Setup

- [ ] Install GitHub CLI (`gh`)
- [ ] Install GitHub ADO2GH CLI extension (`gh extension install github/gh-ado2gh`)
- [ ] Configure Git with appropriate credentials
- [ ] Access to PowerShell/Bash for scripting
- [ ] Migration tracking spreadsheet or tool

### Stakeholder Identification

- [ ] Executive Sponsor
- [ ] IT Leadership
- [ ] Development Team Leads
- [ ] Security/Compliance Team
- [ ] DevOps/Platform Engineers
- [ ] End Users (Developers)


Have everything on your check list? Perfect, now let's schedule that kick off meeting! 

Here's an agenda for your kick off meeting, a charter template to keep everything organized, and a Risk Management Matrix to keep expectations realistic.

### Kickoff Meeting Agenda

1. **Project Overview** (30 minutes)

   - Migration objectives and scope
   - Success criteria and timeline
   - Roles and responsibilities
   - Communication plan

1. **Technical Deep Dive** (45 minutes)

   - Current Azure DevOps usage
   - Integration dependencies
   - Security and compliance requirements
   - GitHub Enterprise Cloud architecture

1. **Risk Assessment** (15 minutes)
   - Identify potential blockers
   - Mitigation strategies
   - Rollback procedures

### Project Charter Template

Use this template to document your migration project:

```md
    ## Migration Project Charter
    
    **Project Name:** ADO to GitHub Migration - [Customer Name]
    **Project Manager:** [Name]
    **Service Engineer:** [Name]
    **Start Date:** [Date]
    **Target Completion:** [Date]
    
    ### Objectives
    
    - [ ] Migrate [X] repositories from ADO to GitHub
    - [ ] Maintain [specify integrations] with Azure DevOps
    - [ ] Implement governance and security controls
    - [ ] Train [X] users on GitHub workflows
    
    ### Scope
    
    **In Scope:**
    
    - Repository migration with full history
    - Team and permission mapping
    - [Specify other items]
    
    **Out of Scope:**
    
    - Legacy system maintenance
    - Custom tool migrations
    - [Specify other items]
    
    ### Success Metrics
    
    - Data integrity: 100% code preservation
    - Migration time: < [X] hours per repository
    - User adoption: [X]% active users within 30 days
    - Support tickets: < [X] per week post-migration
    
    ### Integration Strategy
    
    - [ ] Azure Boards: [Keep/Migrate/Hybrid]
    - [ ] Azure Pipelines: [Keep/Migrate/Hybrid]
    - [ ] Azure Artifacts: [Keep/Migrate/Hybrid]
    - [ ] Other services: [List decisions]
```

### Risk Management Matrix
Use this matrix to identify and plan for potential risks:

| Risk                       | Likelihood | Impact | Mitigation                              | Owner    |
| -------------------------- | ---------- | ------ | --------------------------------------- | -------- |
| Data loss during migration | Low        | High   | Backup verification, test migrations    | SE       |
| User access issues         | -Medium    | Medium | Pre-configure SSO, test accounts        | Customer |
| Integration failures       | Medium     | High   | Maintain ADO connections, fallback plan | SE       |
| Timeline delays            | High       | Medium | Buffer time, phased approach            | PM       |

## Communication plan

Establish clear communication channels and regular check-ins:

- **Weekly status meetings** with core team
- **Bi-weekly stakeholder updates** via email or dashboard
- **Escalation path** for critical issues
- **Change management communications** for end users

With these tools and templates, you're ready to begin Phase 1 of your migration journey.
