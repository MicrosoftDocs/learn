Here, we talk about managing dependencies.

Here's a sample scenario:

* The team identifies code that can be shared among multiple applications.
* The team contacts the owner of that code and they agree to split it.
* The team splits the code, including relevant tests, and creates a pipeline for it. The pipeline produces a package.
* The team changes the app codebase to use the package. They also update the build pipeline to support the change.