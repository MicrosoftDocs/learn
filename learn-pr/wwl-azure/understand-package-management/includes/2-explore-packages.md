**Packages** are used to define the components you rely on and depend upon in your software solution. They provide a way to store those components in a well-defined format with **metadata** to describe them.

## What is a package?

A **package** is a formalized way of creating a distributable unit of software artifacts that can be consumed from another software solution.

**Key characteristics of packages:**

- **Content description:** The package describes the content it contains.
- **Metadata:** Provides extra information about the package (version, author, dependencies).
- **Unique identification:** Information uniquely identifies individual packages.
- **Self-descriptive:** Package format is standardized and well-documented.

**Benefits of using packages:**

- **Centralized storage:** Store packages in centralized locations for easy access.
- **Predictable consumption:** Consume package contents in a consistent manner.
- **Tooling support:** Enable automated tools to manage packages in your software solution.
- **Version management:** Track and manage different versions of components.
- **Dependency resolution:** Automatically resolve and install required dependencies.

## Package components

A typical package contains:

- **Compiled code:** Libraries, assemblies, or executable files.
- **Source files:** In some cases, source code for debugging or reference.
- **Metadata:** Information about the package (name, version, author, license, dependencies).
- **Documentation:** README files, API documentation, or usage guides.
- **Assets:** Images, configuration files, or other resources.

## Types of packages

Packages can be used for different kinds of components. The type of components you want to use in your codebase differ for the different parts and layers of the solution you're creating.

**Component ranges:**

- **Frontend components:** JavaScript code files, CSS libraries, UI frameworks.
- **Backend components:** .NET assemblies, Java JARs, Python modules.
- **Complete solutions:** Self-contained applications or microservices.
- **Reusable files:** Templates, configurations, or documentation.

Over the past years, packaging formats have changed and evolved. Now there are several de facto standard formats for packages.

### NuGet packages

**NuGet** packages (pronounced "new get") are a standard used for **.NET code artifacts**.

**Characteristics:**

- **Contents:** Includes .NET assemblies and related files, tooling, and sometimes only metadata.
- **Format:** Essentially a compressed folder structure with files in ZIP format.
- **Extension:** `.nupkg` file extension.
- **Usage:** Defines how packages are created, stored, and consumed in .NET ecosystem.

See also [An introduction to NuGet](/nuget/what-is-nuget).

### npm packages

**npm** packages are used for **JavaScript development**.

**Characteristics:**

- **Origin:** Originates from Node.js development where it's the default packaging format.
- **Contents:** File or folder containing JavaScript files and a `package.json` file.
- **Metadata:** `package.json` describes the package's metadata, dependencies, and scripts.
- **Modules:** Package usually includes one or more modules that can be loaded once consumed.

See also [About packages and modules](https://docs.npmjs.com/about-packages-and-modules).

### Maven packages

**Maven** is used for **Java-based projects**.

**Characteristics:**

- **Project Object Model:** Each package has a POM file describing the project's metadata.
- **Format:** JAR (Java Archive) files for libraries, WAR (Web Archive) for web applications.
- **Coordinates:** Identified by groupId, artifactId, and version.
- **Build tool:** Maven serves as both package manager and build automation tool.

### PyPI packages

**PyPI** (Python Package Index), abbreviated as PyPI and known as the Cheese Shop, is the official third-party software repository for **Python**.

**Characteristics:**

- **Format:** Distributions in wheel (`.whl`) or source distribution (`.tar.gz`) formats.
- **Tool:** Managed using **pip** (package installer for Python).
- **Contents:** Python modules and packages with dependencies.
- **Metadata:** `setup.py` or `pyproject.toml` files define package information.

### Docker images

**Docker** packages are called **images** and contain complete and self-contained deployments of components.

**Characteristics:**

- **Self-contained:** A Docker image commonly represents a software component that can be hosted and executed by itself.
- **Layered architecture:** Images are built in layers for efficiency and reusability.
- **Base images:** Images might be dependent on other images as their basis (e.g., Ubuntu, Alpine).
- **Registries:** Stored in Docker registries (Docker Hub, Azure Container Registry).

## Choosing the right package type

| **Package Type** | **Primary Use**                     | **Language/Platform**  | **Extension**     |
| ---------------- | ----------------------------------- | ---------------------- | ----------------- |
| **NuGet**        | .NET libraries and tools            | C#, F#, VB.NET         | `.nupkg`          |
| **npm**          | JavaScript libraries and frameworks | JavaScript, TypeScript | N/A (folder)      |
| **Maven**        | Java libraries and applications     | Java, Kotlin, Scala    | `.jar`, `.war`    |
| **PyPI**         | Python libraries and packages       | Python                 | `.whl`, `.tar.gz` |
| **Docker**       | Containerized applications          | Any language           | Image layers      |
