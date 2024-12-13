Microsoft Purview data security solutions help you manage and monitor your data and protect information. 

## Know your data

Identifying which items are sensitive and gaining visibility into how they're being used is central to your information protection practice. Microsoft Purview includes:

* Sensitive information types to identify sensitive items by using built-in or custom regular expressions, or a function.
* Trainable classifiers to identify sensitive items by using examples of the data you're interested in rather than identifying elements in the item.
* Data classification provides a graphical identification of items in your organization that have a sensitivity label, a retention label, or have been classified and the actions your users are taking on them


## Protect your data

There are many capabilities that you can use from the Microsoft Purview Information Protection solution to help protect your data, wherever it's stored and however it's accessed. However, **sensitivity labels** are the foundational capability that both provide protection actions and interact with other Purview solutions and capabilities.

Sensitivity labels provide users and admins with visibility into the sensitivity of the data that they're using, and the labels themselves can apply protection actions that include encryption, access restrictions, and visual markings. For more information about the range of labeling scenarios supported, see the Common scenarios for sensitivity labels section from the getting started documentation. For more information about sensitivity labels, see Learn about sensitivity labels.

## Encrypt your data and control your encryption keys

Encryption is an important part of your information protection strategy. The encryption process encodes your data (referred to as plaintext) into ciphertext. Unlike plaintext, ciphertext can't be used by people or computers unless and until the ciphertext is decrypted. Decryption requires an encryption key that only authorized users have. Encryption helps ensure that only authorized recipients can decrypt your content.

* **Microsoft Purview Double Key Encryption** - uses two keys to protect data; one key in your control and a second key stored securely in Microsoft Azure.
* **Microsoft Purview Customer Key** -  provides extra protection against viewing of data by unauthorized systems or personnel, and complements BitLocker disk encryption and SSE in Microsoft data centers. Helps you meet regulatory or compliance obligations for controlling root keys.

## Prevent data loss

Unintentional sharing of sensitive items can cause financial harm to your organization and may result in a violation of laws and regulations. Microsoft Purview Data Loss Prevention can help protect your organization against unintentional or accidental sharing of sensitive information both inside and outside of your organization. In a data loss prevention policy, you:

* Define the sensitive information you want to monitor for, like financial, health, medical, and privacy data.
* Where to monitor, like Microsoft 365 services or Windows and macOS devices.
* The conditions that must be matched for a policy to be applied to an item, like items containing credit card, driver's license, or social security numbers.
* The actions to take when a match is found, like audit, block the activity, and block the activity with override.