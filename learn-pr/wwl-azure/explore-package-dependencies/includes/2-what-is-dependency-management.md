Before we can understand dependency management, we'll need first to get introduced to the concepts of dependencies.

## Dependencies in software

Modern software development involves complex projects and solutions.

Projects have dependencies on other projects, and solutions aren't single pieces of software.

The solutions and software built consist of multiple parts and components and are often reused.

As codebases are expanding and evolving, it needs to be componentized to be maintainable.

A team that is writing software won't write every piece of code by itself but use existing code written by other teams or companies and open-source code that is readily available.

Each component can have its maintainers, speed of change, and distribution, giving both the creators and consumers of the components autonomy.

A software engineer will need to identify the components that make up parts of the solution and decide whether to write the implementation or include an existing component.

The latter approach introduces a dependency on other components.

## Why is dependency management needed?

Software dependencies that are introduced in a project and solution must be appropriately declared and resolved.

You need to manage the overall composition of the project code and the included dependencies.

Without proper dependency management, it will be hard to keep the components in the solution controlled.

Management of dependencies allows a software engineer and team to be more efficient working with dependencies.

With all dependencies being managed, it's also possible to control the consumed dependencies, enabling governance and security scanning to use known vulnerabilities or exploits packages.
