In the previous unit, you explored how to structure GitHub Actions policies and templates at both the enterprise and organizational levels. In this unit, you'll dive deeper into how to manage and maintain reusable components—like workflows, custom actions, and automation scripts—across multiple repositories.

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
