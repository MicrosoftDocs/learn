The schema describes the kinds of objects the directory can hold and the attributes those objects can carry. Directory data is the population of actual objects that follow those rules.

| Layer | Example | Changes how often | Change risk |
| --- | --- | --- | --- |
| Schema definition | The `user` class allows a `telephoneNumber` attribute | Rarely, under strict control | Forest-wide |
| Directory data | `CN=Ana Bowman` has `telephoneNumber = 555-0100` | Constantly, routine administration | Object-scoped |

**Schema definitions are themselves directory objects.** A class is stored as a `classSchema` object and an attribute as an `attributeSchema` object, both reside in the schema partition. Tools you use to read directory objects can read the schema.

## Classes, instances, attributes, and values

To understand classes, instances, attributes, and values, consider:

- A **class** (`classSchema`) is a template. An **instance** is one object created from it. `user` is a class; `CN=Ana Bowman` is an instance.
- An **attribute** (`attributeSchema`) is a defined property. A **value** is the content one instance stores in it. `telephoneNumber` is an attribute; `555-0100` is a value.
- A **schema change** redefines what is possible for every object of a type. An ordinary change edits one object's values. Editing Ana's phone number is routine; changing the `user` class affects every user in the forest.

Consider familiar objects:

- A **user** is an instance of the `user` class, which inherits attributes from more general classes.
- A **group** is an instance of the `group` class, whose `member` attribute links to other objects.
- A **computer** is an instance of the `computer` class, which is itself a specialization of `user`.

## One schema per forest

There's exactly **one schema per Active Directory forest**, and every domain in that forest shares it. Every domain controller (DC) holds a replica of the schema. Cross-domain objects are consistent. A schema change is a forest-wide event.
