Schema attributes carry security metadata that governs who can read and write directory data. Understanding these controls and their limits keeps sensitive data protected.

## Four GUID-bearing identifiers

Access control on schema-defined data touches several GUIDs. Keeping them distinct avoids serious mistakes:

| GUID | Belongs to | Role in security |
| --- | --- | --- |
| `objectGUID` | An individual directory object | Immutable identity of that object |
| `schemaIDGUID` | A `classSchema` or `attributeSchema` definition | Names the class or attribute in object-specific access-control entries |
| `attributeSecurityGUID` | An attribute definition | Associates the attribute with a **property set** |
| `rightsGuid` | A `controlAccessRight` object | Identifies an extended right, property set, or validated write |

`schemaIDGUID` is what an ACL references when it grants or denies rights to a specific attribute or class. Because ACLs bind to this GUID, an extension must generate `schemaIDGUID` values once and reuse the same values in every installation, or permissions become inconsistent.

## Property sets and control access rights

- A **property set** groups related attributes so a single permission can cover them all. Membership is expressed through `attributeSecurityGUID`, which points at the property set's `controlAccessRight` object.
- The **`controlAccessRight`** objects live in `CN=Extended-Rights,CN=Configuration,...` and back three things conceptually: **extended rights**, **property sets**, and **validated writes**.

> [!IMPORTANT]
> Defining a schema attribute doesn't create a control access right. Control access rights are separate configuration objects. A custom validated write also requires validation behavior that schema metadata alone can't provide. This module doesn't cover creating custom control access rights.

## Default security for new instances

`defaultSecurityDescriptor` on a class supplies the initial security descriptor for **new** instances of that class. It isn't a retrofit: changing it doesn't resecure objects that already exist. Plan the default before objects are created.

## Confidentiality controls plus replication limits

| Control | What it does | What it is **not** |
| --- | --- | --- |
| Confidential bit (`searchFlags` `0x80`) | Adds an extra control-access read check on the attribute | Not encryption; doesn't replace ACL design |
| RODC filtered attribute set (`searchFlags` `0x200`) | Prevents replication of the attribute to read-only DCs | Not encryption; not a substitute for permissions |
| `schemaFlagsEx` critical flag | Marks an attribute critical | Blocks that attribute from the RODC filtered set |

These controls reduce exposure but none of them encrypt data. Layer them with proper ACLs, and remember the RODC filtered set only limits *where* data replicates, not *who* can read it on a writable DC.

## Keep secrets out of the schema

> [!WARNING]
> Never store passwords, private keys, tokens, or equivalent secret material in custom attributes. Directory attributes replicate widely and are readable by more principals than most secret data should ever reach. Secrets belong in a system designed for them, with application-layer encryption and specialized access controls.
