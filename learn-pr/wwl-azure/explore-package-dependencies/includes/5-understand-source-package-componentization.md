Current development practices already have the notion of **componentization**—the process of breaking down a system into discrete, manageable components. There are two primary approaches to componentization commonly used in software development.

## Two approaches to componentization

### 1. Source componentization

**Source componentization** is focused on organizing source code. It refers to splitting the source code in the codebase into separate parts and organizing it around the identified components.

**How it works:**

- Code is organized into logical modules or projects within a solution.
- Components are defined by folder structure and project boundaries.
- Teams work on different components within the same repository.

**When to use source componentization:**

- **Single team or closely coordinated teams:** When all developers work in the same repository.
- **Tightly coupled components:** When components change frequently together.
- **Early development:** When component boundaries are still being defined.
- **Internal use only:** When the source code isn't shared outside of the project.

**Advantages:**

- **Simplified development:** All code is in one place, making it easy to make cross-component changes.
- **Easier refactoring:** Component boundaries can be adjusted without changing external contracts.
- **Unified builds:** Everything compiles together, making it easier to ensure compatibility.

**Limitations:**

- **Sharing challenges:** Once components need to be shared, it requires distributing the source code or the produced binary artifacts.
- **Version control complexity:** Large repositories can become difficult to manage.
- **Build times:** Entire solution must be built even for small changes.
- **Limited autonomy:** Teams must coordinate changes across components.

### 2. Package componentization

**Package componentization** uses packages as a formal way of wrapping and handling components. Distributing software components is performed by creating and publishing packages.

**How it works:**

- Components are built and packaged separately.
- Packages are published to package feeds (**Azure Artifacts**, **NuGet.org**, **npm**, **Maven Central**).
- Projects consume components by referencing package versions.
- Each component has its own version and release cycle.

**When to use package componentization:**

- **Multiple teams:** When different teams maintain different components.
- **Loosely coupled components:** When components can evolve independently.
- **External sharing:** When components are shared across organizations or publicly.
- **Mature components:** When component interfaces are stable.

**Advantages:**

- **Independent versioning:** Each component can be versioned and released independently.
- **Better dependency management:** Explicit declarations of dependencies with version constraints.
- **Improved governance:** Control over what versions are consumed.
- **Team autonomy:** Teams can work on components independently.
- **Reusability:** Components can be easily shared across projects and organizations.

**Characteristics added by packages:**

- **Versioning:** Track and manage different versions of components.
- **Metadata:** Include information about authors, licenses, and dependencies.
- **Distribution:** Formal distribution channel through package feeds.
- **Dependency resolution:** Automatic resolution of transitive dependencies.

## Choosing the right approach

The choice between source and package componentization depends on your specific needs:

| Factor                 | Source Componentization | Package Componentization |
| ---------------------- | ----------------------- | ------------------------ |
| **Team size**          | Single or small team    | Multiple teams           |
| **Component coupling** | Tightly coupled         | Loosely coupled          |
| **Release cadence**    | Unified releases        | Independent releases     |
| **Sharing scope**      | Internal only           | Internal and external    |
| **Maturity**           | Early development       | Stable components        |

Many organizations use a **hybrid approach**, combining both methods:

- Use **source componentization** for core application code.
- Use **package componentization** for shared libraries and frameworks.

See also [Collaborate more and build faster with packages](/azure/devops/artifacts/collaborate-with-packages).
