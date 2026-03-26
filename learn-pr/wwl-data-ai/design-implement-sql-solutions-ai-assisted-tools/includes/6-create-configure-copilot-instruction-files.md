Custom instruction files provide a way to guide GitHub Copilot's behavior consistently across your projects and team. Instead of repeating the same context in every prompt, you define your preferences, coding standards, and project-specific guidance in files that Copilot reads automatically.

## What are custom instruction files?

Custom instruction files are markdown documents that contain guidance for GitHub Copilot. When you place these files in specific locations, Copilot includes their contents as context when generating suggestions. This means you can influence how Copilot responds without modifying each prompt.

:::image type="content" source="../media/structure.png" alt-text="Diagram showing a repository folder structure with a .github folder containing copilot-instructions.md and a prompts subfolder with .prompt.md files.":::

There are two main types of instruction files:

- **Repository instructions** (`copilot-instructions.md`): Apply to everyone working in a specific repository. Stored in the `.github` folder at the repository root.

- **Prompt files** (`.prompt.md`): Reusable prompts for specific tasks or scenarios. Stored in the `.github/prompts` folder and can be referenced in chat conversations.

## Create a repository instruction file

To [create custom instructions for your repository](/visualstudio/ide/copilot-chat-context?azure-portal=true), follow these steps:

1. Navigate to your repository root folder
2. Create a `.github` folder if it doesn't exist
3. Create a file named `copilot-instructions.md`
4. Add your instructions in markdown format

Here's an example instruction file for a database project:

```markdown
# Project Guidelines for Copilot

## Database Development Standards

This project uses SQL Server 2022 with the following conventions:

### Naming Conventions
- Tables: PascalCase, singular (Customer, OrderDetail)
- Columns: PascalCase (FirstName, OrderDate)
- Stored procedures: usp_ActionEntity (usp_GetCustomerOrders)
- Views: vw_EntityName (vw_ActiveCustomers)
- Indexes: IX_TableName_ColumnName

### T-SQL Style
- Use explicit column lists in SELECT statements (avoid SELECT *)
- Always include schema prefix (dbo.TableName)
- Use ANSI JOIN syntax, not comma-separated tables
- Include error handling in all stored procedures
- Use TRY...CATCH blocks for data modification operations

### Security Requirements
- Never generate GRANT statements to public
- Use parameterized queries, never concatenate user input
- Avoid dynamic SQL when possible

### Performance Guidelines
- Suggest appropriate indexes when creating tables
- Prefer SET NOCOUNT ON in stored procedures
- Use EXISTS instead of COUNT for existence checks
```

When Copilot generates T-SQL code in this repository, it considers these guidelines and produces suggestions that align with your standards.

## Configure instruction file settings

In Visual Studio and VS Code, you can configure how Copilot uses instruction files:

**In VS Code:**
1. Open Settings (**Ctrl+,**)
2. Search for "GitHub Copilot: Instructions"
3. Configure which instruction files to include automatically

**In Visual Studio:**
1. Go to **Tools** > **Options**
2. Navigate to **GitHub** > **Copilot**
3. Configure custom instruction preferences

You can also reference instruction files explicitly in chat using the Command Palette (**Ctrl+Shift+P**) and selecting **Chat: Configure Instructions**.

## Create reusable prompt files

Prompt files let you define templates for common tasks. For database development, you might create prompts for:

- Generating stored procedure templates
- Creating data migration scripts
- Reviewing query performance
- Documenting existing code

To create a prompt file:

1. Create a `.github/prompts` folder in your repository
2. Create a file with `.prompt.md` extension
3. Define the prompt template with any required parameters

Example prompt file for creating a stored procedure (`create-procedure.prompt.md`):

```markdown
# Create Stored Procedure

Generate a stored procedure with the following specifications:

- Procedure name: {{procedureName}}
- Purpose: {{description}}
- Parameters: {{parameters}}

Follow these requirements:
- Include TRY...CATCH error handling
- Add SET NOCOUNT ON at the beginning
- Include appropriate comments
- Follow our naming conventions (usp_ prefix)
- Use explicit transactions for data modifications
```

To use this prompt in VS Code, reference it in the chat panel with the `#` symbol or through the prompt picker.

## Team-wide instruction strategies

For enterprise teams, consider these approaches to instruction file management:

- **Centralized standards**: Maintain a master instruction file in a shared repository that gets copied or linked to project repositories.

- **Layered instructions**: Use organization-level instructions for general standards, with repository-specific additions for project requirements.

- **Version control**: Track instruction file changes in git so you can review how your AI guidance evolves over time.

> [!TIP]
> Review your instruction files periodically. As your team's practices evolve or as Copilot improves, you might need to adjust your guidance.

## Best practices for instruction files

To get the most out of custom instruction files, follow these best practices:

**Be specific**: Vague instructions produce vague results. Instead of "use good naming," specify your exact naming pattern.

**Provide examples**: Show Copilot what you want rather than just describing it. Include code snippets that demonstrate your preferred patterns.

**Prioritize**: Put your most important guidelines first. Copilot considers the full context, but prominent placement helps ensure critical rules are followed.

**Test iteratively**: After creating instruction files, test various prompts to see if Copilot follows your guidance. Adjust wording if results aren't as expected.

**Keep current**: Update instructions when your standards change. Outdated guidance leads to inconsistent suggestions.

Example of a specific, example-driven instruction:

```markdown
## Error handling pattern

Always use this error handling pattern in stored procedures:

```sql
CREATE PROCEDURE dbo.usp_ExampleProcedure
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Procedure logic here
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        -- Log error details
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
```

This pattern includes explicit transaction handling and proper error propagation.
```

With well-crafted instruction files, your team gets consistent AI assistance that aligns with your coding standards and project requirements. The next unit covers connecting to MCP server endpoints to enhance this guidance with live database context.
