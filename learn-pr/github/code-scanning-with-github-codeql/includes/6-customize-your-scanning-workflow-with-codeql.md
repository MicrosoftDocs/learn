Code scanning workflows that use CodeQL have various configuration options you can adjust to better suit the needs of your organization.

When you use CodeQL to scan code, the CodeQL analysis engine generates a database from the code and runs queries on it. CodeQL analysis uses a default set of queries, but you can specify more queries to run in addition to the default queries.

You can run extra queries if they're part of a CodeQL pack (beta) published to the GitHub Container registry or a QL pack stored in a repository.

There are two options for specifying which queries you want to run with CodeQL code scanning:

* Using your code scanning workflow
* Using a custom configuration file

In this unit, you'll learn how to edit a workflow file to reference additional queries, how to use queries from query packs, and how to combine queries from a workflow file and a custom configuration file.

## Specify additional queries in a workflow file

The options available to specify the additional queries you want to run are:

* `packs` to install one or more CodeQL query packs (beta) and run the default query suite or queries for those packs.
* `queries` to specify a single `.ql` file, a directory containing multiple `.ql` files, a `.qls` query suite definition file, or any combination.

You can use both packs and queries in the same workflow.

We don't recommend referencing query suites directly from the `github/codeql` repository, like `github/codeql/cpp/ql/src@main`. Such queries may not be compiled with the same version of CodeQL as used for your other queries, which could lead to errors during analysis.

### Use CodeQL query packs

> [!NOTE]
> The CodeQL package-management functionality, including CodeQL packs, is currently in beta and subject to change.

To add one or more CodeQL query packs (beta), add a `with: packs:` entry within the `uses: github/codeql-action/init@v1` section of the workflow. Within packs, you can specify one or more packages to use and, optionally, which version to download. Where you don't specify a version, the latest version is downloaded. If you want to use packages that aren't publicly available, you need to set the `GITHUB_TOKEN` environment variable to a secret that has access to the packages.

In the following example, scope is the organization or personal account that published the package. When the workflow runs, the three CodeQL query packs download from GitHub and the default queries or query suite for each pack run. In the below example, each of the packs in the list will download based on their specifications:
* The latest version of `pack1` is downloaded and all default queries are run.
* Version 1.2.3 of `pack2` is downloaded and all default queries are run.
* The latest version of `pack3` that is compatible with version 3.2.1 is downloaded and all queries are run.
* Version 4.5.6 of `pack4` is downloaded and only the queries found in path/to/queries are run.

```yml
- uses: github/codeql-action/init@v3
  with:
    # Comma-separated list of packs to download
    packs: scope/pack1,scope/pack2@1.2.3,scope/pack3@~3.2.1,scope/pack4@4.5.6:path/to/queries
```

> [!NOTE]
> For workflows that generate CodeQL databases for multiple languages, you must instead specify the CodeQL query packs in a configuration file.

### Use queries in QL packs

To add one or more queries, add a `with: queries:` entry within the `uses: github/codeql-action/init@v3` section of the workflow. If the queries are in a private repository, use the `external-repository-token` parameter to specify a token that has access to check out the private repository.

```yml
- uses: github/codeql-action/init@v3
  with:
    # Comma-separated list of queries / packs / suites to run.
    # This may include paths or a built in suite, for example:
    # security-extended or security-and-quality.
    queries: security-extended
    # Optional. Provide a token to access queries stored in private repositories.
    external-repository-token: ${{ secrets.ACCESS_TOKEN }}
```

You can also specify query suites in the value of `queries`. Query suites are collections of queries, usually grouped by purpose or language.

The following query suites are built into CodeQL code scanning and are available for use:

|Query suite|Description|
|---|---|
|  `security-extended` | Queries from the default suite, plus lower severity and precision queries |
| `security-and-quality` | Queries from `security-extended`, plus maintainability and reliability queries |

Each of these query suites contains a different subset of the queries included in the built-in CodeQL query pack for that language. The query suites are automatically generated using the metadata for each query.

When you specify a query suite, the CodeQL analysis engine will run the queries contained within the suite for you in addition to the default set of queries.

## Combine queries from a workflow file and a custom configuration file

If you also use a configuration file for custom settings, any additional packs or queries specified in your workflow are used instead of those specified in the configuration file. If you want to run the combined set of additional packs or queries, prefix the value of `packs` or `queries` in the workflow with the `+` symbol.

In the following example, the `+` symbol ensures that the specified additional packs and queries are used together with any specified in the referenced configuration file:

```yml
- uses: github/codeql-action/init@v3
  with:
    config-file: ./.github/codeql/codeql-config.yml
    queries: +security-and-quality,octo-org/python-qlpack/show_ifs.ql@main
    packs: +scope/pack1,scope/pack2@1.2.3,scope/pack3@4.5.6:path/to/queries
```
