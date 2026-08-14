The `classSchema` object tells you what an object of that type must contain, may contain, where it can live, and how it inherits from more general classes.

## Core `classSchema` properties

| Property | Description |
| --- | --- |
| `cn` | Relative distinguished name (RDN) of the class definition object |
| `lDAPDisplayName` | Name used by LDAP clients and filters (for example, `user`) |
| `governsID` | Object identifier (OID) that uniquely identifies the class |
| `schemaIDGUID` | Stable GUID used in object-specific access control |
| `objectClassCategory` | Integer marking the class structural, abstract, or auxiliary |
| `subClassOf` | The immediate parent class it inherits from |
| `mustContain` / `systemMustContain` | Mandatory attributes (`system`-prefixed variants are protected) |
| `mayContain` / `systemMayContain` | Optional attributes |
| `auxiliaryClass` / `systemAuxiliaryClass` | Auxiliary classes that add attributes |
| `possSuperiors` / `systemPossSuperiors` | Which parent objects can contain this object |
| `defaultObjectCategory` | The `objectCategory` value stamped on new instances |
| `defaultSecurityDescriptor` | Initial security descriptor for new instances |
| `systemFlags` | Bit field marking system characteristics |
| `isDefunct` | Whether the class is deactivated |

> [!NOTE]
> `rDNAttID`, `defaultHidingValue`, and `systemOnly` also appear on class definitions. 

## Structural, abstract, and auxiliary classes

`objectClassCategory` sorts every class into one of three kinds:

| Category | Purpose | Can be instantiated? |
| --- | --- | --- |
| Structural | Defines objects that can actually exist (`user`, `group`) | Yes |
| Abstract | Provides a common definition base for other classes (`top`, `person`) | No |
| Auxiliary | A reusable attribute bundle attached to other classes | No |

Only **structural** classes can be instantiated as real directory objects. Abstract classes contribute definitions through inheritance; auxiliary classes contribute a named set of attributes to whatever class includes them.

## Inheritance and effective attributes

:::image type="content" source="../media/schema-class-inheritance.svg" alt-text="Diagram that shows inheritance from top to person to organizationalPerson to user, plus an auxiliary class that adds attributes.":::

Classes form an inheritance chain through `subClassOf`. A common example:

```text
top -> person -> organizationalPerson -> user
```

The **effective** mandatory and optional attributes of an object are the *union* of:

- The attributes defined on the class itself,
- The attributes inherited from every superclass up to `top`, and
- The attributes contributed by any applicable auxiliary classes.

This is why the lists stored directly on the `user` class aren't the complete picture. To know what a user object can hold, you must combine `user` with `organizationalPerson`, `person`, `top`, and any auxiliary classes.

`possSuperiors` constrains hierarchy: it lists the class types that are legal parents, so it governs where in the directory tree an instance may appear.

## Inspect a class definition (read-only)

```powershell
# READ: read the stored definition of the user class
$classProperties = @(
    'lDAPDisplayName','governsID','schemaIDGUID','objectClassCategory',
    'subClassOf','mustContain','systemMustContain','mayContain',
    'systemMayContain','auxiliaryClass','systemAuxiliaryClass',
    'possSuperiors','systemPossSuperiors','defaultObjectCategory',
    'defaultSecurityDescriptor','systemFlags','isDefunct'
)

Get-ADObject `
    -Server $schemaMaster `
    -SearchBase $schemaNC `
    -LDAPFilter '(&(objectClass=classSchema)(lDAPDisplayName=user))' `
    -Properties $classProperties
```

The `mustContain` and `mayContain` values returned here are only the attributes stored *directly* on `user`. The full effective set also includes everything inherited and everything added by auxiliary classes.

## `objectClass`, `objectCategory`, and `objectClassCategory`

These three similarly named terms are distinct:

| Term | Where it lives | Meaning |
| --- | --- | --- |
| `objectClass` | On an object instance | Multivalued list of the full inheritance chain (`top`, `person`, `organizationalPerson`, `user`) |
| `objectCategory` | On an object instance | Single-valued DN of a class category, used for efficient searches |
| `objectClassCategory` | On a `classSchema` definition | Integer marking the class structural, abstract, or auxiliary |

Searches typically filter on `objectCategory` because it's single-valued and indexed, making `(objectCategory=person)` faster and more precise than filtering the multivalued `objectClass`.

## Default category and security behavior

- Property `defaultObjectCategory` sets the `objectCategory` value stamped onto each new instance of the class.
- Property `defaultSecurityDescriptor` provides the initial security descriptor applied to **new** instances only. Changing it doesn't retroactively resecure objects that already exist.
