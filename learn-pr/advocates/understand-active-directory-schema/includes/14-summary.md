The **Active Directory schema** The schema is the formal set of rules for object classes, attributes, constraints, and directory structure. There's one schema per forest, held on every domain controller and changed only on the schema master. Every change is forest-wide and effectively permanent. In this module you learned to:

- Discover naming contexts from RootDSE; never hard-code a forest distinguished name.
- Keep default operations read-only; treat every schema write as demonstration-only until it's an approved, tested change.
- A schema version number is evidence, not proof of complete replication or application readiness.
- Extensions aren't reversible; `isDefunct` deactivates but doesn't delete, and restoring one domain controller isn't a rollback.

## Continue learning

- [Active Directory Schema (AD DS)](/windows/win32/ad/active-directory-schema)
- [Characteristics of Object Classes](/windows/win32/ad/characteristics-of-object-classes)
- [Characteristics of Attributes](/windows/win32/ad/characteristics-of-attributes)
- [Restrictions on Schema Extension](/windows/win32/ad/restrictions-on-schema-extension)
- [Find the current Active Directory schema version](/windows-server/identity/ad-ds/deploy/find-active-directory-schema)
- [Flexible Single Master Operations roles in AD DS](/windows-server/identity/ad-ds/manage/understand-fsmo-roles)
- [Windows Server Inside Out (Microsoft Press)](https://aka.ms/WSInsideOut)
