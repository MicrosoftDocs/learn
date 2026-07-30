An attribute is defined by an `attributeSchema` object. Its definition controls the attribute's type, size, cardinality, indexing, replication reach, and security exposure everywhere the attribute is used.

## Core `attributeSchema` properties

| Property | Why it matters |
| --- | --- |
| `cn` | RDN of the attribute definition object |
| `lDAPDisplayName` | Name used by LDAP clients and filters |
| `attributeID` | OID that uniquely identifies the attribute |
| `schemaIDGUID` | Stable GUID used in object-specific access control |
| `attributeSyntax` | Data type portion of the syntax triplet |
| `oMSyntax` | Integer that refines the syntax |
| `oMObjectClass` | Object type for object-reference syntaxes |
| `rangeLower` / `rangeUpper` | Minimum and maximum length or value |
| `isSingleValued` | Whether the attribute holds one value or many |
| `searchFlags` | Bit field controlling indexing, ANR, confidentiality, and more |
| `isMemberOfPartialAttributeSet` | Whether the attribute replicates to the global catalog |
| `linkID` | Pairs a forward link with its back link |
| `attributeSecurityGUID` | Associates the attribute with a property set |
| `schemaFlagsEx` | Marks an attribute critical, blocking RODC filtering |
| `systemFlags` | Bit field marking system characteristics |
| `systemOnly` | Whether only the system can write the value |
| `isDefunct` | Whether the attribute is deactivated |

## Syntax, range, and cardinality

The **syntax triplet** (`attributeSyntax`, `oMSyntax`, and where relevant `oMObjectClass`) determines how AD DS stores and validates values. For example, one triplet defines a Unicode string, another a large integer, another a distinguished-name reference. AD DS enforces the syntax on write; an LDAP client can still present the resulting value in a different textual form.

- Properties `rangeLower` and `rangeUpper` bound the length of a string or the magnitude of a number. They're validation limits, not storage guarantees.
- Property `isSingleValued` chooses cardinality. **Multivalued attributes are unordered**, so you can't rely on the order values are returned.

## Links between objects

:::image type="content" source="../media/schema-attribute-controls.svg" alt-text="Diagram that shows attribute controls for indexing, ANR, GC membership, RODC filtering, confidentiality, and linked-attribute pairing.":::

A **linked attribute** models a managed relationship between objects using a matched pair:

- The **forward link** stores the reference (for example, `member` on a group).
- The **back link** is *calculated* from the forward links (for example, `memberOf` on a user); you don't write it directly.
- The pair is joined by `linkID`: the forward link has an **even** value and the back link the next **odd** value.
- Only forward links replicate; back links are computed locally. Forward-link changes use **linked-value replication**, which replicates individual values rather than the whole attribute.

Distinguish these from **constructed** or system-maintained values (such as `memberOf` or `canonicalName`) that AD DS calculates rather than stores as ordinary replicated data.

## Indexing and search behavior

Indexing is a property of the *attribute*, so it applies **everywhere the attribute is used**, not to a single class. The operationally important `searchFlags` bits are:

| Bit | Meaning |
| --- | --- |
| `0x01` | Create an index |
| `0x04` | Include in Ambiguous Name Resolution (ANR) |
| `0x08` | Preserve value on logical deletion |
| `0x20` | Create a tuple index (for medial searches) |
| `0x80` | Mark as confidential |
| `0x200` | Include in the RODC filtered attribute set |

> [!NOTE]
> `searchFlags` contains additional bits beyond these. They're rarely administered directly and their numeric values aren't assessed here; see the reference links for the complete field.

Decode the flags on any attribute you retrieved:

```powershell
# READ: decode the searchFlags bit field for one attribute
$flags = [int]$attribute.searchFlags

[pscustomobject]@{
    Indexed          = [bool]($flags -band 0x01)
    ANR              = [bool]($flags -band 0x04)
    PreserveOnDelete = [bool]($flags -band 0x08)
    TupleIndex       = [bool]($flags -band 0x20)
    Confidential     = [bool]($flags -band 0x80)
    RODCFiltered     = [bool]($flags -band 0x200)
}
```

## Global catalog, read-only domain controllers, and confidentiality

- **Partial attribute set (PAS):** When `isMemberOfPartialAttributeSet` is true, the attribute replicates to every global catalog in the forest. That speeds forest-wide reads but adds replication and storage cost across all GC servers. Add attributes to the GC only when forest-wide reads justify it.
- **RODC filtered attribute set:** The `0x200` bit stops an attribute from replicating to read-only domain controllers. It's a replication control, not encryption, and not a substitute for access control lists (ACLs). An attribute marked critical through `schemaFlagsEx` **can't** be added to the filtered attribute set.
- **Confidential bit (`0x80`):** Marking an attribute confidential adds an extra control-access authorization check before it can be read. It's **not encryption** and doesn't replace careful ACL design.

## Inspect an attribute definition (read-only)

```powershell
# READ: read the stored definition of the employeeID attribute
$attributeProperties = @(
    'lDAPDisplayName','attributeID','schemaIDGUID','attributeSyntax',
    'oMSyntax','oMObjectClass','rangeLower','rangeUpper','isSingleValued',
    'searchFlags','isMemberOfPartialAttributeSet','linkID',
    'attributeSecurityGUID','schemaFlagsEx','systemFlags','systemOnly','isDefunct'
)

$attribute = Get-ADObject `
    -Server $schemaMaster `
    -SearchBase $schemaNC `
    -LDAPFilter '(&(objectClass=attributeSchema)(lDAPDisplayName=employeeID))' `
    -Properties $attributeProperties

$attribute

# Convert the byte-array schemaIDGUID to standard GUID notation
[Guid]::new([byte[]]$attribute.schemaIDGUID)
```

PowerShell commonly returns `schemaIDGUID` as a raw byte array. Converting it with `[Guid]::new(...)` produces the GUID notation used in object-specific access-control documentation.

## Names and identifiers

An attribute (and a class) carries several identifiers with different purposes and uniqueness scopes:

| Identifier | Purpose | Uniqueness |
| --- | --- | --- |
| `cn` | RDN of the definition object | Within the schema partition |
| `lDAPDisplayName` | Name used by LDAP clients and filters | Across all class **and** attribute definitions |
| `attributeID` | OID for an attribute | Shared OID space with classes |
| `governsID` | OID for a class | Shared OID space with attributes |
| `objectGUID` | Identity of the definition object itself | Forest-wide, per object |
| `schemaIDGUID` | Stable GUID used in object-specific ACLs | Per definition, reused across installs |
| `attributeSecurityGUID` | Associates the attribute with a property set | Per property set |

Class and attribute OIDs share **one** uniqueness space, and `lDAPDisplayName` values must be unique across *both* class and attribute definitions.
