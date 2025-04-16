Here, you'll explore the different tools and strategies available to you in GitHub Enterprise Cloud and GitHub Enterprise Server in order to share GitHub actions and workflows and manage their use within your enterprise.

The content is structured around the level at which the tools presented are available: _enterprise level_ or _organizational level_.

## At enterprise level

### Configure a GitHub Actions use policy

GitHub Actions workflows often contain actions, which are sets of standalone commands to be executed within the workflow. When creating a workflow, you can create your own actions to use, or reference public community actions available from GitHub Marketplace. For this reason, configuring a use policy for workflows and actions in your enterprise is essential to prevent users from using malicious third-party actions.

You have several options in Enterprise Cloud to configure a policy, as well as in Enterprise Server if GitHub Connect is enabled in your enterprise settings.

To configure a GitHub Actions use policy for your enterprise, navigate to your enterprise account and then to **Policies > Actions** in the sidebar. The following options should appear.

:::image type="content" source="../media/policies.png" alt-text="Screenshot of the Actions screen with default options selected.":::

The dropdown at the top labeled **Enable for all organizations** enables you to decide which organizations in your enterprise can use GitHub Actions (all of them, some of them or none of them), while the three options underneath enable you to define the restriction level of GitHub Actions within these organizations.

If you want to enable only specific actions to be used within your enterprise, select **Allow enterprise, and select non-enterprise, actions and reusable workflows**, and choose the option corresponding to your use case.

:::image type="content" source="../media/policies-2.png" alt-text="Screenshot of the Actions screen with Allow select actions option selected.":::

### Manually sync public actions for Enterprise Server

Most official GitHub-authored actions come automatically bundled with Enterprise Server, and they're captured at a point in time from the GitHub Marketplace. They include `actions/checkout`, `actions/upload-artifact`, `actions/download-artifact`, `actions/labeler`, and various `actions/setup-` actions, among others. To get all the official actions included on your enterprise instance, browse to the actions organization on your instance: https://HOSTNAME/actions.

As mentioned in the [Configure a GitHub Actions use policy](#configure-a-github-actions-use-policy) section, it's possible to configure Enterprise Server to automatically access the public actions available in the GitHub Marketplace and to configure a use policy for them. However, if you want stricter control over the public actions that should be made available in your enterprise, you can manually download and sync actions into your enterprise instance using the `actions-sync` tool.

## At organization level

### Document corporate standards

Creating a GitHub Actions workflow often involves writing multiple files and creating several repositories to specify the workflow in itself. Creating also includes the actions, containers, and/or runners to use in the workflow. Depending on the number of users in your Enterprise Cloud or Enterprise Server instance, things can get messy pretty quickly if you don't have corporate standards in place for creating GitHub Actions workflows.

As a best practice, we recommend you document the following in a GitHub wiki or as a markdown file in a repository accessible to all within an organization:

- Repositories for storage
- Files/folders naming conventions
- Location of shared components
- Plans for ongoing maintenance
- Contribution guidelines

### Create workflow templates

Workflow templates are a great way to ensure automation is reused and maintained in your enterprise. Both in Enterprise Cloud and Enterprise Server, users with write access to an organization's `.github` repository can create workflow templates that will be available for use to the other organization's members with the same write access. Workflow templates can then be used to create new workflows in the public and private repositories of the organization.

Creating a workflow template is done in two steps:

1. Create a `yml` workflow file.
2. Create a `json` metadata file that describes how the template should be presented to users when they're creating a workflow.

:::note
The metadata file must have the same name as the workflow file. Instead of the `.yml` extension, it must be appended with `.properties.json`. For example, a file named `octo-organization-ci.properties.json` contains the metadata for the workflow file named `octo-organization-ci.yml`.
:::

Both files must be placed in a public `.github` repository and in a directory named `workflow-templates`. You might have to create these if they don't already exist in your organization.

Once a workflow template is created, users in your organization can find it under **Actions > New workflow > Workflows created by _your_organization_name**.

:::image type="content" source="../media/workflow-template.png" alt-text="Workflow template example." border="false":::

## Reusable Templates for Actions and Workflows

GitHub Actions allows for **workflow automation**, and a key part of managing workflows efficiently is using **reusable templates**. Reusable templates help standardize and streamline development across multiple repositories, reducing redundancy and improving maintainability.

Reusable templates in GitHub Actions refer to **predefined actions and workflows** that can be referenced and used across multiple projects. They ensure consistency and compliance with enterprise-wide standards.

### Types of reusable templates

| **Template Type**      | **Purpose**                                      | **Example**                                |
| ---------------------- | ------------------------------------------------ | ------------------------------------------ |
| **Reusable Workflows** | Standardize CI/CD pipelines across repositories. | `ci-pipeline.yml`, `deploy-app.yml`        |
| **Reusable Actions**   | Encapsulate common automation logic.             | `setup-env-action`, `security-scan-action` |
| **Worflow Templates**  | Define reusable job structures.                  | `test-job.yml`, `build-job.yml`            |

### Reusable workflows

A **reusable workflow** is a workflow defined in a separate repository that can be referenced in multiple projects. This allows organizations to **centralize** their CI/CD logic.

####  Structure of a reusable workflow

A reusable workflow is stored in `.github/workflows/` and uses the **`workflow_call`** trigger.

#### Example: Standardized CI workflow (ci-pipeline.yml)

```yaml
name: CI Pipeline
on:
  workflow_call:
    inputs:
      node-version:
        required: true
        type: string
    secrets:
      npm-token:
        required: true
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Set up Node.js
        uses: actions/setup-node@v3
        with:
          node-version: ${{ inputs.node-version }}
          registry-url: 'https://npm.pkg.github.com/'
      - name: Install Dependencies
        run: npm install
      - name: Run Tests
        run: npm test
```

#### Using a reusable workflow in another repository

Once defined, the reusable workflow can be used in any repository via the **`uses:`** keyword.

**Example:** Calling the reusable workflow

```yaml
name: Reusable CI Pipeline
on: push
jobs:
  test:
    uses: org/reusable-workflows/.github/workflows/ci-pipeline.yml@v1
    with:
      node-version: '16'
    secrets:
      npm-token: ${{ secrets.NPM_TOKEN }}
```

#### Benefits of using a reusable workflow

- Ensures all repositories follow the same CI/CD structure.  
- Reduces redundancy and maintenance overhead.  
- Allows for **centralized updates** without modifying each repository.

### Reusable actions

A **GitHub Action** is a modular, reusable unit that executes specific automation tasks. Organizations often create custom actions to **encapsulate frequently used logic**.

#### Structure of a reusable action

A reusable action is defined in an **action repository** with an `action.yml` file.

**Example:** Custom Setup Environment Action

```yaml
name: "Setup Environment"
description: "Sets up Node.js and installs dependencies"
inputs:
  node-version:
    description: "Node.js version"
    required: true
  registry-url:
    description: "NPM Registry URL"
    required: false
    default: "https://registry.npmjs.org/"
runs:
  using: "node16"
  main: "index.js"
```

#### Using a reusable action in a workflow

Instead of repeating setup steps in every workflow, we use our custom action:

```yaml
name: Build & Test
on: push
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Environment
        uses: org/actions/setup-env@v1
        with:
          node-version: '16'
```

**Benefits:** 
- Reduces duplication of setup logic across repositories.  
- Simplifies workflow files, making them more readable.  
- Centralizes updates—fixes or improvements in one place reflect across all workflows.

### Workflow templates

As discussed earlier, workflow templates help standardize automation across your organization by providing predefined structures for common tasks. These templates are a key part of the broader category of reusable workflows.

In the earlier section "Create workflow templates," we outlined how to build these templates from a `yml` file and a corresponding `.properties.json` metadata file. That section also detailed where to store them and how they appear in the GitHub Actions UI for reuse.

To further connect the concept: workflow templates are a form of reusable workflow. When you create and store them in a public `.github` repository under the `workflow-templates/` directory, they allow other organization members to create consistent workflows for their repositories without having to define them from scratch.

By leveraging workflow templates, enterprises can:
- Enforce best practices across repositories.
- Accelerate onboarding and setup for new projects.
- Maintain consistency in CI/CD processes.

:::image type="content" source="../media/workflow-template.png" alt-text="Workflow template example." border="false":::

## Managing and leveraging reusable components in GitHub Actions

Reusable components in GitHub Actions refer to **workflows, actions, and scripts** that are used across multiple repositories to streamline development and automation. They help standardize CI/CD pipelines, improve maintainability, and reduce redundant configuration efforts.

### Types of reusable components

1. Reusable Workflows
    - Defined once and referenced in multiple repositories.
    - Example: A standard build-and-deploy workflow for all projects in an enterprise.
2. Custom GitHub Actions
    - Created for repeated tasks (e.g., setting up dependencies, running security checks).
    - Example: A company-wide action for enforcing code linting.
3. Shared Scripts
    - Bash, PowerShell, or Python scripts used in workflows to automate tasks.
    - Example: A script to generate compliance reports for code repositories.

### Creating centralized repositories for reusable components

A well-structured repository for reusable workflows and actions ensures easy access and standardization. Consider creating the following:

| **Repository type**      | **Purpose**                                        | **Example naming convention** |
| ------------------------ | -------------------------------------------------- | ----------------------------- |
| **Actions Repository**   | Stores custom GitHub Actions used across projects. | `org-actions-repo`            |
| **Workflows Repository** | Contains reusable workflows for CI/CD automation.  | `org-reusable-workflows`      |
| **Scripts Repository**   | Maintains reusable scripts for automation.         | `org-scripts-library`         |

**Example structure for an actions repository:**

```
org-actions-repo/
│── setup-node/         # Custom GitHub Action for Node.js setup
│   ├── action.yml
│   ├── Dockerfile
│   ├── README.md
│── security-scan/      # Custom GitHub Action for security scanning
│   ├── action.yml
│   ├── scan.py
│   ├── README.md
│── LICENSE
│── README.md
```

### Naming conventions for files and folders

To ensure maintainability and ease of use, follow **consistent naming conventions**.

#### Repository naming

- Use **descriptive and consistent** names for repositories:
    - `org-actions-repo`
    - `org-reusable-workflows`
    - `my-random-actions`
- Prefer **hyphenated names** for clarity:
    - `ci-pipeline`
    - `CIPipeline`

#### Workflow and action naming

- Follow a structured format:
    
    - `[scope]-[purpose]`
    - Examples:
        - `ci-test.yml` → For Continuous Integration testing
        - `deploy-app.yml` → Deployment workflow
        - `build-container.yml` → Builds Docker containers
- Use **versioned directories** for long-term maintainability:
    
    ```
    reusable-workflows/
    ├── v1/
    │   ├── ci-test.yml
    │   ├── deploy-app.yml
    ├── v2/
    │   ├── ci-test.yml
    │   ├── deploy-app.yml
    ```

#### Action naming

- **Use PascalCase or kebab-case** for action names:
    
    - `Run-Linter`
    - `run-linter`
    - `Runlinter`
- **Provide clear descriptions in `action.yml`:**
    
    ```yaml
    name: "Run Linter"
    description: "A reusable action to run lint checks on JavaScript projects."
    ```

### Plans for ongoing maintenance of reusable components

#### 1. Versioning and dependency management

- **Tag releases** using GitHub releases (`v1.0.0`, `v2.0.0`).
- **Avoid using `latest` tags** in workflows to prevent unexpected breaking changes.
- **Use semantic versioning**:
    - **Patch Updates:** `v1.0.1` → Fixes bugs, minor updates.
    - **Minor Updates:** `v1.1.0` → New features, backward-compatible.
    - **Major Updates:** `v2.0.0` → Breaking changes.

**Referencing versions in workflows**

Instead of:

```yaml
uses: org-actions-repo/setup-node@latest
```

Use a stable version:

```yaml
uses: org-actions-repo/setup-node@v1.2.0
```

#### 2. Automating updates and maintenance

- Implement a **GitHub Action to automatically test workflows and actions** before merging.
- Use **Dependabot** to detect outdated dependencies in reusable actions.

#### 3. Documenting and providing usage guidelines

- Each repository should include:
    - **README.md** explaining:
        - Purpose of the component.
        - How to use it.
        - Example workflows.
    - **CHANGELOG.md** to track updates.
    - **CONTRIBUTING.md** outlining best practices for modifications.

#### 4. Security and access control
- Restrict write access to action repositories.
- Require code reviews and **GitHub CODEOWNERS** for managing changes.
- Use **GitHub Secret Scanning** to prevent hardcoding secrets in workflows.
- 
#### 5. Monitoring and deprecation strategy
- **Set up GitHub Issues and Discussions** for feedback.
- **Deprecation plan**:
  - Notify users before removing older versions.
  - Offer migration guides for major changes.
