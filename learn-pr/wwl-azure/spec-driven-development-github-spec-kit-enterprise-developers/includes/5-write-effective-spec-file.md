The specification file (`spec.md`) is the single source of truth for what your software should do. This unit covers advanced techniques for writing enterprise-grade specifications.

## Review spec fundamentals

In spec-driven development, the specification defines exactly what the software should do, and every implementation decision traces back to it. A well-structured specification includes:

- **Summary**: Concise description of the application (or new feature) from an end-user perspective.
- **User stories**: Brief narratives of how users interact with the application.
- **Acceptance criteria**: Specific, testable conditions that must be true for completion.
- **Functional requirements**: Detailed descriptions of system behavior.
- **Nonfunctional requirements**: Quality attributes like performance, security, and scalability.
- **Edge cases**: Unusual scenarios, error conditions, and boundary behaviors.

## The spec as the single source of truth

In spec-driven development, the specification defines exactly what the software should do, and every implementation decision traces back to it. If functionality doesn't appear in the spec, it doesn't appear in the final product unless someone updates the spec and regenerates artifacts.

This approach represents a mindset shift: writing the spec is as important as writing code. The spec isn't a formality to satisfy project management—it's the artifact that drives AI code generation. Invest the same care in crafting specs as you would in implementing features manually.

Think of the spec as executable documentation. When you modify requirements, you update the spec and regenerate the plan and tasks. The spec, which is version-controlled in Git, becomes the authoritative record of what each feature should accomplish.

For enterprise developers accustomed to agile workflows, the spec serves the same purpose as detailed user stories and acceptance criteria, but with machine-readable structure that AI assistants can consume directly.

## Specification structure

GitHub Spec Kit organizes specifications into standardized sections that cover functional behavior, quality requirements, and edge cases.

### Summary section

A concise description of the feature from an end-user perspective. This section should answer "What does this feature do?" in one or two sentences.

For example:

```markdown
## Summary

This feature enables employees to upload PDF and DOCX documents to their personal dashboard. Files are stored securely in Azure Blob Storage and appear in the user's document list immediately after upload.
```

The summary provides high-level context. Someone unfamiliar with the project should understand the feature's purpose after reading this section.

### User stories section

Brief narrative descriptions of how users interact with the feature. User stories capture intent and value rather than technical implementation.

For example:

```markdown
## User Stories

As an employee, I want to upload documents to my dashboard so that I can access them from any device.

As an employee, I want to see upload progress for large files so that I know the system is processing my request.

As a system administrator, I want uploads to be logged so that we can audit file activity for compliance purposes.
```

User stories help AI assistants understand the human motivations behind features, leading to more intuitive implementations.

### Acceptance criteria section

Specific, testable conditions that must be true for the feature to be considered complete. The acceptance criteria form a checklist for verifying implementation.

For example:

```markdown
## Acceptance Criteria

- User can select PDF or DOCX files for upload
- Maximum file size is 50MB
- Files larger than 50MB display an error message
- Unsupported file types display an error message
- Successfully uploaded files appear in the document list within 2 seconds
- Upload progress is displayed for files larger than 1MB
- Only users with 'Contributor' role can upload documents
- Uploaded files are stored in user-specific folders in Azure Blob Storage
```

Write acceptance criteria as observable facts. Avoid vague statements like "system is responsive"—instead specify "API responds within 200 ms."

### Functional requirements section

Detailed descriptions of system behavior. Functional requirements elaborate on how the feature works.

For example:

```markdown
## Functional Requirements

### Upload interface
- Dashboard displays an "Upload Document" button in the documents section
- Clicking "Upload Document" opens a file selection dialog
- User selects a file from their local filesystem
- System validates file type and size before initiating upload

### Upload process
- Files are uploaded via multipart HTTP POST to /api/documents endpoint
- Upload includes file content and metadata (filename, size, content type)
- Server validates authentication token before accepting upload
- Server checks user has 'Contributor' role before processing

### Storage
- Files are stored in Azure Blob Storage container 'employee-documents'
- Storage path follows pattern: {userId}/{fileId}/{filename}
- Server generates unique file ID to prevent naming collisions
- File metadata (original filename, upload timestamp, user ID) stored in Azure SQL Database

### User feedback
- Upload progress bar updates every 10% completion
- Success message displays upon completion: "Document uploaded successfully"
- Error messages display for: file too large, unsupported type, network error, server error
```

Functional requirements provide enough detail for AI to generate appropriate implementations without prescribing exact code structure.

### Nonfunctional requirements section

Quality attributes like performance, security, scalability, and compliance. These requirements often reference the constitution.

For example:

```markdown
## Non-Functional Requirements

### Performance
- File uploads under 5MB complete within 5 seconds on typical network
- Upload progress updates display with less than 100ms latency
- Document list refresh completes within 1 second after upload

### Security
- All uploads require valid Microsoft Entra ID authentication token
- HTTPS/TLS 1.2 enforced for all data transmission
- Files scanned for malware before storage (future enhancement)
- No sensitive data logged (filenames logged, content never logged)

### Scalability
- Support concurrent uploads (up to 5 simultaneous per user)
- Handle 1000 concurrent users uploading files

### Compliance
- Audit log records: user ID, filename, timestamp, file size, IP address
- Audit logs retained for 90 days minimum
- Support data deletion requests within the specified timeline
```

Nonfunctional requirements ensure AI-generated code meets enterprise quality standards, not just functional correctness.

### Edge cases section

Unusual scenarios, error conditions, and boundary behaviors. Explicitly documenting edge cases prevents AI from making assumptions.

For example:

```markdown
## Edge Cases

### Network interruption during upload
- If connection drops, display error: "Upload failed due to network error. Please retry."
- No partial files stored in Azure Blob Storage
- User can retry upload from beginning

### Duplicate filename
- System allows duplicate filenames by generating unique file IDs
- User sees original filename in document list
- Back end uses unique IDs to prevent overwrites

### Storage capacity limits
- If Azure Blob Storage quota exceeded, display error: "Upload failed due to storage limit. Contact support."
- Log storage errors for administrator notification

### Concurrent uploads by same user
- System supports up to 5 simultaneous uploads per user
- Sixth concurrent upload queued until one completes
- Progress bars update independently for each upload

### File type detection
- System validates file type by MIME type, not just extension
- File with .pdf extension but non-PDF content rejected
- Error message: "File appears corrupted or has incorrect type"
```

Thinking through edge cases during specification prevents bugs that would otherwise emerge during implementation or testing.

## Create a specification with GitHub Spec Kit

 Writing effective specifications is easier with GitHub Spec Kit's `/speckit.specify` command.

GitHub Spec Kit generates specification drafts based on natural language descriptions, accelerating spec creation while maintaining consistent structure.

### Invoke the specify command

To create a specification:

1. Open your project in Visual Studio Code.
1. Open GitHub Copilot Chat, and then run the `/speckit.specify` command with a prompt describing the feature you want to create.

    For example:

    ```plaintext
    /speckit.specify Create a new document upload feature. The feature should allow employees to upload PDF or DOCX documents through the web dashboard. Files are stored in Azure Blob Storage under the user's account folder. After upload, the file appears in the user's document list. Only users with 'Contributor' role can upload. Maximum file size is 50MB. Show error messages for oversized files or unsupported types. Display upload progress for files larger than 1MB.
    ```

    This description covers:
    - What: Upload PDF/DOCX documents
    - Where: Web dashboard interface
    - How: Stored in Azure Blob Storage
    - Who: Users with Contributor role
    - Constraints: 50-MB limit, specific file types
    - User experience: Progress display, error messages

GitHub Copilot generates a structured `spec.md` file based on this input, creating sections for summary, acceptance criteria, requirements, and edge cases.

### Review the generated spec

After GitHub Copilot generates the spec, open `spec.md` and verify:

- **Completeness**: Does the spec cover all requirements you mentioned? If you specified "only PDF and DOCX," confirm acceptance criteria list those file types.

- **Accuracy**: Are details correct? If you said 50-MB limit, verify the spec states 50 MB, not a different value.

- **Consistency**: Do different sections align? If summary mentions progress display, acceptance criteria should include it.

- **Missing elements**: What did GitHub Copilot infer or omit? Review generated requirements to see if the AI made assumptions you disagree with.

The initial spec is a strong starting point but rarely perfect. Expect to refine it through clarification.

## Refining specifications with /speckit.clarify

The `/speckit.clarify` command analyzes your specification and identifies ambiguities, gaps, or assumptions requiring clarification.

### Ensure spec clarity

Ambiguities in specifications lead to incorrect implementations. Use `/speckit.clarify` to surface unclear areas.

After generating an initial spec:

1. In GitHub Copilot Chat, run:

    ```plaintext
    /speckit.clarify
    ```

1. GitHub Copilot analyzes `spec.md` and asks questions about unclear or missing details

    Example clarification questions:

    ```markdown
    I've analyzed the specification and have some questions:
    
    1. File retention: How long should uploaded documents be retained? Forever, or is there a retention policy?
    
    2. Duplicate filenames: If a user uploads a file with the same name as an existing file, should the system:
        - Overwrite the existing file
        - Create a new version
        - Reject the upload with an error
        - Store both with unique identifiers
    
    3. Virus scanning: Should uploaded files be scanned for malware? If so, when—before storage or asynchronously after upload?
    
    4. Download capability: The spec describes upload but doesn't mention download. Should users be able to download their uploaded documents?
    
    5. File sharing: Can users share documents with other employees, or are documents private to the uploader?
    ```

These questions help you to make decisions about aspects that you might have missed initially.

### Answer clarification questions

Respond to each question with specific decisions:

```markdown
1. File retention: Retain documents indefinitely until user deletes them. No automatic deletion.

2. Duplicate filenames: Option d - Store both with unique identifiers. Users can have multiple files with the same name. Display upload timestamp to distinguish them in the list.

3. Virus scanning: Not required for initial release. Mark as future enhancement in the spec.

4. Download capability: Yes, users should be able to download their documents. Add this to the spec.

5. File sharing: Documents are private to the uploader for this release. Sharing is a future feature.
```

After you answer, GitHub Copilot updates `spec.md` to incorporate your decisions:

- Acceptance criteria gains: "Users can download previously uploaded documents."
- Functional requirements add download endpoint specification.
- Edge cases include: "Multiple files with identical names distinguished by upload timestamp."
- Nonfunctional requirements note: "Virus scanning deferred to future release."

### Iterate until complete

Run `/speckit.clarify` multiple times if needed. Each iteration refines the spec further:

- First pass: Major functionality gaps.
- Second pass: Edge case details.
- Third pass: Fine-tuning nonfunctional requirements.

Stop when GitHub Copilot has no more questions or only asks about features you want to defer.

## Best practices for specification writing

Writing clear, unambiguous specifications is key to successful spec-driven development.

### Be specific and measurable

Replace vague terms with precise values:

- Not: "Support large files."
- Instead: "Support files up to 50 MB."

- Not: "Fast upload performance."
- Instead: "Uploads under 5 MB complete within 5 seconds on 10-Mbps connection."

Specific requirements enable AI to generate implementations that meet your actual needs.

### Use consistent terminology

Define terms once and reuse them throughout the spec. If you call them "documents" in the summary, don't switch to "files" or "attachments" later. Inconsistent terminology confuses both humans and AI.

For enterprise internal projects, use official product names and terminology from your organization's standards.

### Cover error handling explicitly

Don't assume AI handles errors appropriately. Specify what happens when operations fail:

- "If Azure Blob Storage is unreachable, display error: 'Unable to connect to storage service. Try again later.'"
- "If user lacks required role, return HTTP 403 with message: 'You don't have permission to upload documents.'"

Explicit error handling prevents AI from implementing generic error messages that don't help users.

### Maintain appropriate scope

If a feature requires more than 300 lines to specify, consider splitting it into multiple specs:

- Instead of one "Document Management System" spec.
- Create separate specs: "Document Upload," "Document Download," "Document Sharing," and "Document Search."

Smaller specs are easier to review, clarify, and implement. They also align with incremental delivery practices.

### Detail "what," not "how"

Specifications define requirements, not implementations. State what the system should do, not how to code it:

- Spec: "Store uploaded files in Azure Blob Storage."
- Not in spec: "Use the Azure.Storage.Blobs NuGet package with BlobContainerClient class."

Implementation decisions belong in the plan phase. However, if the constitution mandates specific technologies, referencing them in the spec is appropriate.

### Validate against the constitution

Before finalizing a spec, verify it doesn't conflict with project principles:

- Constitution requires Microsoft Entra ID authentication → Spec must specify Microsoft Entra ID, not custom auth.
- Constitution mandates 90-day audit retention → Spec must include audit logging requirements.
- Constitution limits max file size to 50 MB → Spec can't require 1-GB file support.

Inconsistencies caught during specification are far cheaper to fix than after implementation.

The completed specification becomes your contract with GitHub Copilot. When you proceed to the planning phase, GitHub Copilot references this spec to design technical implementations that precisely match your requirements. The time invested in thorough specification pays dividends throughout development.

## Summary

Writing effective specifications is foundational to successful spec-driven development. A well-structured spec serves as the single source of truth, guiding AI code generation and ensuring alignment with project principles. By using GitHub Spec Kit's `/speckit.specify` and `/speckit.clarify` commands, you can rapidly create and refine detailed specifications that cover functional behavior, quality attributes, and edge cases. Following best practices in specification writing enhances clarity, reduces ambiguity, and leads to implementations that meet both user needs and enterprise standards.
