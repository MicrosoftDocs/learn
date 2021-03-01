As part of planning for domain controller deployments, it's important to identify the optimal number and placement of the global catalog role. This becomes relevant when expanding AD DS environment to other locations, as is the case with Contoso's planned expansion.

## Manage the AD DS global catalog role

The *global catalog* is a partial, read-only, searchable copy of all the objects in a forest. The global catalog can help speed up searches for objects that might be stored on domain controllers in a different domain in the forest.

Within a single domain, the AD DS database on each domain controller contains all the information about every object in that domain. However, only a subset of this information replicates to the global catalog servers in other domains in the forest. Within a domain, a query for an object is directed to one of the domain controllers in that domain. However, that query does not return results about objects in other domains within the forest. For a query to include results from other forest domains, you must query a domain controller that is also a global catalog server.

The global catalog doesn't contain all the attributes for each object. Instead, it maintains the subset of attributes that are most likely to be useful in cross-domain searches. These attributes include, for example, **givenName**, **displayName**, and **mail**. You can change the set of attributes replicated to the global catalog by modifying the AD DS schema.

In a multiple-domain forest, searching the global catalog can be useful in many situations. For example, when a server that's running Microsoft Exchange Server receives an incoming email, it must search for the recipient’s account so it can decide how to route the message. By automatically querying the global catalog, the server can find the recipient in a multiple-domain environment. Additionally, when users sign in to their Active Directory accounts, the domain controller that performs the authentication must contact the global catalog to check for universal group memberships before authenticating the users.

In a single domain, you should configure all the domain controllers to have a copy of the global catalog. In multiple-domain and multiple-site forests, it might sometimes make sense to limit the number of domain controllers hosting the global catalog role to reduce the volume of replication traffic, although this is an uncommon scenario. Note, however, that this will introduce dependency on connectivity to other sites when performing global catalog queries.

> [!TIP]
> Consider configuring every domain controller as a global catalog unless you must reduce replication traffic volume.
