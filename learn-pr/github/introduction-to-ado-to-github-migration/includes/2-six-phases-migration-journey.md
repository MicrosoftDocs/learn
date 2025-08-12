:::image type="content" source="../media/migration-process-steps.png" alt-text="Screenshot of a six-step migration process diagram, including Discovery & Planning, Source Environment Assessment, Target Environment Setup, Migration Testing, Production Migration, and Post-Migration Activities." lightbox="../media/migration-process-steps.png":::

### Phase 1: Discovery & planning (1 - 2 weeks time estimated) 
This foundational phase involves aligning stakeholders, defining business goals, and identifying key success metrics. Teams assess current DevOps workflows and determine how GitHub's extensible platform—featuring deep IDE integration, GitHub Copilot, and 17,000+ third-party apps—can enhance productivity and collaboration.

Licensing considerations, such as GitHub's metered billing model and Azure Consumption Revenue (ACR) eligibility, are also addressed early to streamline procurement and budgeting.

**Key activities:**
- Stakeholder alignment and business case development
- Current state assessment
- Success criteria definition
- Resource planning and timeline establishment


### Phase 2: Source environment assessment (1 - 2 weeks time estimated) 
Organizations evaluate their existing ADO setup, including repositories, pipelines, permissions, and integrations. This assessment helps determine what should be migrated, what can be archived, and what needs rearchitecting to align with GitHub's best practices. The goal is to reduce complexity and ensure that only relevant, high-value assets are transitioned.

**Key activities:**
- Azure DevOps environment audit
- Asset prioritization and rationalization
- GitHub Enterprise environment provisioning
- Security and governance configuration

### Phase 3: Target environment setup (1 - 2 weeks time estimated)
In this phase, GitHub Enterprise Cloud is configured to meet organizational needs. This includes setting up repositories, configuring GitHub Actions for CI/CD, enabling GitHub Advanced Security (GHAS), and applying governance policies such as branch protection rules and code owners. GitHub's support for data residency—especially for customers in the EU and Australia—ensures compliance with regional regulations. 

### Phase 4: Migration testing (1 week time estimated)
Before going live, teams conduct test migrations using GitHub's Enterprise Importer and other tooling. This phase validates that repositories, workflows, and permissions migrate correctly and that integrations (e.g., Azure Boards, Codespaces) function as expected. It's also an opportunity to apply GitHub's Well-Architected Framework principles to ensure the migration supports security, reliability, and operational excellence.

**Key activities:**
- Test migration execution
- Workflow validation
- Integration testing
- Security and compliance verification

### Phase 5: Production migration (1 - 3 weeks time estimated)
With testing complete, the production migration begins. This phase involves moving live workloads, coordinating with stakeholders, and ensuring minimal disruption to development teams. GitHub's unified platform helps reduce tool fragmentation, enabling faster delivery cycles and improved cross-functional collaboration.

**Key activities:**
- Production data migration
- Stakeholder coordination
- Team transition management
- Communication and change management

### Phase 6: Post-migration activities (1 - 2 weeks time estimated)
After migration, the focus shifts to adoption, optimization, and value realization. Teams monitor usage, refine workflows, and expand GitHub capabilities—such as enabling Copilot across teams or integrating additional marketplace apps. GitHub's metered billing and data residency features continue to support scalability and compliance, while ongoing enablement ensures long-term success.

**Key activities:**
- Usage monitoring and optimization
- Team enablement and training
- Workflow refinement
- Value realization tracking
