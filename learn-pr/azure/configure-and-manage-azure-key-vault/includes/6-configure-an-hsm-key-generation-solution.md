As mentioned in the prior unit, a Hardware Security Module (HSM) is a crypto appliance for securing encryption keys and other secrets. One of the security benefits of using Azure Key Vault is the ability to import or generate keys in HSMs that never leave the HSM boundary. This scenario is often referred to as _bring Your own key_ (BYOK).

> [!NOTE]
> This feature is not available in Azure China.

**Generating and transferring an HSM-protected key over the Internet**:

1. You generate the key from an offline workstation, which reduces the attack surface.

2. The key is encrypted with a Key Exchange Key (KEK), which stays encrypted until transferred to the Azure Key Vault HSMs. Only the encrypted version of your key leaves the original workstation.

3. The toolset sets properties on your tenant key that binds your key to the Azure Key Vault security world. After the Azure Key Vault HSMs receive and decrypt your key, only these HSMs can use it. Your key cannot be exported. This binding is enforced by the Thales HSMs.

4. The KEK that encrypts your key is generated inside the Azure Key Vault HSMs, and is not exportable. The HSMs enforce that there can be no clear version of the KEK outside the HSMs. In addition, the toolset includes attestation from Thales that the KEK is not exportable and was generated inside a genuine HSM that was manufactured by Thales.

5. The toolset includes attestation from Thales that the Azure Key Vault security world was also generated on a genuine HSM manufactured by Thales.

6. Microsoft uses separate KEKs and separate security worlds in each geographical region. This separation ensures that your key can be used only in data centers in the region in which you encrypted it. For example, a key from a European customer cannot be used in data centers in North American or Asia.

For more information, see [Implementing bring your own key (BYOK) for Azure Key Vault](https://docs.microsoft.com/azure/key-vault/key-vault-hsm-protected-keys).

If you have access to Thales HSM, smartcards, and support software you can walk through an exercise detailed at the link above. It is suggested to review the steps even if you cannot perform the exercise.
