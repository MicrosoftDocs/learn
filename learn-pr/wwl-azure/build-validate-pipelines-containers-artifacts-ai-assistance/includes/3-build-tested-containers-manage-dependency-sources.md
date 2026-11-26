The EShopOnWeb team has a reviewed correction for **Search results showing out-of-stock items**. Its pipeline can compile the change, but compilation answers only one question: can these inputs produce an application? Before another team uses the output, you also need to know what it contains, whether the required checks ran, and which exact output those checks cover.

This is the supply-chain part of the larger build process: **reviewed source -> approved dependencies -> build and test -> identified output -> controlled sharing**. Repository collaboration supplies the reviewed change; supply-chain controls keep its inputs and outputs traceable. They don't replace application testing or implement deployment.

## Identify packages and artifacts through the store example

An **artifact** is an output you retain from a process. A **package** bundles files and metadata in a format that a package manager understands. In everyday usage, a package is one kind of artifact, but not every artifact is a reusable package.

For this illustrative extension of EShopOnWeb, suppose the catalog team shares product-availability data contracts with another application. It distributes those contracts as a NuGet package. The storefront consumes that package and produces a container image.

| Item | Example in the store | How another process uses it |
| --- | --- | --- |
| Dependency package | Fictional `EShopOnWeb.Catalog.Contracts` version `1.4.0` | NuGet restores it before compiling the storefront |
| Pipeline artifact | Application files and test reports retained from a build run | A later job downloads those files without rebuilding |
| Container image | The packaged storefront and its runtime | A container platform runs that image |
| Evidence artifact | A component inventory or scan report | A reviewer or automated check evaluates the identified output |

These package names, versions, and outputs are fictional teaching examples, not supplied application assets. The search correction might need only application code; sharing a contracts package doesn't itself justify upgrading it.

A **feed** or **registry** is the service endpoint where consumers find packages or images. Azure Artifacts hosts package feeds; GitHub Packages provides ecosystem-specific registries. A container registry stores images. Choose storage by what consumers need, rather than upload everything to a package feed.

Copilot can help map the repository's manifests and pipeline definitions to this table. Ask it to identify inputs, outputs, and destinations, and to mark anything it can't determine. Verify its answer against the actual files; don't let it invent a missing package or publication step.

## Follow one candidate from source to output

Imagine the team builds the search correction using the reviewed commit and contracts package `1.4.0`. It restores the dependencies, runs availability-filtering tests, and creates a candidate image. A **candidate** is simply an output awaiting a decision about wider use.

The manifest declares dependencies; the resolved dependency graph includes both direct and transitive packages. A lockfile records that resolution in the package manager's format. Keep the reviewed lockfile with the source so validation can detect unexpected resolution changes.

Identify the outputs separately. The package has a name and version; the build run has its own identifier; the image has a **digest**, a content-derived identifier. A friendly image tag such as `search-fix` can move to different contents. Retain the digest when recording which image passed review.

Prefer moving the same candidate between checking and publication jobs. Rebuilding after approval creates another output, which needs its own evidence. Likewise, a passing test report from a different commit doesn't establish that this candidate works.

## Build the container without bypassing tests

For the storefront, a multi-stage build uses SDK tools to compile and test, then copies the published application into a runtime image. The final image normally doesn't need the SDK or the entire source tree. Select supported SDK and runtime images compatible with the application's actual target framework.

The practical review question is: **must the tests succeed before this image can be published?** With BuildKit, stages run according to their dependencies, not merely their position in the file. A `test` stage can be skipped if the selected final stage doesn't depend on it. Require a dependency through the tested stage or an explicit blocking pipeline test job. See [multi-stage builds](https://docs.docker.com/build/building/multi-stage/).

Two other details matter even in a small store build:

- **Cache inputs:** when the lockfile or shared restore settings change, dependency restoration must see that change. A fast cache hit isn't proof that the new dependency set was tested. Don't share untrusted pull-request caches with privileged publication without an appropriate trust boundary.
- **Credentials:** private-package access belongs to the authorized job or a supported build-secret mechanism. Don't copy credential-bearing configuration into image layers or pass secrets as ordinary build arguments. Deleting a secret in a later layer doesn't remove it from earlier layers.

Copilot is useful for explaining stage relationships and spotting overly broad copies or missing restore inputs. The build log and executed checks, not its explanation, confirm what actually ran.

### Distinguish three kinds of stages

A pipeline stage or job groups automation. A Dockerfile stage defines an intermediate filesystem and build environment. A release stage targets an environment or audience. They are different structures: a pipeline job can run a multi-stage Docker build without deploying anything.

Also distinguish **running build tools in a container** from **building an application container image**. A container job standardizes the tool environment; its output can still be a ZIP or NuGet package. An application image packages the workload and runtime for a later container deployment. Neither approach makes the worker immune to untrusted scripts or grants it publishing permission.

### Make the final image depend on tested output

The following Dockerfile uses the fictional `App.sln`, `src/Web/Web.csproj`, and output assembly `Web.dll`. It assumes compatible .NET SDK/runtime images, a runtime image containing the nonroot `app` user, and an application that can listen on port 8080. Supply reviewed image references through the two build arguments; use approved digests when reproducible input selection is required.

```dockerfile
ARG SDK_IMAGE
ARG RUNTIME_IMAGE
FROM ${SDK_IMAGE} AS build
WORKDIR /src
COPY . .
RUN dotnet restore App.sln \
    && dotnet build App.sln --configuration Release --no-restore

FROM build AS tested
RUN dotnet test App.sln --configuration Release --no-build \
    && dotnet publish src/Web/Web.csproj --configuration Release --no-build --output /out

FROM ${RUNTIME_IMAGE} AS runtime
WORKDIR /app
COPY --from=tested /out .
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
USER app
ENTRYPOINT ["dotnet", "Web.dll"]
```

The final stage copies from `tested`, which inherits `build`. BuildKit therefore needs that dependency path. A failed test stops publication output and the image build. A separate unreferenced `test` stage would not provide the same guarantee.

The broad source copy keeps this teaching graph readable, not optimized. Review `.dockerignore` so the context excludes `.git`, local outputs, credentials, and unrelated data while retaining required source, tests, lockfiles, and restore settings. Optimize restore caching only after those inputs are understood. BuildKit can reuse a previously successful layer; use the approved cache policy or fresh execution when policy requires new evidence.

Private-feed restoration requires a supported build-secret mount and scoped identity; the Dockerfile above assumes its approved sources need no secret. Don't add a token through `ARG`, `ENV`, or a copied credential file to make it work. Publishing the final image is a separate pipeline action, not a Dockerfile instruction.

## Collect evidence that answers concrete questions

Before sharing the candidate, assemble evidence for these questions:

| Question | Evidence for the EShopOnWeb candidate |
| --- | --- |
| Does the correction work? | Tests showing in-stock products remain searchable and out-of-stock products follow the acceptance criteria |
| What does it contain? | A software bill of materials (SBOM): an inventory of packaged components |
| Are there known security or licensing concerns? | Dependency and final-image scans, plus version-specific license terms and required notices |
| Where did it come from? | Provenance linking the source commit, build definition, and build run to the output |
| Can consumers verify the expected origin? | Signature or attestation verification against the expected identity and output |

Bind image reports to the candidate digest. Check that scans include both application dependencies and base-image operating-system components, and the relevant platform for multi-platform images. Record the base-image digest too, so a later runtime refresh is an identifiable input change.

An SBOM isn't a safety certificate; a signature doesn't prove correct search behavior. Copilot can summarize these reports and highlight missing evidence, but missing coverage or unresolved license terms still require a decision. The result is a named candidate with understandable supporting evidence, ready for controlled publication.

## Control the dependency sources used by the build

### Trace the dependency before choosing a feed

You distinguish a direct dependency, which your project declares, from a transitive dependency, which another component introduces. A manifest expresses intent, but the resolved graph shows the versions that a particular restore selects. A lockfile records resolution details according to the package manager's format. You need all three perspectives when a small manifest edit changes several downstream components.

In the example, you treat the proposed dependency update as a separate justification within the same change. A filtering correction doesn't automatically require a new library. You compare the existing API with the proposed capability and inspect the resulting transitive changes. If the current dependency supports the correction, you reject unnecessary package churn rather than accept a larger review surface.

Your decision record connects the package's exact name, ecosystem, resolved version, and origin to its purpose. You also record the owning team and whether the component appears only during build or ships with the application. This distinction helps you assess both build-host exposure and distributed software obligations. An internal package name alone doesn't establish a trusted origin.

Source consolidation follows this inventory, not the other way around. You map existing consumers, credentials, duplicate names, and retention needs before you select a common endpoint. A migration that silently changes resolution is an input change even when no application code changes. You compare resolved graphs before and after the endpoint change and preserve required versions before you retire an old source.

### Control Azure Artifacts resolution and access

An Azure Artifacts feed can contain multiple ecosystems, including NuGet and npm packages. You don't need a separate feed solely because the package type differs. Project or organization scope, ownership, access boundaries, and consumer needs drive the separation.

Upstream sources let the feed serve packages from configured external origins. Azure Artifacts searches directly published packages, saved upstream packages, and then configured upstream sources in order. A single configured client feed with upstream sources gives you a clearer resolution path than an uncontrolled collection of client endpoints. This doesn't make arbitrary package-manager source lists sequential or deterministic.

The permission to download a saved package differs from the permission to introduce an upstream version. A Feed Reader consumes packages already in the feed. A Feed and Upstream Reader, also called a Collaborator, can save an upstream package when installing it. A Contributor can publish and promote packages. You therefore distinguish ordinary restoration from upstream intake rather than grant every consumer publishing rights.

With Azure Pipelines, you inspect the build identity's feed permissions as well as authentication configuration. For NuGet, the NuGet Authenticate task configures supported tools to authenticate before restore or push. It doesn't grant missing feed permissions. For a project-scoped feed in another project, you also check project access. You keep credentials out of committed configuration and grant publishing access only where the approved workflow needs it.

Feed views need an access review too. A person with access to a view can download its packages without direct feed access. You inspect both feed and view visibility before treating the feed as restricted. Storage in a feed doesn't certify package security or licensing. Your intake controls supply those decisions.

See [Azure Artifacts key concepts](/azure/devops/artifacts/artifacts-key-concepts?view=azure-devops) and [feed permissions](/azure/devops/artifacts/feeds/feed-permissions?view=azure-devops).

### Separate version identity from promotion

You choose a versioning scheme that communicates what consumers need. Semantic Versioning, or SemVer, communicates intended compatibility through major, minor, and patch components. Calendar Versioning, or CalVer, communicates release timing through date-based components. Neither scheme proves compatibility. You still need behavioral evidence and the package ecosystem's supported syntax.

An Azure Artifacts package version becomes permanently reserved after publication, even after deletion. If package contents need correction, you publish a new version. You don't rebuild different contents under the original identity.

A feed-view promotion selects an existing immutable version for another audience. It doesn't rebuild the package or change its version. The default `@local` view contains published and saved packages. Membership in `@prerelease` or `@release` requires promotion. A SemVer suffix such as `-beta.1` doesn't automatically add a package to `@prerelease`, and a view name doesn't perform quality validation.

For the illustrative change, your approval record identifies the exact reviewed version and the evidence that supports promotion. Azure Artifacts doesn't support package demotion, so your recovery plan selects an earlier acceptable version for consumers rather than promises to reverse promotion. Retention planning preserves that version and its evidence. See [promotion and feed views](/azure/devops/artifacts/feeds/views?view=azure-devops).

### Apply the equivalent outcome without false parity

GitHub Packages uses registry-specific permission models. The Container, npm, NuGet, and RubyGems registries support granular permissions. Maven and Gradle registries use repository-scoped permissions. You check the actual registry before assuming package access follows repository access.

In GitHub Actions, `GITHUB_TOKEN` supports package operations where the workflow repository has the required access. You check token permissions and package Actions access together. A token from one repository doesn't imply access to every private package. Public visibility also doesn't imply anonymous consumption across ecosystems. Public container packages support anonymous pulls, while most other registries require authentication.

You don't translate Azure Artifacts views into an invented GitHub Packages promotion command. Instead, you define an approved package version or image digest, retain its evidence, and control publication and consumer selection using the chosen registry and workflow capabilities.

Finally, you distinguish a pipeline artifact, a versioned package, and an image digest. A pipeline artifact carries files associated with a run. A package provides an ecosystem-specific consumable identity. An image digest identifies container content. You link these identities explicitly rather than substitute a run number or mutable tag for the reviewed output. The [GitHub Packages permissions reference](https://docs.github.com/en/packages/learn-github-packages/about-permissions-for-github-packages) explains the registry distinctions.

**Azure Artifacts is not a container registry.** With Azure Pipelines, retain an image archive as a run artifact when transferring it between approved jobs, and publish images to an approved registry such as Azure Container Registry. With GitHub Actions, workflow artifacts likewise transfer files, while GitHub Packages' Container registry (`ghcr.io`) stores images. A package feed, a run artifact, and a deployment environment aren't interchangeable destinations.

Feed-view promotion changes who can consume an existing package version. It does not deploy that version to dev/test, staging, or production. That environment sequence and production exposure belong to the release module.
