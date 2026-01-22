A specification defines what you need to build. A technical plan defines how you build it. This unit covers advanced planning techniques for enterprise brownfield scenarios.

## Review plan fundamentals

The plan.md file serves as your design document, bridging the gap between high-level requirements in spec.md and the concrete implementation tasks that follow. A comprehensive technical plan contains:

- **Architecture overview**: High-level view of how components interact
- **Technology stack and key decisions**: Explicit documentation of technology choices with rationales
- **Implementation sequence**: Logical progression of implementation steps
- **Constitution verification**: Explicit check that proposed solutions comply with project principles
- **Assumptions and open questions**: Documentation of assumptions and unresolved questions

This separation of concerns is fundamental—specifications remain stable and focused on "what," while plans can evolve as you experiment with different "how" approaches. If you later switch technologies, you update plan.md while spec.md remains largely unchanged.

With these fundamentals in mind, let's explore advanced planning considerations for enterprise development.

## Understand the purpose of a technical plan

The plan.md file serves as your design document. It bridges the gap between high-level requirements in spec.md and the concrete implementation tasks that follow. While the specification remains stable and focused on "what," the plan can evolve as you experiment with different "how" approaches.

This separation of concerns is fundamental to spec-driven development. If you later switch from one technology to another—say, moving from Azure Blob Storage to Azure Files—you update plan.md while spec.md remains largely unchanged. The feature requirements aren't changed; only the implementation approach is changed.

For the document upload feature, the specification defines user requirements: file size limits, supported formats, upload feedback, and access controls. The plan translates these requirements into concrete decisions: which Azure storage service to use, how to structure the API, which authentication mechanism to implement, and how to validate files.

## Examine plan structure and content

A comprehensive technical plan contains several key sections that collectively define your implementation approach.

### Architecture overview

The architecture overview provides a high-level view of how components interact. For the document upload feature, the architecture might describe:

"Implement a new back-end API endpoint `/api/documents/upload` to handle multipart file uploads. The React front end includes a new DocumentUpload component with a file picker and progress indicator. When a user selects a file, the front end validates size and type before uploading. The back end receives the file, validates again, stores it in Azure Blob Storage, and records metadata in the SQL database. After successful upload, the front end refreshes the document list to show the new file."

This summary establishes the overall flow without diving into code-level details. It ensures everyone understands the major components and their interactions.

### Technology stack and key decisions

The plan explicitly documents technology choices and rationales. This section prevents future confusion about why specific libraries or services were selected.

Example technology decisions:

- **Back end**: .NET 8 Web API with Azure.Storage.Blobs SDK v12 for blob operations.
- **Front end**: React 18 with Ant Design's Upload component for UI consistency.
- **Authentication**: Use existing Microsoft Entra ID token from portal's authentication context.
- **Storage**: Azure Blob Storage container named `employee-documents`.
- **Database**: Extend existing SQL database with a DocumentMetadata table (columns: Id, UserId, FileName, BlobUrl, UploadDate, FileSize).

Each decision should align with both the specification requirements and the constitution principles. If your constitution mandates "Use Azure services for all cloud resources," the plan explicitly selects Azure Blob Storage and references this principle.

### Implementation sequence

The plan outlines the order of implementation steps. While not as granular as the task list generated later, this sequence provides a logical progression from setup to completion.

A typical implementation sequence for the document upload feature:

1. Database schema update: Create DocumentMetadata table with appropriate indexes and constraints.
1. Back-end API development: Implement POST /api/documents/upload endpoint with file validation, blob storage integration, and metadata persistence.
1. Front-end component creation: Build DocumentUpload component with file selection, client-side validation, and upload progress display.
1. Integration: Wire the front-end component to the back-end API, handle responses, and update the document list.
1. Security hardening: Implement server-side file type validation, size limits, and authentication checks.
1. Error handling: Add comprehensive error messages for client and server-side failures.
1. Testing: Create unit tests for API methods and integration tests for the upload flow.

This sequence ensures that foundational elements (database schema) exist before dependent components (API that writes to the database) are implemented. Each step builds on previous work, reducing the likelihood of integration problems.

### Constitution verification

The plan includes a verification section that explicitly checks proposed solutions against the constitution. This verification prevents architectural drift and ensures consistency with project principles.

If your constitution includes "All data storage must use Azure services" and "APIs must validate inputs on both client and server," the plan verification section confirms:

- "Using Azure Blob Storage satisfies the Azure services requirement."
- "Implementing validation in both React component (client) and .NET API (server) aligns with defense-in-depth security principle."
- "Microsoft Entra ID authentication requirement is met by using existing portal authentication context."

This verification serves as a checkpoint. If the plan proposes something that violates the constitution, the AI typically flags it, or you notice during review. Addressing constitution conflicts in the plan phase prevents rework later.

### Assumptions and open questions

Well-constructed plans document assumptions and unresolved questions. This transparency helps you identify potential issues before implementation begins.

Example assumptions:

- "Assume the Azure Blob Storage container 'employee-documents' exists and is configured for private access."
- "Assume the existing SQL database has sufficient storage capacity for metadata."
- "Assume virus scanning of uploaded files is out of scope for this iteration."

Example open questions:

- "Should administrators have the ability to delete other users' uploaded documents?"
- "Do we need audit logging for all document access attempts?"
- "Should the system send email notifications when documents are uploaded?"

Documenting these assumptions and questions prevents scope creep and ensures stakeholders address important decisions before coding begins. If an assumption proves incorrect during implementation, you can update the plan accordingly.

## Generate a plan using /speckit.plan

GitHub Spec Kit generates plans through the `/speckit.plan` command in GitHub Copilot Chat. This command uses both spec.md and constitution.md as inputs to produce a comprehensive technical design.

Before invoking the command, consider what other context the AI needs. Your existing codebase, technology preferences, and infrastructure constraints all influence the plan. Providing this context upfront produces more accurate and actionable results.

For the document upload feature in an internal employee portal scenario, you might provide context like this:

"The existing portal uses a React front end with a .NET 8 Web API back end. We need to integrate the upload feature into this stack. Use Azure Blob Storage for file persistence. Require Microsoft Entra ID authentication for all upload operations. The portal already has a SQL database available for metadata storage."

This context guides the AI to generate a plan that fits seamlessly into your existing architecture rather than proposing a greenfield solution that doesn't align with your current stack.

### Invoke the planning command

Open GitHub Copilot Chat in Visual Studio Code and enter `/speckit.plan`. If the AI requests more information, provide your architectural context. GitHub Copilot processes the specification, constitution, and your extra context to generate plan.md.

The planning phase might take a moment as the AI considers various approaches, checks them against your constitution, and structures the output into a coherent design document.

## Review and validate the plan

Generating a plan is only the first step. Critical review ensures the plan is accurate, complete, and aligned with your project's needs.

### Verify coverage of specification requirements

Compare the plan against spec.md systematically. Every requirement in the specification should map to an implementation approach in the plan.

For example, if spec.md requires "Display an error message for files exceeding 50 MB," the plan should describe where and how this validation occurs. If the plan omits this validation, either the plan is incomplete or the specification needs clarification.

### Check alignment with technical standards

Ensure the plan's technology choices align with your organization's standards and best practices. If your team standardizes on specific libraries or patterns, the plan should reflect these preferences.

Questions to consider:

- Does the proposed architecture fit with existing systems?
- Are the selected libraries approved for use in your environment?
- Do technology choices comply with organizational security and compliance policies?
- Are there established patterns for similar functionality that should be followed?

For the document upload feature in an Azure environment, verify that Azure Blob Storage is an approved service, that the authentication approach aligns with enterprise identity standards (such as using Microsoft Entra ID), and that the proposed SQL schema follows database naming conventions.

### Validate constitution adherence

The plan should include explicit verification that proposed solutions comply with constitution requirements. Review this verification section carefully to ensure no principles are violated.

If your constitution requires "All secrets must be stored in Azure Key Vault" and the plan proposes storing Azure Storage connection strings in appsettings.json, a conflict exists. The plan should be revised to retrieve connection strings from Key Vault at runtime.

Constitution violations discovered during planning are easy to fix. Constitution violations discovered during code review or production deployment are costly and disruptive.

## Iterate and refine the plan

Plans often require refinement after initial generation. Don't expect perfection on first try. Use GitHub Copilot's clarification capabilities to improve plan quality.

### Address ambiguities and gaps

If the plan contains vague statements like "implement appropriate error handling," press for specifics. What errors might occur? How should each error be handled? What error information should be logged versus displayed to users?

Use GitHub Copilot Chat to ask follow-up questions: "What specific errors should the upload endpoint handle?" or "What should happen if Azure Blob Storage is unavailable?" The AI can expand vague sections into concrete specifications.

### Validate technical feasibility

Verify that the proposed architecture is technically feasible given your constraints. If the plan proposes uploading 50-MB files synchronously through a Web API with a 30-second timeout, a problem exists. Files that are over 50 MB might require chunked uploads or increased timeouts.

Consult with team members who have relevant expertise. If the plan proposes database schema changes, review with a database administrator. If it requires new Azure resources, verify with infrastructure engineers that provisioning is possible.

### Consider nonfunctional requirements

Ensure the plan addresses nonfunctional requirements from the specification: performance, security, scalability, maintainability, accessibility.

For document upload, confirm the plan includes:

- **Performance**: How quickly should an upload complete? What's the maximum concurrent upload volume?
- **Security**: How are files scanned for malware? How is access controlled? Where are audit logs stored?
- **Scalability**: How does the system handle increased upload volume? What are storage capacity limits?
- **Maintainability**: How are uploaded files cleaned up when employees leave the organization?
- **Accessibility**: Does the upload UI meet Web Content Accessibility Guidelines (WCAG) 2.1 AA standards?

If the plan omits any of these considerations, add them explicitly. Nonfunctional requirements frequently become after thoughts during implementation if they're not addressed in planning.

### Assess feasibility and completeness

Evaluate whether the plan provides sufficient guidance for implementation. Plans that are too vague ("Implement file upload") aren't helpful. Plans that are too prescriptive ("Use exactly 47 lines of code") are overly constraining.

The right level of detail provides clear direction without removing all flexibility. The plan should answer:

- What components need to be created or modified?
- How do these components interact?
- What technologies and libraries are used?
- What's the implementation order?
- What verification steps ensure correctness?

If you can't envision how to implement the feature from the plan, it needs more detail. If the plan feels like it's writing the code for you, it might be too detailed.

### Identify missing elements

Look for gaps in the plan. Common omissions include:

- **Error handling**: How does the system handle network failures, storage errors, or database issues?
- **Performance considerations**: Are there any concerns about upload speed, concurrent users, or storage limits?
- **Testing strategy**: What tests need to be written to validate the implementation?
- **Rollback approach**: If deployment causes issues, how do you revert changes?

Address these gaps by manually editing plan.md or providing more context and regenerating relevant sections.

### Regenerate with refined context

If the initial plan misses the mark, provide more specific context and regenerate. For example, if the plan suggests using a new database but you need to use an existing one, clarify: "Use the existing EmployeePortal database. Add a DocumentMetadata table to this database rather than creating a new one."

Regenerate the plan with `/speckit.plan` incorporating this updated context. The AI adjusts the approach accordingly.

### Manually edit the plan

Since plan.md is a Markdown file, you can edit it directly. If the AI suggests an approach that's 90% correct but needs minor adjustments, edit the file rather than regenerating everything.

For instance, if the plan proposes a specific blob container name but your organization has naming conventions, update the container name in plan.md directly.

### Collaborate with team members

In team environments, share plan.md for review. A senior developer or architect can validate architectural decisions before implementation begins. This peer review catches issues that automated checks might miss.

Team review also builds shared understanding. When multiple developers work on a feature, reviewing the plan together ensures everyone knows the approach and can identify potential conflicts with other ongoing work.

## Document architectural decisions

Plans should document not just what you'll build, but why you made specific architectural choices to help future developers understand decision context.

### Record alternatives considered

When you're choosing between multiple viable approaches, document the alternatives you considered and why you selected one over others.

For file storage, you might consider three approaches:

- **Azure Blob Storage**: Selected for cost-effectiveness, scalability, and integration with existing Azure environment.
- **Azure Files**: Rejected due to higher cost for large file storage and unnecessary Server Message Block (SMB) protocol overhead.
- **SQL Database FILESTREAM**: Rejected to avoid increasing database size and complexity.

This documentation prevents future developers from questioning why simpler approaches weren't used. The decision rationale is preserved rather than lost to time.

### Capture assumptions

Plans make assumptions about existing systems, infrastructure, and organizational constraints. Make these assumptions explicit.

Example assumptions for document upload:

- Azure Blob Storage container `employee-documents` is provisioned by infrastructure team before development begins.
- Existing portal authentication provides validated Microsoft Entra ID tokens that can be trusted for user identification.
- SQL database has sufficient capacity for another metadata table without requiring storage expansion.
- Network infrastructure supports 50-MB HTTP uploads without proxy or firewall restrictions.

If any assumption proves incorrect during implementation, you can revisit the plan and adjust accordingly. Documented assumptions make impact analysis straightforward when circumstances change.

### Plan for future evolution

Consider how the feature might evolve and ensure your architecture accommodates likely extensions.

For document upload, potential future requirements might include:

- Supporting other file types beyond PDF and DOCX.
- Implementing file sharing between employees.
- Adding document versioning.
- Enabling bulk uploads of multiple files.
- Integrating virus scanning

If your architecture makes these extensions difficult, consider whether adjusting the initial design is warranted. You don't implement future features now, but you avoid painting yourself into corners that make future changes painful.

## Share and maintain the plan during implementation

The plan becomes your reference throughout implementation. Developers should consult the plan regularly to ensure their code aligns with the documented architecture.

### Share the plan with stakeholders

After finalizing the plan, share it with relevant stakeholders for validation:

- **Product managers**: Verify the plan delivers all specification requirements.
- **Security team**: Confirm security controls meet organizational standards.
- **Infrastructure team**: Ensure proposed Azure resources can be provisioned and configured.
- **Architecture team**: Validate alignment with organizational architecture principles.

This stakeholder review catches issues before implementation begins. If security team feedback reveals that proposed authentication is insufficient, you update the plan before writing code.

### Update the plan as needed

Plans are living documents. When you discover during implementation that an approach doesn't work as intended, update the plan to reflect the new approach.

If you planned to store upload progress in browser localStorage but discover this causes issues in private browsing mode, update the plan to use in-memory state instead. Document why the change was necessary so the reasoning is preserved.

Keep plan.md synchronized with actual implementation. When plan and code diverge, the plan loses value as reference documentation.

- Do the security approaches meet organizational requirements?
- Is the database schema design following naming conventions?

If the plan suggests using a database but your existing portal already has one, that's likely overkill. If the plan proposes a technology your team avoids, document why or adjust the plan.

## Common planning pitfalls to avoid

Avoid these common mistakes when creating and reviewing plans:

- **Skipping the planning phase**: Jumping directly from specification to code without a plan increases the risk of architectural mistakes. The time invested in planning pays dividends by preventing rework.

- **Accepting plans without review**: AI-generated plans are starting points, not final designs. Always review critically and verify against your specific context.

- **Over-constraining implementation**: Plans should guide, not dictate every detail. Leave room for developers to make appropriate tactical decisions during implementation.

- **Ignoring constitution conflicts**: If the plan violates constitution principles, address the conflict immediately. Either adjust the plan to comply or update the constitution if the principle needs revision.

- **Forgetting to update plans**: When implementation reveals new information, update plan.md. Stale plans mislead future developers and reduce the value of your documentation.

## Summary

The technical plan transforms your specification into actionable architecture. Generate plans using `/speckit.plan` with appropriate context about your technology stack and infrastructure. Review plans critically to ensure they cover all specification requirements, align with your constitution, and provide sufficient implementation guidance. Use the validated plan to guide task generation and implementation. Treat plan.md as a living document that evolves with your understanding and provides valuable context for the entire development lifecycle.
