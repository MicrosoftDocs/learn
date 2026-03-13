CI/CD for SQL Database Projects brings the same automation, consistency, and safety nets to database development that application teams rely on for their code.

In this module, you learned how to:

- **Create, build, and validate SQL Database Projects**: Define database objects in declarative T-SQL files, build them into `.dacpac` artifacts, and validate references and syntax against a target platform using the SDK-style `Microsoft.Build.Sql` project format.
- **Configure source control and manage reference data**: Place SQL database projects in Git, organize files by object type, and use predeployment and post-deployment scripts with SQLCMD `:r` includes to manage reference data alongside the schema.
- **Manage branching, pull requests, and conflict resolution**: Use feature branches for database changes, review T-SQL diffs in pull requests, resolve merge conflicts at the object level, and validate merged results with a project build.
- **Detect and resolve schema drift**: Compare live databases against SQL database projects using schema comparison tools, automate drift detection with SqlPackage Extract, and review planned changes with deployment reports and scripts.
- **Implement CI/CD pipelines with deployment controls**: Build and deploy `.dacpac` files with GitHub Actions (`azure/sql-action`) and Azure DevOps (`SqlAzureDacpacDeployment`), manage secrets through repository secrets and Azure Key Vault, and protect production with environment approvals, branch policies, and code owners.
- **Design and implement a testing strategy**: Create SQL Server unit tests with test conditions (Row Count, Scalar Value, Expected Schema), write negative tests for error handling, and integrate tests into CI/CD pipelines to catch logic errors before deployment.

## Learn more

- [What are SQL database projects?](/sql/tools/sql-database-projects/sql-database-projects)
- [Get started with SQL database projects](/sql/tools/sql-database-projects/get-started)
- [SQL Server Data Tools, SDK-style (preview)](/sql/ssdt/sql-server-data-tools-sdk-style)
- [Predeployment and post-deployment scripts](/sql/tools/sql-database-projects/concepts/pre-post-deployment-scripts)
- [Schema comparison overview](/sql/tools/sql-database-projects/concepts/schema-comparison)
- [Compare a database and a project](/sql/tools/sql-database-projects/howto/compare-database-project)
- [SQL projects automation](/sql/tools/sql-database-projects/sql-projects-automation)
- [About branches and branch policies](/azure/devops/repos/git/branch-policies-overview)
- [Verify database code by using SQL Server unit tests](/sql/ssdt/verifying-database-code-by-using-sql-server-unit-tests)
- [Azure SQL Deploy action (GitHub)](https://github.com/azure/sql-action)
- [SqlAzureDacpacDeployment task reference](/azure/devops/pipelines/tasks/reference/sql-azure-dacpac-deployment-v1)
