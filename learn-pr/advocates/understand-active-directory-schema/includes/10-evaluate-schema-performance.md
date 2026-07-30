Attribute design has measurable cost. Every choice about indexing, global catalog membership, size, and links multiply across all instances and all domain controllers.

## Indexing cost

Setting the index bit (`searchFlags` `0x01`) speeds equality searches but has the following impact:

- The index consumes storage on **every** DC.
- Each write to the attribute must also update the index, adding write cost.
- Index builds run in the **background** on DCs after the change.

Index an attribute only when queries are frequent and values are **selective**. A low-selectivity attribute (few distinct values, such as a yes/no flag) gains little from an index while paying its full cost. The tuple index (`0x20`) further helps leading-wildcard searches such as `(sn=*mith)` but costs more still.

## Global catalog and RODC tradeoffs

| Control | Effect | Cost or limit |
| --- | --- | --- |
| Partial attribute set (`isMemberOfPartialAttributeSet`) | Attribute replicates to every global catalog, enabling fast forest-wide reads | Adds storage and replication load on all GC servers |
| RODC filtered attribute set (`searchFlags` `0x200`) | Attribute doesn't replicate to read-only domain controllers | Blocked when the attribute is marked critical via `schemaFlagsEx`; not encryption |
| Ambiguous Name Resolution (`searchFlags` `0x04`) | Attribute participates in ANR name lookups | Only worthwhile for name-like attributes |

Add an attribute to the global catalog only when forest-wide reads genuinely justify the extra replication and storage everywhere.

## Value size, volatility, and replication

- **Size:** Large values replicate in full on every change and inflate the directory database on all DCs. Prefer a reference to an external store over storing bulky data in the directory.
- **Volatility:** A frequently changing attribute generates continuous replication traffic. High volatility plus global catalog membership multiplies that traffic across every GC.
- **Linked-value replication:** Forward-link changes replicate individual values rather than the whole attribute, which makes large group memberships far cheaper to replicate than an equivalently sized multivalued nonlinked attribute. Model a true managed relationship as a linked attribute for this reason.

## Quick performance checklist

- Is the attribute queried often enough to justify an index?
- Are its values selective enough for an index to help?
- Does any consumer read it forest-wide, warranting global catalog membership?
- How large and how volatile is a typical value, across all instances?
- Is a managed relationship better modeled as a linked attribute?

Estimate these from current product guidance and representative testing rather than treating advisory numbers as universal hard limits.
