**Packages** should be stored in a centralized place for distribution and consumption to take dependencies on the components they contain.

The centralized storage for packages is commonly called a **package feed**. There are other names in use, such as **repository** or **registry**.

**Terminology:**

- **Feed:** General term used by Azure Artifacts and some other services.
- **Repository:** Common in Maven and Docker contexts (Maven repositories, Docker registries).
- **Registry:** Used by npm (npm registry) and Docker (container registry).

We'll refer to all of these as **package feeds** unless it's necessary to use the specific name for clarity.

## Feed characteristics

### Type-specific feeds

Each package type has its type of feed. Put another way: **One feed typically contains one type of packages**.

**Examples:**

- **NuGet feeds:** Store .NET packages.
- **npm feeds:** Store JavaScript/Node.js packages.
- **Maven repositories:** Store Java packages.
- **PyPI feeds:** Store Python packages.
- **Docker registries:** Store container images.

### Versioned storage

**Package feeds** offer versioned storage of packages. A particular package can exist in multiple versions in the feed, catering for consumption of a specific version.

**Benefits of versioning:**

- **Compatibility:** Maintain compatibility with different project requirements.
- **Rollback:** Revert to previous versions if issues arise with newer versions.
- **Testing:** Test with specific versions before upgrading.
- **Stability:** Pin dependencies to known-good versions for production.

## Private and public feeds

The package feeds are centralized and available for many different consumers. Depending on the package, purpose, and origin, it might be generally available or restricted to a select audience.

### Public feeds

**Public feeds** are accessible to anyone without authentication.

**Characteristics:**

- **Open access:** Anyone can consume packages without credentials.
- **Anonymous consumption:** No account required for most operations.
- **Optional authentication:** Some public feeds offer authentication for publishing.
- **Visibility:** Packages are discoverable through search and browsing.

**Typical use cases:**

- **Open-source projects:** Applications, libraries, and frameworks shared with everyone.
- **Community packages:** Reusable components contributed by developers worldwide.
- **Free access:** Most public feeds are free to consume.

**Examples of public feeds:**

- **NuGet.org:** Public feed for .NET packages.
- **npmjs.com:** Public registry for JavaScript packages.
- **Maven Central:** Public repository for Java packages.
- **PyPI.org:** Public index for Python packages.
- **Docker Hub:** Public registry for container images.

### Private feeds

**Private feeds** can only be consumed by those who are allowed access.

**Why use private feeds:**

- **Intellectual property:** Contains proprietary code or business logic.
- **Internal use:** Components developed for internal use within project, team, or company.
- **Security:** Sensitive code that shouldn't be publicly exposed.
- **Licensing:** Packages with restricted licensing agreements.
- **Development stage:** Pre-release or experimental packages not ready for public use.

**Key difference:** The main difference between public and private feeds is the need for **authentication**.

- **Public feeds:** Can be anonymously accessible and optionally authenticated.
- **Private feeds:** Can be accessed only when authenticated with proper credentials.

**Access control:**

- **User-based:** Grant access to specific users.
- **Team-based:** Grant access to entire teams.
- **Organization-based:** Restrict to organization members.
- **Role-based:** Different permissions for readers, contributors, and owners.

## Feed visibility options

When creating a feed, you typically choose between visibility options:

| **Visibility**   | **Access**                   | **Use Case**                              |
| ---------------- | ---------------------------- | ----------------------------------------- |
| **Public**       | Anyone can consume           | Open-source packages, community libraries |
| **Private**      | Only authenticated users     | Internal components, proprietary code     |
| **Organization** | Members of your organization | Shared across teams within company        |
| **Project**      | Members of specific project  | Project-specific packages                 |

In **Azure Artifacts**, you can also configure:

- **Feed permissions:** Control who can read, contribute, and administer.
- **Upstream sources:** Include packages from public sources.
- **Feed views:** Create filtered views of your feed (e.g., Release, Prerelease).
