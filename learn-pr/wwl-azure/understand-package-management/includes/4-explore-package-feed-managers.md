Each of the **package types** has a corresponding **package manager** that takes care of one or more of the following aspects of package management:

- **Installation and removal:** Managing local packages on development machines.
- **Publishing:** Pushing packages to remote package feeds.
- **Consumption:** Downloading and consuming packages from remote feeds.
- **Searching:** Finding and discovering packages in feeds.
- **Dependency resolution:** Automatically installing required dependencies.
- **Version management:** Managing package versions and updates.

The package manager has cross-platform **command-line interface (CLI)** tools to manage local packages and feeds that host the packages. This CLI tooling is part of a local install on a development machine.

## Common package managers

### NuGet CLI

**Purpose:** Manage .NET packages.

**Key commands:**

- `nuget install` - Install packages.
- `nuget pack` - Create packages.
- `nuget push` - Publish packages to feeds.
- `nuget restore` - Restore packages for a solution.

**Tools:** NuGet CLI, dotnet CLI (integrated with .NET SDK).

### npm

**Purpose:** Manage JavaScript/Node.js packages.

**Key commands:**

- `npm install` - Install packages.
- `npm publish` - Publish packages to feeds.
- `npm update` - Update packages.
- `npm search` - Search for packages.

**Configuration:** `package.json` defines dependencies and scripts.

### Maven

**Purpose:** Manage Java packages and build automation.

**Key commands:**

- `mvn install` - Install artifacts to local repository.
- `mvn deploy` - Deploy artifacts to remote repository.
- `mvn dependency:resolve` - Resolve and download dependencies.

**Configuration:** `pom.xml` (Project Object Model) defines project structure and dependencies.

**Alternative:** **Gradle** is another popular build tool for Java that can work with Maven repositories.

### pip

**Purpose:** Manage Python packages.

**Key commands:**

- `pip install` - Install packages.
- `pip uninstall` - Remove packages.
- `pip list` - List installed packages.
- `pip freeze` - Output installed packages in requirements format.

**Configuration:** `requirements.txt` lists package dependencies.

### Docker CLI

**Purpose:** Manage container images.

**Key commands:**

- `docker pull` - Download images from registries.
- `docker push` - Upload images to registries.
- `docker build` - Build images from Dockerfiles.
- `docker images` - List local images.

**Registries:** Docker Hub, Azure Container Registry, private registries.

## CLI tooling benefits

The **command-line nature** of the tooling offers several advantages:

- **Scriptability:** Include commands in scripts to automate package management.
- **CI/CD integration:** Use in build and release pipelines for automated workflows.
- **Consistency:** Same commands work across different operating systems.
- **Automation:** Create, publish, and consume packages automatically.
- **Version control:** Script package management in version-controlled files.

**Best practice:** Ideally, one should use the tooling in **build and release pipelines** for:

- Creating packages from built components.
- Publishing packages to feeds automatically.
- Consuming packages during builds.
- Restoring dependencies before compilation.

## Integrated developer tooling

Additionally, developer tooling can have integrated support for working with package managers, providing a **user interface** for the raw tooling.

**Examples of integrated tooling:**

- **Visual Studio:** NuGet Package Manager UI, integrated package management.
- **Visual Studio Code:** Extensions for npm, NuGet, and other package managers.
- **Eclipse:** Maven integration (m2eclipse), Gradle integration.
- **IntelliJ IDEA:** Maven and Gradle support built-in.
- **PyCharm:** pip package management integrated.

**Benefits of integrated tooling:**

- **Visual interface:** Easier for developers not comfortable with CLI.
- **Discovery:** Browse and search packages visually.
- **Installation:** Install packages with clicks instead of commands.
- **Updates:** Visual notifications of available package updates.
- **Conflict resolution:** UI assistance for resolving dependency conflicts.

## Choosing tools

When selecting package management tools, consider:

- **Developer preference:** CLI for automation, GUI for ease of use.
- **CI/CD requirements:** CLI tools are essential for pipelines.
- **Team skills:** Match tooling to team expertise.
- **Project needs:** Choose based on package types and workflows.

Many developers use a **combination** of both CLI and GUI tools:

- **Development:** GUI for quick package additions and exploration.
- **Automation:** CLI for build scripts and CI/CD pipelines.
