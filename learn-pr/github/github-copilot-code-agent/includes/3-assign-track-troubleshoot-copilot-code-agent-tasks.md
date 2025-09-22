The GitHub Copilot coding agent acts as an autonomous teammate that works directly inside GitHub. Once it is enabled, you can assign it a task, watch its progress in real time, and guide its work by leaving comments on its pull requests. This unit explains how to assign issues to Copilot using GitHub.com, GitHub Mobile, the API, or the CLI. It also shows you how to track the agent's work and iterate with it, and provides a troubleshooting playbook for common issues.

### By the end of this unit, you will be able to:

- Assign issues to Copilot using GitHub.com, GitHub Mobile, the API, or the CL.
- Monitor Copilot's progress through pull request timelines and session logs.
- Iterate on Copilot's work by commenting on its pull requests.
- Understand the approval rules for agent-generated pull requests.
- Troubleshoot common problems when delegating tasks to Copilot.

### **Assigning issues to Copilot**

When you assign an issue to Copilot, the agent acknowledges it by adding an 👀 reaction to the issue. It then creates a dedicated `copilot/` branch, opens a draft pull request linked to the issue, and begins an agent session inside a GitHub Actions-powered environment. As it works, Copilot pushes commits to the branch and updates the pull request body with status messages. Once the task is complete, Copilot posts a "Copilot finished work" event and requests your review.

:::image type="content" source="../media/repository-navigation-issues.png" alt-text="Screenshot of a GitHub repository navigation bar highlighting the Issues tab with the number of open issues displayed." lightbox="../media/repository-navigation-issues.png":::

On GitHub.com, you assign an issue to Copilot just like you would assign it to another user. Navigate to the repository's Issues tab, open the issue you want to delegate, and in the right sidebar under Assignees, select Copilot. Copilot receives the issue title, description, and any existing comments at the time of assignment. Later comments on the issue are not seen by the agent, so add new information as comments directly on the agent's pull request.

:::image type="content" source="../media/issue-assignees-copilot.png" alt-text="Screenshot of the GitHub issue Assignees panel showing the option to assign Copilot as an AI pair programmer." lightbox="../media/issue-assignees-copilot.png":::

You can also assign issues to Copilot from the list of issues on a repository's Issues page, from GitHub Projects, or by using GitHub Mobile. For command-line workflows, you can use the GitHub CLI (`gh issue edit`) to add Copilot as an assignee.

## Assigning via the API

You can assign issues to Copilot programmatically through the GraphQL API. First, check that the coding agent is available by querying `suggestedActors` for the repository and verifying that `copilot-swe-agent` appears as a suggested actor. Next, fetch the repository ID. To create and assign a new issue, use the `createIssue` mutation, passing the repository ID and Copilot's bot ID. To assign an existing issue, fetch the issue ID and then use the `replaceActorsForAssignable` mutation to add Copilot as the assignee. This approach is useful for integrating Copilot into automated workflows.

### Availability check

```
query {
  repository(owner: "octo-org", name: "octo-repo") {
    suggestedActors(capabilities: [CAN_BE_ASSIGNED], first: 100) {
      nodes { login __typename ... on Bot { id } ... on User { id } }
    }
  }
}

```

### Get repository id

```
query {
  repository(owner: "octo-org", name: "octo-repo") { id }
}

```

### Create and assign a new issue

```
mutation {
  createIssue(
    input: {
      repositoryId: "REPOSITORY_ID",
      title: "Implement comprehensive unit tests",
      body: "DETAILS",
      assigneeIds: ["BOT_ID"]
    }
  ) {
    issue { id title assignees(first: 10) { nodes { login } } }
  }
}
```

### Assign an existing issue

```
query {
  repository(owner: "monalisa", name: "octocat") {
    issue(number: 9000) { id title }
  }
}

mutation {
  replaceActorsForAssignable(
    input: { assignableId: "ISSUE_ID", actorIds: ["BOT_ID"] }
  ) {
    assignable {
      ... on Issue {
        id title
        assignees(first: 10) { nodes { login } }
      }
    }
  }
}

```

### Tracking Copilot's progress

After you assign an issue to GitHub Copilot, the agent provides visible signals so you can follow its work from start to finish.

- **Immediate confirmation.** Shortly after you assign an issue, Copilot adds an 👀 reaction to the issue.
  
  :::image type="content" source="../media/issue-description-sub-issue.png" alt-text="Screenshot of a GitHub issue description showing steps to reproduce and the option to create a sub-issue." lightbox="../media/issue-description-sub-issue.png":::

- **Draft pull request creation.** Within a few seconds, Copilot opens a draft pull request linked to the original issue. A new event appears in the issue's timeline showing the pull request.

  :::image type="content" source="../media/issue-comment-copilot-mention.png" alt-text="Screenshot of a GitHub issue comment where Copilot mentions a related issue with a link to issue number 1123." lightbox="../media/issue-comment-copilot-mention.png":::

- **Active agent session.** Copilot starts an agent session to work on your issue. You'll see a "Copilot started work" event in the pull request timeline. As it runs, Copilot updates the pull request body with regular status messages and pushes commits to the dedicated branch.

  :::image type="content" source="../media/issue-timeline-copilot-started-work.png" alt-text="Screenshot of a GitHub issue timeline where Copilot started work on behalf of a user." lightbox="../media/issue-timeline-copilot-started-work.png":::

- **Live session logs.** All your sessions-past and present-are visible from the Agents page. Click View session on the pull request to open the live session log viewer and watch Copilot's actions in real time. If you need to stop Copilot, click Stop session in the viewer. 

- **Completion and review.** When Copilot finishes its work, the agent session ends automatically. A **"Copilot finished work"** event appears in the pull request timeline, and Copilot requests a review from you, triggering a notification.

  :::image type="content" source="../media/issue-timeline-copilot-finished-work.png" alt-text="Screenshot of a GitHub issue timeline where Copilot finished work on behalf of a user after requesting a review." lightbox="../media/issue-timeline-copilot-finished-work.png":::

### Iterating with Copilot

You guide Copilot's work the same way you would guide a human contributor-through comments and reviews. Mention @copilot in a pull request comment to request changes. Only comments from users with write permission to the repository are processed. Copilot posts an 👀 reaction to your comment to confirm that it has received the request, then adds "Copilot started work" to the pull request timeline as it resumes. This allows you to iterate on Copilot's work without leaving your normal review workflow.

### Approvals and workflows

Pull requests created by Copilot are always in draft state. They require human approval before merge, and GitHub Actions workflows triggered by the agent do not run automatically. To run workflows on a Copilot pull request, click Approve and run workflows in the merge box. The developer who asked Copilot to create the pull request cannot approve it, which preserves your repository's "required reviews" rules and ensures an independent review before merge.

### Troubleshooting Copilot coding agent

- **Copilot not in "Assignees" list**

  Ensure you're on an eligible plan (Pro, Pro+, Business, Enterprise). Confirm the agent isn't disabled at the org/repo level. Verify on your features page: `github.com/settings/copilot/features`. 

- **Enterprise Managed User (EMU) personal repositories** 
  
  Agent not available; use organization-owned repositories (requires GitHub-hosted runners).
 

- **"Cannot create a pull request" from Chat** 
  
  Ensure the agent is available. In IDEs, mention @github in your prompt (not required on GitHub.com).
 

- **Assigned an issue but nothing happened** 
  
  Refresh; look for the **👀** reaction, then a draft PR.

- **PR created but no progress** 
  
  Check PR timeline for "Copilot started work"; open View session logs.

- **Agent not responding to PR comment** 
  
  Confirm you have write access and mentioned @copilot on the agent's PR.

- **Appears stuck** 
  
  It may recover; sessions time out after one hour. Retry by unassigning/reassigning the issue or reposting the comment.

- **Actions aren't running** 
  
  Click Approve and run workflows in the merge box.

- **Pushes don't pass CI** 
  
  Provide clear repo-level guidance via .github/copilot-instructions.md so the agent can self-validate with tests/linters.

- **Firewall warnings** 
  
  The Internet is restricted by default; warnings list the blocked address and command. Adjust per [Customizing or disabling the firewall for GitHub Copilot coding agent.](https://docs.github.com/en/copilot/customizing-copilot/customizing-or-disabling-the-firewall-for-copilot-coding-agent)

- **Images not picked up** 
  
  Max image size is 3.00 MiB; larger images are removed.

With a reliable assign-track-iterate loop in place, you can boost consistency and speed by customizing the agent's environment, extending it with MCP tools, and enforcing robust validation before merge.