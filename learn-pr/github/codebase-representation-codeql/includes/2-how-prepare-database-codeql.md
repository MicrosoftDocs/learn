
CodeQL treats code like data. You create a database by using queryable data that you extract from your codebase. Then you can run CodeQL queries on this database to identify security vulnerabilities, bugs, and other errors. You can write your own queries or run standard CodeQL queries written by GitHub researchers and community contributors.

In this unit, you learn how to create a database. This step is required before you can analyze your code. You need to create a CodeQL database that contains all the data necessary to run queries on your code.

CodeQL analysis relies on extracting relational data from your code and using it to build a CodeQL database. These databases contain all of the important information about a codebase.

You can use the CodeQL CLI standalone product to analyze code and to generate a database representation of a codebase. After the database is ready, you can query the database or run a suite of queries to generate a set of results in Static Analysis Results Interchange Format (SARIF).

## Database preparation for CodeQL

Before you generate a CodeQL database, you need to install and set up the CodeQL CLI. You then need to check out the version of your codebase that you want to analyze.

For compiled languages, the directory should be ready to build, with all dependencies already installed. CodeQL begins by extracting a single relational representation of each source file in the codebase to create a database. You'll use this database to analyze your code.

For interpreted languages, the extractor runs directly on the source code. This capability gives you an accurate representation of the codebase and resolves any dependencies.

Source file extraction from the codebase works by monitoring the normal build process for compiled languages. CodeQL makes a copy of the source file each time you invoke a compiler to process a source file. It collects all relevant information about the source code with each source file.

## CLI setup

Use the following steps to set up the CodeQL CLI.

### 1. Download the CodeQL CLI bundle's .zip package

We recommend that you install the CodeQL CLI and queries by downloading the bundled package. This method helps ensure compatibility and improved performance, as opposed to downloading the CLI and queries separately.

The CodeQL CLI download package is a .zip archive that contains tools, scripts, and various CodeQL-specific files. The bundle includes the CodeQL CLI, compatible versions of the queries and libraries from the CodeQL GitHub repo, and precompiled versions of the included queries.

1. Go to the [Releases page of the CodeQL public repository](https://github.com/github/codeql-action/releases).
1. Download the platform-specific bundle under **Assets**.

On the **Releases** page, you can also view the changelogs for releases, along with downloads for previous versions of the CodeQL bundle. If necessary, you can download `codeql-bundle.tar.gz`, which contains the CLI for all supported platforms.

### 2. Extract the .zip archive

If you're using Linux, Windows, or macOS, you can extract the .zip archive into the directory of your choice.

Users of macOS Catalina (or newer) need to take additional steps. For more information, see the [CodeQL documentation about getting started with the CLI](https://docs.github.com/en/code-security/codeql-cli/getting-started-with-the-codeql-cli/).

### 3. Run CodeQL processes

After extraction, take one of the following steps to use the `codeql` executable file to run the CodeQL processes:

- Run `<extraction-root>/codeql/codeql`, where `<extraction-root>` is the folder in which you extracted the CodeQL CLI package.
- Add `<extraction-root>/codeql` to your `PATH` entry, so that you can run the executable file as just `codeql`.

Now you can run CodeQL commands.

## Verification of your CLI setup

You can run CodeQL CLI subcommands to verify that you correctly set up the CLI and can analyze databases:

- Run `codeql resolve qlpacks` (if you added `codeql` to `PATH`) to show which CodeQL packs the CLI can find. Otherwise, use `/<extraction-root>/codeql/codeql resolve qlpacks`. This command displays the names of the CodeQL packs included in the CodeQL CLI bundle, shown in the earlier steps as `<extraction-root>`.

  If the CodeQL CLI can't find the CodeQL packs for the expected languages, check that you downloaded the CodeQL bundle and not a standalone copy of the CodeQL CLI.

- Run `codeql resolve languages` to show which languages the CodeQL CLI package supports by default.

## Database creation

Create a CodeQL database by running this command from the checkout root of your project:

>
```
codeql database create <database> --language=<language-identifier>
```
>

In the command:

- Replace `<database>` with the path to the new database to be created.
- Replace `<language-identifier>` with the identifier for the language that you're using to create the database. You can use this identifier with `--db-cluster` to accept comma-separated lists, or you can specify it more than once.

You can also specify the following options. These options depend on the location of the source file, whether your code needs to be compiled, or whether you want to create CodeQL databases for more than one language.

- Use `--source-root` to identify the root folder for the primary source files for database creation.
- Use `--db-cluster` for multiple-language codebases when you want to create databases for more than one language.
- Use `--command` when you create a database for one or more compiled languages. You don't need this option if you're using only Python and JavaScript.
- Use `--no-run-unnecessary-builds` along with `--db-cluster` to suppress the build command for languages where the CodeQL CLI doesn't need to monitor the build.

After you successfully create the database, a new directory appears at the path specified in the command. If you used the `--db-cluster` option to create more than one database, a subdirectory is created for each language. 

Each CodeQL database directory contains multiple subdirectories, including the relational data that's used for analysis and a source archive. The source archive is a copy of the source files made at the time that you created the database. CodeQL uses it for displaying analysis results.

## Extractors

An extractor is a tool that produces the relational data and source reference for each input file, from which a CodeQL database can be built. Each language that CodeQL supports has one extractor. This structure ensures that the extraction process is as accurate as possible.

Each extractor defines its own set of configuration options. Entering `codeql resolve extractor --format=betterjson` results in data formatted like the following example:

>
```
{
    "extractor_root" : "/home/user/codeql/java",
    "extractor_options" : {
        "option1" : {
            "title" : "Java extractor option 1",
            "description" : "An example string option for the Java extractor.",
            "type" : "string",
            "pattern" : "[a-z]+"
        },
        "group1" : {
            "title" : "Java extractor group 1",
            "description" : "An example option group for the Java extractor.",
            "type" : "object",
            "properties" : {
                "option2" : {
                    "title" : "Java extractor option 2",
                    "description" : "An example array option for the Java extractor",
                    "type" : "array",
                    "pattern" : "[1-9][0-9]*"
                }
            }
        }
    }
}
```

To find out which options are available for your language's extractor, enter `codeql resolve languages --format=betterjson` or `codeql resolve extractor --format=betterjson`. The `betterjson` output format also provides the extractor's root and other language-specific options.

## Data in a CodeQL database

A CodeQL database is a single directory that contains all of the data that's required for analysis. This data includes relational data, copied source files, and a language-specific database schema that specifies the mutual relations in the data. CodeQL imports this data after extraction.

CodeQL databases provide a snapshot of a particular language's queryable data that was extracted from a codebase. This data is a full, hierarchical representation of the code. It includes a representation of the abstract syntax tree, the data-flow graph, and the control-flow graph.

Databases are generated one language at a time for multiple-language codebases. Each language has its own unique database schema. The schema provides an interface between the initial lexical analysis during the extraction process and the complex analysis through CodeQL.

A CodeQL database includes two main tables:

- The `expressions` table contains a row for every expression in the source code that CodeQL analyzed during the build process.
- The `statements` table contains a row for every statement in the source code that CodeQL analyzed during the build process.

The CodeQL library defines classes to provide a layer of abstraction over each of these tables. This layer includes the related auxiliary tables `Expr` and `Stmt`.

## Potential CodeQL shortfalls

Database creation in the code-scanning workflow has some potential shortfalls. This section specifically discusses using the GitHub CodeQL action.

You need to use a language matrix for `autobuild` to build each of the compiled languages listed in the matrix. You can use a matrix to create jobs for more than one supported version of a programming language, operating system, or tool.

If you don't use a matrix, `autobuild` tries to build the supported compiled language with the most source files in the repository. Analysis of compiled languages, other than Go, will often fail unless you supply explicit commands to build the code before performing the analysis step.

The behavior of the `autobuild` step varies depending on the operating system that the language extractor runs on. The `autobuild` step tries to automatically detect a suitable build method for the language based on the operating system. This behavior can lead to unreliable results for compiled languages, and it can often result in a failed run.

We recommend that you configure a build step within the code-scanning workflow file that runs before analysis, rather than letting `autobuild` try to build compiled languages. This way, the workflow file is tailored to your system's and project's build requirements for more reliable scans.

You can read more on specific languages and the `autobuild` steps in the [CodeQL autobuild documentation](https://docs.github.com/code-security/code-scanning/creating-an-advanced-setup-for-code-scanning/codeql-code-scanning-for-compiled-languages#about-autobuild-for-codeql).

## VS Code extension

You can use Visual Studio Code (VS Code) and the CodeQL extension to compile and run queries, as long as you're using VS Code 1.39 or later. You can download the extension from the [Visual Studio Code Marketplace](https://marketplace.visualstudio.com/VSCode) or by downloading the CodeQL VSIX file.

The extension uses your installed CLI found in `PATH` if it's available. If not, the extension automatically manages access to the executable file of the CLI for you. Automatic management ensures that the CLI is compatible with the CodeQL extension.
