The following screenshots show the eleven tabs of the exemplar template. The selected values illustrate the controls, not a recommended configuration for every workload. Available settings depend on compatibility levels, cryptographic providers, certificate purpose, and other selections.

Across these tabs, **OK** saves changes and closes the dialog, **Apply** saves without closing, **Cancel** discards unapplied changes, and **Help** opens help for the dialog.

## General tab

:::image type="content" source="../media/exemplar-general.png" alt-text="Screenshot of the General tab showing template names, certificate lifetime, renewal, and directory publication settings." lightbox="../media/exemplar-general.png":::


The following table describes the settings shown on the General tab.

| Setting | Description |
| --- | --- |
| **Template display name** | **Exemplar Template** is the friendly name shown in administrative and enrollment interfaces. |
| **Template name** | `ExemplarTemplate` is the programmatic identifier used in requests, commands, and template references. Choose it before publishing the template. |
| **Validity period** | **1 year** is shown. The number and unit specify the intended certificate lifetime; CA policy and the CA certificate's remaining lifetime can shorten it. |
| **Renewal period** | **6 weeks** is shown. Defines the renewal window before expiration. Autoenrollment also requires the certificate to have completed 80% of its lifetime; this field doesn't enable autoenrollment. |
| **Publish certificate in Active Directory** | Selected. Publishes the issued public certificate to the account's directory object. It neither publishes the template on a CA nor stores the private key in AD DS. |
| **Do not automatically reenroll if a duplicate certificate exists in Active Directory** | Unchecked. Suppresses automatic enrollment when AD DS already contains a valid certificate from the same template for the account. |

## Compatibility tab

:::image type="content" source="../media/exemplar-compatibility.png" alt-text="Screenshot of the Compatibility tab showing CA and certificate recipient compatibility settings." lightbox="../media/exemplar-compatibility.png":::


The following table describes the settings shown on the Compatibility tab.

| Setting | Description |
| --- | --- |
| **Show resulting changes** | Selected. Shows the features affected when you change either compatibility level. |
| **Certification Authority** | **Windows Server 2016** is selected. Sets the minimum CA compatibility level used to determine which template features are available. |
| **Certificate recipient** | **Windows 10 / Windows Server 2016** is selected. Sets the recipient compatibility level for enrollment and private-key features. |

## Request handling tab

:::image type="content" source="../media/exemplar-request-handling.png" alt-text="Screenshot of the Request Handling tab showing key purpose, archival, export, renewal, and user-interaction settings." lightbox="../media/exemplar-request-handling.png":::


The following table describes the settings shown on the Request Handling tab.

| Setting | Description |
| --- | --- |
| **Purpose** | **Signature and encryption** is selected. Specifies whether the certificate's key supports signing, encryption, or both. An encryption-capable purpose is required for encryption-key archival. |
| **Delete revoked or expired certificates (do not archive)** | Unchecked and unavailable here. Removes expired, revoked, or renewed certificates from the local certificate store instead of retaining archived certificates. This isn't CA private-key archival. |
| **Include symmetric algorithms allowed by the subject** | Selected. Adds supported symmetric algorithms as S/MIME capabilities in the request and certificate. It advertises capabilities, not encryption keys. |
| **Archive subject's encryption private key** | Unchecked. Sends a protected copy of the encryption private key to the CA for recovery. The CA also needs configured key recovery agents; this setting is separate from later key export. |
| **Allow private key to be exported** | Selected. Permits later export of the private key, such as in a PFX file for backup or transfer. It doesn't itself export the key and increases the risk of key copying. |
| **Renew with the same key** | Unchecked. Reuses the existing key pair during renewal instead of generating a new one. Reuse extends the key's lifetime and doesn't migrate it to another provider or algorithm. |
| **For automatic renewal of smart card certificates, use the existing key if a new key cannot be created** | Unchecked. Permits same-key renewal as a fallback when the smart card can't create a new key; it doesn't always require key reuse. |
| **Enroll subject without requiring any user input** | Selected. Requests enrollment without user interaction. It doesn't independently enable autoenrollment or bypass other issuance requirements. |
| **Prompt the user during enrollment** | Unselected. Requires user interaction during autoenrollment; it doesn't add a prompt to manual enrollment. |
| **Prompt the user during enrollment and require user input when the private key is used** | Unselected. Adds enrollment interaction and protection that requires interaction when the private key is used. The provider determines the prompt or password behavior. |

## Cryptography tab

:::image type="content" source="../media/exemplar-cryptography.png" alt-text="Screenshot of the Cryptography tab showing a legacy CSP, a 2048-bit minimum key size, and provider restrictions." lightbox="../media/exemplar-cryptography.png":::


The following table describes the settings shown on the Cryptography tab.

| Setting | Description |
| --- | --- |
| **Provider Category** | **Legacy Cryptographic Service Provider** is selected. Chooses legacy CryptoAPI CSPs or modern Cryptography Next Generation key storage providers (KSPs). |
| **Algorithm name** | **Determined by CSP** is shown. In this legacy configuration, the provider determines the key algorithm rather than this field selecting it independently. |
| **Minimum key size** | **2048** bits is shown. Sets the minimum permitted key length, not a requirement that every key has exactly this length. |
| **Requests can use any provider available on the subject's computer** | Unselected. Permits any available provider that satisfies the template's other requirements. |
| **Requests must use one of the following providers** | Selected. Restricts enrollment to the checked providers in the list. A suitable permitted provider must exist on the requesting computer. |
| **Providers** | Lists eligible providers, filtered by settings such as algorithm, minimum key size, purpose, and exportability. The scrollbar exposes additional entries. |
| **Up and down arrow buttons** | Change the preference order of selected providers. They don't install providers on enrollment clients. |
| **Request hash** | **Determined by CSP** is shown and independent selection is unavailable. Controls the hash used to sign the request, not the CA's signature on the issued certificate. |
| **Use alternate signature format** | Unchecked and unavailable here. Selects an alternate request-signature format where supported, such as RSA-PSS. It doesn't change the CA's certificate-signature format. |

The following provider entries are visible in the screenshot:

| Provider | Description |
| --- | --- |
| **Microsoft Enhanced Cryptographic Provider v1.0** | Checked. A legacy general-purpose RSA provider for signatures, key exchange, and symmetric encryption. |
| **Microsoft DH SChannel Cryptographic Provider** | Unchecked. A legacy Schannel provider for Diffie-Hellman key exchange. |
| **Microsoft Enhanced DSS and Diffie-Hellman Cryptographic Provider** | Unchecked; the name is truncated in the image. Supports DSA signatures and Diffie-Hellman key exchange. |
| **Microsoft Enhanced RSA and AES Cryptographic Provider** | Unchecked. A legacy provider supporting RSA operations and AES encryption. |
| **Microsoft RSA SChannel Cryptographic Provider** | Unchecked. A legacy RSA-based provider for Schannel operations. |

## Key attestation tab

:::image type="content" source="../media/exemplar-key-attestation.png" alt-text="Screenshot of the Key Attestation tab showing unavailable attestation modes, trust methods, and issuance-policy options." lightbox="../media/exemplar-key-attestation.png":::

All controls are unavailable in this screenshot, with **None** selected. The documented TPM attestation configuration requires a supported KSP, RSA, **Microsoft Platform Crypto Provider**, and nonexportable, nonarchived keys. The legacy CSP and exportable-key selections shown in the other tabs don't meet these requirements.

| Setting | Description |
| --- | --- |
| **None** | Doesn't require TPM key attestation. Selecting a TPM-backed provider alone doesn't prove TPM protection to the CA. |
| **Required, if client is capable** | Requires attestation from capable clients but permits enrollment without attestation from incapable clients. It doesn't guarantee hardware-backed keys for every certificate. |
| **Required** | Requires successful attestation before issuance. Requests that can't meet the requirement fail. |
| **User credentials** | Trusts the TPM endorsement public key supplied by the authenticated user, based on domain credentials rather than a manufacturer certificate or approved-key list. |
| **Hardware certificate** | Uses the TPM endorsement-key certificate, called **Endorsement certificate** or **EKCert** in the documentation. The CA validates its chain against configured endorsement-certificate trust stores. |
| **Hardware key** | Uses the TPM endorsement public key, called **Endorsement Key** or **EKPub** in the documentation. The key must appear in the administrator's approved-key list. |
| **Include issuance policies for enforced attestation types** | Adds policy OIDs that identify the successful attestation trust methods so relying applications can recognize the assurance level. No selection is visible here. |
| **Perform attestation only (do not include issuance policies)** | Performs attestation without adding those policy OIDs. No selection is visible here. |

## Subject name tab

:::image type="content" source="../media/exemplar-subject-name.png" alt-text="Screenshot of the Subject Name tab showing directory-based subject and alternative-name settings." lightbox="../media/exemplar-subject-name.png":::


The following table describes the settings shown on the Subject Name tab.

| Setting | Description |
| --- | --- |
| **Supply in the request** | Unselected. Takes subject and subject alternative name information from the request. Supplying a name doesn't prove the requester is authorized to use that identity. |
| **Use subject information from existing certificates for autoenrollment renewal requests** | Unchecked and unavailable here. Reuses the subject and SAN from an existing valid certificate during autoenrollment renewal. It doesn't waive other renewal requirements. |
| **Build from this Active Directory information** | Selected. Builds the certificate's identity from the subject's AD DS attributes instead of accepting requester-supplied names. |
| **Subject name format** | **Fully distinguished name** is selected. Uses the account's AD DS distinguished name as the certificate's primary Subject field. |
| **Include e-mail name in subject name** | Selected. Adds the directory email address to the Subject field, separately from the SAN email option. |
| **E-mail name** | Selected. Adds the directory email address to the SAN extension. |
| **DNS name** | Unchecked. Adds the computer account's `dNSHostName` value to the SAN extension. |
| **User principal name (UPN)** | Selected. Adds the account's `userPrincipalName` to the SAN extension. A UPN isn't necessarily the account's email address. |
| **Service principal name (SPN)** | Unchecked. Sets the SPN-related SAN flag. The current Windows CA specification describes this flag as adding `userPrincipalName`, not copying the directory's `servicePrincipalName` list. |

The four options under **Include this information in alternate subject name** populate SAN, not the primary Subject field. Missing required directory attributes can cause issuance to fail. Because older descriptions of the SPN option differ from the current specification, verify the issued SAN before relying on that setting. 

## Extensions tab

:::image type="content" source="../media/exemplar-extensions.png" alt-text="Screenshot of the Extensions tab showing application policies, basic constraints, template information, and key usage." lightbox="../media/exemplar-extensions.png":::


The following table describes the settings shown on the Extensions tab.

| Setting | Description |
| --- | --- |
| **Extensions included in this template** | Lists the extensions available for inspection. Select an entry to see its description and edit it where supported. |
| **Application Policies** | Selected. Defines application purposes, such as client authentication or secure email, expressed as policy identifiers. These differ from low-level Key Usage restrictions. |
| **Basic Constraints** | Identifies a CA certificate versus an end-entity certificate and can limit a CA's subordinate certification-path length. Its values aren't shown here. |
| **Certificate Template Information** | Provides read-only template information, including the subject type. Start with a suitable base template when a different subject type is needed; its details aren't shown here. |
| **Issuance Policies** | Identifies the policies or assurance conditions under which certificates are issued. It doesn't select their application purposes; no policy values are shown here. |
| **Key Usage** | Restricts key operations, such as digital signatures, key encipherment, certificate signing, and CRL signing. The selected operations aren't visible in this screenshot. |
| **Edit** | Opens the editor for the selected editable extension. Its availability for Application Policies doesn't make every extension editable. |
| **Description of Application Policies** | Shows the configured purposes for the selected extension. The scrollbar moves through the description; this panel isn't another policy selector. |

The example combines these four application policies:

| Application policy | Purpose |
| --- | --- |
| **Microsoft Trust List Signing** | Signs certificate trust lists (CTLs), not software. |
| **Encrypting File System** | Protects files with EFS; this isn't the EFS recovery-agent purpose. |
| **Secure Email** | Protects email with S/MIME signing or encryption, subject to Key Usage and application support. |
| **Client Authentication** | Authenticates a client to a service. |

Retain only the purposes required by the workload rather than copying this multipurpose example unchanged. 

## Issuance requirements tab

:::image type="content" source="../media/exemplar-issuance-requirements.png" alt-text="Screenshot of the Issuance Requirements tab showing approval, authorized signatures, signer policies, and renewal options." lightbox="../media/exemplar-issuance-requirements.png":::


The following table describes the settings shown on the Issuance Requirements tab.

| Setting | Description |
| --- | --- |
| **CA certificate manager approval** | Unchecked. Places otherwise acceptable requests in a pending state until a certificate manager issues or denies them. This is separate from cryptographic approval signatures. |
| **This number of authorized signatures** | Selected with **1** signature required. The request must carry the specified number of qualifying signatures. More than one signature prevents autoenrollment, as the dialog warns. |
| **Policy type required in signature** | **Application policy** is selected. Chooses whether authorization-signing certificates must satisfy application-policy requirements, issuance-policy requirements, or both. |
| **Application policy** | **Any Purpose** is shown. Specifies a required purpose in the certificate signing the request, not the application purposes of the certificate being requested. It doesn't remove the authorized-signature requirement. |
| **Issuance policies** | Empty and unavailable with the displayed policy type. Lists the issuance policies required in authorization-signing certificates when issuance-policy checking is selected. |
| **Add** | Unavailable here. Adds an issuance-policy requirement for authorization-signing certificates, not a policy to the requested certificate. |
| **Remove** | Unavailable here. Removes the selected requirement from that issuance-policy list. |
| **Same criteria as for enrollment** | Selected for reenrollment. Requires the initial enrollment approval criteria again, including the configured authorized signatures. |
| **Valid existing certificate** | Unselected. A qualifying renewal can use a valid certificate from the same template and proof of its private key instead of repeating initial approval requirements. Template and identity checks still apply. |
| **Allow key based renewal** | Unchecked and unavailable here. Permits qualifying certificate-authenticated renewals without the normal template Enroll-permission check. Requires **Valid existing certificate** and **Supply in the request**. Unlike **Renew with the same key**, this controls renewal authorization, not which key the new certificate uses. |

One authorized signature doesn't automatically enable autoenrollment; permissions, client policy, and the enrollment workflow must also support it. 

## Superseded templates tab

:::image type="content" source="../media/exemplar-superseded-templates.png" alt-text="Screenshot of the Superseded Templates tab showing an empty predecessor-template list and Add and Remove buttons." lightbox="../media/exemplar-superseded-templates.png":::


The following table describes the settings shown on the Superseded Templates tab.

| Setting | Description |
| --- | --- |
| **Certificate templates** | Lists the older templates this template replaces. The empty list means no supersedence relationship is configured. |
| **Template Display Name** | Identifies each predecessor by its friendly name. Add only templates whose purposes the replacement covers. |
| **Minimum Supported CAs** | Shows the minimum CA version supported by each listed predecessor. |
| **Add** | Selects an existing template to supersede. This doesn't publish the replacement on a CA. |
| **Remove** | Removes the selected supersedence relationship, not the template object or its certificates. Unavailable while no entry is selected. |

Supersedence guides eligible autoenrollment clients to the replacement. It doesn't revoke existing certificates or automatically remove certificates published in AD DS. 

## Security tab

:::image type="content" source="../media/exemplar-security.png" alt-text="Screenshot of the Security tab showing template principals and Read permission allowed for Authenticated Users." lightbox="../media/exemplar-security.png":::


The following table describes the principals shown on the Security tab.

| Setting | Description |
| --- | --- |
| **Group or user names** | Lists principals with permission entries on the template. Selecting a principal changes the permission grid; it isn't a list of certificate holders. |
| **Authenticated Users** | Selected. Represents authenticated users and computers. The displayed permissions apply to this entry. |
| **Administrator** | An individual account listed by name. Its domain or computer qualifier and its template permissions aren't shown. |
| **Domain Admins** (`CONTOSO\Domain Admins`) | The example domain's administration group. Its template permissions aren't displayed. |
| **Enterprise Admins** (`CONTOSO\Enterprise Admins`) | The example forest's administration group. Its template permissions aren't displayed. |
| **Add** | Adds an existing principal to the template's permission configuration; it doesn't create an account or group. |
| **Remove** | Removes the selected permission entry, not the account or its issued certificates. Access might remain through other group memberships. |
| **Advanced** | Opens detailed access-control entries and settings, including special permissions not represented by the simplified grid. |

In **Permissions for Authenticated Users**, only **Read** is allowed. All other displayed **Allow** boxes and all **Deny** boxes are clear.

| Permission | Description |
| --- | --- |
| **Full Control** | Permits full template administration, including changing settings and permissions. Restrict this permission to trusted template administrators. |
| **Read** | Permits template discovery and inspection. Requesters and issuing CA computer accounts need access to read the template. |
| **Write** | Permits changes to template attributes. It isn't permission to enroll or, by itself, to change the template's permissions or owner. |
| **Enroll** | Permits certificate requests based on the template. Read permission and the other enrollment and issuance requirements still apply. |
| **Autoenroll** | Permits automatic enrollment. Also requires Read, Enroll, and appropriate client policy; it doesn't configure that policy. |

**Allow** grants a permission through the selected entry; **Deny** records an explicit denial. Clearing Allow isn't the same as selecting Deny. Effective access also depends on group membership, inheritance, and access-control entry ordering. 

## Server tab

:::image type="content" source="../media/exemplar-server.png" alt-text="Screenshot of the Server tab showing CA database storage and certificate revocation-information options." lightbox="../media/exemplar-server.png":::


The following table describes the settings shown on the Server tab.

| Setting | Description |
| --- | --- |
| **Do not store certificates and requests in the CA database** | Unchecked. Requests volatile issuance without retaining issued certificates and requests in the CA database. The CA must also enable volatile requests. This limits database growth but removes the records used for routine per-certificate auditing and revocation. |
| **Do not include revocation information in issued certificates** | Unchecked. Omits revocation information from issued certificates. Relying applications might reject certificates that lack the information required by their revocation policy. |

Keep these options clear unless the workload explicitly supports their consequences, such as an approved short-lived certificate design.
