You need to make it possible for the clinicians to access the application. This will enable them to access health records for patients at your facilities in a secure way. You'll need to invite them as guest users.

Here, you'll create a tenant. You'll configure appropriate external collaboration settings for Azure AD B2B. You'll invite guest users, add them to a user group, and give them access to an application.

## Create a new tenant

1. [Sign in](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) to the Azure portal as a global administrator account. If you're the person who signed up for an Azure subscription, you're automatically the global administrator.
1. Select **Create a resource > Identity**, then select **Azure Active Directory**.
1. Fill in the Create directory form as appropriate. You can use your own values for the **Organization name** and **Initial domain name** fields. For the **Country or region field**, select United States.
![Create a tenant](../media/4-create-tenant.png)
1. Select **Create**.
1. After your directory has been created, select your username at the top right of the Azure portal, then select **Switch directory**.
1. You'll see a list of directories. Select the tenant you've created to switch in to it.

> [!NOTE] You might need to close the Azure portal and open it again to view the newly created tenant.

## Configure external collaboration settings

By default, all default member users and guest users can invite external users. Make sure that guest invitations can only be sent by administrators and users in the guest inviter role.

1. Select **Azure Active Directory > Users > User settings**, then select **Manage external collaboration settings** under the external users heading.
1. Select No for the **Members can invite** and **Guests can invite** fields.
![Configure external collaboration](../media/4-configure-external-collaboration.png)
1. Select **Save**.

## Add a guest user to your directory

Invite a guest user to add them to your directory.

1. Select **Azure Active Directory > Users > New Guest user**.
![Send an invitation](../media/4-send-invitation.png)
1. Fill in the form as appropriate. Use your guest user's email address for the **E-mail address** field. Use an email address you yourself can access for this exercise.
1. For the personal message text area, you can write your own customized invitation message.
1. Select **Invite** to send your invitation.
1. Sign in to the guest user's email account you have entered previously. In the inbox, you'll see an email with a "You're invited to the Contoso organization" subject line from Microsoft Invitations. Select the **Get Started** button in the email.
1. In the Review permissions page that shows up, select **Accept**.

## Add a guest user to a group

Your guest user can also be made a member of a particular group.

1. Select **Azure Active Directory > Groups**.
1. Select **New group** in the groups pane.
1. Fill in the form as appropriate. For **Group type**, select Security.
1. Select **Members**.
![Add a new member to the group](../media/4-create-group-add-member.png)
1. In the search field, look for and select your guest user. Then select **Select**.
1. Select **Create**.

## Add a guest user to an application

Now give your guest user access to an application.

1. Select **Azure Active Directory**, select **Enterprise applications**, then select **All applications > New application**.
1. In the search box look for GitHub, then select **GitHub.com** in the returned list, then select **Add**.
1. Go to your newly added application. Select **Azure Active Directory > Enterprise applications > All applications**, then select your application.
1. Select **Total Users**, then select **Add user**.
1. In the Add Assignment form, select **Users**.
![Add a user to the application](../media/4-add-user-to-application.png)
1. Select your user in the list of users, then select **Select**.
1. Select **Assign** at the bottom of the form.
