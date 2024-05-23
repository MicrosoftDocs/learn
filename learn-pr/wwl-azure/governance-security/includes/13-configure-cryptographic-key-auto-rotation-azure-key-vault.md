Automated cryptographic key rotation in [Key Vault](/azure/key-vault/general/overview) allows users to configure Key Vault to automatically generate a new key version at a specified frequency. To configure rotation you can use key rotation policy, which can be defined on each individual key.

It is recommended to rotate encryption keys at least every two years to meet cryptographic best practices.

For more information about how objects in Key Vault are versioned, see [Key Vault objects, identifiers, and versioning](/azure/key-vault/general/about-keys-secrets-certificates#objects-identifiers-and-versioning).

## Integration with Azure services

This feature enables end-to-end zero-touch rotation for encryption at rest for Azure services with customer-managed key (CMK) stored in Azure Key Vault. Please refer to specific Azure service documentation to see if the service covers end-to-end rotation.

For more information about data encryption in Azure, see:

 -  [Azure Encryption at Rest](/azure/security/fundamentals/encryption-atrest#azure-encryption-at-rest-components)
 -  [Azure services data encryption support table](/azure/security/fundamentals/encryption-models#supporting-services)

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

Key rotation generates a new key version of an existing key with new key material. Target services should use versionless key uri to automatically refresh to latest version of the key. Ensure that your data encryption solution stores versioned key uri with data to point to the same key material for decrypt/unwrap as was used for encrypt/wrap operations to avoid disruption to your services. All Azure services are currently following that pattern for data encryption.

:::image type="content" source="../media/key-rotation-example-1-86820625.png" alt-text="Screenshot showing an example of the key rotation policy configuration page.":::


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

Configure rotation policy on existing keys.

:::image type="content" source="../media/key-rotation-test-83f27919.png" alt-text="Screenshot showing an example of how to configure a key rotation policy on existing keys.":::


### Azure CLI

Save key rotation policy to a file.

Set rotation policy on a key passing previously saved file using Azure CLI [az keyvault key rotation-policy update](/cli/azure/keyvault/key/rotation-policy) command.

```azurecli
az keyvault key rotation-policy update --vault-name <vault-name> --name <key-name> --value </path/to/policy.json>
```

### Azure PowerShell

Set rotation policy using Azure PowerShell [Set-AzKeyVaultKeyRotationPolicy](/powershell/module/az.keyvault/set-azkeyvaultkeyrotationpolicy) cmdlet.

```powershell
Set-AzKeyVaultKeyRotationPolicy -VaultName <vault-name> -KeyName <key-name> -ExpiresIn (New-TimeSpan -Days 720) -KeyRotationLifetimeAction @{Action="Rotate";TimeAfterCreate= (New-TimeSpan -Days 540)}
```

### Rotation on demand

Key rotation can be invoked manually.

#### Portal

Click 'Rotate Now' to invoke rotation.

:::image type="content" source="../media/key-rotation-options-0cb50e09.png" alt-text="Screenshot showing how to invoke a key rotation policy.":::


### Azure CLI

Use Azure CLI [az keyvault key rotate](/cli/azure/keyvault/key#az-keyvault-key-rotate) command to rotate key.

```azurecli
az keyvault key rotate --vault-name <vault-name> --name <key-name>
```

### Azure PowerShell

Use Azure PowerShell [Invoke-AzKeyVaultKeyRotation](/powershell/module/az.keyvault/invoke-azkeyvaultkeyrotation) cmdlet.

```azurecli
Invoke-AzKeyVaultKeyRotation -VaultName <vault-name> -Name <key-name>
```

## Configure key near expiry notification

Configuration of expiry notification for Event Grid key near expiry event. In case when automated rotation cannot be used, like when a key is imported from local HSM, you can configure near expiry notification as a reminder for manual rotation or as a trigger to custom automated rotation through integration with Event Grid. You can configure notification with days, months and years before expiry to trigger near expiry event.

:::image type="content" source="../media/key-rotation-notification-57cf441f.png" alt-text="Screenshot showing an example of a key rotation policy notification.":::


For more information about Event Grid notifications in Key Vault, see [Azure Key Vault as Event Grid source](/azure/event-grid/event-schema-key-vault?tabs=event-grid-event-schema)
