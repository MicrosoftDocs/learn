The Identity Risk Management Agent in Microsoft Entra ID Protection provides proactive risk management capabilities by analyzing user behavior. The agent then suggests actions to mitigate potential identity risks. You can configure the settings to meet your organization's needs. By using a Large Language Model, the agent helps security administrators review and respond to risky activities before they lead to security incidents.

## Prerequisites

- You must have at least the Microsoft Entra ID P2 license.
- You must have available security compute units (SCU).
- You must have the appropriate Microsoft Entra role.
   - **Security Administrator** - required to activate the agent the first time and view the agent and take action on the suggestions.
   - **Security Reader** and **Global Reader** - view the agent and any suggestions (can't take actions).

## How the agent works

The agent checks for new risky identities that weren't previously identified. If new risky identities are found, it takes the following steps (no SCUs consumed):

1. The agent checks for new risky users in your tenant who currently have a risk state of "At risk".
2. The agent identifies risky users that are within your defined scope settings.

If the agent finds new suggestions, it takes the following steps (SCUs consumed):

| Step | Agent activity |
| :--- | :----- |
| Investigate the risky user | The agent checks the user's risky sign-ins and risk detections to analyze what's risky about this user. |
| Generate findings and a risk summary | The agent generates findings based on the investigation, which includes a thorough risk summary explaining the suggestion and defining the key risk factors. |
| Generate a recommended remediation action | The agent suggests a remediation action, using the information gathered during the investigation. |
| Answer questions through chat | IT administrators ask the agent questions related to the risky users and the risk summary. |
| Store custom instructions in agent memory | Customers can give the agent custom instructions through agent chat, which the agent stores in its memory and applies for future runs. Currently, agent memory can store preferred remediation actions. |

## Using the agent

1. Sign in to the **Microsoft Entra admin center** as at least a Security Administrator.
2. Browse to **ID Protection** > **Risky users**.
3. Look for the banner at the top of the page.
4. Select **Start agent**

### Configuring agent settings

With the **Risky users** page open, select the **Agent view**. Select the ellipses in the upper-right corner and then select Settings.

- **Controls** - provide the roles and permissions needed to run the agent.
- **Triggers** - set when and how the agent is run:
   - Continuous monitoring - checks for new risky users every 5 minutes
   - Daily trigger - agent runs once per day
   - Manual run - agent runs only when manually launched
- **Scope** - By default, the agent investigates the most recent 100 risky users within the last 90 days. You can control the scope of for agent scan by adjusting several options.
   - Select users and groups option to search for and select the users and groups you want the agent to scan.
   - Set the maximum recent risky users to scan within 1-100.
   - Select which risk levels to include in the scan. All risk levels are selected by default.
   - Set a specific time frame for the scope:
      - Last 7 days
      - Last 14 days
      - Last 30 days
      - Custom time frame up to 90 days
- **Communications** - enter a set of users to receive notifications of the agent run.
- **Memory** - list of user confirmed safe items that were false positives.

## Explore the agent findings report

### Agent summary
An agent summary appears at the top of the Agent view, showing recent agent activities. This tile provides quick access to the Chat with agent feature and a Manage agent button, which lets you trigger a one-time run or open agent settings.

### Agent suggestions
Agent suggestions are displayed below the agent summary. Hover over a suggestion to highlight impacted users in the table. Selecting a suggestion filters the table to show only those users for review. Each suggestion includes a bulk action button, so you can apply the action with one button.

Currently, the following remediation actions are available in agent suggestions:

- Dismiss risk
- Reset password

### Risky users table with agent suggestions
The lower half of the report lists all risky users. Select a user to view agent findings, risk factors, and suggestions specific to that user. The Agent suggestion column also shows recommended remediation actions directly in the table. Select the action button to apply a remediation to individual users.

### Risky user details
The Risky user details page provides a new Agent view, which presents agent findings specific to a risky user. This view includes the following information:

- **Basic user information**: Username, current risk level, and User Principal Name (UPN)
- **Agent findings**: The agent provides a verdict of Compromised or Not compromised based on its investigation
- **Risk summary**: A detailed explanation of the agent's findings, based on analysis of the user's sign-ins and behaviors
- **Risk factors**: Key risk indicators summarized for easy review
- **Suggested remediation action**: A call-to-action button that allows you to quickly start remediating the risk
