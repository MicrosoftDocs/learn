Understanding project scope and ownership is crucial for successful collaboration between GitHub Projects and Azure Boards. In this unit, we'll explore key considerations for defining project boundaries and responsibilities.

### Project scope and ownership decisions

**Organization vs. User Projects - Decision Matrix:**

| **Factor**             | **Organization Project**                | **User Project**                     |
| ---------------------- | --------------------------------------- | ------------------------------------ |
| **Team collaboration** | Multi-team, cross-functional work       | Individual or small team experiments |
| **Governance**         | Formal approval processes, audit trails | Lightweight, rapid iteration         |
| **Visibility**         | Enterprise-wide transparency            | Personal or limited visibility       |
| **Access control**     | Role-based permissions, enterprise SSO  | Individual control                   |
| **Lifecycle**          | Long-term, production workloads         | Prototypes, learning, testing        |

**Best practice recommendations:**

- Use organization projects for production applications and shared services
- Leverage user projects for proof-of-concepts and individual learning
- Consider data governance and compliance requirements when choosing scope

### Project creation workflow

**For organization projects:**

1.  Navigate to your organization's main page on GitHub
2.  Click **Projects** in the organization navigation
3.  Select **New project** dropdown → **New project**
4.  Choose appropriate project template based on workflow needs

**For user projects:**

1.  Click your avatar → **Your projects**
2.  Select **New project** dropdown → **New project**
3.  Select template that aligns with project goals

**Project template selection guide:**

| **Template**     | **Use Case**                            | **Key Features**                    |
| ---------------- | --------------------------------------- | ----------------------------------- |
| **Team backlog** | Sprint planning, feature development    | Story points, sprint cycles         |
| **Feature**      | Product roadmap, release planning       | Milestones, dependencies            |
| **Bug triage**   | Issue management, quality assurance     | Severity, priority, status tracking |
| **Blank**        | Custom workflows, specialized processes | Full customization flexibility      |

:::image type="content" source="../media/new-project-beta-38cd122d-88b048f8-0763326c.png" alt-text="Screenshot of New GitHub Project (beta) feature.":::

## Project documentation and communication strategy

**README and description best practices:**

1.  Navigate to your project
2.  Click the settings menu (three dots) in the top-right
3.  Select **Settings**
4.  Create comprehensive project documentation:

**Project Description Framework:**

- **Purpose**: Clear statement of project objectives and scope
- **Stakeholders**: Key team members, sponsors, and decision-makers
- **Success criteria**: Measurable outcomes and acceptance criteria
- **Timeline**: Key milestones and delivery expectations

**README Content Structure:**

```markdown
# Project Name

## Overview

Brief description of project goals and context

## Getting Started

Prerequisites and setup instructions

## Workflow Guidelines

- Issue creation and labeling standards
- Review and approval processes
- Communication protocols

## Team Information

Contact details and responsibilities
```

**Example enterprise README template:**

```markdown
# Customer Portal Enhancement Project

## Project Overview

Modernize customer self-service portal to improve user experience and reduce support ticket volume by 30%.

## Key Stakeholders

- **Product Owner**: Name (email@company.com)
- **Tech Lead**: Name (email@company.com)
- **UX Designer**: Name (email@company.com)

## Success Metrics

- Page load time < 2 seconds
- User satisfaction score > 4.2/5
- Support ticket reduction of 30%

## Workflow Standards

- All features require design review before development
- Security review mandatory for user-facing changes
- Performance testing required for all releases
```

:::image type="content" source="../media/github-projects-beta-settings-6b354d9f-a8f1643f-8f0e0f2f.png" alt-text="Screenshot of GitHub Projects settings.":::

## Strategic work item planning and management

### Issue creation and organization strategy

**Initial project setup workflow:**
When your new project initializes, it prompts you to add items. This is your opportunity to establish the project foundation.

**Strategic issue creation approach:**

1. **Start with epics and themes**: Create high-level work items that represent major features or initiatives
2. **Break down into user stories**: Define specific, testable functionality from user perspective
3. **Add technical tasks**: Include infrastructure, testing, and deployment work
4. **Plan dependencies**: Identify blocking relationships and critical path items

**Issue template best practices:**

**Feature Issue Template:**

```markdown
## User Story

As a [user type], I want [functionality] so that [business value].

## Acceptance Criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Definition of Done

- [ ] Code review completed
- [ ] Unit tests written and passing
- [ ] Integration tests updated
- [ ] Documentation updated
- [ ] Accessibility review completed

## Dependencies

- Links to related issues or external dependencies

## Technical Notes

Implementation considerations and architectural decisions
```

Click the plus (+) sign to add more issues systematically based on your project plan.

:::image type="content" source="../media/github-projects-beta-add-issues-33d0a6b6-f724491e-dee11b76.png" alt-text="Screenshot of GitHub Projects list with empty tasks.":::

**Work item hierarchy and organization:**

- **Epics**: Major features or initiatives
- **Features**: Deliverable functionality
- **User Stories**: Specific user-facing capabilities
- **Tasks**: Technical implementation work
- **Bugs**: Defects and issues requiring resolution

### Advanced issue categorization examples

**Labeling strategy for enterprise projects:**

| **Category** | **Labels**                                                              | **Purpose**                        |
| ------------ | ----------------------------------------------------------------------- | ---------------------------------- |
| **Priority** | `priority:critical`, `priority:high`, `priority:medium`, `priority:low` | Resource allocation and scheduling |
| **Type**     | `type:feature`, `type:bug`, `type:technical-debt`, `type:research`      | Work categorization and reporting  |
| **Team**     | `team:frontend`, `team:backend`, `team:qa`, `team:design`               | Ownership and responsibility       |
| **Status**   | `status:blocked`, `status:in-review`, `status:needs-info`               | Workflow state management          |
| **Release**  | `release:v2.1`, `milestone:q1-2024`                                     | Release planning and tracking      |

## Advanced project configuration and governance

### Security and access management

Navigate to project settings by clicking the menu (three dots) in the top-right corner.

**Access control best practices:**

| **Role**      | **Permissions**                           | **Use Cases**                   |
| ------------- | ----------------------------------------- | ------------------------------- |
| **Admin**     | Full project control, settings management | Project owners, tech leads      |
| **Write**     | Create/edit items, manage workflows       | Development team members        |
| **Read**      | View project content, add comments        | Stakeholders, QA team           |
| **No access** | Cannot view project                       | External users, restricted data |

**Enterprise security considerations:**

- Enable two-factor authentication for all project administrators
- Regular access reviews and permission audits (quarterly recommended)
- Integration with enterprise SSO and identity management systems
- Audit logging for compliance and security monitoring

:::image type="content" source="../media/github-projects-beta-settings-access-e302fba5-c82cad81-160370da.png" alt-text="Screenshot of GitHub Projects settings manage access.":::

### Custom fields and workflow configuration

**Strategic custom field design:**

**Business Value Tracking:**

- **Effort estimation**: Story points or time estimates
- **Business priority**: Customer impact or revenue potential
- **Risk assessment**: Technical complexity or dependency risk
- **Compliance requirements**: Security, accessibility, regulatory needs

**Common enterprise custom fields examples:**

| **Field Name**       | **Type** | **Values/Options**               | **Purpose**                       |
| -------------------- | -------- | -------------------------------- | --------------------------------- |
| **Business Value**   | Select   | High, Medium, Low                | Prioritization and ROI analysis   |
| **Effort**           | Number   | 1-13 (Fibonacci sequence)        | Sprint planning and capacity      |
| **Component**        | Select   | Frontend, Backend, Database, API | Technical ownership and expertise |
| **Customer Segment** | Select   | Enterprise, SMB, Individual      | Feature targeting and validation  |
| **Release Target**   | Date     | Specific dates                   | Milestone and dependency planning |

:::image type="content" source="../media/github-projects-beta-settings-custom-field-5094a01a-bf9ce2e0-a62b2d4f.png" alt-text="Screenshot of GitHub Projects settings to create custom fields.":::

**Automation and workflow optimization:**

- Set up automated status transitions based on pull request states
- Configure notifications for critical updates and blockers
- Establish review cycles and approval workflows
- Implement escalation procedures for stalled work items

### Continuous improvement and analytics

**Project health monitoring:**

- Track velocity trends and team capacity utilization
- Monitor cycle time from issue creation to completion
- Identify bottlenecks and process improvement opportunities
- Regular retrospectives and workflow adjustments

**Integration checkpoints:**

- Weekly project sync meetings with stakeholder updates
- Monthly process review and optimization sessions
- Quarterly strategic alignment and goal assessment
- Annual project governance and security audits

For more information about Projects, see:

- [Quickstart for projects - GitHub Docs](https://docs.github.com/issues/trying-out-the-new-projects-experience/quickstart).
- [Creating an issue - GitHub Docs](https://docs.github.com/issues/tracking-your-work-with-issues/creating-an-issue).
