Walk the learner through the app code that can be abstracted/refactored into a package.

Discuss concepts you should know and various strategies you can use. The JTA recommends:

* Registries such as NuGet, Maven, Chocolatey, NPM, & container registries
  * Although we're specifically working with a .NET Core app, we can say that the registry you choose depends on the kind of app you're building. For example, if you're building a Java app, you might ...
* Talk about hosting, feeds, and access (public vs. private)
* Talk about versioning (for example, Assembly version format, Semantic Versioning) and an overall strategy of how multiple pipelines can feed into the build pipeline for your app.

Perhaps also cover:

* When it's appropriate (and not appropriate) to split your codebase into multiple packages. What are the benefits? What are the tradeoffs?