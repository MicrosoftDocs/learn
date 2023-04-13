In addition to the graphical user interface on GitHub.com, you can also access many of the same primary CodeQL features through a command-line interface.

This unit will cover using the CodeQL CLI to create databases, analyze databases, and upload the results to GitHub.

## CodeQL CLI commands

Once you've made the CodeQL CLI available to servers in your CI system and ensured that they can authenticate with GitHub, you're ready to generate data.

You can use three different commands to generate results and upload them to GitHub:

* `database create` to create a CodeQL database to represent the hierarchical structure of each supported programming language in the repository.
* `database analyze` to run queries to analyze each CodeQL database and summarize the results in a SARIF file.
* `github upload-results` to upload the resulting SARIF files to GitHub where the results are matched to a branch or pull request and displayed as code scanning alerts.

You can display the command-line help for any command using the `--help option`.

Uploading SARIF data to display as code-scanning results in GitHub is supported for organization-owned repositories with GitHub Advanced Security enabled, and public repositories on GitHub.com.

## Create CodeQL databases to analyze

Follow the steps below to create CodeQL databases to analyze:

1. Check out the code that you want to analyze:
    * For a branch, check out the head of the branch that you want to analyze.
    * For a pull request, check out either the head commit of the pull request, or check out a GitHub-generated merge commit of the pull request.
2. Set up the environment for the codebase, making sure that any dependencies are available.
3. Find the build command, if any, for the codebase. Typically this is available in a configuration file in the CI system.
4. Run `codeql database create` from the checkout root of your repository and build the codebase:
    * To create one CodeQL database for a single supported language, use the following command:

        ```bash
        codeql database create <database> --command<build> --language=<language-identifier>
        ```

    * To create one CodeQL database per language for multiple supported languages, use the following command:

        ```bash
        codeql database create <database> --command<build> \
          --db-cluster --language=<language-identifier>,<language-identifier>
        ```

> [!NOTE]
> If you use a containerized build, you need to run the CodeQL CLI inside the container where your build task takes place.

The full list of parameters for the `database create` command is shown in the following table:

| Option | Required Usage |
|---|---|
|`<database>` | Specify the name and location of a directory to create for the CodeQL database. The command will fail if you try to overwrite an existing directory. If you also specify `--db-cluster`, this is the parent directory, and a subdirectory is created for each language analyzed. |
| `--language` | Specify the identifier for the language to create a database for, one of: `cpp`, `csharp`, `go`, `java`, `javascript`, `python`, and `ruby` (use Javascript to analyze TypeScript code). When used with `--db-cluster`, the option accepts a comma-separated list, or can be specified more than once. |
| `--command` | Recommended. Use to specify the build command or script that invokes the build process for the codebase. Commands are run from the current folder or, where it is defined, from `--source-root`. Not needed for Python and JavaScript/TypeScript analysis. |
| `--db-cluster` | Optional. Use in multi-language codebases to generate one database for each language specified by `--language`.|
| `--no-run-unnecessary-builds`	| Recommended. Use to suppress the build command for languages where the CodeQL CLI does not need to monitor the build (for example, Python and JavaScript/TypeScript).|
| `--source-root` | Optional. Use if you run the CLI outside the checkout root of the repository. By default, the database create command assumes that the current directory is the root directory for the source files; use this option to specify a different location.|

### Single language example

This example creates a CodeQL database for the repository checked out at `/checkouts/example-repo`. It uses the JavaScript extractor to create a hierarchical representation of the JavaScript and TypeScript code in the repository. The resulting database is stored in `/codeql-dbs/example-repo`.

```bash
$ codeql database create /codeql-dbs/example-repo --language=javascript \
    --source-root /checkouts/example-repo

> Initializing database at /codeql-dbs/example-repo.
> Running command [/codeql-home/codeql/javascript/tools/autobuild.cmd]
    in /checkouts/example-repo.
> [build-stdout] Single-threaded extraction.
> [build-stdout] Extracting
...
> Finalizing database at /codeql-dbs/example-repo.
> Successfully created database at /codeql-dbs/example-repo.
```

### Multiple languages example

This example creates two CodeQL databases for the repository checked out at `/checkouts/example-repo-multi`. It uses:

* `--db-cluster` to request analysis of more than one language.
* `--language` to specify which languages to create databases for.
* `--command` to tell the tool the build command for the codebase, here make.
* `--no-run-unnecessary-builds` to tell the tool to skip the build command for languages where it is not needed (like Python).

The resulting databases are stored in `python` and `cpp` subdirectories of `/codeql-dbs/example-repo-multi`.

```bash
$ codeql database create /codeql-dbs/example-repo-multi \
    --db-cluster --language python,cpp \
    --command make --no-run-unnecessary-builds \
    --source-root /checkouts/example-repo-multi
Initializing databases at /codeql-dbs/example-repo-multi.
Running build command: [make]
[build-stdout] Calling python3 /codeql-bundle/codeql/python/tools/get_venv_lib.py
[build-stdout] Calling python3 -S /codeql-bundle/codeql/python/tools/python_tracer.py -v -z all -c /codeql-dbs/example-repo-multi/python/working/trap_cache -p ERROR: 'pip' not installed.
[build-stdout] /usr/local/lib/python3.6/dist-packages -R /checkouts/example-repo-multi
[build-stdout] [INFO] Python version 3.6.9
[build-stdout] [INFO] Python extractor version 5.16
[build-stdout] [INFO] [2] Extracted file /checkouts/example-repo-multi/hello.py in 5ms
[build-stdout] [INFO] Processed 1 modules in 0.15s
[build-stdout] <output from calling 'make' to build the C/C++ code>
Finalizing databases at /codeql-dbs/example-repo-multi.
Successfully created databases at /codeql-dbs/example-repo-multi.
$
```

## Analyze a CodeQL database

After creating your CodeQL database, follow these steps to analyze it:

1. Optionally run `codeql pack download <packs>` to download any CodeQL packs (beta) that you want to run during analysis.
2. Run `codeql database analyze` on the database and specify which packs and/or queries to use.

```bash
codeql database analyze <database> --format=<format> \
    --output=<output>  <packs,queries>
```

>[!NOTE]
>If you analyze more than one CodeQL database for a single commit, you must specify a SARIF category for each set of results this command generates. When you upload the results to GitHub, code scanning uses this category to store the results for each language separately. If you forget to do this, each upload overwrites the previous results.

```bash
codeql database analyze <database> --format=<format> \
    --sarif-category=<language-specifier> --output=<output> \
    <packs,queries>
```

The full list of parameters for the `database analyze` command is shown in the following table:

|Option | Required Usage |
|---|---|
|`<database>` | Specify the path for the directory that contains the CodeQL database to analyze.|
|`<packs,queries>` | Specify CodeQL packs or queries to run. To run the standard queries used for code scanning, omit this parameter. You can find the other query suites included in the CodeQL CLI bundle in `/<extraction-root>/codeql/qlpacks/codeql-<language>/codeql-suites`. For information about creating your own query suite, check out [Creating CodeQL query suites](https://codeql.github.com/docs/codeql-cli/creating-codeql-query-suites/) in the documentation for the CodeQL CLI.|
|`--format` | Specify the format for the results file generated by the command. For upload to GitHub, this should be: `sarif-latest`.|
|`--output` | Specify where to save the SARIF results file.|
|`--sarif-category`| Optional for single database analysis. Required to define the language when you analyze multiple databases for a single commit in a repository. Specify a category to include in the SARIF results file for this analysis. A category is used to distinguish multiple analyses for the same tool and commit, but performed on different languages or different parts of the code.|
|`--sarif-add-query-help` | Optional. Use if you want to include any available markdown-rendered query help for custom queries used in your analysis. Any query help for custom queries included in the SARIF output will be displayed in the code scanning UI if the relevant query generates an alert.|
|`<packs>`	| Optional. Use if you have downloaded CodeQL query packs and want to run the default queries or query suites specified in the packs.|
|`--threads` | Optional. Use if you want to use more than one thread to run queries. The default value is 1. You can specify more threads to speed up query execution. To set the number of threads to the number of logical processors, specify 0.|
|`--verbose` | Optional. Use to get more detailed information about the analysis process and diagnostic data from the database creation process.|

### Basic example

This example analyzes a CodeQL database stored at `/codeql-dbs/example-repo` and saves the results as a SARIF file: `/temp/example-repo-js.sarif`. It uses `--sarif-category` to include extra information in the SARIF file that identifies the results as JavaScript. This is essential when you have more than one CodeQL database to analyze for a single commit in a repository.

```bash
$ codeql database analyze /codeql-dbs/example-repo  \
    javascript-code-scanning.qls --sarif-category=javascript
    --format=sarif-latest --output=/temp/example-repo-js.sarif

> Running queries.
> Compiling query plan for /codeql-home/codeql/qlpacks/
    codeql-javascript/AngularJS/DisablingSce.ql.
...
> Shutting down query evaluator.
> Interpreting results.
```

## Upload results to GitHub

SARIF upload supports a maximum of 5,000 results per upload. Any results over this limit are ignored. If a tool generates too many results, you should update the configuration to focus on results for the most important rules or queries.

For each upload, SARIF upload supports a maximum size of 10 MB for the gzip-compressed SARIF file. Any uploads over this limit will be rejected. If your SARIF file is too large because it contains too many results, you should update the configuration to focus on results for the most important rules or queries.

Before you can upload results to GitHub, you must determine the best way to pass the GitHub App or personal access token you created earlier to the CodeQL CLI. We recommend that you review your CI system's guidance on the secure use of a secret store. The CodeQL CLI supports:

* Passing the token to the CLI via standard input using the `--github-auth-stdin` option (recommended).
* Saving the secret in the environment variable `GITHUB_TOKEN` and running the CLI without including the `--github-auth-stdin` option.

When you've decided on the most secure and reliable method for your CI server, run `codeql github upload-results` on each SARIF results file and include `--github-auth-stdin` unless the token is available in the environment variable `GITHUB_TOKEN`.

```bash
echo "$UPLOAD_TOKEN" | codeql github upload-results --repository=<repository-name> \
      --ref=<ref> --commit=<commit> --sarif=<file> \
      --github-auth-stdin
```

The full list of parameters for the `github upload-results` command is shown in the table below.

|Option	|Required Usage|
|---|---|
|`--repository`| Specify the OWNER/NAME of the repository to which to upload data. The owner must be an organization within an enterprise that has a license for GitHub Advanced Security, and GitHub Advanced Security must be enabled for the repository unless the repository is public.|
|`--ref` |Specify the name of the ref you checked out and analyzed so that the results can be matched to the correct code. For a branch, use `refs/heads/BRANCH-NAME`; for the head commit of a pull request, use `refs/pulls/NUMBER/head`; or for the GitHub-generated merge commit of a pull request, use `refs/pulls/NUMBER/merge`.|
|`--commit` |Specify the full SHA of the commit you analyzed.|
|`--sarif`  |Specify the SARIF file to load.|
|`--github-auth-stdin`  |Optional. Use to pass the CLI the GitHub App or personal access token created for authentication with GitHub's REST API via standard input. This isn't needed if the command has access to a `GITHUB_TOKEN` environment variable set with this token.|
