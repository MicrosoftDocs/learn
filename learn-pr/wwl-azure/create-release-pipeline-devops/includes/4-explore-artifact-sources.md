
What is an artifact? An artifact is a deployable component of your application. These components can then be deployed to one or more environments.

In general, the idea about build and release pipelines and Continuous Delivery is to build once and deploy many times.

It means that an artifact will be deployed to multiple environments. The artifact should be a stable package if you want to achieve it.

The configuration is the only thing you want to change when deploying an artifact to a new environment.

The contents of the package should never change. It's what we call [immutability](/azure/devops/artifacts/artifacts-key-concepts). We should be 100% sure that the package that we build, the artifact, remains unchanged.

How do we get an artifact? There are different ways to create and retrieve artifacts, and not every method is appropriate for every situation.

:::image type="content" source="../media/artifact-sources-97b67122.png" alt-text="Screenshot of multiple artifact sources to add to the pipeline.":::


The most common way to get an artifact within the release pipeline is to use a build artifact.

The build pipeline compiles, tests, and eventually produces an immutable package stored in a secure place (storage account, database, and so on).

The release pipeline then uses a secure connection to this secured place to get the build artifact and do extra actions to deploy it to an environment.

The significant advantage of using a build artifact is that the build produces a versioned artifact.

The artifact is linked to the build and gives us automatic traceability. We can always find the sources that made this artifact. Another possible artifact source is version control.

We can directly link our version control to our release pipeline.

The release is related to a specific commit in our version control system. With that, we can also see which version of a file or script is eventually installed. In this case, the version doesn't come from the build but from version control.

Consideration for choosing a version control artifact instead of a build artifact can be that you only want to deploy one specific file. If you don't need to run more actions before using this file in your release pipeline, creating a versioned package (build artifact) containing only one file doesn't make sense.

Helper scripts that do actions to support the release process (clean up, rename, string actions) are typically good candidates to get from version control.

Another possibility of an artifact source can be a network share containing a set of files. However, you should be aware of the possible risk. The risk is that you aren't 100% sure that the package you're going to deploy is the same package that was put on the network share. If other people can also access the network share, the package might be compromised. Therefore, this option won't be sufficient to prove integrity in a regulated environment (banks, insurance companies).

Finally, container registries are a rising star regarding artifact sources. Container registries are versioned repositories where container artifacts are stored. Pushing a versioned container to the content repository and consuming that same version within the release pipeline has more or less the same advantages as using a build artifact stored in a safe location.
