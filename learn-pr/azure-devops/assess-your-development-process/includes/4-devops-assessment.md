Alice, who is new to the team, is going to take the Microsoft DevOps Self-Assessment. This self-assessment gives you the opportunity to reflect on your existing processes. It also provides you with a greater understanding of where you fit in the DevOps maturity model. More mature teams typically release faster, with greater confidence, and fewer bugs than less mature teams.

The assessment comes in two forms &mdash; a long form and a shorter form. Being new to the team, Alice knows she doesn't understand everything so she's going to use the shorter form. Taking the assessment is a good first step. It will give the team an overall view of where they are in the DevOps process. With the results, everyone on the team has a common starting point for identifying the first steps towards improving Tailspin's development and release processes.

Here's how you can take the assessemet with her. 

## Take the assessemt

1. Go to [devopsassessment.net](https://devopsassessment.net?azure-portal=true).
1. Fill out the personal information:
    * Tailspin is the company name.
    * Company size is 50-249.
    * Select **Other** for Title.
    * Select **Other** for Industry.

1. Click **Start the Assessment**.
1. Select the short form. Click **Take the Assessment**.

> [!NOTE]
> For now, just follow Alice's responses. You'll have the opportunity to go through the assessment a second time, so think about what selection you would make for your team.

For each section that follows, choose the same answer as Alice for each question.

### Process and Agility

The team follows a waterfall approach. Work already feels ad-hoc, and the deployment process is invisible to her once she hands off new features to QA.

Alice has already seen the team using open source components with various licenses. This can lead to trouble should anyone discover they may not be correctly licensing open source code they use.

| Question | Response |
|----------|----------|
| How do you plan, prioritize and schedule work? | By feature completion against spec |
| How do you manage suppliers for outsourced development? | None of the above/not applicable |
| What is your definition of done? | The person doing the work decides if work is complete |
| How do development and operations teams collaborate during a production issue? | Not applicable because Ops handles production issues independently |
| What are your policies around open software? | We do not have a policy about using open source |

Click **Next Category**.

### Version Control

The team uses centralized version control, which makes it difficult for developers to contribute to the same source files. It also makes it difficult to work when not connected to the corporate network.

Alice also wonders why Bob hasn't yet reviewed any of her code. She only hopes that her new features are written correctly and function as she intends.

| Question | Response |
|----------|----------|
| What files do you keep under version control? | Application source code |
| What is your branching policy? | We have no branches and develop only in the trunk or master |
| How do you review code changes? | We review code changes infrequently |
| How do you manage code dependencies across teams? | We track them in a spreadsheet or document |

### Continuous Integration and Continuous Delivery

When QA has identified a release candidate, the team schedules a review with the company's leadership team. The leadership team decides whether the release candidate goes out or if more work is needed.

These meetings cause the team some anxiety, as they've put in a lot of effort before getting feedback.

| Question | Response |
|----------|----------|
| How do you roll out new features to users? | We deploy when the appropriate manager approves |

### Cloud and Infrastructure

The operations team deploys each web site to an on-prem datacenter. Players report that the site is slow during weekends and holidays.

Operations holds the SSH keys and passwords to access the servers. That means only they can take action when the site goes down or needs maintenance.

| Question | Response |
|----------|----------|
| What is your policy for using the public cloud? | None of the above/not applicable |
| How are passwords and other secrets managed? | Secrets are managed by Operations |

### Testing

Alice hasn't seen any unit tests in the projects she's looked at, including her current project, the web site for _Space Game_. No wonder Carol from QA is always coming back to the team with bugs when existing functionality breaks when the dev team adds new features.

The teams have pushed back on developing mobile apps for their games because they say maintaining standard web sites is hard enough.

| Question | Response |
|----------|----------|
| What does your team consider good testing? | We do not have a standard for good testing |
| When do you test for security? | We do not have a prescribed cadence for security tests |
| How do you test mobile apps? | We don't develop mobile apps |

### Monitoring

Alice knows that the operations team uses ping requests to monitor their systems for uptime. She's almost certain that they don't monitor resource usage or collect crash data and telemetry of who's accessing the sites, and when.

| Question | Response |
|----------|----------|
| What instrumentation do you use to monitor applications running in production? | Availability monitoring via pinging or synthetic transactions |

Click **Next Category**.

### Culture

The teams get along, but don't always communicate their plans, decisions, or failures. In fact, Bob has told Alice that change is hard because the leadership team has called out failures (and who caused them) through emails and at all-hands meetings.

| Question | Response |
|----------|----------|
| Who makes decisions in the organization? | Decision making is inconsistent |
| How does your team collaborate, share risks, innovate, and learn? | There is some communication. When mistakes are made, there is justice for the responsible person |
| When corporate governance discovers that a project "is breaking the rules," what happens? | The corporate governance body will negotiate with the business unit to replace a non-compliant project |

Click **Next Category**.

### Measurement

Carol from QA receives a quarterly bonus based on the number of bugs she's found. Although she's well-intentioned, Carol has the incentive to report the same bug repeatedly rather than trying to solve the underlying problem.

| Question | Response |
|----------|----------|
| How do you measure code quality? | Based on bugs found |
| What decisions do you make by looking at usage data from your applications? | None of the above/not applicable |

Click **Next Category**.

### Outcomes

Alice joined Tailspin because they make great video games. Both Alice's immediate coworkers and the game design and development teams seem to like working at Tailspin.

However, Alice already gets the sense that things don't always go as planned and schedules slip. Processes she feels should happen almost instantly can take days or even weeks. Many work weekends to meet deadlines.

In today's market, influencers and critics can have a bit impact on whether your game is a roaring success or a complete flop. Having a successful web site at the launch of each new game is critical because it provides players with the latest game info and a link to download the game.

| Question | Response |
|----------|----------|
| For the application or service you work on, how often does your organization deploy code to production? | Between once per month and once every 6 months |
| What is your lead time for changes (i.e., how long does it take to go from "code committed" to "code successfully running in production")? | Between one week and one month |
| How long does it generally take to restore service when a service incident occurs (e.g., unplanned outage, service impairment, etc.)? | Between one day and one week |
| When you deploy a change to the primary application or service you work on, what percentage of the changes result in degraded service or subsequently require remediation? | 31%-45% |
| How satisfied are you with your job? | I like my job |

Click **Get your results**.

### Examine the results

Alice gets back a graph.

![The team's progress for each of the Self-Assessment categories](../media-draft/4-assessment-results.png)

The graph summarizes the team's progress for each of the Self-Assessment categories. Each category is a point. The further the point is from the center, the more mature the team is for that category.

The blue boundary that connects the points makes it easy to see the team's overall progress. For example, the Tailspin team is further along in Culture, Technology, and Outcomes than it is in Measurement and Process. You can also hover over a point to get a numerical value, which is another way to compare results for each category.