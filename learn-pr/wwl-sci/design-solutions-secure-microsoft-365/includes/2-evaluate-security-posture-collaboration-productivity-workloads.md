Microsoft Secure Score is a measurement of an organization's security posture, with a higher number indicating more recommended actions taken. It can be found at [https://security.microsoft.com/securescore](https://security.microsoft.com/securescore) in the [Microsoft Defender portal](/microsoft-365/security/defender/microsoft-365-defender-portal?view=o365-worldwide).

Following the Secure Score recommendations can protect your organization from threats. From a centralized dashboard in the Microsoft Defender portal, organizations can monitor and work on the security of their Microsoft 365 identities, apps, and devices.

### Products included in Secure Score

Currently there are recommendations for the following products:

-   Microsoft 365 (including Exchange Online)
-   Microsoft Entra ID
-   Microsoft Defender for Endpoint
-   Microsoft Defender for Identity
-   Microsoft Defender for Cloud Apps
-   Microsoft Teams

### How it works

You're given points for the following actions:

-   Configuring recommended security features
-   Doing security-related tasks
-   Addressing the recommended action with a third-party application or software, or an alternate mitigation

Some recommended actions only give points when fully completed. Some give partial points if they're completed for some devices or users. If you can't or don't want to enact one of the recommended actions, you can choose to accept the risk or remaining risk.

### Assessing security posture

To help you find the information you need more quickly, Microsoft recommended actions are organized into groups:

-   Identity (Microsoft Entra accounts & roles)
-   Device (Microsoft Defender for Endpoint, known as [Microsoft Secure Score for Devices](/windows/security/threat-protection/microsoft-defender-atp/tvm-microsoft-secure-score-devices))
-   Apps (email and cloud apps, including Office 365 and Microsoft Defender for Cloud Apps)
-   Data (through Microsoft Information Protection)

In the Microsoft Secure Score overview page, view how points are split between these groups and what points are available. You can also get an all-up view of the total score, historical trend of your secure score with benchmark comparisons, and prioritized recommended actions that can be taken to improve your score.

:::image type="content" source="../media/secure-score-home-page.png" alt-text="Screenshot showing the Secure Score homepage in the Microsoft Defender portal." border="true" lightbox="../media/secure-score-home-page.png":::

### Check your current score

To check on your current score, go to the Microsoft Secure Score overview page and look for the tile that says **Your secure score**. Your score will be shown as a percentage, along with the number of points you've achieved out of the total possible points.

Additionally, if you select the **Include** button next to your score, you can choose different views of your score. These different score views will display in the graph on the score tile and the point breakdown chart.

The following are scores you can add to your view of your overall score to give you a fuller picture of your overall score:

-   **Planned score**: Show projected score when planned actions are completed
-   **Current license score**: Show score that can be achieved with your current Microsoft license
-   **Achievable score**: Show score that can be achieved with your Microsoft licenses and current risk acceptance

This view is what it will look like if you've included all possible score views:

:::image type="content" source="../media/secure-score-achievable.png" alt-text="Screenshot showing your secure score including planned score, current license score, and achievable score in the Microsoft Defender portal." border="true":::

### Take action to improve your score

The **recommended actions** tab lists the security recommendations that address possible attack surfaces. It also includes their status (to address, planned, risk accepted, resolved through third party, resolved through alternate mitigation, and completed). You can search, filter, and group all the recommended actions.

Once you have completed an action it can take between 24-48 hours for the changes to be reflected in your secure score.

#### Ranking

Ranking is based on the number of points left to achieve, implementation difficulty, user impact, and complexity. The highest ranked recommended actions have a large number of points remaining with low difficulty, user impact, and complexity.

#### View recommended action details

When you select a specific recommended action, a full page flyout appears.

:::image type="content" source="../media/secure-score-improvement-action-details.png" alt-text="Screenshot that shows the flyout of a recommended action in the Microsoft Defender portal." border="true":::

To complete the action, you have a few options:

-   Select **Manage in Microsoft Defender XDR** to go to the configuration screen and make the change. You'll then gain the points that the action is worth, visible in the flyout. Points generally take about 24 hours to update.
    
-   Select **Share** to copy the direct link to the recommended action. You can also choose the platform to share the link, such as email, Microsoft Teams, or Microsoft Planner.
    

Add **Notes** to keep track of progress or anything else you want to comment on. If you add your own **tags** to the recommended action, you can filter by those tags.

#### Choose a recommended action status

Choose any statuses and record notes specific to the recommended action.

-   **To address** - You recognize that the recommended action is necessary and plan to address it at some point in the future. This state also applies to actions that are detected as partially, but not fully completed.
-   **Planned** - There are concrete plans in place to complete the recommended action.
-   **Risk accepted** - Security should always be balanced with usability, and not every recommendation will work for your environment. When that is the case, you can choose to accept the risk, or the remaining risk, and not enact the recommended action. You won't be given any points for this status. You can view this action in history or undo it at any time.
-   **Resolved through third party** and **Resolved through alternate mitigation** - The recommended action has already been addressed by a third-party application or software, or an internal tool. You'll gain the points that the action is worth, so your score better reflects your overall security posture. If a third party or internal tool no longer covers the control, you can choose another status. Keep in mind, Microsoft will have no visibility into the completeness of implementation if the recommended action is marked as either of these statuses.

### Assess information and review user impact

The section called **At a glance** will tell you the category, attacks it can protect against, and the product.

**User impact** is what the users will experience if the recommended action is enacted, and the **Users affected** are the people who will be impacted.

### Implement the recommended action

The **Implementation** section shows any prerequisites, step-by-step next steps to complete the recommended action, the current implementation status of the recommended action, and any learn more links.

Prerequisites include any licenses that are needed or actions to be completed before the recommended action is addressed. Make sure you have enough seats in your license to complete the recommended action and that those licenses are applied to the necessary users.

<!--TODO: Link to other unit once published.
For discussion of Microsoft Defender for Cloud secure score, see [[Posture evaluation with Microsoft Defender for Cloud secure score]].
-->
