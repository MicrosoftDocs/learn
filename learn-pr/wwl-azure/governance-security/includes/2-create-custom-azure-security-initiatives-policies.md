Security recommendations in Microsoft Defender for Cloud help you to improve and harden your security posture. Recommendations are based on the security standards you define in subscriptions that have Defender for Cloud onboarded. Security standards can be based on regulatory compliance standards, and on customized standards.

## Before you begin

 -  You need Owner permissions on the subscription to create a new security standard.
 -  For custom standards to be evaluated and displayed in Defender for Cloud, you must add them at the subscription level (or higher). We recommend that you select the widest scope available.

## Create a custom standard in the portal<br>

1.  Sign in to the Azure portal.
2.  Navigate to **Microsoft Defender for Cloud**, **Environment settings**.<br>
3.  Select the relevant subscription or management group.<br>
4.  Select **Security policies**, **Create**, **Custom standard**.
5.  Enter a name and description.
    
    > [!IMPORTANT]
    > Make sure the name is unique. If you create a custom standard with the same name as an existing standard, it causes a conflict in the information displayed in the dashboard.
6.  Select **Next**.
7.  In **Recommendations**, select the recommendations that you want to add to the custom standard.
8.  (Optional) Select the three dot button (**...**) **Manage effect and parameters** to manage the effects and parameters of each recommendation, and save the setting.
9.  Select **Next**.<br>
10. In **Review+ create**, select **Create**.<br>

Your new standard takes effect after you create it. You can see the effects of your new standard:<br>

 -  On the Regulatory compliance page, you will see the new custom standard alongside existing standards.<br>
 -  If your environment doesn't align with the custom standard, you begin to receive recommendations to fix issues found in the **Recommendations** page.
