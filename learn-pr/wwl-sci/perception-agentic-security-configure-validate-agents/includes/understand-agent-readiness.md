---
no_index_ks: true
---

An agent marked Enabled is available for use, but that status doesn't prove that a security practitioner can complete the required task. Readiness depends on how the work, agent access, and security practitioner access fit together.

## Connect the work from requirements to handoff

Approved task → required agent → agent and security practitioner access → testing → handoff

Start with what the team needs to accomplish and what a successful result looks like. Those requirements determine the supported workflow, the agent it needs, and the data the agent must use. They also define what you need to test, including security practitioner actions such as starting a session, responding to a plan, and retrieving a report.

For example, extracting indicators and attacker behaviors from a threat report requires a different capability from coordinated protection analysis. Keep configuration and testing within the approved task. Broader work needs its own authorization.

## Keep setup authority and the two kinds of access separate

Setup authority, agent permissions, and security practitioner access serve different purposes. One person might both configure and use the agent, but these permissions still need separate checks:

- **Setup account**: Needs authority to configure the agent. Grant additional permissions within your authority, or request them through your organization's access-management process.
- **Agent identity**: Runs the agent's work with its own assigned permissions and resource access.
- **User account**: Needs access to start the workflow, respond to requests, and review the output.

The required services must also be available. Check both the organization's access to each service and the agent's permission to use it. For example, MDTI enrichment requires access to the service as well as the agent's API grant.

These checks establish the conditions for the test. They also help you locate a problem before changing access. If a security practitioner can't start a session, check their access. If the session can't read required data, check the agent identity, its access, and service availability.

## Test the setup with a security practitioner's account

Configuration checks show that the required settings and services are in place. Testing the task shows whether they work together. Use an account with the access needed for the security work, so the results reflect what that person can do.

The security practitioner runs the workflow and evaluates the findings. Check whether the required actions and data access work, then retain the security practitioner's assessment of the output against the agreed criteria.

Use those results to decide whether the configuration is ready for the approved task. A failed or untested requirement needs follow-up before you record readiness. The handoff carries the tested configuration, results, remaining limits, and ownership to the next person. Your readiness assessment supports the organization's operational approval process rather than replacing it.
