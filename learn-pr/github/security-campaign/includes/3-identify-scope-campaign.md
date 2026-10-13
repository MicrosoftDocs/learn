Security campaigns in GitHub Advanced Security are created and managed from the organization-level Security and Quality tab. They are used to group related security alerts across multiple repositories and coordinate remediation efforts in a structured way.

Campaigns begin with selecting and defining a focused set of security alerts that represent a specific area of risk. This process happens within the **Campaigns section of Security and Quality**, where organization-wide security data is already aggregated.

## Step 1: Open Security and Quality and start a campaign

You create a security campaign from the organization's Security and Quality.

To start:
- Go to your GitHub organization
- Open **Security and Quality**
- Select the **Campaigns** section
- Click **Create campaign**

Security and Quality shows all security alerts across repositories, so you can build campaigns using organization-wide data.

## Step 2: Review security alerts and identify focus areas

You review security alerts to understand where risk exists across the organization.

You look for:
- Repositories with the highest number of alerts
- Alert types that appear most frequently
- High and critical severity issues
- Similar vulnerabilities across multiple repositories

You use this analysis to identify a clear focus area for the campaign, such as a recurring vulnerability type or a concentrated risk pattern.

## Step 3: Define and scope the campaign

You select the alerts to include in the campaign and define its boundaries in a single scoping step.

You use filters and selections to determine:

### Alert inclusion

You include alerts based on:
- Alert type (code scanning, secret scanning, dependency alerts)
- Severity level (high or critical)
- Specific vulnerability categories or patterns

### Repository scope

You include repositories based on:
- Team or product ownership
- Shared dependencies or architecture
- Business or service boundaries

### Campaign objective

You define what the campaign aims to achieve, such as:
- Reducing a specific class of vulnerabilities
- Clearing a backlog of high-severity alerts
- Addressing a recurring risk pattern across repositories

This combined step ensures the campaign focuses on a clearly defined and measurable set of security issues.

## Step 4: Assign ownership

You assign alerts to the teams or users responsible for remediation.

You assign based on:
- Repository ownership
- Engineering team responsibility
- Service or application boundaries

You ensure every alert has a clear owner who can take action.