A successful build produces a candidate; it doesn't make that application available to users. Deployment takes the verified artifact and installs or activates it in a target environment. For the illustrative EShopOnWeb search fix, that means delivering the accepted application package without rebuilding it and losing the connection to the recorded test results.

Continuous integration (CI) establishes whether an integrated change builds and passes its required checks. Continuous delivery (CD) prepares that candidate for controlled release; continuous deployment additionally automates its deployment when the required gates pass. You can automate deployment steps while retaining an independent approval before production.

## Separate application delivery from infrastructure readiness

An application deployment requires somewhere to run. An App Service package needs an existing web app and hosting plan. A container needs a target platform and access to its image. A database migration needs a reachable database, appropriate permissions, and a compatibility plan. The exact prerequisites depend on the workload, not on the pipeline platform.

**Infrastructure must be ready before the application deployment consumes it**, but the application pipeline doesn't have to create it. The target might be a long-running environment maintained by a platform team, resources created through the Azure portal, or infrastructure prepared by an operator running an approved deployment script. A separate infrastructure pipeline is another option. And ultimately, you could integrate a multi-stage pipeline scenario which runs CI Build, infrastructure deployment across different environments (for example dev/test, staging, production) and closes the loop with CD application workload deployment. Each stage would come with the necessary validation and quality/health gates and approval requirements.

The application delivery process needs evidence that its prerequisites are satisfied, regardless of how the resources were created. A pipeline environment in Azure DevOps or GitHub represents a deployment/control boundary; naming it doesn't provision the Azure resources.

Before generating YAML, define the delivery contract:

- **Candidate:** Which run produced the artifact, which revision does it represent, and which checks accepted it?
- **Target:** Which subscription, resource group, runtime, network dependencies, and configuration does the application require?
- **Readiness:** How do you verify resource existence, runtime compatibility, connectivity, and required configuration?
- **Authority:** Which identity may deploy the application, who approves it, and which team owns any prerequisite infrastructure changes?
- **Outcome:** Which smoke tests and health evidence establish that deployment succeeded?

A container image, ZIP package, script, or database change needs a different deployment component. A composite application can require several components in a deliberate order. Don't ask Copilot to invent that topology from the artifact name.

## Connect the build candidate to application deployment

For now, extend the earlier build-only example to describe application delivery into a ready target:

```text
Build -> Deploy
  |         |
  |         Confirm target readiness, download the accepted candidate,
  |         deploy the application, and check its health
  Restore, compile, test, and package the candidate once

Deployment prerequisite: an available, correctly configured target
prepared and maintained through the team's chosen infrastructure workflow.
```

Build and deployment have different responsibilities. Build produces the verified artifact. Deployment consumes that artifact and applies the environment-specific settings needed to run it. Preserve the link to the accepted build rather than recompiling the application for each target.

If the required build checks fail, the artifact is missing, or the target isn't ready, stop the deployment. Don't select an unrelated "latest" package or let the deployment identity create missing resources as an improvised repair. Surface the unmet prerequisite to its owner.

An existing web app isn't necessarily a ready application target. Confirm runtime compatibility, required configuration, network access, and dependent services before deployment. Afterward, use smoke tests and health evidence to establish whether the application works; resource existence alone doesn't prove that outcome. This also means that you can rely on pipelines, to perform rollbacks in case of failures. 

## Choose reusable application deployment components

### Promote the same candidate through environments

An environment sequence answers *where* you validate and release; an exposure pattern answers *who* receives a production change.

| Environment | Typical purpose | Required handoff |
| --- | --- | --- |
| Dev/test | Check integration, configuration, and selected behavior in an isolated target | The candidate identity and relevant test results |
| Staging | Rehearse the release against representative runtime, networking, identity, and dependencies | Readiness, smoke/acceptance evidence, and a compatibility/recovery decision |
| Production | Deliver through the approved exposure mechanism | Independent authorization, candidate/configuration identity, and observed release health |

```text
Accepted build candidate -> Dev/test -> Staging -> Production exposure
                            check      rehearse   early adopters/canary -> wider audience
```

These are deployment environments, not a requirement to maintain three long-lived Git branches or rebuild three versions. Select the same ZIP or container digest for each target. Configuration can differ, so record it and validate those differences separately.

For a ZIP, download the artifact from the selected accepted build run. For a container, use the accepted registry digest rather than a mutable tag. Package-feed view promotion controls package consumption; it doesn't deploy an application or supply evidence from a production environment.

Don't confuse an independent staging environment with the `staging` slot of a production App Service. A slot is a live application within that App Service and may share capacity or dependencies. You can rehearse in a separate staging environment before preparing a production slot.

Select deployment steps that match the accepted artifact and target. For an App Service ZIP package, the component downloads the package, checks the approved target, deploys the package, and verifies the result. A container deployment instead identifies the accepted image and updates the target to use it. Database changes need their own compatibility and sequencing decisions.

Extract reviewed application deployment steps into Azure Pipelines templates or GitHub reusable workflows when several pipelines need them. Parameterize approved target choices while keeping credentials in the platform's protected resources. Preserve artifact identity, required checks, and failure behavior during extraction.

The dedicated infrastructure-as-code material develops how to define, validate, and deploy the underlying resources. Once those concepts are established, infrastructure automation can also be integrated into a full CI/CD scenario. That's a design option, not a requirement for every application deployment or an assumption that resources must be recreated on each release.

## Establish controls before implementation

Protect infrastructure changes separately from application releases: they can require different permissions and reviewers. In Azure Pipelines, resource owners configure environment approvals and checks outside YAML. In GitHub, configure environment protection rules and deployment branch restrictions separately, subject to the repository's plan and feature availability. Merely adding an `environment` reference doesn't establish those rules.

The following units develop identity, configuration, progressive exposure, and health gates. Carry forward a verified candidate, a target-readiness contract, and clear deployment authority. These inputs let you use Copilot to propose application deployment YAML without assuming that infrastructure provisioning belongs in the same pipeline.

Learn more about [Azure Pipelines approvals and checks](/azure/devops/pipelines/process/approvals?view=azure-devops), [GitHub deployment environments](https://docs.github.com/en/actions/how-tos/deploy/configure-and-manage-deployments/manage-environments), and [App Service deployment slots](/azure/app-service/deploy-staging-slots).
