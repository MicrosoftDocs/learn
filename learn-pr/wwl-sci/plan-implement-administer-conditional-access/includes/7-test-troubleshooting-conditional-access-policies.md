The Conditional Access framework provides you with great configuration flexibility. However, great flexibility also means that you should carefully review each configuration policy before releasing it to avoid undesirable results. In this context, you should pay special attention to assignments affecting complete sets such as **all users / groups / cloud apps**.

Organizations should avoid the following configurations:

**For all users, all cloud apps:**

 - **Block access** - This configuration blocks your entire organization.
 - **Require Hybrid Microsoft Entra domain joined device** - This access-blocking policy also has the potential to block access for all users in your organization if they don't have a hybrid Microsoft Entra joined device.<br>
 - **Require app protection policy** - This access-blocking policy also has the potential to block access for all users in your organization if you don't have an Intune policy. If you're an administrator without a client application that has an Intune app protection policy, this policy blocks you from getting back into portals such as Intune and Azure.

**For all users, all cloud apps, all device platforms:**

 - **Block access** - This configuration blocks your entire organization.

## Conditional Access sign-in interrupt

The first way is to review the error message that appears. For problems signing in when using a web browser, the error page itself has detailed information. This information alone describes what the problem is and suggests a solution.

:::image type="content" source="../media/image-1.png" alt-text="Screenshot of the Sign-in error - compliant device required. With a button to cancel or get more information.":::

In the above error, the message states that the application can only be accessed from devices or client applications that meet the company's mobile device management policy. In this case, the application and device don't meet that policy.

## Microsoft Entra sign-in events

The second method to get detailed information about the sign-in interruption is to review the Microsoft Entra sign-in events to see which Conditional Access policy or policies were applied and why.

Find more information about the problem by clicking **More Details** in the initial error page. Clicking **More Details** will reveal troubleshooting information that's helpful when searching the Microsoft Entra sign-in events for the specific failure event the user saw or when opening a support incident with Microsoft.

:::image type="content" source="../media/image-2.png" alt-text="Screenshot of the More details from a Conditional Access interrupted web browser sign-in.":::

To find out which Conditional Access policy or policies applied and why, do the following steps:

1. Sign into the Microsoft Entra admin center as a Security Administrator, or Global Reader.
2. Browse to **Identity - Monitoring and Health**, then **Sign-ins**.
3. Find the event for the sign-in to review. Add or remove filters and columns to filter out unnecessary information.
    
   1. Add filters to narrow the scope:
        
      1.  Correlation ID when you have a specific event to investigate.
      2.  Conditional access to see policy failure and success. Scope your filter to show only failures to limit results.
      3.  Username to see information related to specific users.
      4.  Date scoped to the time frame in question.
            
          :::image type="content" source="../media/image-3.png" alt-text="Screenshot of the error message screen. User is selecting the Conditional access filter in the sign-ins log.":::
            
4. Once the sign-in event that corresponds to the user's sign-in failure has been found select the **Conditional Access** tab, the tab will show the specific policy or policies that resulted in the sign-in interruption.
    
   1. Information in the **Troubleshooting and support** tab provides a clear reason as to why a sign-in failed, such as a device that didn't meet compliance requirements.
   2. To investigate further, drill down into the configuration of the policies by clicking on the Policy Name. Clicking the Policy Name will show the policy configuration user interface for the selected policy for review and editing.
   3. The client user and device details that were used for the Conditional Access policy assessment are also available in the **Basic Info**, **Location**, **Device Info**, **Authentication Details**, and **Additional Details** tabs of the sign-in event.

### Policy details

Selecting the ellipsis on the right side of the policy in a sign-in event brings up policy details. This gives administrators additional information about why a policy was successfully applied or not.

:::image type="content" source="../media/image-5.png" alt-text="Screenshot of the Sign-in event Conditional Access tab. Waiting for user input.":::

:::image type="content" source="../media/policy-details.png" alt-text="Screenshot of the Policy details (preview) screen in Microsoft Entra conditional access.":::

The left side provides details collected at sign-in, and the right side provides details of whether those details satisfy the requirements of the applied Conditional Access policies. Conditional Access policies only apply when all conditions are satisfied or not configured.

If the information in the event isn't enough to understand the sign-in results or adjust the policy to get desired results, then a support incident can be opened. Navigate to that sign-in event's **Troubleshooting and support** tab and select **Create a new support request**.

:::image type="content" source="../media/image-6.png" alt-text="Screenshot of The Troubleshooting and support tab of the Sign-in event. Wizard helps fix issues.":::

When submitting the incident, provide the request ID and time and date from the sign-in event in the incident submission details. This information will allow Microsoft support to find the event you're concerned about.
