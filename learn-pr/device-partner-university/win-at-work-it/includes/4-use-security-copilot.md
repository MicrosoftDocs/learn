You're an IT administrator at a medium-sized company. A user triggered an impossible travel alert—their account has signed in from multiple locations within minutes. You need to investigate the alert, determine whether it's a legitimate threat or false positive, and decide on next steps.

> [!IMPORTANT]
> To complete this exercise, an eligible Microsoft 365 subscription and access to Microsoft Security Copilot are required. How you use Copilot depends on your permissions and license.

## Step 1: Gather information

Before opening Security Copilot, ensure you have the relevant information available:

- User account or username
- Sign-in locations and timestamps
- Device IDs and associated IP addresses
- Any related alerts or suspicious activity

### Prerequisites

- *Azure subscription*: Required to purchase security compute units and provision capacity.
- Access to [Microsoft Security Copilot](https://securitycopilot.microsoft.com/).
- Appropriate permissions (typically *Security Administrator* or *Global Administrator*).

> [!TIP]
> Security compute units are the required units of resources that are needed for dependable and consistent performance of Microsoft Security Copilot. [Learn more](https://learn.microsoft.com/copilot/security/get-started-security-copilot#security-compute-units).

## Step 2: Prepare the workspace

Open Microsoft Security Copilot and ensure you're signed into an account with the necessary permissions. You can interact with Copilot via:

- **Copilot sidebar**: Access it from the Microsoft Security portal to input prompts and receive recommendations.
- **Inline prompts**: Ask Copilot questions directly within alerts or investigation pages.

## Step 3: Investigate using Copilot

Submit the following prompts to Security Copilot to gather more information about the anomalous incident.

| Task                  | Prompt                                                                 | What Copilot Returns / Why It Helps                                         |
|-----------------------|-------------------------------------------------------------------------|-------------------------------------------------------------------------------|
| **Summarize the alert** | `Summarize the anomalous sign-in activity for user <username> in the last 24 hours.` | Provides sign-in times, locations, and affected devices. |
| **Gather related activity** | `Show all recent sign-ins and device activity for <username>.` | Helps identify patterns and correlate events. |
| **Analyze and correlate** | `Compare this sign-in activity with typical user behavior and flag anything unusual.` | Highlights deviations from normal behavior. |
| **Document findings**     | `Create a report of findings and recommended next steps for this alert.` | Produces a structured summary that can be shared or archived. |

## Step 4: Refine the investigation

If Copilot’s summary is incomplete, make follow-up requests like:

- "Include IP geolocation for each sign-in."
- "Highlight any sign-ins from unexpected devices."

You can also request actionable recommendations with a prompt like:

- "Suggest remediation steps or monitoring strategies."

## Step 5: Check your work

Use this checklist to ensure your investigation is complete. Did you complete all the steps listed?

- [ ] Alert details summarized clearly.
- [ ] Related activity gathered and correlated.
- [ ] Findings documented with supporting evidence.
- [ ] Recommendations for remediation, monitoring, or escalation provided.
- [ ] Investigation structured and ready for handoff or reporting.

> [!TIP]
> - **False positives**: Investigate whether the alert is caused by legitimate activity, such as the user connecting through a VPN, roaming on a mobile network, or traveling for work.
>
> - **Escalation**: If you determine that the account is compromised, take appropriate action immediately. This might include temporarily suspending the account, enforcing or resetting multifactor authentication, and notifying your incident response or security operations team (if applicable).

## Step 6: Summarize the investigation

Once the investigation is complete, you should take appropriate actions based on the findings. If the activity is confirmed to be malicious, this might include temporarily suspending the user account, enforcing or resetting multifactor authentication, and notifying the incident response or security operations team (if applicable).

If the alert is determined to be a false positive—such as legitimate travel, VPN use, or mobile roaming—document the findings and continue to monitor the account as needed. In all cases, ensure that the investigation and any actions taken are clearly recorded, so the information is available for reporting, handoff, or future reference.

Include any recommended actions you'll take or have taken, such as remediation, monitoring, or escalation. A structured summary not only helps you stay organized but also ensures that any follow-up actions are clear to everyone and repeatable.
