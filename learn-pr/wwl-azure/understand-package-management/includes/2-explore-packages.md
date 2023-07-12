
Packages are used to define the components you rely on and depend upon in your software solution.

They provide a way to store those components in a well-defined format with metadata to describe them.

## What is a package?

A package is a formalized way of creating a distributable unit of software artifacts that can be consumed from another software solution.

The package describes the content it contains and usually provides extra metadata, and the information uniquely identifies the individual packages and is self-descriptive.

It helps to better store packages in centralized locations and consume the contents of the package predictably.

Also, it enables tooling to manage the packages in the software solution.

## Types of packages

Packages can be used for different kinds of components.

The type of components you want to use in your codebase differ for the different parts and layers of the solution you're creating.

The range from frontend components, such as JavaScript code files, to backend components like .NET assemblies or Java components, complete self-contained solutions, or reusable files in general.

Over the past years, the packaging formats have changed and evolved. Now there are a couple of de facto standard formats for packages.

 -  **NuGet** packages (pronounced "new get") are a standard used for .NET code artifacts. It includes .NET assemblies and related files, tooling, and sometimes only metadata. NuGet defines the way packages are created, stored, and consumed. A NuGet package is essentially a compressed folder structure with files in ZIP format and has the `.nupkg` extension. See also [An introduction to NuGet](/nuget/what-is-nuget).
 -  **npm** package is used for JavaScript development. It originates from node.js development, where it's the default packaging format. An npm package is a file or folder containing JavaScript files and a `package.json` file describing the package's metadata. For node.js, the package usually includes one or more modules that can be loaded once the package is consumed. See also [About packages and modules](https://docs.npmjs.com/about-packages-and-modules).
 -  **Maven** is used for Java-based projects. Each package has a Project Object Model file describing the project's metadata and is the basic unit for defining a package and working with it.
 -  **PyPi** The Python Package Index, abbreviated as PyPI and known as the Cheese Shop, is the official third-party software repository for Python.
 -  **Docker** packages are called images and contain complete and self-contained deployments of components. A Docker image commonly represents a software component that can be hosted and executed by itself without any dependencies on other images. Docker images are layered and might be dependent on other images as their basis. Such images are referred to as base images.
