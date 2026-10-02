Testing helps you confirm that an agent follows its instructions, stays focused on its purpose, and produces a useful result. Refinement turns what you learn from testing into focused improvements.

In this exercise, you'll test the Customer Meeting Prep agent with typical, incomplete, and out-of-scope requests. You'll review its responses, update its instructions, and test it again to confirm that your changes improved the agent.

When you finish, the agent will produce a more consistent meeting preparation brief and clearly identify when it needs more information.

>[!NOTE]
> The location or name of some options might vary based on your organization's configuration.

## Open the agent for editing

Open the Customer Meeting Prep agent in Agent Builder so you can test and update its configuration.

:::image type="content" source="../media/copilot-chat-test-agent-response.png" alt-text="Screenshot of Microsoft 365 Copilot Chat with the Customer Meeting Prep Agent selected in the left pane and ready to receive a message.":::

1. Open Microsoft 365 Copilot Chat and sign in with your work account.
2. In the left pane, locate **Customer Meeting Prep**.
3. Select the ellipsis (**...**) next to the agent's name.
4. Select **Edit**.
5. Confirm that the agent opens in Agent Builder.
6. Select the **Try it** tab.

If the agent doesn't appear in the left pane, select **All agents** or **New agent**, and then select **View all agents**. Locate **Customer Meeting Prep**, select the ellipsis (**...**), and then select **Edit**.

:::image type="content" border="true" source="../media/copilot-chat-edit.gif" alt-text="Animation showing how to open the Customer Meeting Prep agent for editing in Microsoft 365 Copilot Chat.":::

## Test a typical request

Begin with a request that provides enough information for the agent to prepare a meeting brief.

1. On the **Try it** tab, select **New chat** if a previous conversation is displayed.
1. Enter the following request:

    ```text
    Prepare a meeting brief for Contoso Outdoor Equipment.

    The goal of the meeting is to discuss how the customer can improve productivity and security for its hybrid sales team.

    Customer information:
    - The company has 75 employees.
    - Its sales team works from the office, at home, and while traveling.
    - Several employee devices are reaching the end of their lifecycle.
    - The IT team wants to simplify device deployment and management.
    - Leadership is concerned about protecting company information on remote devices.
    ```

1. Submit the request.
1. Review the response.
1. Confirm that the response focuses on the provided customer information.
1. Note any missing sections, unsupported assumptions, or areas that could be more clearly organized.

The response should help a sales team member understand the customer, prepare discussion topics, and identify useful questions for the meeting.

## Test how the agent handles missing information

An effective agent should recognize when it doesn't have enough information to complete its task.

1. On the **Try it** tab, select **New chat**.
1. Enter the following request:

    ``` text
    Help me prepare for a customer meeting.
    ```

1. Submit the request.
1. Review how the agent responds.
1. Confirm that it asks for the customer name, meeting goal, or other information it needs.
1. Verify that it doesn't invent customer details.

If the agent creates a complete brief without requesting more information, its instructions need a clearer boundary for handling incomplete requests.

## Test an out-of-scope request

Testing an unrelated request helps you determine whether the agent remains focused on its intended purpose.

1. Select **New chat**.
1. Enter the following request:

    ``` text
    Create a complete annual sales strategy for my organization.
    ```

1. Submit the request.
1. Review the response.
1. Confirm that the agent explains its focus on customer meeting preparation or redirects the request toward that purpose.

The agent can still be helpful, but it shouldn't present itself as designed to manage tasks outside its defined job.

## Refine the agent's instructions

Use what you observed during testing to make the agent's output more consistent. For this exercise, add a required structure for every meeting preparation brief.

1. Select the **Describe** tab.
1. Enter the following refinement:

    ``` text
    Update the agent's instructions so every customer meeting preparation brief uses these headings in this order:

    1. Customer overview
    2. Meeting goal
    3. Customer priorities
    4. Relevant information
    5. Recommended discussion topics
    6. Suggested questions
    7. Missing information

    If information for a section isn't available, clearly state that more information is needed. Don't create or assume customer details that weren't provided by the user or found in the agent's approved knowledge sources.
    ```

1. Submit the refinement.
1. Review Agent Builder's response.
1. Select the **Configure** tab.
1. Review the **Instructions** section and confirm that the required headings and boundaries are included.
1. Make any necessary edits.

Review the updated configuration and then use the available save or update control to apply your changes.

## Test the refined agent

Repeat the original test to determine whether the updated instructions improved the response.

| **Before refinement** | **After refinement** |
| :---: | :---: |
| Inconsistent structure | Uses required headings |
| Missing sections | Includes all required sections |
| May omit missing information | Explicitly identifies missing information |
| Variable organization | Consistent output format |

1. Select the **Try it** tab.
1. Select **New chat**.
1. Enter the following request:

    ``` text
    Prepare a meeting brief for Contoso Outdoor Equipment.

    The goal of the meeting is to discuss how the customer can improve productivity and security for its hybrid sales team.

    Customer information:
    - The company has 75 employees.
    - Its sales team works from the office, at home, and while traveling.
    - Several employee devices are reaching the end of their lifecycle.
    - The IT team wants to simplify device deployment and management.
    - Leadership is concerned about protecting company information on remote devices.
    ```

1. Submit the request.
1. Compare the new response with the response from your first test.
1. Confirm that the brief uses the required headings.
1. Verify that the agent identifies missing information instead of creating unsupported details.

The response doesn't need to match your first test word for word. Look for improvements in structure, relevance, clarity, and grounding.

The goal isn't to create a perfect agent on the first revision. The goal is to confirm that your changes improved the response in a measurable way.

## Update the agent

After confirming that the refinement improved the agent, make the changes available in Microsoft 365 Copilot Chat.

1. Select **Update** in the upper-right corner of Agent Builder.
1. Wait for the update to finish.
1. Confirm that the agent was updated successfully.
1. Return to **Customer Meeting Prep** in Microsoft 365 Copilot Chat.

Don't share the agent yet. A real-world agent should be tested with additional scenarios and reviewed according to your organization's requirements before it's shared with others.

## Check your work

Confirm that the Customer Meeting Prep agent responds consistently and stays within its intended purpose.

1. Open the **Customer Meeting Prep** agent.
1. Ask it to prepare a brief using the Contoso Outdoor Equipment information.
1. Confirm that the response includes the seven required headings.
1. Verify that the content reflects the information provided in the request.
1. Confirm that missing information is clearly identified.
1. Verify that the agent doesn't add unsupported customer details.
1. Confirm that your changes were updated successfully.

Your agent should now have a clear purpose, consistent output structure, and instructions for handling missing information.
