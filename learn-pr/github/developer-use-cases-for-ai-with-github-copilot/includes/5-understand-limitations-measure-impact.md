While GitHub Copilot offers significant benefits, it's crucial to understand its limitations and accurately measure its impact on development processes. This unit explores the constraints of AI-assisted coding and introduces methods to quantify GitHub Copilot's influence on productivity.


## Identify limitations of GitHub Copilot

While GitHub Copilot is a powerful tool, it has limitations that developers should be aware of:

### Code quality and correctness

- **Potential for errors:** GitHub Copilot can sometimes suggest code that contains bugs or doesn't fully meet requirements.
- **Security concerns:** Generated code may not always adhere to best security practices, requiring careful review.
- **Context misinterpretation:** GitHub Copilot might misunderstand the broader context, leading to inappropriate suggestions.

### Language and framework specificity

- **Varying performance:** GitHub Copilot's effectiveness can vary across different programming languages and frameworks.
- **Niche technologies:** For less common or newer technologies, suggestions may be less accurate or relevant.

### Dependency on training data

- **Bias in suggestions:** GitHub Copilot's suggestions reflect patterns in its training data, which may include biases or outdated practices.
- **Copyright concerns:** There's ongoing debate about the copyright implications of code generated from trained models.

### Complex problem solving

- **Limitation in high-level design:** GitHub Copilot excels at code-level tasks but may not grasp complex architectural decisions.
- **Creativity constraints:** While helpful, GitHub Copilot cannot replace human creativity in solving novel problems.

## Measure productivity gains

Understanding the productivity gains provided by GitHub Copilot is essential to maximizing its benefits. The **REST API for GitHub Copilot usage metrics** and **GitHub Copilot Developer Survey** offers a powerful way to measure and analyze how GitHub Copilot influences your development workflow. This section introduces methods to evaluate GitHub Copilot’s impact using these tools and related metrics.

### Use the REST API endpoints for GitHub Copilot usage metrics 

GitHub provides a REST API to access GitHub Copilot usage metrics for enterprise members, teams, and organization members. These metrics offer insights into daily usage of GitHub Copilot, including completions, chat interactions, and user engagement across different editors and languages.

#### Get a summary of GitHub Copilot usage for enterprise members

**Endpoint:** `GET /enterprises/{enterprise}/GitHub Copilot/usage`

This endpoint provides a daily breakdown of aggregated usage metrics for GitHub Copilot completions and GitHub Copilot Chat across all users in an enterprise. It includes details on suggestions, acceptances, and active users, further broken down by editor and language.

**Example request:**
```bash
curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer <YOUR-TOKEN>" \
  https://api.github.com/enterprises/ENTERPRISE/GitHub Copilot/usage
```

**Response:**
- **Status Code:** `200 OK`
- **Body:** JSON array with daily metrics, including suggestions, acceptances, active users, and breakdown by editor and language.

#### Get a summary of GitHub Copilot usage for an enterprise team

**Endpoint:** `GET /enterprises/{enterprise}/team/{team_slug}/GitHub Copilot/usage`

This endpoint provides a daily breakdown of aggregated usage metrics for GitHub Copilot completions and GitHub Copilot Chat within a specific enterprise team.

**Example request:**
```bash
curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer <YOUR-TOKEN>" \
  https://api.github.com/enterprises/ENTERPRISE/team/TEAM_SLUG/GitHub Copilot/usage
```

**Response:**
- **Status Code:** `200 OK`
- **Body:** JSON array with daily metrics for the team, including suggestions, acceptances, active users, and breakdown by editor and language.

#### Get a summary of GitHub Copilot usage for organization members

**Endpoint:** `GET /orgs/{org}/GitHub Copilot/usage`

This endpoint provides a daily breakdown of aggregated usage metrics for GitHub Copilot completions and GitHub Copilot Chat across an organization.

**Example request:**
```bash
curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer <YOUR-TOKEN>" \
  https://api.github.com/orgs/ORG/GitHub Copilot/usage
```

**Response:**
- **Status Code:** `200 OK`
- **Body:** JSON array with daily metrics for the organization, including suggestions, acceptances, active users, and breakdown by editor and language.


### Implementing a measurement framework

To systematically assess GitHub Copilot’s impact, consider the following framework, using the GitHub Copilot usage metric API at each stage:

1. **Evaluation:** During the initial phase of adopting GitHub Copilot, focus on leading indicators such as developer satisfaction and task completion rates. Use the API to collect metrics like Average Daily Active Users, Total Acceptance Rate, and Lines of Code Accepted.

2. **Adoption:** As GitHub Copilot becomes more integrated into your team’s workflow, continue to monitor productivity metrics and enablement indicators. The API can provide insights into user engagement and identify areas where further training may be needed.

3. **Optimization:** Once GitHub Copilot is fully adopted, use the REST API for GitHub Copilot usage metrics to fine-tune its impact on broader organizational goals, such as reducing time-to-market or improving code quality across the team.

4. **Sustained efficiency:** Continuously evaluate GitHub Copilot’s effectiveness as your organization evolves. The API allows for ongoing monitoring and adjustment to ensure long-term productivity gains.

### Use the GitHub Copilot developer survey

The GitHub Copilot Developer Survey is a valuable tool designed to gather insights from your teams, helping you understand how GitHub Copilot is being used, its benefits, and any challenges developers face. This survey is divided into two formats: short-form and long-form, each serving different purposes throughout the GitHub Copilot evaluation and adoption stages.

**1. Survey cadence and timing**

When deploying the GitHub Copilot Developer Survey, it's important to establish a regular cadence to avoid survey fatigue while still gathering meaningful data.

- **Short-form survey**: Can be conducted every two weeks if frequent feedback is needed, especially when coupled with other feedback channels like online or in-person discussions. 
- **Long-form survey**: Recommended to be conducted no more than once every four weeks, particularly at the end of the evaluation and adoption stages, to capture comprehensive feedback.

**2. Structuring the survey**

The survey questions should be tailored to fit your organization’s specific needs, ensuring that the data collected is relevant and actionable. Here’s how to structure both the short-form and long-form surveys:

- **Short-form survey**: Focuses on immediate feedback, capturing developers' overall satisfaction with GitHub Copilot, specific challenges faced, and time saved or wasted.
  - Example questions:
    - "How would you feel if you could no longer use GitHub Copilot?"
    - "When using GitHub Copilot, I enjoy coding more / write better quality code / complete tasks faster."
    - "What challenges have you encountered in using GitHub Copilot since your last survey?"

- **Long-form survey**: Offers a deeper analysis of GitHub Copilot’s impact, capturing detailed insights into its usage and benefits, and how it affects team dynamics.
  - Example questions:
    - "I use GitHub Copilot to code in a familiar language / explore a new language / write repetitive code."
    - "When using GitHub Copilot, my team provides better code reviews / merges code to production faster."
    - "What challenges have you encountered in using GitHub Copilot since your last survey?"

**3. Analyzing survey results**

Once the surveys are completed, it’s important to analyze the results systematically:

- **Privacy considerations**: Ensure that survey responses are anonymized and cannot be traced back to individual developers, meeting privacy obligations.
- **Data tracking**: Collate the survey responses into existing Business Intelligence (BI) tools or spreadsheets for ease of analysis. Over time, track the results to identify trends and make informed decisions about GitHub Copilot’s implementation.
  
**4. Continuous improvement**

Use the insights gathered from the surveys to make informed decisions about GitHub Copilot's deployment in your organization. Focus on addressing the challenges identified, leveraging the benefits reported by developers, and adjusting the tool’s use to maximize productivity.

The GitHub Copilot Developer Survey is a critical component in understanding and enhancing the use of GitHub Copilot within your teams.

By leveraging the REST API and survey for GitHub Copilot usage metrics, you can move beyond anecdotal evidence and gain concrete insights into how GitHub Copilot influences your coding process. This data-driven approach allows for informed decision-making and continuous improvement on GitHub Copilot's role in the development workflow and helps identify areas where its use can be optimized for maximum benefit.