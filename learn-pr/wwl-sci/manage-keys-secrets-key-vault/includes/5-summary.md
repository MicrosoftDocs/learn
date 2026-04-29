Contoso Health's audit identified two critical lifecycle failures for keys and secrets: an encryption key untouched for three years, and connection strings with no expiry date enforced. Both are now addressed.

## Analyze what this module addressed

The RSA key protecting patient record archives now has a rotation policy configured directly on the key. Key Vault creates a new HSM-backed key version automatically every 18 months, publishes a `Microsoft.KeyVault.KeyNearExpiry` Event Grid notification 30 days before the two-year expiry window closes, and retains all previous versions so archived data remains available throughout the transition. The three-year exposure window that defined the original finding can't recur.

The database connection strings now have expiry attributes enforced on each version. A dual-credential rotation function—triggered by the `Microsoft.KeyVault.SecretNearExpiry` Event Grid event—rotates the active credential while the alternate credential remains valid in the database. Applications using versionless Key Vault references pick up the new credential transparently at the next startup. Zero downtime, no manual rotation cycle to forget.

## Reflect on what you learned

In this module, you:

- Evaluated key types and HSM-backed key requirements, and imported existing keys into Azure Key Vault using Bring Your Own Key (BYOK)
- Configured automatic key rotation policies to eliminate manual rotation cycles
- Managed secret versioning and expiry attributes, and used Key Vault references so applications pick up rotated credentials without redeployment
- Implemented dual-credential rotation patterns using Azure Function automation for zero-downtime secret rotation

## Learn more

- [Configure cryptographic key autorotation in Azure Key Vault](/azure/key-vault/keys/how-to-configure-key-rotation)
- [HSM-protected keys in Azure Key Vault](/azure/key-vault/keys/hsm-protected-keys)
- [Import HSM-protected keys to Key Vault (BYOK)](/azure/key-vault/keys/hsm-protected-keys-byok)
- [Automate the rotation of a secret for resources that use one set of authentication credentials](/azure/key-vault/secrets/tutorial-rotation)
- [Automate the rotation of a secret for resources that have two sets of authentication credentials](/azure/key-vault/secrets/tutorial-rotation-dual)
