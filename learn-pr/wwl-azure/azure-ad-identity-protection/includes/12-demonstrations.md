
In this set of try this exercises, you will test conditional access. 

## Task 1 - Configure conditional access (require MFA)

> [!NOTE] 
> This task requires a user account, AZ500User1. If you want to show the MFA verification, the user account must have a phone number. 

In this task, we will review conditional access policy settings and create a policy that requires MFA when signing in to the Portal. 

### Configure the policy

1. In the **Portal** search for and select **Azure Active Directory**.
1. Under **Manage** select **Security**.
1. Under **Protect** select **Conditional access**.
1. Click **New Policy**.
	* Name: **AZ500Policy1**
	* Users and groups > Select users and groups > Users and Groups > Select: **AZ500User1**
	* Cloud apps or actions > Select apps > Select: **Microsoft Azure Management**
	* Review the warning that this policy impacts Portal access.
	* Conditions > Sign-in risk > Review the risk levels
	* Device platforms > Review the devices that can included, such as Android and iOS.
	* Locations > Review the physical location selections.
	* Under **Access controls** click **Grant**.
	* Review the Grant options such as MFA. You may require one or more of the controls.
	* Select **Require multi-factor authentication**.
	* For **Enable policy** select **On**.
1. Click **Create**. 

### Test the policy

1. Sign-in to the **Portal** as the **AZ500User1**.
1. Before you can sign in a second authentication is required.
1. If you have a phone number associated with the user, provide and verify the text code. You should be able to successfully sign in to the Portal.
1. If you do not have a phone number associated with the user, this demonstrates that MFA is in effect. 
1. You may want to return to the **AZ500Policy1** and turn the policy **Off**.

## Task 2 - Access review

In this task, we will configure an access review. 

### Configure an access review

1. In the **Portal**, search for and select **Identity Governance**.
1. Under **Access Reviews** select **Access Reviews**.
1. Click **New Access Review**.
1. We will create an access review to ensure we validate the AZ500Admin group membership. 
1. Complete the required information and discuss each setting. Configuration settings are added as you make your selections. For example, if you select a weekly access review, you will be prompted for the duration. 
	* Review name: **AZ500Review**
	* Start date: **current date**
	* Frequency: **One-time**
	* Users to review: **Members of a group**
	* Scope: **Everyone**
	* Select a group: **AZ500Admins**
	* Reviewers: **Selected user**
	* Select reviewers: **add yourself as a reviewer** 
	* Review the **Upon completion settings**, specifically the action if a reviewer doesn't respond.
	* Review **Advanced settings**.
1. **Start** the access review.
1. On the **Access review** page ensure the new access review is listed. 
1. The **Status** will change from **Not started** to **Initializing**.

### Conduct an access review

In this task, we will conduct an access review. 

1. When the access review is complete you will receive an email. This is the email associated with your reviewer account.
1. View the email and discuss the review instructions. Note when the review period will end.
1. In the email, click **Start review**.
1. On the **Access reviews** page, click the **AZ500Review**.
1. Notice you are reviewing the AZ500Admin group members. There are two members.
1. Use the **Details** link to view information about the user.
1. Select **Approve** for one user and **Deny** for the other. Be sure to provide a **Reason**.
1. **Submit** your reviews. 

### Review the access review results

In this task, we will review the access review results. 

1. Return to the **Portal**.
1. Click the **AZ500Review**.
1. From the **Overview** blade review the results.
1. There should be one member **approved** and one member **denied**.
1. Click **Results** for more detailed information about the reviewer and their reasons.
1. From the **Overview** blade, click **Stop** and confirm you want to stop the review.
1. The **Review status** should now be **Complete**.

### Apply the access review

In this task, we will apply the review results.

1. In the **Portal**, search for and select **Azure Active Directory**.
1. Under **Manage** select **Groups**.
1. Locate the **AZ500Admins** group. 
1. Review the members of the group. 
1. Confirm there are two members. 
1. Return to the **AZ500Review**.
1. Click **Apply**.
1. Confirm that you want to remove the denied member.
1. The **Review status** will change from **Applying** to **Result applied**.
1. Verify the **AZ500Admins** group now only has one member.  
