
When you use a release pipeline to deploy your packages to production, you need traceability.

That means you want to know where the package that you're deploying originates from.

It's essential to understand that the sources that you built and checked into your version control are precisely the same as the sources that you're going to deploy to the various environments that are going to be used by your customers.

Primarily when you work in a regulated environment like a bank or an insurance company, auditors ask you to provide traceability to sources that you deployed to prove the integrity of the package.

Another crucial aspect of your artifacts is auditability. You want to know who changed that line of code and who triggered the build that produces the artifact deployed.

A proper mechanism to make sure you can provide the correct traceability and auditability is using immutable packages.

It isn't something that you can buy, but something that you need to implement yourself.

Using a build pipeline that produces a package stored in a location that humans can't access, you ensure the sources are unchanged throughout the whole-release process. It's an essential concept of release pipelines.

You identify an immutable package by giving it a version so that you can refer to it at a later stage. Versioning strategy is a complex concept and isn't in the scope of this module.

Still, having a unique identification number or label attached to the package and ensuring that this number or label cannot be changed or modified afterward ensures traceability and auditability from source code to production.

Read more about [Semantic Versioning](https://semver.org).

Choosing the right artifact source is tightly related to the requirements you have about traceability and auditability.

If you need an immutable package (containing multiple files) that can never be changed and be traced, a build artifact is the best choice.

If it's one file, you can directly link to source control.

You can also point at a disk or network share, but it implies some risk-concerning auditability and immutability. Can you ensure the package never changed?

See also [Release artifacts and artifact sources](/azure/devops/pipelines/release/artifacts).
