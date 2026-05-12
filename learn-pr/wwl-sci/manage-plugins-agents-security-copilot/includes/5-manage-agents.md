Deploying agents is the beginning, not the end. Security operations evolve, and the agents supporting them need to keep pace. Security Copilot provides controls to run, pause, edit, and refine agent behavior—including a memory system that lets you teach agents to produce more relevant outputs over time.

## Control agent execution

Agents can run automatically based on a configured trigger or manually on demand:

- **Automatic (on trigger)**: the agent runs on its configured schedule or in response to the defined event. When the trigger is active, the agent runs without manual intervention.
- **Manual (one time)**: select **One time** to run the agent immediately, regardless of its trigger schedule. Use "one time" to validate a configuration change or run an ad-hoc investigation.

To pause or resume an agent:

1. Navigate to the agent page.
2. Select **Pause** to stop automatic runs, or **Run** to resume.

> [!NOTE]
> If you switch the assigned workspace for an agent, turn off any scheduled or automatic triggers first. Set up the agent again in the new workspace to continue using it. Agents don't carry feedback or memories between workspaces.

## Edit agent configuration

As requirements change, you can modify an agent's identity, trigger, or other parameters without removing and recreating it.

1. Navigate to the agent you want to update.
2. Select **Edit**.
3. Update the relevant settings, then select **Finish**.

Changes take effect for subsequent executions and don't affect any in-progress runs.

## Provide feedback to improve agent performance

Agents improve when you tell them what's working and what isn't. When an agent's output isn't right—perhaps it's investigating the wrong entity types, or its summaries are too verbose—you can provide targeted feedback.

1. In the agent results pane, select the **feedback** button.
2. From the dropdown, choose who the feedback is for:
   - **For the agent**: feedback is stored in the agent's memory and shapes future outputs
   - **To Microsoft**: product feedback sent to the Security Copilot development team for future improvements—this feedback isn't stored in agent memory
3. Provide details and select **Submit**.

Feedback directed to the agent is persistent. The agent factors it into its reasoning on every subsequent run until you remove it from memory.

## Manage agent memory

Agent memory stores the feedback you provided and lets you review and control what the agent retains.

1. From the agent page, select the overflow menu **(...)** > **Manage memory**.
2. Your previously submitted feedback entries are listed.
3. Select an entry to review it.
4. To remove it, select **Reject feedback**. The agent no longer considers that entry when forming outputs.

Memory management is useful when previous feedback becomes outdated—for example, if team scope or processes changed—or when experimental feedback produced unintended results that you want to reverse.

## Build agent effectiveness over time

Well-managed agents improve incrementally. A threat triage agent that consistently receives feedback about which alert types warrant escalation becomes progressively better at filtering noise. An intelligence briefing agent whose memory reflects current scope definitions delivers more focused summaries.

The combination of run controls, targeted feedback, and memory management gives you the flexibility to adapt agents as your security environment changes—without requiring a full reconfiguration from scratch.
