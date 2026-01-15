---
applyTo: '**'
---
## Microsoft Documentation and Code Samples

You have access to specialized tools for retrieving official Microsoft documentation and code samples:

- `microsoft_docs_search` - Search Microsoft Learn and official documentation
- `microsoft_docs_fetch` - Retrieve complete documentation pages
- `microsoft_code_sample_search` - Find official code examples and implementation patterns

### When to Use These Tools

Use these tools when working with Microsoft technologies, Azure services, or .NET frameworks to:

- Verify current API syntax, parameters, and best practices
- Access the latest product features when relevant to the context of the training objectives and updates beyond your training data
- Retrieve official code examples and implementation patterns
- Reference authoritative documentation for complex or specific technical scenarios

Always prioritize these official sources for Microsoft-specific content to ensure accuracy and currency of information.

### Creating Microsoft Learn Training Content

When asked to create, update, or review content for Microsoft Learn modules, units, or learning paths—especially for the following modules or similar training content:

**Always consult the [Microsoft Learn training content guidelines](https://learn.microsoft.com/en-us/help/learn/?azure-portal=true) when creating training content on the Microsoft Learn platform.**

1- Look first on the list below: 
1	learn-wwl.build-ai-solutions-sql-server	Build AI-powered solutions using SQL Server 2025
2	learn.wwl.write-subqueries	Write Subqueries in T-SQL
3	learn.wwl.automl-azure-databricks	Use AutoML in Azure Databricks
4	learn.wwl.deploy-iaas-solutions-with-azure-sql	Deploy IaaS solutions with Azure SQL
5	learn.wwl.deploy-paas-solutions-with-azure-sql	Deploy PaaS solutions with Azure SQL
6	learn.wwl.deep-learning-azure-databricks	Train deep learning models in Azure Databricks
7	learn.wwl.use-built-functions-transact-sql	Use built-in functions and GROUP BY in Transact-SQL
8	learn.wwl.sort-and-filter-queries	Sort and filter results in T-SQL
9	learn.wwl.schedule-tasks-using-sql-server-agent	Create and manage SQL Agent jobs
10	learn.wwl.query-multiple-tables-with-joins	Combine multiple tables with JOINs in T-SQL
11	learn.wwl.protect-data-transit-at-rest	Protect data in-transit and at rest
12	learn.wwl.protecting-monitoring-tuning-migrated-database	Protect, monitor, and tune a migrated database
13	learn-wwl.preprocess-data-with-data-wrangler-microsoft-fabric	Preprocess data with Data Wrangler in Microsoft Fabric
14	learn.wwl.prepare-to-maintain-sql-databases-azure	Prepare to maintain SQL Server-based databases on Azure
15	learn.wwl.modify-data-with-transact-sql	Modify data with T-SQL
16	learn-wwl.perform-post-migration-tasks-azure-sql	Perform post-migration tasks on Azure SQL
17	learn.wwl.mlflow-azure-databricks	Use MLflow in Azure Databricks
18	learn-wwl.migrate-sql-workloads-azure-virtual-machines	Migrate SQL Server workloads to Azure Virtual Machine
19	learn-wwl.migrate-sql-workloads-azure-sql-databases	Migrate SQL Server workloads to Azure SQL Database
20	learn-wwl.migrate-sql-workloads-azure-managed-instances	Migrate SQL Server workloads to Azure SQL Managed Instance
21	learn.wwl.manage-azure-paas-resources-using-automated-methods	Manage Azure PaaS tasks using automation
22	learn.wwl.machine-learning-production-azure-databricks	Manage machine learning in production with Azure Databricks
23	learn.wwl.machine-learning-azure-databricks	Train a machine learning model in Azure Databricks
24	learn.wwl.intro-to-transact-sql	Introduction to Transact-SQL
25	learn.wwl.introduction-open-source-database-migration-azure	Introduction to open-source database migration on Azure
26	learn.wwl.introduction-data-platform-modernization	Design a SQL Server migration strategy
27	learn.wwl.implement-compliance-controls-for-sensitive-data	Implement compliance controls for sensitive data
28	learn.wwl.hyperparameters-azure-databricks	Tune hyperparameters in Azure Databricks
29	learn-wwl.get-started-with-graphql-microsoft-fabric	Get started with GraphQL in Microsoft Fabric
30	learn-wwl.get-started-sql-database-microsoft-fabric	Get started with SQL Database in Microsoft Fabric
31	learn-wwl.get-started-sql-database-application-development	Get started with Azure SQL Database for modern application development
32	learn.wwl.explore-query-performance-optimization	Explore query performance optimization
33	learn-wwl.explore-security-practices-azure-sql-database	Explore security practices for Azure SQL Database
34	learn-wwl.explore-data-for-data-science-microsoft-fabric	Explore data for data science with notebooks in Microsoft Fabric
35	learn-wwl.explore-data-manipulation-azure-sql-database	Explore data manipulation options in Azure SQL Database
36	learn.wwl.explore-iaas-paas-platform-tools-for-ha-dr	Explore IaaS and PaaS solutions for high availability and disaster recovery
37	learn.wwl.explore-performance-based-design	Explore performance-based database design
38	learn.wwl.evaluate-strategies-for-migrating-to-azure-sql	Evaluate strategies for migrating to Azure SQL
39	learn.wwl.evaluate-performance-improvements	Evaluate performance improvements
40	learn-wwl.develop-azure-sql-database	Develop for Azure SQL Database
41	learn-wwl.develop-data-api-azure-sql-database	Develop a data API for Azure SQL Database
42	learn.wwl.describe-high-availability-disaster-recovery-strategies	Describe high availability and disaster recovery strategies
43	learn.wwl.describe-performance-monitoring	Describe performance monitoring
44	learn.wwl.configure-sql-server-resources-for-optimal-performance	Configure SQL Server resources for optimal performance
45	learn.wwl.configure-databases-for-optimal-performance	Configure databases for optimal performance
46	learn.wwl.configure-database-authentication-authorization	Configure database authentication and authorization
47	learn.wwl.configure-automatic-deployment-for-azure-sql-database	Automate database deployment
48	learn.wwl.backup-restore-databases	Back up and restore databases
49	learn.wwl.assess-sql-server-databases-for-migration-to-azure-sql	Assess SQL Server databases for migration to Azure SQL

2. If the content was not found that can be derived, look at other learn modules
3. At the end look at Microsoft Docs to complement or adjust what is needed to maintain relevance

**Always use the Microsoft documentation tools to:**

- Verify syntax, commands, and API signatures are current
- Include accurate code samples from official sources
- Align content with the latest product features and best practices
- Validate technical accuracy against authoritative documentation
- Ensure consistency with Microsoft's terminology and conventions

This ensures training content reflects the most up-to-date information and maintains alignment with official Microsoft guidance.
## Writing Developer-Focused Insights for Unit Introductions

When creating or updating the introduction of a unit or when presenting an important concept, include a paragraph that reveals a non-obvious, practical truth that developers often discover too late. This insight should:

**Format and tone:**
- Write as a flowing paragraph (not bullet points)
- Start with phrases like "Here's what many developers discover too late:" or "What's rarely discussed but critical:"
- Use conversational, direct language that speaks to real developer pain points

**Content focus:**
- Highlight the **permanence and consequences** of the decisions being taught (e.g., "these choices are harder to change than application code")
- Contrast with **application development patterns** developers already know (e.g., "while you can refactor a C# class, changing this database object requires...")
- Reveal **hidden costs of wrong choices** (e.g., "choosing X when you need Y forces workarounds in your application tier")
- Explain **why retrofitting is difficult** (e.g., "these aren't features you can add later—they fundamentally change how data is stored at the engine level")
- Show **architectural implications** beyond the immediate technical feature

**What to avoid:**
- Generic statements about "best practices" or "performance"
- Information that's already obvious from documentation
- Marketing language or feature promotion
- Surface-level observations without depth

**Example prompt to generate such insights:**
"What's a non-obvious truth about [TOPIC] that developers typically discover too late in production? Focus on permanence of decisions, costs of wrong choices, or architectural implications that can't be easily retrofitted."

**Example output (from database object design module):**
"Here's what many developers discover too late: database object design decisions are far more permanent than application code. While you can refactor a C# class or rewrite a microservice with minimal impact, changing a table from rowstore to columnstore, retrofitting temporal history tracking, or switching from IDENTITY to SEQUENCE requires migrations that can lock tables for hours and disrupt production systems. The specialized object types you'll learn in this module—in-memory tables, LEDGER tables, GRAPH structures—aren't just performance optimizations you can add later. They fundamentally change how data is stored, queried, and validated at the engine level. Choosing a standard table when you need temporal auditing means manually building triggers and history tables. Selecting IDENTITY when your architecture needs distributed sequences forces workarounds in your application tier. Understanding these objects upfront lets you design systems that can evolve without painful rewrites, enabling capabilities like blockchain-style verification, millisecond-latency caching, or real-time analytics that can't be retrofitted once you've committed to a different foundation."

## Header Formatting Standards

When creating or updating Microsoft Learn module content, all section headers (## and ### level) must begin with an action verb. This creates clear, learner-focused content that emphasizes what readers will do or understand.

**Action verb examples:**
- Understand, Use, Avoid, Apply, Implement, Create, Configure, Design, Estimate, Prioritize, Explore, Evaluate, Compare, Choose, Monitor, Optimize, Analyze, Build, Deploy, Manage

**Format requirements:**
- ## and ### headers must start with action verbs
- Use imperative mood (command form)
- Keep headers concise (3-7 words typically)

**Examples of correct header formatting:**

✅ **Correct:**
- `### Understand data type implications`
- `### Use columnstore for analytics`
- `### Avoid partitioning when`
- `### Estimate table size impact`
- `## Design best practices`

❌ **Incorrect:**
- `### Why data types matter` (starts with "Why")
- `### When to use indexes` (starts with "When")
- `### Data type considerations` (starts with noun)
- `### Performance implications` (starts with noun)

**Rationale:**
Action-oriented headers provide clear learning objectives and guide readers toward practical application of concepts. They align with Microsoft Learn's learner-centric approach and improve content scannability.

## Text Formatting Guidelines

**Always follow Microsoft Learn's official text formatting guidelines:**
- Consult the [Microsoft Learn text formatting guidelines](https://learn.microsoft.com/en-us/contribute/content/text-formatting-guidelines?azure-portal=true) for all content creation
- Apply consistent formatting for UI elements, code references, file paths, and other technical content
- Follow Microsoft's standards for bold, italic, code formatting, and other text styling
- Ensure proper formatting of links, lists, tables, and other structural elements

This reference should be checked whenever creating or updating Microsoft Learn module content to maintain consistency with Microsoft's documentation standards.

## Unit Formatting Compliance Standards

When creating or updating Microsoft Learn module units, ensure all content adheres to these comprehensive formatting and styling standards. Apply these rules automatically without requiring explicit instruction for each item.

### Documentation Links

**Always use official Microsoft Learn documentation links:**
- Append `?azure-portal=true` parameter to all Microsoft Learn URLs for proper tracking
- Link to official documentation for all features, services, and concepts mentioned
- Verify links are current and point to the most relevant documentation page

**Examples:**
```markdown
[Azure SQL Database Hyperscale](https://learn.microsoft.com/azure/azure-sql/database/service-tier-hyperscale?azure-portal=true)
[In-Memory OLTP](https://learn.microsoft.com/sql/relational-databases/in-memory-oltp/in-memory-oltp-in-memory-optimization?azure-portal=true)
```

### Language and Tone

**Use active voice in sentences:**
- Write in active voice where the subject performs the action
- Avoid gerund forms (verb + -ing) as sentence subjects
- Keep sentences direct and clear

❌ **Avoid passive/gerund constructions:**
- "Choosing appropriate data types affects..." → "Appropriate data types affect..." or "Data types affect..."
- "Understanding table size is important..." → "Table size is important..." or "You must understand table size..."
- "Using columnstore improves..." → "Columnstore improves..." or "Use columnstore to improve..."

✅ **Use active voice:**
- Subject performs the action directly
- Clear actor when relevant ("You", "The database", "The query optimizer")
- Direct, imperative sentences for instructions

**Use factual, technical language instead of marketing terms:**

❌ **Avoid marketing language:**
- "ideal solution" → "fully managed service" or specific capability
- "perfect for" → "designed for" or "supports"
- "seamlessly integrates" → "integrates with" or "works with"
- "powerful feature" → specific capability or benefit
- "dramatically improves" → quantify improvement or use "improves"
- "critical capability" → "important" or state the actual impact
- "cutting-edge" → "latest" or omit
- "revolutionary" → describe actual impact
- "industry-leading" → omit or use specific metrics

✅ **Use factual alternatives:**
- State specific capabilities: "supports up to 128 TB storage"
- Quantify benefits: "reduces query time by caching frequently accessed data"
- Describe actual features: "provides automatic backup and point-in-time restore"
- Focus on technical accuracy: "uses lock-free data structures for concurrent access"

### Content Structure

**Prefer tables over lists for comparative or detailed information:**
- Use markdown tables when presenting multiple attributes for multiple items
- Include columns for: Item/Feature, Description/Purpose, Example/Use Case
- Keep table cells concise but complete
- Ensure all rows have consistent column structure

**Example:**
```markdown
| Data Type | Purpose | Storage Size | Example |
|-----------|---------|--------------|---------|
| INT | Whole numbers | 4 bytes | `CustomerID INT` |
| NVARCHAR(n) | Variable-length Unicode text | 2 bytes × length + 2 bytes overhead | `ProductName NVARCHAR(100)` |
```

**For code examples:**
- Include context comments explaining non-obvious aspects
- Show complete, runnable examples when possible
- Use proper syntax highlighting with language tags (```sql, ```csharp, etc.)

### Technical Accuracy

**Version-specific features:**
- Always specify which SQL Server version or Azure SQL service tier introduced a feature
- Use accurate terminology: "generally available" vs "preview" vs "deprecated"
- Update content when new versions add capabilities (e.g., SQL Server 2025 native JSON data type)

**Examples:**
```markdown
- **JSON data type** (SQL Server 2025, Azure SQL Database): Native support for JSON with `CREATE JSON INDEX`
- **In-Memory OLTP** (SQL Server 2014+): Memory-optimized tables and natively compiled procedures
```

### Content Organization

**Unit structure should include:**
1. Optional developer-focused insight paragraph (see separate section)
2. Clear introduction stating what will be covered
3. Main content sections with action verb headers
4. Code examples demonstrating concepts
5. Links to official documentation for deeper exploration
6. Avoid generic summaries at the end unless adding unique value

### Pre-Submission Checklist

Before completing any unit creation or update, automatically verify:
- [ ] All ## and ### headers start with action verbs
- [ ] Official Microsoft Learn links include `?azure-portal=true` parameter
- [ ] No marketing language present (ideal, perfect, powerful, seamlessly, dramatically, critical, revolutionary)
- [ ] Tables used instead of lists for comparative data
- [ ] Code examples include proper language tags and are complete
- [ ] Version-specific information is accurate and current
- [ ] Developer insight paragraph included for introduction units (if appropriate)
- [ ] Links to official documentation for all major features mentioned
- [ ] Technical accuracy verified against current Microsoft documentation

### Automated Application

Apply all these standards automatically when:
- Creating new units from scratch
- Updating existing unit content
- Reviewing or refactoring module content
- Responding to requests about "fixing" or "improving" units

**Do not ask for confirmation on each standard** - apply them as a complete set to ensure formatting compliance.