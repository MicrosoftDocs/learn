Source control supplies a reviewed revision and verification requirements. A build pipeline now has to turn those inputs into an identified, tested output that delivery can consume. A successful merge isn't evidence that dependencies resolved correctly, tests executed, or the final container passed its checks.

For the illustrative EShopOnWeb work item **"Search results showing out-of-stock items"**, follow **accepted source -> restore -> build and verify -> package once -> controlled publication**. The application paths, contracts package, pipeline, Dockerfile, and registries used here are teaching examples, not assets supplied by the Azure Boards lab.

In this module, you:

- Design CI triggers, stage/job dependencies, explicit output transfer, and meaningful test evidence in Azure Pipelines and GitHub Actions.
- Distinguish a containerized build environment from an application image, and connect Docker build stages so required tests can't be bypassed.
- Choose pipeline artifacts, Azure Artifacts feeds, GitHub Packages, or a container registry according to the consumer.
- Use Copilot to draft and evaluate build-only YAML, dependency, container, and publication changes.
- Separate validation from privileged publication, and bound runtime agents and remediation with retained evidence.

The output is a candidate identified by a package version, file identity, or image digest, with matching test and supply-chain evidence. 
