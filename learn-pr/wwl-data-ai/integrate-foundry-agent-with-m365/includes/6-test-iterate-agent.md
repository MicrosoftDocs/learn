Testing is essential throughout the agent development and publishing lifecycle. Different testing environments serve different purposes, from rapid iteration during development to validation after deployment. Understanding when and how to use each testing approach helps you deliver reliable agents to your users.

## Testing in the Foundry playground

The Foundry portal includes an integrated playground for testing your agents during development. This environment is your primary tool for rapid iteration before publishing.

### Using the playground effectively

The playground provides a chat interface where you can:

- Send messages to your agent and review responses
- Test different types of user inputs to check agent behavior
- Verify that instructions produce the intended responses
- Check that configured tools are invoked correctly

When testing in the playground:

1. **Test typical scenarios**: Start with the most common questions your users will ask.
2. **Test edge cases**: Try unusual inputs, misspellings, and off-topic questions.
3. **Test tool invocations**: If your agent uses tools, verify they're called appropriately and return expected results.
4. **Review response quality**: Check that responses are accurate, appropriate in tone, and correctly formatted.

### Limitations of the playground

The Foundry playground tests your agent in isolation. It doesn't simulate:

- The Teams or Copilot user interface
- Authentication flows users experience
- Network conditions between Teams and your agent
- The published agent identity and its permissions

You need additional testing after publishing to verify the full integrated experience.

## Testing in Microsoft Teams

After publishing your agent, test it directly in Microsoft Teams to verify the complete integration.

### Upload the publishing package

If you downloaded the publishing package:

1. Open Microsoft Teams.
2. Go to **Apps** > **Manage your apps** > **Upload an app**.
3. Select **Upload a custom app** and choose your `.zip` file.
4. Wait for Teams to install the agent.

### Verification checklist

When testing your published agent in Teams, verify:

| Area | What to check |
|------|---------------|
| **Basic responses** | Agent responds to messages correctly |
| **Response times** | Responses arrive within acceptable timeframes |
| **Tool functionality** | Tools configured in Foundry work after publishing |
| **Permissions** | Agent can access resources it needs (if using tools with Azure resources) |
| **Error handling** | Agent handles errors gracefully without exposing technical details |
| **Conversation flow** | Multi-turn conversations maintain context appropriately |

### Testing with multiple users

If possible, have colleagues test your agent to discover issues you might miss:

- Different users may phrase questions differently
- Fresh perspectives identify confusing responses
- Testing across different Teams clients (desktop, web, mobile) reveals platform-specific issues

## Common troubleshooting scenarios

When issues arise, these common scenarios and resolutions can help:

### Agent doesn't respond in Teams

**Possible causes:**
- Azure Bot Service isn't running
- Bot Service configuration is incorrect
- Network issues between Teams and your agent

**Resolution steps:**
1. Verify the Bot Service resource exists in the Azure portal.
2. Check Bot Service logs for errors.
3. Confirm the agent is published and the package was uploaded correctly.

### Tools work in Foundry but fail in Teams

**Possible cause:** The published agent identity doesn't have the required permissions.

**Resolution:**
1. Find the published agent's identity in the Foundry portal.
2. In the Azure portal, locate the resources your tools access.
3. Assign appropriate RBAC roles to the published agent identity.

### Users can't find the agent

**Possible causes:**
- Wrong publish scope selected
- Admin approval pending (for organization scope)
- Tenant policies block custom apps

**Resolution:**
- For shared scope: Share the direct link with users.
- For organization scope: Verify admin approval in the Microsoft 365 admin center.
- Check tenant settings for custom app permissions.

### Slow response times

**Possible causes:**
- Complex agent instructions requiring extended processing
- Tools that query large data sets
- Network latency

**Resolution:**
- Simplify agent instructions where possible.
- Optimize tool configurations.
- Test from different network locations to isolate network issues.

## Monitoring published agents

After deployment, ongoing monitoring helps identify issues before users report them:

### Check Foundry metrics

The Foundry portal provides metrics for published agents:

- Request volume and patterns
- Response times
- Error rates
- Tool invocation statistics

Review these metrics regularly to spot trends that indicate problems.

### Review Application Insights

If you've configured Application Insights integration, you can:

- Trace individual conversations
- Analyze error patterns
- Measure end-to-end latency
- Set up alerts for anomalies

### Gather user feedback

Establish channels for users to report issues:

- Create a Teams channel or email address for agent feedback
- Periodically review feedback to identify common problems
- Use feedback to prioritize agent improvements

## Iterating on your agent

When you need to update your published agent:

1. Make changes in the Foundry portal.
2. Test thoroughly in the Foundry playground.
3. Republish to create an updated package.
4. Deploy the updated package to Teams.
5. For organization scope, updates may require re-approval depending on your tenant's policies.

> [!TIP]
> Keep a testing checklist specific to your agent. Document the key scenarios you test before each release to ensure consistent quality.
