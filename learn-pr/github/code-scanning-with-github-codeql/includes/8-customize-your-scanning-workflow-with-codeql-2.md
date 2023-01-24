Code-scanning workflows that use CodeQL have various configuration options that you can adjust to better suit the needs of your organization.

In this unit, you'll learn how to reference additional queries in a custom configuration file.

## Additional queries in a custom configuration file

A custom configuration file is an alternative way to specify additional packs and queries to run. You can also use the file to disable the default queries and to specify which directories to scan during analysis.

In the workflow file, use the `config-file` parameter of the `init` action to specify the path to the configuration file you want to use. This example loads the configuration file `./.github/codeql/codeql-config.yml`.

```yml
- uses: github/codeql-action/init@v1
  with:
    config-file: ./.github/codeql/codeql-config.yml
```

The configuration file can be located within the repository you're analyzing or in an external repository. Using an external repository allows you to specify configuration options for multiple repositories in a single place. When you reference a configuration file located in an external repository, you can use the `OWNER/REPOSITORY/FILENAME@BRANCH` syntax. For example: `octo-org/shared/codeql-config.yml@main`.

If the configuration file is located in an external private repository, use the `external-repository-token` parameter of the `init` action to specify a token that has access to the private repository.

```yml
- uses: github/codeql-action/init@v1
  with:
    external-repository-token: ${{ secrets.ACCESS_TOKEN }}
```

The settings in the configuration file are written in YAML format.

### Specify CodeQL query packs in custom configuration files

> [!NOTE]
> The CodeQL package-management functionality, including CodeQL packs, is currently in beta and subject to change.

You can specify CodeQL query packs in an array. Note that the format is different from the format used by the workflow file.

```yml
packs:
  # Use the latest version of 'pack1' published by 'scope'
  - scope/pack1
  # Use version 1.23 of 'pack2'
  - scope/pack2@v1.2.3
  # Use the latest version of 'pack3' compatible with 1.23
  - scope/pack3@~1.2.3
```

If you have a workflow that generates more than one CodeQL database, you can specify any CodeQL query packs to run in a custom configuration file using a nested map of packs.

```yml
packs:
  # Use these packs for JavaScript analysis
  javascript:
    - scope/js-pack1
    - scope/js-pack2
  # Use these packs for Java analysis
  java:
    - scope/java-pack1
    - scope/java-pack2@v1.0.0
```

### Specify additional queries in a custom configuration

You can specify additional queries in a queries array. Each element of the array contains a uses parameter with a value that identifies a single query file, a directory containing query files, or a query suite definition file.

```yml
queries:
  - uses: ./my-basic-queries/example-query.ql
  - uses: ./my-advanced-queries
  - uses: ./query-suites/my-security-queries.qls
```

Optionally, you can give each array element a name, as shown in the following example configuration file:

```yml
name: "My CodeQL config"

disable-default-queries: true

queries:
  - name: Use an in-repository QL pack (run queries in the my-queries directory)
    uses: ./my-queries
  - name: Use an external JavaScript QL pack (run queries from an external repo)
    uses: octo-org/javascript-qlpack@main
  - name: Use an external query (run a single query from an external QL pack)
    uses: octo-org/python-qlpack/show_ifs.ql@main
  - name: Use a query suite file (run queries from a query suite in this repo)
    uses: ./codeql-qlpacks/complex-python-qlpack/rootAndBar.qls

paths:
  - src
paths-ignore:
  - src/node_modules
  - '**/*.test.js'
```

## Disable the default queries

If you only want to run custom queries, you can disable the default security queries by using `disable-default-queries: true`. You should also use this flag if you're trying to construct a custom query suite that excludes a particular rule. This is to avoid having all of the queries run twice.

## Specify directories to scan

For the interpreted languages that CodeQL supports (Python, Ruby and JavaScript/TypeScript), you can restrict code scanning to files in specific directories by adding a paths array to the configuration file. You can exclude the files in specific directories from analysis by adding a `paths-ignore` array.

```yml
paths:
  - src
paths-ignore:
  - src/node_modules
  - '**/*.test.js'
```

> [!NOTE]
> * The `paths` and `paths-ignore` keywords, used in the context of the code scanning configuration file, should not be confused with the same keywords when used for `on.<push|pull_request>.paths` in a workflow. When they're used to modify `on.<push|pull_request>` in a workflow, they determine whether the actions will be run when someone modifies code in the specified directories.
> * The filter pattern characters `?`, `+`, `[`, `]`, and `!` aren't supported and will be matched literally.
> * `**` characters can only be at the start or end of a line, or surrounded by slashes, and you can't mix `**` and other characters. For example: `foo/**`, `**/foo`, and `foo/**/bar` are all allowed syntax, but `**foo` isn't. However ,you can use single stars along with other characters, as shown in the example. You'll need to quote anything that contains a `*` character.

For compiled languages, if you want to limit code scanning to specific directories in your project, you must specify appropriate build steps in the workflow. The commands you need to use to exclude a directory from the build will depend on your build system.

You can quickly analyze small portions of a monorepo when you modify code in specific directories. You'll need to both exclude directories in your build steps and use the `paths-ignore` and `paths` keywords for `on.<push|pull_request>` in your workflow.
