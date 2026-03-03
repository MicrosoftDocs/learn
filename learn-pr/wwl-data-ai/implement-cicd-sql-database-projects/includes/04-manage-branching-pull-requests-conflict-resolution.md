Two developers add columns to the same table on the same day. One pushes to production, the other follows an hour later and overwrites the first change. Sound familiar? Branching, pull requests, and conflict resolution exist to prevent exactly this kind of collision.

## Use feature branches for database changes

A simple branching strategy for SQL database projects follows three principles:

- Creates a **feature branch** for every change, whether it's new tables, bug fixes, or stored procedure updates.
- Merges feature branches into **main** through pull requests.
- Always keep main in a deployable state.

When you start a database change, branch off `main`. Your work is isolated from everything else in progress. You modify the relevant `.sql` files, and because each object has its own file, a commit that adds a column to `Customers` touches only `Tables/Customers.sql` and nothing else.

```bash
git checkout -b feature/add-customer-email
```

After completing the changes, push the branch to the remote repository:

```bash
git add .
git commit -m "Add Email column to Customers table"
git push origin feature/add-customer-email
```

## Review changes with pull requests

A pull request signals that your changes are ready for a second pair of eyes. Because SQL database projects store each object in a separate file, the diff shows the precise T-SQL that changed. Separate files make it far easier to review than a 500-line migration script that mixes unrelated modifications.

Pull requests for database changes should address questions like:

- Does the schema change break existing queries or stored procedures?
- Are the naming conventions consistent with the rest of the project?
- Does the change require a corresponding update to a post-deployment script?
- Does the change cause data loss or require data migration?

In Azure DevOps, create a pull request from a feature branch to `main` in the **Repos** section. In GitHub, use the **Pull requests** tab.

### Connect pull requests to CI builds

A pull request with a green build gives reviewers confidence. Configure the PR to trigger a CI build that compiles the SQL database project. If the build fails because of a broken reference, syntax error, or unresolved dependency, the problem gets caught before it reaches main.

In Azure DevOps, you configure a CI build trigger through a **Build Validation** branch policy. In GitHub, you set up a workflow that triggers on `pull_request` events targeting the `main` branch.

## Resolve merge conflicts in SQL database projects

Conflicts happen when two branches modify the same file in ways Git can't reconcile on its own. In database projects, a common scenario is two developers editing the same `CREATE TABLE` statement. One adds a `Phone` column, the other adds `Address`, and both touch the same region of the file.

To resolve the conflict:

1. Pull the latest changes from `main` into your feature branch:

    ```bash
    git checkout feature/add-customer-phone
    git pull origin main
    ```

2. Git marks the conflicting sections in the file. Open the file and review both versions.
3. Edit the file to include both changes in the correct syntax.
4. Mark the conflict as resolved and commit:

    ```bash
    git add Tables/Customers.sql
    git commit -m "Resolve merge conflict: include both Phone and Address columns"
    ```

> [!TIP]
> Reduce the frequency of merge conflicts by keeping feature branches short-lived. Merge them back to `main` as soon as the change is complete and reviewed. Long-running branches that diverge significantly from `main` are harder to merge.

### Validate after resolving conflicts

A clean text merge doesn't guarantee a valid schema. Suppose one branch renames a column while another branch adds a stored procedure that references the old column name. Git merges the files without complaint, but the project is broken. Always rebuild after resolving conflicts:

```bash
dotnet build MyDatabaseProject.sqlproj
```

&#128221; A successful build confirms that object references are intact and the T-SQL syntax is correct after the merge.

## Key takeaways

Use short-lived feature branches to isolate database changes, and merge them back to `main` through pull requests. Configure CI builds as pull request checks so a successful `dotnet build` validates every proposed change before merging. Merge conflicts in `.sql` files are typically straightforward because each file contains a single object declaration. Always rebuild the project after resolving merge conflicts to verify that all object references are intact. Next, you learn how to detect when the live database falls out of sync with your project.
