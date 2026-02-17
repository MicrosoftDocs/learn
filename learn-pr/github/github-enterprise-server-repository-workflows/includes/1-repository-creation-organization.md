Repositories on GitHub Enterprise Server exist within a structured enterprise hierarchy that reflects organizational ownership, access control, and governance requirements. While the basic repository concept is identical to GitHub.com, the way repositories are created and managed is often more deliberate and controlled.

### In this unit, you'll learn

- How repositories are organized within enterprises and organizations

- How governance affects repository creation and ownership

- Why standardization is common in GHES environments

### Enterprise and organization structure

In GHES, repositories live inside organizations, which in turn are governed by an enterprise account. This hierarchy allows organizations to apply consistent policies across large numbers of repositories while still delegating day-to-day management to specific teams.

Enterprises typically use organizations to represent products, services, or business units. Access permissions, visibility settings, and inherited policies are applied at the organization level, which means that repository behavior is often shaped before a single line of code is written.

From a developer perspective, this structure means that repositories are rarely “personal” spaces. They are shared assets owned by teams and governed by enterprise-wide standards.

### Repository creation in governed environments

In many GHES deployments, repository creation is not open to all users. Organizations may restrict repository creation to organization owners or specific roles, ensuring that new repositories align with internal standards from the beginning.

When repositories are created, they often inherit predefined settings such as default branches, branch protection rules, issue tracking configuration, and automation hooks. Naming conventions may be enforced to make repositories easy to identify and manage at scale.

These controls reduce inconsistency and help enterprises maintain visibility and compliance across hundreds or thousands of repositories. For developers, this means that creating a repository is often a coordinated action rather than an individual choice.
 If you cannot create a repository directly, use your organization's established request path rather than creating workarounds or duplicating code in ungoverned locations.

### Roles, ownership, and repository lifecycle

Enterprise-managed environments often separate responsibilities. Developers contribute code, but organization owners or repository administrators may control repository creation, visibility, and policy configuration. This ensures repositories are created with the right ownership, access model, and baseline settings from day one.

Repository governance also includes lifecycle controls. In some situations, repositories may be locked to prevent further changes, or restored after accidental deletion. Understanding that repositories are managed assets-rather than personal workspaces-helps teams plan changes, request access through the right channels, and avoid work that conflicts with enterprise controls.

### Repository templates and standardization

To further support consistency, many organizations rely on repository templates. Templates provide a starting point that includes required documentation, configuration files, and default workflows. By using templates, teams avoid repetitive setup tasks and ensure that every repository meets baseline requirements for security, documentation, and automation.

Before creating a new repository on GHES, developers should check whether approved templates exist and follow organizational guidance. Using the correct template is often the fastest path to getting started.

### Step-by-step: Confirm you're in the right repository and understand its standards

If you are joining an existing project, start by verifying you're working in the correct organization and repository, and identify any standards the repository expects you to follow.

1. In the GHES web UI, navigate to the organization and repository you expect to use.
1. Confirm the repository name and description match the project you intend to work on.
1. Verify the default branch (commonly main) and whether the repository appears to be active.
1. Review common standardization files if they exist:

   - README (what the repo is and how to run it)
   - CONTRIBUTING (contribution workflow and review expectations)
   - CODEOWNERS (who must review changes to specific paths)
   - SECURITY (security reporting process)

1. If you use GitHub CLI, you can confirm basic repository details from the command line:

    ```bash
    gh repo view ORG/REPO --hostname github.company.com
    ```

If you cannot access the repository, confirm your organization membership and repository permissions before troubleshooting Git or branch settings.

Key takeaway: On GHES, repositories are governed assets, so understanding the enterprise structure, following creation controls, and using approved templates helps you start work in a compliant and sustainable way.

Now that you understand where repositories live and how they are created in governed environments, you're ready to look at how work flows through branches in those repositories.