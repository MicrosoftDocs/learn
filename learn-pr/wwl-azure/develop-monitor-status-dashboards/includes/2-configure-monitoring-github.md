GitHub provides **comprehensive native monitoring** capabilities that enable teams to track repository activity, measure collaboration effectiveness, and make data-driven decisions about their development workflows. These built-in monitoring features eliminate the need for external tools while providing deep insights into code changes, contributor patterns, workflow performance, and project health.

**Why GitHub monitoring matters**

- **Visibility into development velocity:** Track how quickly code changes move from commit to deployment
- **Team collaboration insights:** Understand contributor patterns, code review effectiveness, and knowledge distribution
- **Quality metrics:** Monitor test coverage, security vulnerabilities, and code quality trends over time
- **Performance optimization:** Identify workflow bottlenecks, slow CI/CD jobs, and resource utilization issues
- **Project management:** Visualize work progress, burndown rates, and milestone achievement
- **Security posture:** Track dependency vulnerabilities, secret scanning alerts, and code scanning findings

**Access and permissions:**
By default, monitoring data and charts are available to anyone with repository access. Repository administrators can configure granular permissions to control who can view insights, create custom charts, and access detailed analytics.

## GitHub monitoring categories

GitHub's monitoring ecosystem spans **multiple integrated categories,** each providing specific insights into different aspects of your development workflow:

**Repository insights:**

- **Traffic analysis:** View visitor counts, clone activity, popular content, and referring sites
- **Contributor activity:** Track commits, pull requests, and issue contributions over time
- **Network graphs:** Visualize branch relationships, fork activity, and code flow patterns
- **Community health:** Measure documentation completeness, contribution guidelines, and project maintainability

**GitHub Actions analytics:**

- **Workflow execution metrics:** Track success rates, duration trends, and failure patterns
- **Job-level performance:** Analyze individual job execution times and resource consumption
- **Runner utilization:** Monitor self-hosted and GitHub-hosted runner usage and availability
- **Action marketplace insights:** Understand which actions are used and their reliability

**Security monitoring:**

- **Dependabot alerts:** Track vulnerable dependencies and automated update success rates
- **Code scanning findings:** Monitor security vulnerabilities detected through static analysis
- **Secret scanning:** Identify accidentally committed secrets and credential exposures
- **Security advisories:** Review published security issues and remediation status

**Project insights:**

- **Current state visualization:** View work item distribution across statuses, assignees, and labels
- **Historical trend analysis:** Track progress over time with burndown, burnup, and velocity charts
- **Custom analytics:** Create specialized visualizations for team-specific metrics and KPIs

## GitHub Insights for Projects

**GitHub Projects Insights** provide powerful built-in analytics for tracking work items, visualizing progress, and understanding team velocity. These insights integrate seamlessly with issues, pull requests, and milestones, offering both real-time snapshots and historical trend analysis.

**Key capabilities:**

- **Default charts:** Pre-configured visualizations that work immediately without configuration
- **Custom charts:** Flexible chart builder supporting multiple visualization types and filtering options
- **Current analysis:** Real-time snapshots showing the present state of work items
- **Historical tracking:** Time-based visualizations showing progress, trends, and velocity over time
- **Filtering and grouping:** Powerful options to segment data by assignees, labels, milestones, repositories, and custom fields

**Chart types available:**
Projects Insights support **two fundamental chart categories,** each serving different analytical purposes:

### Current charts

**Current charts** provide real-time visualization of your project's **present state,** showing work item distribution, team workload, and status breakdowns at the current moment. These charts answer questions like "What is the team working on right now?" and "How is work distributed across team members?"

**Default Status chart:**
The built-in Status chart displays the current total number of items in your project, segmented by their status (To Do, In Progress, Done, etc.). This provides an immediate snapshot of work distribution and helps identify bottlenecks where work accumulates.

**Common current chart use cases:**

**Team workload distribution:**

- **Purpose:** Visualize how many work items are assigned to each team member
- **Configuration:** X-axis: Assignees, Y-axis: Count of items
- **Benefits:** Identify workload imbalances, prevent team member overload, facilitate work redistribution
- **Example insight:** "Sarah has 15 active items while most team members have 5-7, suggesting we should redistribute work"

**Iteration progress:**

- **Purpose:** Show how many issues are raised or completed in each iteration
- **Configuration:** X-axis: Milestone, Y-axis: Count of items, Group by: Status
- **Benefits:** Track sprint progress, identify iterations with scope creep, plan capacity for future iterations
- **Example insight:** "Sprint 3 has 45 items vs. average of 30, indicating we may have overcommitted"

**Label-based categorization:**

- **Purpose:** Visualize work distribution across categories (bug, feature, documentation, etc.)
- **Configuration:** X-axis: Labels, Y-axis: Count of items
- **Benefits:** Understand work composition, ensure balanced attention to different work types
- **Example insight:** "70% of current work is bugs, suggesting we should dedicate capacity to technical debt"

**Repository breakdown:**

- **Purpose:** Show work item distribution across multiple repositories in a multi-repo project
- **Configuration:** X-axis: Repository, Y-axis: Count of items, Group by: Status
- **Benefits:** Identify which repositories have the most active work, spot neglected codebases
- **Example insight:** "API repository has 80% of work items, while frontend has minimal activity"

**Advanced filtering for current charts:**

**Remaining work visualization:**

- **Filter:** Status: "To Do" OR "In Progress"
- **Purpose:** Focus on incomplete work, hiding completed items from view
- **Use case:** Daily standup dashboards showing only active and pending work

**High-priority items:**

- **Filter:** Label: "priority: high" OR "priority: critical"
- **Purpose:** Surface urgent work requiring immediate attention
- **Use case:** Leadership dashboards highlighting critical path items

**Specific assignee focus:**

- **Filter:** Assignee: @username
- **Purpose:** Show individual contributor's current workload and responsibilities
- **Use case:** One-on-one meetings, personal productivity tracking

**Label and assignee combination:**

- **Filter:** Label: "frontend" AND Assignee: @frontend-team
- **Purpose:** Segment work by both category and responsibility
- **Use case:** Team-specific dashboards for specialized work streams

### Historical charts

**Historical charts** enable **time-based analysis** of your project's evolution, revealing trends, patterns, and velocity over days, weeks, or months. These charts answer questions like "Are we completing work faster over time?" and "Where did our velocity drop?"

**Default Burnup chart:**
The built-in Burnup chart visualizes progress over time by showing two key metrics:

- **Total scope:** All work items added to the project (including new items added mid-sprint)
- **Completed work:** Work items that have been closed or moved to "Done" status

**Benefits of burnup vs. burndown:**

- **Scope visibility:** Burnup charts reveal scope changes (adding new work), while burndown charts hide them
- **Predictive capability:** Historical completion rates enable forecasting of future delivery dates
- **Trend identification:** Spot acceleration or deceleration in team velocity
- **Bottleneck detection:** Identify periods where work completion stalls despite continued effort

**Common historical chart use cases:**

**Velocity tracking:**

- **Purpose:** Measure how many work items the team completes per time period
- **Configuration:** X-axis: Time (weekly), Y-axis: Count of items, Filter: Status: "Done"
- **Benefits:** Understand sustainable pace, forecast completion dates, identify productivity trends
- **Example insight:** "Team averaged 12 completions/week in Q1 but only 8/week in Q2, suggesting capacity issues"

**Issue closure rate:**

- **Purpose:** Track how quickly issues are being resolved over time
- **Configuration:** X-axis: Time, Y-axis: Count of items, Filter: Type: "Issue" AND Status: "Closed"
- **Benefits:** Measure responsiveness to bugs and user feedback, identify backlog health
- **Example insight:** "Issue closure rate decreased 40% after product launch, indicating support burden"

**Pull request merge patterns:**

- **Purpose:** Visualize pull request throughput and merge frequency
- **Configuration:** X-axis: Time, Y-axis: Count of items, Filter: Type: "Pull Request" AND Status: "Merged"
- **Benefits:** Understand code review effectiveness, identify merge bottlenecks
- **Example insight:** "PRs taking 2+ days to merge increased from 20% to 60% over last month"

**Work-not-planned closure:**

- **Purpose:** Track items closed without completion (duplicate, won't fix, out of scope)
- **Configuration:** X-axis: Time, Y-axis: Count of items, Filter: Closed as: "Not planned"
- **Benefits:** Identify scope refinement patterns, measure requirements quality
- **Example insight:** "30% of items closed as not planned, suggesting upfront planning needs improvement"

**Multi-series comparison:**

- **Purpose:** Compare multiple categories on the same timeline
- **Configuration:** X-axis: Time, Y-axis: Count, Group by: Label or Status
- **Benefits:** Understand category relationships, spot shifting priorities
- **Example insight:** "Bug work increased 3x while feature work decreased, confirming quality focus shift"

**Important limitations:**

**Archived and deleted items:**
Historical charts do **not track** items that have been:

- **Archived:** Removed from active view but retained in project history
- **Deleted:** Permanently removed from the project

**Rationale:** These items represent abandoned or cancelled work that shouldn't influence velocity calculations or historical trends.

**Workaround:** If you need to track cancelled work separately, use a custom status like "Cancelled" or "Won't Do" before archiving, so the historical chart captures the closure event.

## Plan availability and limits

**GitHub Insights availability** varies by plan tier, with different capabilities and limits based on your subscription level:

**Historical charts requirements:**

- **GitHub Team:** Historical charts available for organization accounts
- **GitHub Enterprise Cloud:** Historical charts available for organization and enterprise accounts
- **GitHub Free and Pro:** Historical charts NOT available for private projects
- **Public projects:** Historical charts available to all users regardless of plan

**Chart creation limits:**

**Unlimited charts:**

- **Private projects with GitHub Team or Enterprise Cloud** (organizations)
- **Private projects with GitHub Pro** (individual users)
- **All public projects** (any plan tier)

**Limited charts:**

- **Private projects with GitHub Free:** Maximum of 2 charts per project
- **Recommendation:** Use the two slots for your most critical metrics (e.g., Status overview + Burnup)

**Plan selection guidance:**

**Choose GitHub Free if:**

- You're working on public open-source projects (unlimited charts)
- You need basic monitoring for small private projects (2 charts sufficient)
- Budget constraints require free tier

**Upgrade to GitHub Pro/Team if:**

- You need historical trend analysis for private projects
- You want more than 2 custom charts per private project
- You need advanced collaboration features beyond monitoring

**Choose GitHub Enterprise Cloud if:**

- You need enterprise-scale monitoring across multiple organizations
- You require advanced security, compliance, and audit logging
- You need centralized billing and policy management

## Creating custom charts

**Step-by-step chart creation process:**

**Step 1: Navigate to project insights**

1. Open **GitHub.com** in your browser
2. Navigate to your **target project** (Organization > Projects > [Project Name])
3. In the top-right corner, select the **Insights icon** (graph symbol)
4. You'll see any existing charts and the option to create new ones

**Step 2: Initiate chart creation**

1. In the **vertical navigation menu** on the left side
2. Select **New chart** (+ icon or "New chart" button)
3. A new blank chart configuration panel appears

**Step 3: Name your chart**

1. Assign a **meaningful, descriptive name** to the chart
2. **Best practices for naming:**
   - **Be specific:** "Frontend Team Workload" vs. "Team Chart"
   - **Include timeframe:** "Q1 Velocity Trends" vs. "Velocity"
   - **Describe purpose:** "High Priority Bugs by Status" vs. "Bugs"
   - **Use consistent naming:** Establish team conventions for chart names

**Step 4: Configure chart settings**
Select **Configure** to modify the chart properties:

**Layout options (visualization types):**

**Bar chart:**

- **Best for:** Comparing categories horizontally
- **Use case:** Assignee workload comparison, repository activity breakdown
- **Advantage:** Easy to read when category names are long

**Column chart:**

- **Best for:** Comparing categories vertically
- **Use case:** Status distribution, label-based categorization
- **Advantage:** Natural for showing "stacking up" or accumulation

**Line chart:**

- **Best for:** Showing trends over time with continuous data
- **Use case:** Velocity tracking, completion rate trends, issue closure patterns
- **Advantage:** Emphasizes trajectory and trend direction

**Stacked area chart:**

- **Best for:** Showing composition changes over time
- **Use case:** Work breakdown by category over time, status evolution
- **Advantage:** Visualizes both total volume and category proportions

**Stacked bar chart:**

- **Best for:** Comparing total values with category composition (horizontal)
- **Use case:** Milestone progress with status breakdown, repository work by type
- **Advantage:** Shows both total and composition in compact horizontal format

**Stacked column chart:**

- **Best for:** Comparing total values with category composition (vertical)
- **Use case:** Weekly work breakdown by priority, sprint velocity by work type
- **Advantage:** Natural for time-based categorical comparisons

**X-axis configuration:**

**Assignees:**

- **Purpose:** Group data by who is responsible for work items
- **Result:** Shows workload distribution across team members
- **Best combined with:** Status grouping (to show each person's work by status)

**Labels:**

- **Purpose:** Group data by work item categories, priorities, or types
- **Result:** Shows work composition across different classifications
- **Best combined with:** Repository or Assignee grouping (to show label distribution per repo/person)

**Milestone:**

- **Purpose:** Group data by project milestones or sprints
- **Result:** Shows work distribution across iterations or release targets
- **Best combined with:** Status grouping (to show milestone progress)

**Repository:**

- **Purpose:** Group data by source repository (for multi-repo projects)
- **Result:** Shows which repositories have the most activity or items
- **Best combined with:** Label or Status grouping (to show work type or progress per repo)

**Status:**

- **Purpose:** Group data by work item status (To Do, In Progress, Done, etc.)
- **Result:** Shows work distribution across workflow stages
- **Best combined with:** Assignee or Milestone grouping (to show status per person/sprint)

**Time:**

- **Purpose:** Create historical chart showing data evolution over time
- **Result:** Enables trend analysis, velocity tracking, and pattern identification
- **Requirement:** Must use Time for historical charts
- **Best combined with:** Status or Label grouping (to show trends by category)

**Group by options (optional secondary dimension):**

**None:**

- **Use case:** Simple single-dimension analysis
- **Example:** Total items by status (no secondary grouping)

**Assignees:**

- **Use case:** Break down primary dimension by team member
- **Example:** Items by status, grouped by assignee (shows each person's status distribution)

**Labels:**

- **Use case:** Break down primary dimension by work type or priority
- **Example:** Items by milestone, grouped by label (shows label distribution per milestone)

**Milestone:**

- **Use case:** Break down primary dimension by sprint or release
- **Example:** Items by assignee, grouped by milestone (shows each person's work per sprint)

**Repository:**

- **Use case:** Break down primary dimension by source repository
- **Example:** Items by status, grouped by repository (shows status distribution per repo)

**Y-axis configuration (aggregation method):**

**Count of items:**

- **Calculation:** Simple count of work items matching criteria
- **Use case:** Most common choice - "How many items?"
- **Example:** Count of issues by status, count of PRs by assignee

**Sum of a field:**

- **Calculation:** Add up numeric values from a custom field
- **Use case:** Story points, estimated hours, priority weights
- **Example:** Sum of story points by milestone, sum of estimated hours by assignee

**Average of a field:**

- **Calculation:** Mean value of a numeric custom field
- **Use case:** Average cycle time, average priority score
- **Example:** Average story points per item by label, average cycle time by assignee

**Minimum of a field:**

- **Calculation:** Lowest value of a numeric custom field
- **Use case:** Fastest completion time, lowest priority items
- **Example:** Minimum cycle time by milestone

**Maximum of a field:**

- **Calculation:** Highest value of a numeric custom field
- **Use case:** Longest running items, highest priority items
- **Example:** Maximum age of open items by status

**Step 5: Apply filters (optional but powerful)**
Above the chart configuration, you can enter **filter expressions** to scope the data:

**Filter syntax examples:**

**Single condition:**

- `status:"In Progress"` - Show only items currently in progress
- `assignee:@username` - Show only items assigned to specific user
- `label:"bug"` - Show only items with bug label

**Multiple conditions (AND logic):**

- `status:"Done" label:"feature"` - Completed features only
- `assignee:@username milestone:"Sprint 5"` - Specific person's work in specific sprint

**Multiple conditions (OR logic):**

- `status:"To Do" OR status:"In Progress"` - All incomplete work
- `label:"bug" OR label:"security"` - All bugs and security issues

**Exclusion (NOT logic):**

- `-status:"Done"` - Everything except completed items
- `-assignee:@username` - All work except for specific person

**Date-based filtering:**

- `updated:>2024-01-01` - Items updated after January 1, 2024
- `created:<2024-06-30` - Items created before June 30, 2024

**Step 6: Save and share**

1. **Save** the chart configuration
2. **View** the chart in your Insights dashboard
3. **Share** the Insights page URL with team members
4. **Iterate** by editing chart configurations as needs evolve

## Chart creation best practices

**Start simple, iterate based on feedback:**

- Create basic charts first (Status, Assignee, Milestone)
- Gather team input on what additional insights would be valuable
- Add complexity (grouping, filtering) only when needed for specific decisions

**Create role-specific dashboards:**

- **Developers:** Workload by assignee, PR merge rates, bug assignment
- **Managers:** Velocity trends, milestone progress, team capacity
- **Product owners:** Feature vs. bug ratio, scope changes, backlog health

**Use consistent filtering across related charts:**

- If you filter one chart to show only "frontend" label, use the same filter on related charts
- Consistency enables apples-to-apples comparisons across visualizations

**Document chart purposes:**

- In chart names or team documentation, explain what each chart measures and what decisions it informs
- Example: "Sprint Burnup (tracks scope changes and completion progress for active sprint)"

**Review and retire outdated charts:**

- Periodically assess which charts are actually used for decision-making
- Archive or delete charts that no longer provide value
- Free up chart slots (for GitHub Free users) by removing unused visualizations

## GitHub Actions monitoring

Beyond project insights, **GitHub Actions** provides built-in monitoring for CI/CD workflows:

**Workflow-level metrics:**

- **Success rate:** Percentage of workflow runs that complete successfully
- **Average duration:** Mean execution time for workflow runs
- **Failure patterns:** Common failure points across workflow jobs
- **Trigger analysis:** Which events (push, PR, schedule) trigger most runs

**Job-level insights:**

- **Job duration:** Execution time for each job within workflows
- **Job dependencies:** Visualization of job parallelization and dependencies
- **Job success rates:** Individual job reliability metrics
- **Resource consumption:** Runner minutes used by each job (important for billing)

**Accessing Actions analytics:**

1. Navigate to your repository on **GitHub.com**
2. Select the **Actions** tab
3. Choose a specific workflow to view its runs
4. Select **Insights** (if available for your plan) for detailed analytics

**Actions monitoring use cases:**

**Identify slow workflows:**

- **Goal:** Find workflows taking excessive time to complete
- **Action:** Examine job-level duration to pinpoint bottlenecks
- **Optimization:** Add parallelization, improve caching, or optimize test suites

**Track failure patterns:**

- **Goal:** Understand which workflows fail most frequently
- **Action:** Review failure rates and common error messages
- **Optimization:** Fix flaky tests, improve error handling, add retry logic

**Optimize runner costs:**

- **Goal:** Reduce GitHub Actions billing by improving efficiency
- **Action:** Monitor runner minutes consumed by each workflow and job
- **Optimization:** Use self-hosted runners for long-running jobs, improve caching, reduce unnecessary runs

**Measure workflow reliability:**

- **Goal:** Ensure CI/CD pipelines are dependable
- **Action:** Track success rates over time, identify degradation
- **Optimization:** Add health checks, improve test stability, implement progressive rollout

## Status badges for repositories

**Status badges** provide **at-a-glance visibility** of repository health and workflow status directly in your README or documentation:

**Benefits:**

- **Immediate visibility:** Anyone viewing the repository sees current build/test status
- **Build confidence:** Green badges indicate passing tests and successful builds
- **Transparency:** Public projects demonstrate quality and maintenance status
- **Quick triage:** Failed badge immediately indicates something needs attention

**Common badge types:**

**GitHub Actions workflow status:**

- **Displays:** Pass/fail status of specified workflow
- **Updates:** Real-time as workflows execute
- **Syntax:** `![Workflow Name](https://github.com/{owner}/{repo}/actions/workflows/{workflow-file}/badge.svg)`

**Test coverage:**

- **Displays:** Percentage of code covered by tests
- **Updates:** After test execution (via services like Codecov, Coveralls)
- **Value:** Demonstrates commitment to testing and quality

**Dependencies status:**

- **Displays:** Whether dependencies are up-to-date and secure
- **Updates:** When dependency scanning detects issues
- **Value:** Shows proactive security and maintenance practices

**License information:**

- **Displays:** Repository license type (MIT, Apache, GPL, etc.)
- **Updates:** Static (reflects LICENSE file)
- **Value:** Clarifies usage permissions for potential users

**Creating workflow status badges:**

**Step 1: Navigate to Actions**

1. Go to your repository on GitHub.com
2. Select the **Actions** tab
3. Choose the **workflow** you want to badge

**Step 2: Get badge markdown**

1. Click the **...** (more options) button on the workflow page
2. Select **Create status badge**
3. Copy the provided Markdown or HTML code

**Step 3: Add to README**

1. Edit your **README.md** file
2. Paste the badge markdown at the top (typically near the title)
3. Commit the changes

**Example badge display:**

```markdown
# My Project

![CI](https://github.com/owner/repo/actions/workflows/ci.yml/badge.svg)
![Tests](https://github.com/owner/repo/actions/workflows/tests.yml/badge.svg)
![Coverage](https://img.shields.io/codecov/c/github/owner/repo)
```

**Badge best practices:**

- **Group related badges:** Place all build/test badges together, all quality badges together
- **Don't overuse:** Too many badges create visual clutter - focus on most important signals
- **Keep updated:** Remove badges for deprecated workflows or services
- **Add alt text:** Ensure badges have descriptive alt text for accessibility
