Proseware automates model deployment, but the team doesn't want every successful workflow run to change production traffic immediately. Automated tests should verify the deployment first. A reviewer should then decide whether the evidence supports promotion.

## Represent deployment stages

A **GitHub environment** is a named deployment target in a repository, such as `staging` or `production`. A workflow job references the environment that it targets. GitHub evaluates that environment's protection rules before the job runs or accesses environment secrets.

The environment name doesn't create an Azure resource. You decide how each GitHub environment maps to Azure Machine Learning resources. For example, staging and production might use separate workspaces for stronger isolation, or separate endpoints in one workspace for lower management overhead.

> [!NOTE]
> A GitHub environment controls deployment jobs. An Azure Machine Learning **environment** defines the operating system, packages, and other dependencies used to run machine learning code. The two concepts are independent.

## Protect production promotion

GitHub environment protection rules can require a reviewer, restrict deployments to selected branches or tags, or add a wait timer. For Proseware, only runs from `main` can target production. A required reviewer examines the staging test results before allowing the production promotion job to continue.

This gate separates two decisions. Automated checks determine whether the deployment meets defined requirements. The reviewer decides whether the release should proceed now, considering evidence and operational context.

## Scope configuration and access

Environment variables can hold non-sensitive target settings, such as the Azure Machine Learning workspace and endpoint names. Environment secrets are available only to jobs that reference that environment and only after its protection rules pass.

With OIDC, you don't store a client secret. You can still use different federated identities for staging and production, then grant each identity only the Azure permissions its job requires. This approach prevents a staging job from gaining production access simply because both jobs use the same repository.

A practical workflow separates deployment from promotion. One job deploys and tests the new model without production traffic. A later job references the protected `production` environment and changes traffic only after approval.

> [!TIP]
> Before adding an approval, identify what evidence the reviewer needs. A gate without clear acceptance criteria delays deployment without improving the decision.

Learn more about [managing GitHub environments for deployment](https://docs.github.com/actions/how-tos/deploy/configure-and-manage-deployments/manage-environments).
