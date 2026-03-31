Assessment is essential before migration. This phase provides a complete understanding of your Azure DevOps environment, including repository history, pipeline types, and Azure Boards customizations.

## Why source assessment matters

Creating a shared truth across engineering, security, and leadership stops scope drift and surprises. A precise inventory lets you speak to counts, sizes, and complexity with confidence. You'll know where the complex repositories and pipelines are and why they require special attention.

## Install and configure the ADO2GH extension

The GitHub CLI ADO2GH extension provides commands specifically designed for Azure DevOps to GitHub migrations.

First, install the extension:

```bash
gh extension install github/gh-ado2gh
```

Authenticate to GitHub and export your Azure DevOps Personal Access Token:

```bash
gh auth login --hostname github.com
export ADO_PAT="your-ado-pat-token"
```

## Generate comprehensive inventory reports

The inventory report command creates CSV files that contain detailed information about your Azure DevOps environment.

Generate an inventory for a specific Azure DevOps organization:

```bash
gh ado2gh inventory-report --ado-org "your-ado-org"
```

For a quicker assessment with essential information only:

```bash
gh ado2gh inventory-report --ado-org "your-ado-org" --minimal
```

To assess all accessible organizations (omit the `--ado-org` parameter):

```bash
gh ado2gh inventory-report
```

The command generates several CSV files:

- `organizations.csv` - Azure DevOps organizations and their settings
- `team_projects.csv` - Team projects within each organization
- `repositories.csv` - Repository details including size, type, and activity
- `pipelines.csv` - Build and release pipelines configuration

## Analyze repository characteristics

Each repository has unique characteristics that affect migration complexity and approach.

### Inventory analysis

Focus on these key areas:

- **Total count and size distribution** - categorize into bands like <100MB, 100MB–1GB, >1GB
- **Repository type** - Git repositories vs. Team Foundation Version Control (TFVC)
- **Recent activity** - identify actively developed vs. archived repositories

Use command-line tools to quickly analyze the CSV data:

```bash
# Count repositories per team project
cut -d',' -f2 repositories.csv | sort | uniq -c | sort -nr

# Get total pipeline count
wc -l < pipelines.csv
```

### Content complexity indicators

Look for these factors that increase migration complexity:

- **Large repositories** (>1GB) with extensive tag history
- **Git submodules** that require coordinated migration order
- **Binary artifacts** in repository history that need Git LFS conversion
- **Multiple active branches** with protection rules
- **Extensive tagging strategies** for releases

### Risk interpretation

Understanding these patterns helps set realistic expectations:

- Repositories over 1GB with many tags typically require longer migration times and potential cleanup
- Submodules need careful coordination to maintain proper pinning relationships
- Binary artifacts in history might need Git LFS migration or cleanup work

## Map Azure Boards dependencies

Azure Boards analysis helps you understand work tracking dependencies and choose the right migration strategy.

Document these key aspects:

```text
### Azure Boards Usage Analysis
Active Projects: [List projects actively using Boards]
Custom Work Item Types: [Document custom types beyond standard]
Process Templates: [Note Agile, Scrum, CMMI, or custom processes]
Custom Fields: [List organization-specific fields]
Workflow Customizations: [Document state transitions and rules]
Integration Points: [Repositories with AB# work item links]
```

## Strategy decision framework

Choose your Azure Boards approach:

- **Keep** - When time is tight and work tracking processes are heavily customized
- **Migrate** - When work items can be exported and imported to GitHub Issues or Projects
- **Hybrid** - When you need work item linking but want to transition gradually

## GitHub Copilot-Assisted Migration Analysis

To streamline and standardize migration assessments, teams now use a Copilot-based migration analysis prompt that automates repository scoring, wave classification, and timeline generation. This prompt implements the same logic and structure as a GitHub Enterprise Importer Migration Strategy, including:

- Repository scoring (size, activity, simplicity)
- Migration wave assignment (1–3 and manual review)
- Timeline projections Risk and eligibility analysis
- Summary report generation in Markdown

The full prompt used for this process is included below for reference.

```text
# GitHub Enterprise Migration Analysis Prompt

## System Instructions

You are an expert migration analyst specializing in GitHub Enterprise migrations. Your task is to analyze repository data from a SQLite database or CSV file and generate a comprehensive migration strategy document similar to a GitHub Enterprise Importer Migration Strategy.

## Input Data Requirements

The input data should contain repository information with the following key fields:
- Repository identification (org, teamproject, repo, url)
- Size metrics (compressed-repo-size-in-bytes)
- Activity metrics (last-push-date, commits-past-year, pr-count)
- Development metrics (pipeline-count, most-active-contributor)
- Note: This is Azure DevOps migration data, so some GitHub-specific fields are not available

## Analysis Framework

### 1. Repository Scoring System
Implement a Migration Compatibility Score (0-11 points) based on:

Size Score (0-5 Points) (based on compressed-repo-size-in-bytes):
- 5 points: < 10MB (Excellent - Fast migration)
- 4 points: < 100MB (Very Good - Standard migration)  
- 3 points: < 500MB (Good - Moderate migration time)
- 2 points: < 5GB (Fair - Longer migration)
- 1 point: < 30GB (Poor - Extended migration, near project limit)
- 0 points: ≥ 30GB (Risk - Exceeds project limit, requires special handling)

Activity Score (0-3 Points) (based on commits-past-year):
- 3 points: 0 commits (Inactive - Lowest migration disruption)
- 2 points: 1-10 commits (Low activity - Minimal disruption)
- 1 point: 11-100 commits (Moderate activity - Some disruption risk)
- 0 points: > 100 commits (High activity - Significant disruption risk)

Simplicity Score (0-3 Points) (based on pr-count and pipeline-count):
- 3 points: 0 PRs AND ≤ 1 pipeline (Simple)
- 2 points: ≤ 10 PRs AND ≤ 3 pipelines (Moderate)
- 1 point: ≤ 50 PRs AND ≤ 10 pipelines (Complex)
- 0 points: > 50 PRs OR > 10 pipelines (Very Complex)

### 2. Migration Wave Classification

Eligibility Criteria (must meet ALL to be eligible for automated waves):
- compressed-repo-size-in-bytes < 30GB
- pipeline-count ≤ 10 (manageable CI/CD complexity)
- Recent activity (last-push-date within last 1 year)
- Note: Azure DevOps data doesn't include fork/archived status - assume all are eligible unless size/complexity exceeds limits

Wave Assignment:
- Wave 1 (Score 9-11): Low Risk - Small, simple, low-activity repositories
- Wave 2 (Score 6-8): Medium Risk - Standard repositories with moderate complexity
- Wave 3 (Score 3-5): High Risk - Complex or large repositories requiring planning
- Manual Review (Score 0-2 OR fails eligibility): Very High Risk - Individual assessment required

### 3. Timeline Calculation

Migration Rates by Wave:
- Wave 1: 800 repositories/day (100 repos/hour) - 8-hour workday
- Wave 2: 600 repositories/day (75 repos/hour) - 8-hour workday
- Wave 3: 400 repositories/day (50 repos/hour) - 8-hour workday
- Manual Review: 200 repositories/day (manual processing)

Calculate timeline in business days (22 days/month)

## Required Output Document Structure

Generate a comprehensive markdown document with the following sections:

### 1. Executive Summary
- Total repositories analyzed
- Automated migration eligible count and percentage
- Manual review required count and percentage
- Estimated timeline in months
- Peak daily throughput
- Migration scale overview with wave distribution

### 2. Repository Selection Criteria
- Repository-level requirements table
- GitHub Enterprise Importer specific considerations
- Activity-based prioritization strategy explanation
- Benefits of low-activity first approach

### 3. Repository Scoring System
- Detailed scoring methodology
- Risk assessment matrix table
- Score range to risk level mapping

### 4. Migration Wave Strategy
#### For each wave (Wave 1, 2, 3, Manual Review):
- Repository count
- Timeline calculation
- Batch size and migration rate
- Characteristics description
- Success criteria
- Special considerations (especially for 30GB limits in Wave 3)

#### Total Migration Timeline Summary:
- Wave breakdown table with counts, percentages, timelines
- Key insights about distribution
- Impact analysis of project constraints

### 5. Repository Size Analysis
#### Top 10 Largest Repositories Table:
- Repository name (org/teamproject/repo)
- Size in GB (converted from compressed-repo-size-in-bytes)
- Last push date
- Commits past year
- PR count
- Pipeline count
- Most active contributor
- Migration impact assessment

#### Critical Size Observations:
- Repositories exceeding 30GB limit
- Near-limit repositories (25-30GB)
- Size optimization recommendations

### 6. GitHub Enterprise Importer Limitations and Considerations
#### Capabilities Table:
- What data IS migrated (based on GHES version)
- Technical limitations and size limits
- Data that is NOT migrated (comprehensive list)
- Branch protection limitations
- Migration process limitations

## Data Analysis Instructions

1. Calculate Migration Scores: Apply the scoring system to all repositories
2. Determine Eligibility: Check each repository against eligibility criteria
3. Assign Migration Waves: Based on eligibility and scores
4. Generate Statistics: Calculate counts, percentages, and timelines for each wave
5. Identify Outliers: Find largest repositories, most complex repositories, edge cases
6. Risk Assessment: Identify repositories requiring special attention
7. Timeline Projection: Calculate realistic migration timeline based on complexity

## Output Requirements

- Generate professional markdown document
- Include all statistical analysis with specific numbers
- Provide actionable recommendations
- Include tables with proper formatting
- Calculate realistic timelines
- Identify risks and mitigation strategies
- Reference GitHub Enterprise Importer documentation limitations
- Use consistent terminology throughout

## Data Source

Analyze the provided SQLite database or CSV file containing repository data with the schema and views described above. Use the `migration_scoring` view for wave assignments and the `manual_review_repositories` view for detailed manual review analysis.

Key analysis patterns for CSV data:

Available fields in repos.csv:
- org: Organization name
- teamproject: Team project name  
- repo: Repository name
- url: Azure DevOps repository URL
- last-push-date: Last activity date
- pipeline-count: Number of CI/CD pipelines
- compressed-repo-size-in-bytes: Repository size in bytes
- most-active-contributor: Primary contributor
- pr-count: Number of pull requests
- commits-past-year: Commit activity in past year
- Size conversion: compressed-repo-size-in-bytes / (1024^3) for GB
- Activity assessment: commits-past-year and last-push-date
- Complexity assessment: pipeline-count and pr-count
- Repository identification: org/teamproject/repo combination

Generate the complete migration strategy document based on this analysis framework and the provided repository data.
```

## Map Azure Pipelines dependencies

Azure Pipelines analysis reveals build and deployment automation complexity.

Catalog these pipeline elements:

```text
### Azure Pipelines Usage Analysis
Classic Build Pipelines: [Count and complexity]
Classic Release Pipelines: [Count and deployment stages]
YAML Pipelines: [Count and modern practices adoption]
Service Connections: [External service integrations]
Variable Groups: [Shared configuration and secrets]
Secure Files: [Certificates and configuration files]
Agent Pools: [Self-hosted vs. Microsoft-hosted usage]
```

### Pipeline migration strategies

- **Keep** - Complex classic pipelines that would take significant time to rewrite
- **Migrate** - YAML-based pipelines that can be adapted to GitHub Actions
- **Hybrid** - Decouple code hosting from release orchestration during transition

Understanding these dependencies helps you communicate realistic timelines and resource requirements to stakeholders.
