Now that you’ve learned the various discovery, remediation, and monitoring capabilities of Permissions Management, let’s apply these steps in a real-world scenario of a security administrator.

As a security administrator using Permissions Management, the first thing that you’ll do is educate yourself on the status of your cloud environment – what in your environment requires more attention?

:::image type="content" source="../media/dashboard-2.png" alt-text="Screenshot of the Permissions Management dashboard featuring Permissions Creep Index."lightbox="../media/dashboard-2.png":::

Looking at the dashboard, you can see that your PCI score has increased by one over the past seven days. To see what is contributing to the increase, you review the recommended findings to see if anything stands out as abnormal.

:::image type="content" source="../media/findings-2.png" alt-text="Screenshot of the Permissions Management findings."lightbox="../media/findings-2.png":::

Right away, the first thing you might notice is that you have 36 Over Provisioned Active Users in your environment. Over Provisioned Active Users are users with a large gap between the permissions they’re granted and the permissions they use (also known as users with high PCI scores). An increase in the number of overprovisioned active users in your environment might be the cause for the increase in overall PCI score that was noted earlier.  

Now that you’ve noticed a problem in our environment, you can move on to resolving it (also known as the remediation phase). By selecting the 36 Over Provisioned Active Users findings, you see a list of who those 36 users are, which allows you to take a closer look at each user.

:::image type="content" source="../media/users-walkthrough.png" alt-text="Screenshot of the Permissions Management user view."lightbox="../media/users-walkthrough.png":::

With this information, you can view the Remediation tab of Permissions Management to act on your findings. 

:::image type="content" source="../media/remediation-2.png" alt-text="Screenshot of the Permissions Management Remediation tab."lightbox="../media/remediation-2.png":::

By applying the **Revoke Unused Tasks** quick action to our 36 identified overprovisioned active users, we can quickly right-size their permissions and mitigate the risk of users having more permissions than they require.

:::image type="content" source="../media/new-alert-trigger.png" alt-text="Screenshot of the Permissions Management creating a new alert trigger."lightbox="../media/new-alert-trigger.png":::

With the identified overprovisioned active users now remediated, you can now create a Permissions Analytics alert to alert you anytime a new overprovisioned active user is detected. This allows you to be more proactive in managing your overprovisioned active users, as you can remediate these users as soon as they're detected (instead of having to wait for them to accumulate).

This example helps demonstrate the power of the **Discover -> Remediate -> Monitor** flow and is just one way in which the features and capabilities of Permissions Management can tie together to provide more value. 
