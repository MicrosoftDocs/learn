Contoso Health's internal security team ran their first full vault audit and found two lifecycle management failures that access controls alone can't prevent. An RSA key used to encrypt patient record archives remains unrotated for three years. If that key was ever visible to an unauthorized party, attackers had three years to use it. Database connection strings stored as secrets had no expiry dates set, meaning any compromised credential would remain valid indefinitely. There was no forced rotation, no expiry boundary, no limit on how long a stolen string could be exploited. Both failures shared the same root cause: the vault secured access to objects, but no one was managing those objects' lifecycles.

## Recognize the lifecycle gaps

Key rotation limits the damage window if a key is ever exposed. An unrotated key in use for three years was potentially accessible to every system, person, and process that touched it across that entire period. Configuring an automatic rotation policy doesn't close that historical window—but it caps all future ones. From the moment rotation is active, the maximum exposure window equals the rotation interval.

Secret expiry works differently but addresses the same underlying risk. An expiry date doesn't rotate credentials automatically—it forces them to become invalid, creating an operational requirement to replace them. Without expiry, a compromised database connection string remains usable for as long as the secret exists. The credential becomes a permanently open door rather than one that closes on a schedule.

## Explore keys and secrets in Key vault

This module covers active lifecycle management across two foundational vault object types. In this module, you:

- Evaluate key types and Hardware Security Module (HSM) backed key requirements, and import existing keys into Azure Key Vault using bring your own key (BYOK)
- Configure automatic key rotation policies to eliminate manual rotation cycles
- Manage secret versioning and expiry attributes, and use Key Vault references so applications pick up rotated credentials without redeployment
- Implement dual-credential rotation patterns using Azure Function automation for zero-downtime secret rotation

In the next unit, you work through the key types, HSM options, and rotation policies that address the first item on Contoso Health's remediation list.
