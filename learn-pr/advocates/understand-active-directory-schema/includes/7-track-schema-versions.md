Every forest ships with a **base schema** of built-in classes and attributes. Products and later operating systems add **extension** objects on top. Microsoft classifies schema objects with two categories that describe how strictly they can be modified:

| Category | Meaning |
| --- | --- |
| Category 1 | Base-schema objects that ship with AD DS; most tightly restricted |
| Category 2 | Extension objects added after installation; less restricted |

> [!IMPORTANT]
> Category 1 and Category 2 are Microsoft *schema-restriction* terms, not module difficulty levels. They describe which modifications the directory permits on an object, and the restrictions differ between the two.

## Raising the base schema

Windows Server raises the base schema through `adprep`. Running `adprep /forestprep` (a **CHANGE** operation, performed from the correct Windows Server installation media under an approved forest-upgrade process) applies the definitions a new server version needs and advances the schema version.

The schema version is stored in the `objectVersion` attribute on the schema partition object. You can read it with the following commands:

```powershell
# READ: schema version from the schema partition object
Get-ADObject `
    -Server $schemaMaster `
    -Identity $schemaNC `
    -Properties objectVersion |
    Select-Object DistinguishedName, objectVersion
```

```powershell
# READ: same value through the AD: provider
Get-ItemProperty "AD:\$schemaNC" -Name objectVersion
```

## Interpreting the version number

As dated examples (accurate as of 2026):

| Windows Server version | Schema `objectVersion` |
| --- | ---: |
| Windows Server 2025 | 91 |
| Windows Server 2022 | 88 |
| Windows Server 2019 | 88 |

Note that Windows Server 2019 and 2022 share version **88**.

> [!WARNING]
> `objectVersion` is the **schema version**, not the **forest functional level**. They advance independently: raising the schema with `adprep` doesn't raise the functional level, and vice versa. Don't read one to infer the other.

## Product-specific version markers

Applications track their own schema state separately from the AD DS `objectVersion`. For example, Microsoft Exchange Server uses `rangeUpper` on its `ms-Exch-Schema-Version-Pt` attribute definition in the schema partition. A forest can therefore be at one Windows Server schema version while carrying an entirely separate product schema version. When you assess "what schema is this forest running," check both the AD DS `objectVersion` and any relevant product markers.

Because versions change over time, treat every mapping in this unit as **dated evidence**. Confirm current values against the Microsoft Learn schema-version references before acting on them.
