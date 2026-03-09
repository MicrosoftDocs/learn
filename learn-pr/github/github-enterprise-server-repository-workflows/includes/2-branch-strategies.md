Branching strategies define how work flows from development into stable, production-ready code. On GHES, branching is not just a technical practice but a governance mechanism that helps enterprises manage risk and maintain control.

### In this unit, you'll learn

- How default branches are treated in enterprise repositories

- Common branching strategies used on GHES

- Why branch discipline is enforced

### Default branches and stability

Most GHES repositories designate a default branch, commonly named main. This branch typically represents the most stable and trusted version of the codebase. It may be used directly for deployments, releases, or downstream integrations.

Because of its importance, the default branch is rarely open for direct modification. Instead, changes are introduced through pull requests from short-lived branches. This approach ensures that every change is reviewed, tested, and recorded before it becomes part of the stable codebase.

### Common enterprise branching models

Enterprises often standardize on a small number of branching models to reduce confusion and improve consistency across teams. Trunk-based development is common, with developers creating short-lived branches and merging frequently into the default branch through pull requests. Some organizations use release branches to support parallel development and maintenance, particularly when supporting multiple versions of a product.

Regardless of the specific model, the key characteristic of enterprise branching on GHES is that branches exist to support controlled change, not experimentation without oversight.

### Why branch discipline matters

Strict branching rules help organizations reduce the risk of unreviewed or unstable changes reaching critical systems. They also support auditability by ensuring that every change has a documented history, including who authored it, who reviewed it, and which checks were applied.

For developers, this discipline can initially feel restrictive. Over time, however, it provides clarity and predictability, especially in large teams where uncontrolled branching quickly leads to confusion.

### Step-by-step: Create a feature branch and keep it up to date

Your organization may have specific naming conventions and rules, but this flow is a common baseline for working safely with a protected default branch.

1. Make sure your local default branch is up to date:

    ```bash
    
    git checkout main

    git fetch origin

    git pull --ff-only
    
    ```

1. Create a short-lived feature branch:

    ```bash

    git checkout -b feature/short-description

    ```

1. Make changes, then commit them:

    ```bash
    
    git status
    
    git add .
    
    git commit -m "Describe the change"
    
    ```

1. Push the branch to GHES:

    ```bash
    
    git push -u origin feature/short-description
    
    ```

1. If your branch falls behind, update it using the approach your team prefers:

   - If your organization prefers rebase:

     ```bash
    
     git fetch origin
    
     git rebase origin/main
    
     ```

   - If your organization prefers merge:

     ```bash
    
     git fetch origin
    
     git merge origin/main
    
     ```

Use the strategy your team standardizes on, since branch protection settings (and review expectations) often assume a particular workflow.

Key takeaway: Enterprise branching models on GHES are designed to keep the default branch stable and to ensure that changes move through controlled, reviewable paths.

With branching discipline in place, the next step is understanding how GHES enforces that discipline through branch protection rules and review requirements.