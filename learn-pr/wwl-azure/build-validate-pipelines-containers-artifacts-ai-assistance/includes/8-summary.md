A build pipeline turns accepted source into an identified candidate. You connect CI triggers and dependencies to verification, Docker packaging, dependency sources, and controlled publication, whether a person or Copilot proposes the automation.

## What you learned

- Distinguish PR validation from a main-branch candidate build and compare Azure Pipelines stages/templates with GitHub Actions jobs/reusable workflows.
- Preserve requirement-linked test execution, explicit cross-job artifact transfer, and candidate identity.
- Build an application image through tested Docker stages without confusing a build container, run artifact, package feed, and registry.
- Compare Azure Artifacts feeds and views with GitHub Packages and GHCR, retaining exact package versions and container digests.
- Evaluate build-only YAML and publication proposals while separating validation workers from privileged publishers.
- Bound runtime agents and remediation, retaining the checks, inputs, outputs, policy, and independent decision needed for audit replay.

The illustrative EShopOnWeb candidate now has matching behavioral, security, license, inventory, and provenance evidence. None of these alone proves universal safety; missing evidence or an expired exception remains unresolved.

Delivery consumes this accepted ZIP, package, or image without rebuilding it for dev/test, staging, and production. Release strategy, environment configuration, canary or early-adopter exposure, blue-green traffic changes, and recovery belong to the next learning path.

## Learn more

- [Azure Pipelines stages](/azure/devops/pipelines/process/stages?view=azure-devops).
- [Docker multi-stage builds](https://docs.docker.com/build/building/multi-stage/).
- [Azure Artifacts feed views](/azure/devops/artifacts/feeds/views?view=azure-devops).
- [GitHub Container registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry).
