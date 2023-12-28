Automated cryptographic key rotation in Key Vault allows users to configure Key Vault to automatically generate a new key version at a specified frequency. To configure rotation you can use key rotation policy, which can be defined on each individual key.

Our recommendation is to rotate encryption keys at least every two years to meet cryptographic best practices.

## Integration with Azure services

This feature enables end-to-end zero-touch rotation for encryption at rest for Azure services with customer-managed key (CMK) stored in Azure Key Vault. Please refer to specific Azure service documentation to see if the service covers end-to-end rotation.

## Pricing

There's an additional cost per scheduled key rotation.

## Permissions required

Key Vault key rotation feature requires key management permissions. You can assign a "Key Vault Crypto Officer" role to manage rotation policy and on-demand rotation.

## Key rotation policy

The key rotation policy allows users to configure rotation and Event Grid notifications near expiry notification.

Key rotation policy settings:

 -  Expiry time: key expiration interval. It's used to set expiration date on newly rotated key. It doesn't affect a current key.
 -  Enabled/disabled: flag to enable or disable rotation for the key
 -  Rotation types:
     -  Automatically renew at a given time after creation (default)
     -  Automatically renew at a given time before expiry. It requires 'Expiry Time' set on rotation policy and 'Expiration Date' set on the key.
 -  Rotation time: key rotation interval, the minimum value is seven days from creation and seven days from expiration time
 -  Notification time: key near expiry event interval for Event Grid notification. It requires 'Expiry Time' set on rotation policy and 'Expiration Date' set on the key.

## Configure key rotation policy

Configure key rotation policy during key creation.

## Configure key near expiry notification

Configuration of expiry notification for Event Grid key near expiry event. In case when automated rotation cannot be used, like when a key is imported from local HSM, you can configure near expiry notification as a reminder for manual rotation or as a trigger to custom automated rotation through integration with Event Grid. You can configure notification with days, months and years before expiry to trigger near expiry event.

## Configure key rotation policy governance

Using the Azure Policy service, you can govern the key lifecycle and ensure that all keys are configured to rotate within a specified number of days.

### Create and assign policy definition

1.  Navigate to Policy resource
2.  Select **Assignments** under **Authoring** on the left side of the Azure Policy page.
3.  Select **Assign policy** at the top of the page. This button opens to the Policy assignment page.
4.  Enter the following information:
     -  Define the scope of the policy by choosing the subscription and resource group over which the policy will be enforced. Select by clicking the three-dot button at on **Scope** field.
     -  Select the name of the policy definition: "Keys should have a rotation policy ensuring that their rotation is scheduled within the specified number of days after creation. "
     -  Go to the **Parameters** tab at the top of the page.
         -  Set **The maximum days to rotate** parameter to desired number of days for example, 730.
         -  Define the desired effect of the policy (Audit, or Disabled).
5.  Fill out any additional fields. Navigate the tabs clicking on **Previous** and **Next** buttons at the bottom of the page.
6.  Select **Review + create**.
7.  Select **Create**.

Once the built-in policy is assigned, it can take up to 24 hours to complete the scan. After the scan is completed, you can see compliance results like below.
