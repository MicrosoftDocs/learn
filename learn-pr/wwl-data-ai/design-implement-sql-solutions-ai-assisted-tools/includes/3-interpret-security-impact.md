Before enabling AI-assisted tools in your database development environment, you need to understand the security implications. GitHub Copilot and Fabric Copilot process code, database schemas, and potentially sensitive data patterns, making security awareness essential for responsible adoption.

## How AI assistants process your data

When you use GitHub Copilot or Fabric Copilot, your prompts and code context are sent to cloud-based AI models for processing. Understanding what data flows to these services helps you make informed decisions about where and how to use AI assistance.

**GitHub Copilot** transmits the following data to generate suggestions:
- The code you're currently writing or editing
- Content from open files in your editor that provide context
- Database schema information when connected to a database
- Your natural language prompts and questions

**Fabric Copilot** processes similar data within the context of your Fabric workspace, including metadata about your lakehouses, warehouses, and semantic models.

> [!NOTE]
> Both GitHub Copilot and Fabric Copilot are designed to protect your data. Prompts and responses are not used to train the underlying AI models, and data is encrypted in transit and at rest.

## Organizational policy considerations

Your organization might have specific policies about AI tool usage, especially when working with sensitive data. Before enabling AI-assisted tools, consider these questions:

**Data classification**: Does your database contain personally identifiable information (PII), financial records, healthcare data, or other regulated information? Some organizations restrict AI tool usage for databases containing sensitive data classifications.

**Compliance requirements**: Are you subject to any compliance frameworks? Review whether using cloud-based AI services aligns with your compliance obligations.

**Intellectual property**: Does your organization have policies about code or schema information being processed by external AI services? Some proprietary database designs might be considered trade secrets.

**Access controls**: Who in your organization should have access to AI-assisted tools? You might need to align AI tool licensing with existing database access permissions.

## GitHub Copilot security features

GitHub Copilot includes several security features that help protect your organization:

**Content filtering**: Copilot filters suggestions to avoid generating potentially harmful code patterns, including SQL injection vulnerabilities and other security anti-patterns.

**Organization policies**: Enterprise administrators can configure policies that control how Copilot is used across the organization, including which repositories can use Copilot and whether suggestions can include code that matches public repositories.

**Audit logging**: Organizations using GitHub Enterprise Cloud can track Copilot usage through audit logs, providing visibility into how the tool is being used.

For detailed information about GitHub Copilot's security practices, review the official [GitHub Copilot in SSMS documentation](/ssms/github-copilot/overview?azure-portal=true).

## Protecting credentials and connection strings

One critical security practice is ensuring that AI tools never see your database credentials directly. Follow these guidelines:

- **Never paste credentials into prompts**: Don't ask the AI assistant to help with connection strings that contain actual passwords or keys
- **Use environment variables**: Store connection information in environment variables rather than hardcoding in files the AI can see
- **Review before committing**: Check AI-generated code for any accidentally included sensitive information before committing to source control

```sql
-- AVOID: Hardcoded credentials in AI-visible files
-- This pattern should never appear in your code
-- CREATE LOGIN username WITH PASSWORD = 'actual_password';

-- RECOMMENDED: Use parameterized approaches
-- CREATE LOGIN username WITH PASSWORD = $(password);
```

## Evaluating AI suggestions critically

AI-generated code requires the same security review as any code entering your database environment. Consider these practices:

**Review permissions**: When Copilot suggests `GRANT` or `REVOKE` statements, verify the permissions align with your least-privilege security model.

**Validate dynamic SQL**: AI-generated dynamic SQL might be vulnerable to injection if not properly parameterized. Always check for appropriate use of `sp_executesql` with parameters.

**Check data exposure**: Review `SELECT` statements to ensure they don't inadvertently expose more data than intended, especially in views or stored procedures that might be used by applications.

> [!TIP]
> Treat AI-generated code as a first draft that requires human review. The assistant optimizes for functionality and common patterns, but you know your specific security requirements.

## MCP server security considerations

When configuring Model Context Protocol (MCP) servers, you establish direct connections between AI assistants and your databases. This requires careful attention to security:

**Authentication**: MCP connections should use the principle of least privilege. Create dedicated service accounts with read-only access when the AI only needs to query schema information.

**Network security**: Consider whether MCP traffic should traverse public networks. For sensitive environments, you might require private endpoints or VPN connections.

**Data sampling**: Some MCP configurations allow sampling data to improve suggestions. Understand what data might be transmitted and whether this aligns with your data handling policies.

Understanding these security considerations prepares you to implement AI-assisted tools in a way that aligns with your organization's security posture. The next unit guides you through the actual process of enabling GitHub Copilot and Fabric Copilot with security best practices in mind.
