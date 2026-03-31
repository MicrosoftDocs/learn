The various **package types** have a standard source that is commonly used for public use. It's a go-to place for developers to find and consume publicly available components as software dependencies. These sources are **package feeds**.

## Public package sources

**Public package sources** are centralized registries where developers share and discover packages.

**Characteristics:**

- **Free to use:** In general, publicly available package sources are free to consume.
- **Open access:** Anyone can search, browse, and download packages.
- **Community-driven:** Maintained by communities or organizations.
- **Trusted sources:** Well-established with security scanning and quality checks.

### Using public sources

**Consuming packages:**

- **Free consumption:** Download and use packages at no cost.
- **No authentication required:** Most public sources allow anonymous access for consumption.
- **Licensing:** Individual packages may have specific licenses (MIT, Apache, GPL, etc.).

**Publishing packages:**

- **Account required:** Need to create an account to publish.
- **Public availability:** Public and free package sources will usually require that you make the packages you store publicly available as well.
- **Open-source encouraged:** Most packages are open-source, though not always required.
- **Payment models:** Some sources have premium tiers for private packages or enhanced features.

## Common public package sources

| **Package Type** | **Package Source**          | **URL**                                              | **Description**                                                             |
| ---------------- | --------------------------- | ---------------------------------------------------- | --------------------------------------------------------------------------- |
| **NuGet**        | NuGet Gallery               | [https://nuget.org](https://nuget.org)               | Official repository for .NET packages with thousands of libraries and tools |
| **npm**          | npmjs                       | [https://npmjs.org](https://npmjs.org)               | World's largest software registry for JavaScript and Node.js packages       |
| **Maven**        | Maven Central               | [https://search.maven.org](https://search.maven.org) | Central repository for Java and JVM ecosystem packages                      |
| **Docker**       | Docker Hub                  | [https://hub.docker.com](https://hub.docker.com)     | Public registry for container images with official and community images     |
| **Python**       | Python Package Index (PyPI) | [https://pypi.org](https://pypi.org)                 | Official repository for Python packages with over 400,000 projects          |

The table above doesn't contain an extensive list of all public sources available. There are other public package sources for each of the types.

## Additional public sources

### NuGet alternatives

- **GitHub Package Registry:** Host NuGet packages on GitHub.
- **MyGet:** Public and private NuGet feeds with additional features.

### npm alternatives

- **GitHub Package Registry:** Host npm packages on GitHub.
- **Yarn:** Alternative package manager that uses npmjs.com registry.

### Maven alternatives

- **JCenter:** Popular Maven repository (now read-only, migrating to Maven Central).
- **Google Maven Repository:** Android libraries and Google services.

### Docker alternatives

- **Quay.io:** Container image registry by Red Hat.
- **GitHub Container Registry:** Host container images on GitHub.

### Python alternatives

- **Anaconda:** Distribution and package repository for data science packages.
- **conda-forge:** Community-maintained repository of conda packages.

## Benefits of using public sources

**For consumers:**

- **Vast selection:** Millions of packages available for various needs.
- **Trusted quality:** Popular packages are well-tested and maintained.
- **Documentation:** Comprehensive documentation and community support.
- **Updates:** Regular security patches and feature updates.

**For publishers:**

- **Visibility:** Reach global audience of developers.
- **Community contributions:** Others can contribute improvements.
- **Reputation:** Build reputation through popular packages.
- **Free hosting:** No cost for hosting open-source packages.

## Considerations when using public sources

**Security:**

- **Vulnerability scanning:** Check packages for known vulnerabilities.
- **Supply chain attacks:** Be aware of malicious packages or typosquatting.
- **Package verification:** Verify package publishers and signatures when available.

**Licensing:**

- **License compliance:** Ensure package licenses are compatible with your project.
- **Attribution:** Provide proper attribution as required by licenses.
- **Commercial use:** Some licenses restrict commercial usage.

**Availability:**

- **Dependency on external source:** Public sources can experience downtime.
- **Package removal:** Authors can remove packages, breaking dependencies.
- **Upstream sources:** Consider using private feeds with public upstream sources for caching.
