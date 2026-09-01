Several tools are able to read the schema.

| Tool | Typical use | Risk |
| --- | --- | --- |
| `ActiveDirectory` PowerShell module | Scripted read and inventory | Low; reads are safe |
| AD drive provider (`AD:\`) | Ad-hoc path-style reads | Low |
| Active Directory Schema MMC | Browse classes and attributes | Low when browsing; changes are possible |
| ADSI Edit | Raw attribute-level inspection | High; edits are immediate and forest-wide |
| LDIFDE | Export inventories; import approved changes | Low on export; high on import |
| LDP | Advanced LDAP reads and filter testing | Low when reading |
| Microsoft Learn schema reference | Look up predefined definitions | None |

## PowerShell and the AD provider

The AD drive provider for PowerShell offers a path-style alternative for quick reads of the schema:

```powershell
# READ: read a single property through the AD: provider
Get-ItemProperty "AD:\$schemaNC" -Name objectVersion
```

### Inventory attributes by behavior

You can use **server-side** LDAP filters so the DC does the filtering rather than pulling the whole schema to the client. The matching rule OID `1.2.840.113556.1.4.803` performs a bitwise-AND test, which lets you match individual `searchFlags` elements.

```powershell
# READ: indexed attributes (searchFlags bit 0x01)
Get-ADObject -Server $schemaMaster -SearchBase $schemaNC `
    -LDAPFilter '(&(objectClass=attributeSchema)(searchFlags:1.2.840.113556.1.4.803:=1))' `
    -Properties lDAPDisplayName, searchFlags

# READ: attributes replicated to the global catalog
Get-ADObject -Server $schemaMaster -SearchBase $schemaNC `
    -LDAPFilter '(&(objectClass=attributeSchema)(isMemberOfPartialAttributeSet=TRUE))' `
    -Properties lDAPDisplayName, isMemberOfPartialAttributeSet

# READ: linked attributes
Get-ADObject -Server $schemaMaster -SearchBase $schemaNC `
    -LDAPFilter '(&(objectClass=attributeSchema)(linkID=*))' `
    -Properties lDAPDisplayName, linkID

# READ: attributes in the RODC filtered attribute set (searchFlags bit 0x200 = 512)
Get-ADObject -Server $schemaMaster -SearchBase $schemaNC `
    -LDAPFilter '(&(objectClass=attributeSchema)(searchFlags:1.2.840.113556.1.4.803:=512))' `
    -Properties lDAPDisplayName, searchFlags, schemaFlagsEx

# READ: defunct class and attribute definitions
Get-ADObject -Server $schemaMaster -SearchBase $schemaNC `
    -LDAPFilter '(&(|(objectClass=classSchema)(objectClass=attributeSchema))(isDefunct=TRUE))' `
    -Properties lDAPDisplayName, isDefunct
```

## Export a schema inventory with LDIFDE

You can use LDIFDE to export schema objects to an LDIF text file. This output can be useful for inventories and before/after evidence during change procedures.

- LDIFDE has an **export** mode (`-f`) and an **import** mode (`-i`). 
- Exports document state; they **aren't** a rollback mechanism. You can't reimport an export to "undo" a schema addition.
- Before differencing two exports, normalize attribute ordering and decode binary values. Multivalued attributes can be returned in different orders, so a raw text diff produces false differences.
- Schema exports can contain ACL and directory details. Don't place them in public repositories.

The following code shows an example export

```powershell
# READ: export class and attribute definitions to an LDIF file
ldifde.exe `
    -f .\schema-export.ldf `
    -s $schemaMaster `
    -d $schemaNC `
    -p SubTree `
    -r '(|(objectClass=classSchema)(objectClass=attributeSchema))' `
    -l 'cn,lDAPDisplayName,objectClass,governsID,attributeID,schemaIDGUID,isDefunct'
```
## Graphical and low-level tools

- **Active Directory Schema MMC** - a console for browsing classes and attributes. You can connect it to a specific DC. Use it for safe visual inspection; avoid making changes.
- **ADSI Edit** - connects to the well-known **Schema** naming context and shows every raw attribute.

  > [!WARNING]
  > In ADSI Edit, edits to schema objects are immediate and forest-wide. Use it to read, and don't treat it as a preferred tool for making changes.

- **LDP** - an optional advanced tool for reading RootDSE, binding to a chosen server, browsing the schema partition, and testing LDAP filters before you script them.
- **Microsoft Learn schema reference** - authoritative pages for predefined classes, attributes, syntaxes, and control access rights. Use them to confirm the documented semantics of a built-in attribute before you reuse it.

## Safe inspection habits

- Discover the schema NC and master through RootDSE; target `-Server $schemaMaster` explicitly.
- Prefer server-side LDAP filters over retrieving the whole schema and filtering client-side.
- Request only the properties you need.
- Treat every browsing tool as read-only unless you're executing an approved, reviewed change.
