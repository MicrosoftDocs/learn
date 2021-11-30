With compiled runtimes like Go, Java, and .NET, you'll want to first compile your code before having a binary that can be run.

The components required to compile your code aren't needed to run your code. And the SDKs can be large, not to mention any potential attack surface area.

A workaround, which is informally called the builder pattern, involves using two Docker images:

 -  One to do a build.
 -  Another is to ship the results of the first build without the penalty of the build chain and tooling in the first image.

An example of the builder pattern:

 -  Derive from a dotnet base image with the whole runtime/SDK (Dockerfile.build).
 -  Add source code.
 -  Produce a statically linked binary.
 -  Copy the static binary from the image to the host (docker create, docker cp).
 -  Derive from SCRATCH or some other light-weight image (Dockerfile).
 -  Add the binary back in.
 -  Push a tiny image to the Docker Hub.

It usually meant having two separate Dockerfiles and a shell script to orchestrate all the seven steps.

Additionally, the challenge with building on the host, including hosted build agents, is to have a build agent with everything we need, including the specific versions.

If your dev shop has any history of .NET Apps, you'll likely have multiple versions to maintain. Which means you have complex agents to deal with the complexities.
