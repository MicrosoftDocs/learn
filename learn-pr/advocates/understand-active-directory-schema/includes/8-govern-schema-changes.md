A schema change is forest-wide and effectively permanent. This unit covers when to extend, how to decide safely, and the ownership and controls a change requires.

## Permanence sets the stakes

> [!WARNING]
> Adding a class or attribute **isn't** a reversible operation. Schema objects can't be deleted through a normal rollback, and restoring one domain controller isn't a safe or supported schema-only rollback strategy.

The most you can do to retire a definition is deactivate it by setting `isDefunct` to true. Even then:

- The definition object remains in the schema.
- Existing data in that attribute isn't automatically removed.
- The identifiers it consumed aren't freed for arbitrary reuse.

Because you can't cleanly undo an extension, the decision to make a schema extension requires careful planning.

## Decide: Extend, reuse, or store elsewhere

:::image type="content" source="../media/schema-extension-decision.svg" alt-text="Diagram of decision flow that chooses whether to reuse an attribute, store data outside AD DS, or extend the schema under full governance.":::

### When not to extend

Don't extend the schema simply because AD DS is convenient. Prefer an alternative store when data is:

- Application-private and never used by directory-aware services.
- Large, binary, highly volatile, or unbounded.
- Secret material needing application-layer encryption or specialized controls.
- High-volume telemetry, history, or transactional data.
- Governed by a lifecycle different from the directory object's lifecycle.
- Better kept in an application database with only a stable identifier in AD DS.

## Attribute design decisions

- Reuse an existing attribute **only** when its documented semantics match the new use; never overload an attribute in a way that breaks interoperability.
- Choose the narrowest correct syntax and reasonable `rangeLower`/`rangeUpper` limits.
- Decide single-valued versus multivalued deliberately.
- Plan linked attributes only when a true managed relationship exists.
- Estimate value and object size from current product guidance and representative testing, not from advisory numbers treated as universal hard limits.
- Estimate total storage and replication impact across **all** instances.
- Avoid indexing attributes with poor selectivity or rare queries; an index consumes storage, adds write cost, and builds in the background on DCs.
- Add an attribute to the global catalog only when forest-wide reads justify the replication and storage cost.

## Identifier and naming governance

| Rule | Reason |
| --- | --- |
| Obtain a registered enterprise OID arc | Guarantees your OIDs never collide with others |
| Keep a central allocation record | Prevents internal reuse of OIDs, names, and GUIDs |
| Use an organization-specific naming prefix | Distinguishes custom classes and attributes from built-ins |
| Generate `schemaIDGUID` values once and reuse them | Keeps ACLs consistent across every installation |

> [!IMPORTANT]
> Never invent OIDs, reuse another organization's OID arc, or reuse identifiers without a collision check. Class and attribute OIDs share one uniqueness space, and `lDAPDisplayName` must be unique across all class and attribute definitions.

## Security design decisions

- Grant **temporary, audited** Schema Admins membership or narrowly delegated schema rights. The Schema Admins group lives in the forest-root domain; remove membership immediately after the approved change.
- Preflight rights against the schema-container ACLs and effective access.
- Distinguish the four GUID-bearing identifiers: an object's `objectGUID`, a definition's `schemaIDGUID`, an attribute's `attributeSecurityGUID`, and a control access right's `rightsGuid`.
- Understand `controlAccessRight` objects in `CN=Extended-Rights,CN=Configuration,...` at a conceptual level: they back extended rights, property sets, and validated writes. Defining an attribute **doesn't** by itself create a custom validated-write implementation.
- Remember that `defaultSecurityDescriptor` secures **new** instances only, the confidential bit is an extra access check (not encryption), and the RODC filtered attribute set is a replication control (not encryption or a permissions substitute).
- Never store passwords, private keys, tokens, or equivalent secrets in custom attributes.

## Governance controls before any change

1. Confirm business and technical **ownership**, data classification, retention, query patterns, expected object count, and application lifecycle.
2. Produce an **extension manifest** (see the next unit) as the change record.
3. Run **compatibility analysis** against ranges, cardinality, inheritance, legal parents, indexing, GC/RODC behavior, security, storage, and replication cost.
4. Check for **collisions** across `cn`, `lDAPDisplayName`, OID, `schemaIDGUID`, and where applicable `rightsGuid` and `linkID`.
5. Confirm **recovery readiness**: current backups, a validated forest-recovery plan, and acceptance that no simple schema-only rollback exists.
6. Validate the exact signed or checksummed package in an **isolated test forest** representative of production.
7. Obtain **change approval**, and for vendor packages perform a full extension review.

## Worked scenario: Application metadata request

A team asks to add an `employeeShoeSize` attribute to every user so their internal app can read it.

- **Directory-relevant?** No directory-aware service consumes it.
- **Lifecycle?** It changes independently of the user object and is app-private.
- **Decision:** Don't extend. Store it in the application's database keyed by the user's `objectGUID`. Extending the forest schema permanently for a single private app is disproportionate to the need.

## Worked scenario: Vendor package review

A vendor ships an LDIF package that extends the schema. Before approving it, review:

- Identifiers: registered OID arc, unique `lDAPDisplayName`s, stable `schemaIDGUID`s, no collisions.
- Dependencies and apply order between attributes and the classes that reference them.
- Required permissions and whether they can be time-boxed.
- Test evidence in a representative forest.
- Indexing, ANR, global catalog membership, and RODC handling of each attribute.
- Uninstall behavior. Confirm the vendor doesn't claim uninstall removes schema definitions, because it can't.

Only after that review, and successful test-forest validation, does the package proceed to a change window.
