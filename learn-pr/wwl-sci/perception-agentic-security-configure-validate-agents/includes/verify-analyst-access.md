---
no_index_ks: true
---

Check people's access separately from the agent's data permissions. Establish who needs to use the agent and whether their permitted actions match the approved task.

## Establish the access people need

Check two layers of access:

- **Portal role**: Confirm Security Reader, the documented role for viewing and interacting with sessions. Reserve Security Admin for work that requires setup authority.
- **Agent settings**: Confirm Run access to each participating agent and the actions required by the task, such as starting sessions, responding to requests, and viewing output.

Use the [agent configuration guidance](/security/agentic-security/agentic-security-agents?azure-portal=true) to check those settings.

## Check the configuration with the intended account

For a Threat Intelligence Agent test, use the account the security practitioner normally uses for security work. The security practitioner signs in with their own approved access. Keep setup credentials private.

- Check the account's Security Reader assignment. If you have role-management authority, make any missing approved assignment. Otherwise, request it through your organization's role-management process. Retain confirmation of the completed assignment.
- In Perception > Agents, open the configured agent and inspect Role-based access. For Extract threat intelligence, check the Threat Intelligence Agent.
- If an agent-level change is required, select Edit, check the user-role settings for execution, steering, and viewing, and select Save changes after the approved adjustment. Confirm that the saved settings match the intended access.
- Check that the security practitioner can reach the supported workflow and the sessions they need to review. This is a preliminary access check, not the full task test.

For the documented role-assignment method, see [Assign Microsoft Entra roles](/entra/identity/role-based-access-control/manage-roles-portal?azure-portal=true). Assigning a role requires the appropriate role-management authority, separately from Perception setup access.

## Keep the test within the approved role

For example, a security practitioner might be able to view a shared report but be unable to start the workflow. Check their permission to start sessions with the agent and their portal role. Correct the account's access, then test again under that account. The agent's API grants address its data access, not the security practitioner's ability to start work.

Record the intended account or approved user role, confirmed portal role, saved settings, and preliminary access result under Security practitioner role and agent settings. Opening the workflow confirms initial access. Completing the task with that account establishes whether all required actions work.
