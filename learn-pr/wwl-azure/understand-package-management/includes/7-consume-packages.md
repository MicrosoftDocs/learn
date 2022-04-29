Each software project that consumes packages to include the required dependencies will use the package manager and more packages sources.

The package manager will download the individual packages from the sources and install them locally on the development machine or build server.

The developer flow will follow this general pattern:

1.  Identify a required dependency in your codebase.
2.  Find a component that satisfies the requirements for the project.
3.  Search the package sources for a package offering a correct version of the component.
4.  Install the package into the codebase and development machine.
5.  Create the software implementation that uses the new components from the package.

The package manager tooling will help search and install the components in the packages.

How it's achieved varies for the different package types. Refer to the documentation of the package manager for instructions on consuming packages from feeds.

To get started, you'll need to specify the package source to be used. Package managers will have a default source defined that refers to the standard package feed for its type.

Alternative feeds will need to be configured to allow consuming the packages they offer.

## Upstream sources

Part of the package management involves keeping track of the various sources.

It's possible to refer to multiple sources from a single software solution. However, when combining private and public sources, the order of resolution of the sources becomes essential.

One way to specify multiple packages sources is by choosing a primary source and selecting an upstream source.

The package manager will evaluate the primary source first and switch to the upstream source when the package isn't found there.

The upstream source might be one of the official public sources or a private source. The upstream source could refer to another upstream source itself, creating a chain of sources.

A typical scenario is to use a private package source referring to a public upstream source for one of the official feeds. It effectively enhances the packages in the upstream source with packages from the private feed, avoiding publishing private packages in a public feed.

A source that has an upstream source defined may download and cache the packages that were requested. It doesn't contain itself.

The source will include these downloaded packages and starts to act as a cache for the upstream source. It also offers the ability to keep track of any packages from the external upstream source.

An upstream source can be a way to avoid direct access of developers and build machines to external sources.

The private feed uses the upstream source as a proxy to the otherwise external source. It will be your feed manager and private source that have the communication to the outside. Only privileged roles can add upstream sources to a private feed.

See also [Upstream sources](/azure/devops/artifacts/concepts/upstream-sources).

## Packages graph

A feed can have one or more upstream sources, which might be internal or external. Each of these can have additional upstream sources, creating a package graph of the source.

Such a graph can offer many possibilities for layering and indirection of origins of packages. It might fit well with multiple teams taking care of packages for frameworks and other base libraries.

The downside is that package graphs can become complex when not correctly understood or designed. It's essential to know how you can create a proper package graph.

See also [Constructing a complete package graph](/azure/devops/artifacts/concepts/package-graph).
