After publishing your agent using the steps in the previous units, ongoing testing and monitoring help ensure your agent performs reliably for users. This unit focuses on post-deployment testing strategies, troubleshooting common issues, and monitoring your agent over time.

## Testing beyond the Foundry playground

The Foundry playground is valuable for development testing, but it doesn't simulate the full published experience. After publishing, test your agent in Microsoft Teams to verify:

- The Teams user interface renders responses correctly
- Authentication flows work as expected
- Response times are acceptable in production
- The published agent identity has necessary permissions

### Testing with multiple users

Have colleagues test your agent to discover issues you might miss. Different users phrase questions differently, and fresh perspectives identify confusing responses. Testing across different Teams clients (desktop, web, mobile) can also reveal platform-specific issues.

## Common troubleshooting scenarios

When issues arise, these common scenarios and resolutions can help:

### Agent doesn't respond in Teams

**Possible causes:**
- Azure Bot Service isn't running
- Bot Service configuration is incorrect
- Network issues between Teams and your agent

**Resolution:**
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

When testing reveals issues or you receive user feedback, update your agent in the Foundry portal and republish following the same process covered in the publishing unit. For organization scope deployments, check your tenant's policies to determine if updates require re-approval.

> [!TIP]
> Keep a testing checklist specific to your agent. Document the key scenarios you test before each release to ensure consistent quality.
