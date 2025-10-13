Each software project that **consumes packages** to include the required dependencies will use the **package manager** and one or more **package sources**.

The package manager will download the individual packages from the sources and install them locally on the development machine or build server.

## Developer workflow for consuming packages

The developer flow will follow this general pattern:

1. **Identify a required dependency:** Determine what functionality is needed in your codebase.
2. **Find a component:** Search for a component that satisfies the requirements for the project.
3. **Search package sources:** Look for a package offering the correct component version.
4. **Install the package:** Use the package manager to install the package into the codebase and development machine.
5. **Implement functionality:** Create the software implementation that uses the new components from the package.

The **package manager tooling** will help search and install the components in the packages. How it's achieved varies for the different package types. Refer to the documentation of the package manager for instructions on consuming packages from feeds.

## Configuring package sources

To get started, you'll need to specify the **package source**. Package managers will have a default source defined as the standard package feed for its type.

**Default sources by package type:**

- **NuGet:** NuGet.org
- **npm:** npmjs.com
- **Maven:** Maven Central
- **pip:** PyPI.org
- **Docker:** Docker Hub

**Alternative feeds** will need to be configured to allow consuming the packages they offer.

### Configuration examples

**NuGet (`nuget.config`):**

```xml
<packageSources>
  <add key="NuGet.org" value="https://api.nuget.org/v3/index.json" />
  <add key="MyPrivateFeed" value="https://pkgs.dev.azure.com/myorg/_packaging/myfeed/nuget/v3/index.json" />
</packageSources>
```

**npm (`.npmrc`):**

```
registry=https://registry.npmjs.org/
@myorg:registry=https://pkgs.dev.azure.com/myorg/_packaging/myfeed/npm/registry/
```

**Maven (`pom.xml` or `settings.xml`):**

```xml
<repositories>
  <repository>
    <id>central</id>
    <url>https://repo.maven.apache.org/maven2</url>
  </repository>
  <repository>
    <id>myprivatefeed</id>
    <url>https://pkgs.dev.azure.com/myorg/_packaging/myfeed/maven/v1</url>
  </repository>
</repositories>
```

**pip (`pip.conf` or command line):**

```
pip install --index-url https://pypi.org/simple/ --extra-index-url https://pkgs.dev.azure.com/myorg/_packaging/myfeed/pypi/simple/ mypackage
```

## Upstream sources

Part of package management involves keeping track of the various sources. It's possible to refer to multiple sources from a single software solution. However, when combining private and public sources, the **order of resolution** of the sources becomes essential.

### How upstream sources work

One way to specify multiple package sources is by choosing a **primary source** and an **upstream source**.

**Resolution order:**

1.  The package manager evaluates the **primary source** first.
2.  If the package isn't found there, it switches to the **upstream source**.
3.  The upstream source might be one of the official public or private sources.
4.  The upstream source could refer to another upstream source, creating a **chain of sources**.

### Typical scenario

A typical scenario is to use a **private package source** referring to a **public upstream source** for one of the official feeds.

**Benefits:**

- **Enhances packages:** Effectively enhances the packages in the upstream source with packages from the private feed.
- **Avoids public publishing:** Avoids publishing private packages in a public feed.
- **Single configuration:** Developers configure only the private feed, which automatically includes upstream packages.

### Caching behavior

A source with an upstream source defined may **download and cache** the requested packages if the source doesn't contain those packages themselves.

**How caching works:**

- The source will include these downloaded packages.
- Starts to act as a **cache** for the upstream source.
- Offers the ability to keep track of any packages from the external upstream source.
- Improves performance by reducing repeated downloads.

### Proxy for external sources

An upstream source can be a way to **avoid direct access** of developers and build machines to external sources.

**Proxy pattern:**

- The private feed uses the upstream source as a **proxy** for the external source.
- It will be your feed manager and private source that have the communication to the outside.
- Developers and build machines only access the private feed.
- Only privileged roles can add upstream sources to a private feed.

**Benefits:**

- **Security:** Control external package access through a single point.
- **Governance:** Monitor and control which external packages are used.
- **Reliability:** Continue using cached packages even if external source is unavailable.
- **Performance:** Faster package downloads from local cache.

See also [Upstream sources](/azure/devops/artifacts/concepts/upstream-sources).

## Package graphs

A feed can have one or more **upstream sources**, which might be internal or external. Each of these can have additional upstream sources, creating a **package graph** of the source.

### Benefits of package graphs

Such a graph can offer many possibilities for layering and indirection of origins of packages. It might fit well with multiple teams taking care of packages for frameworks and other base libraries.

**Use cases:**

- **Team-specific feeds:** Different teams maintain their own feeds with shared upstream sources.
- **Environment separation:** Development, staging, and production feeds with different configurations.
- **Framework layers:** Base framework packages → Company libraries → Application packages.

### Considerations

The downside is that package graphs can become **complex** when not correctly understood or designed. It's essential to know how you can create a proper package graph.

**Best practices:**

- **Keep it simple:** Avoid unnecessary complexity in upstream source chains.
- **Document structure:** Clearly document the package graph for your organization.
- **Limit depth:** Avoid deep chains of upstream sources.
- **Monitor usage:** Track which packages come from which sources.

See also [Constructing a complete package graph](/azure/devops/artifacts/concepts/package-graph).

## Authentication

When consuming packages from **private feeds**, authentication is required.

**Authentication methods:**

- **Personal Access Tokens (PAT):** Token-based authentication for scripts and tools.
- **Credential providers:** Automatic credential management for package managers.
- **Service principals:** For CI/CD pipelines and automation.
- **Integrated authentication:** Use existing organizational credentials.

**Example with Azure Artifacts:**

- Install Azure Artifacts Credential Provider.
- Package managers automatically prompt for credentials when needed.
- Credentials are cached for future use.
