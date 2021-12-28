A user in Azure Stack Hub can be a reader, owner, or contributor for each instance of a subscription, resource group, or service. For example, User A might have reader permissions to Subscription One, but have owner permissions to Virtual Machine Seven.

 -  **Reader**: User can view everything, but can't make any changes.
 -  **Contributor**: User can manage everything except access to resources.
 -  **Owner**: User can manage everything, including access to resources.
 -  **Custom**: User has limited, specific access to resources.

## Set access permissions for a user

1.  Sign in with an account that has owner permissions to the resource you want to manage.
2.  In the blade for the resource, click the **Access** icon.
3.  In the **Users** blade, click **Roles**.
4.  In the **Roles** blade, click **Add** to add permissions for the user.

## Set access permissions for a universal group

Applicable only to Active Directory Federated Services (AD FS).

1.  Sign in with an account that has owner permissions to the resource you want to manage.
2.  In the blade for the resource, click the **Access** icon.
3.  In the **Users** blade, click **Roles**.
4.  In the **Roles** blade, click **Add** to add permissions for the Universal Group Active Directory Group.
