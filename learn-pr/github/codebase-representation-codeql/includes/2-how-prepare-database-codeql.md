
CodeQL treats code like data. You create a database using queryable data that you extracted from your code base. Then you can run CodeQL queries on this database to identify security vulnerabilities, bugs, and other errors. You can write your own queries or run standard CodeQL queries written by GitHub researchers and community contributors.

In this unit, you'll learn how to create a database. This step is required before you can analyze your code. You need to create a CodeQL database containing all the data necessary to run queries on your code. CodeQL analysis relies on extracting relational data from your code and using it to build a CodeQL database. These databases contain all of the important information about a codebase. 

You can use the CodeQL CLI standalone product to analyze code and to generate database representation of a codebase. Once the database is ready you can query the database, or run a suite of queries to generate a set of results in SARIF format.

## Prepare a database for CodeQL

Before you generate a CodeQL database, you need to:

1. Install and set up the CodeQL CLI
2. Check out the version of your codebase you want to analyze

For compiled languages, the directory should be ready to build, with all dependencies already installed. CodeQL begins by extracting a single relational representation of each source file in the codebase to create a database. This is the database you'll use to analyze your code.

For interpreted languages, the extractor runs directly on the source code. This gives you an accurate representation of the codebase and resolves any dependencies. 

Source file extraction from the codebase works by monitoring the normal build process for compiled languages. A copy of the source file is made each time a compiler is invoked to process a source file. All relevant information is collected about the source code with each source file.

## CLI setup

Use the following steps to set up the CodeQL CLI.

### 1. Download the CodeQL CLI bundle zip package

It's recommended to install the CodeQL CLI and queries by downloading the bundled package. This ensures compatibility and improved performance as opposed to downloading the CLI and queries repo separately. The CodeQL CLI download package is a zip archive containing tools, scripts, and various CodeQL-specific files. The bundle includes the CodeQL CLI, compatible versions of the queries and libraries from the CodeQL Github repo, and precompiled versions of the included queries. 

You can download the bundle by navigating to the CodeQL public repository under the releases<sup>[4]</sup> section, and downloading the platform specific bundle from underneath "assets." On this page you can also view the changelogs for releases as well as downloads for previous versions of the CodeQL bundle. If needed, you can download `codeql-bundle.tar.gz`, which contains the CLI for all supported platforms

### 2. Extract the zip archive

If you're using Linux, Windows, or macOS, you can simply extract the zip archive into the directory of your choice.

Additional steps need to be taken for macOS "Catalina"<sup>[5]</sup> (or newer) users.

### 3. Launch `codeql`

After extraction, you can follow one of the below steps to use the `codeql` executable to run the CodeQL processes.

- Execute `<extraction-root>/codeql/codeql`, where `<extraction-root>` is the folder where you extracted the CodeQL CLI package.
- Add `<extraction-root>/codeql` to your `PATH`, so that you can run the executable as just `codeql`.

Now you're able to execute CodeQL commands.

## Verify your CodeQL CLI setup

You can also execute CodeQL CLI subcommands to verify that you correctly set up and can analyze databases.

- Run `codeql resolve qlpacks` (if codeql was added to your PATH) to show which QL packs the CLI can find or `/<extraction-root>/codeql/codeql resolve qlpacks` otherwise. This will display the names of the QL packs included in the CodeQL CLI bundle, shown in the earlier steps as `<extraction root>`. If the CodeQL CLI is unable to locate the qlpacks for the expected languages, check that you downloaded the CodeQL bundle and not a standalone copy of the CodeQL CLI.

- Run `codeql resolve languages` to show which languages are available supported by default in your CodeQL CLI package.

## Create a database

CodeQL databases are created by running this command from the checkout root of your project.

>
```
codeql database create <database> --language=<language-identifier>
```
>

You need to specify the following information in the command. Here are the definitions for the terms used in the command:

- `<database>` is a path to the new database to be created
- `--language` is the identifier for the language used to create the database. This can be used with the `--db-cluster` to accept comma-separated lists, or can be specified more than once

You can also specify additional options. These options depend on the location of the source file, if your code needs to be compiled, or if you want to create CodeQL databases for more than one language.

- `--source-root` is the root folder for the primary source files used in the database creation
- `--db-cluster` is used for multiple-language codebases when you want to create databases for more than one language
- `--command` is used when you create a database for one or more compiled languages. This option isn't needed if you're only using Python and JavaScript
- `--no-run-unnecessary-builds` is used along with `--db-cluster` to suppress the build command for languages where the CodeQL CLI doesn't need to monitor the build

After the database is successfully created, there will be a new directory at the path specified in the command. If you used the --db-cluster option to create more than one database, a subdirectory is created for each language. Each CodeQL database directory contains a number of subdirectories, including the relational data used for analysis and a source archive. The source archive is a copy of the source files made at the time the database was created used for displaying analysis results.

## Extractors

An extractor is a tool that produces the relational data and source reference for each input file, from which a CodeQL database can be built. Each language supported by CodeQL has one extractor. This ensures that the extraction process is as accurate as possible.

Each extractor defines its own set of configuration options. Typing `codeql resolve extractor --format=betterjson` will result in data formatted like the following example:

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

To find out which options are available for your language's extractor, type `codeql resolve languages --format=betterjson` or `codeql resolve extractor --format=betterjson`.
The `betterjson` output format also provides the extractor's root and other language specific options.

## What to know about your data in a CodeQL database

CodeQL databases provide you with the snapshot of a particular language's queryable data that was extracted from a codebase. This data is a full, hierarchical representation of the code, including a representation of the abstract syntax tree, the data flow graph, and the control flow graph.

## The database schema

Each language has its own unique database schema. The schema provides an interface between the initial lexical analysis during the extraction process and the actual complex analysis using CodeQL.

## How does CodeQL represent the common features of your chosen language?

Databases are generated one language at a time for multi-language codebases.

A CodeQL database is a single directory containing all of the data required for analysis. This includes relational data, copied source files, and a language-specific database schema, which specifies the mutual relations in the data. This data is imported after extraction. 

A CodeQL database includes two main tables:

- The `expressions` table contains a row for every single expression in the source code that was analyzed during the build process.
- The `statements` table contains a row for every single statement in the source code that was analyzed during the build process.

The CodeQL library defines classes to provide a layer of abstraction over each of these tables. This includes the related auxiliary tables `Expr` and `Stmt`.

## Potential CodeQL shortfalls

Now let's talk about some potential shortfalls of database creation in the code scanning workflow. This section specifically looks at using the GitHub CodeQL action.

You need to use a language matrix for `autobuild` to build each of the compiled languages listed in the matrix. A matrix can be used to create jobs for more than one supported version of a programming language, operating system, or tool. If you don't use a matrix, then `autobuild` attempts to build the supported compiled language with the most source files in the repository. Analysis of compiled languages, other than Go, will often fail unless you supply explicit commands to build the code before performing the analysis step.

The `autobuild` step behavior varies depending on the operating system that the langauge extractor runs on. The `autobuild` step attempts to autodetect a suitable build method for the language based on the OS, this can lead to unreliable results for **compiled langauges** though, and will often result in a failed run. It's recommended that you configure a build step within the code scanning workflow file that runs before analysis, rather than letting `autobuild` attempt to build compiled languages. This way the workflow file is tailored to your system and project's build requirements, allowing for more reliable scans.

You can read more on specific langauges and the steps autobuild attempts in the documentation<sup>[6]</sup>

## VS Code extension

Additionally, you can use Visual Studio (VS) Code and the CodeQL extension, as long as you're using VS Code 1.39 or later. Using the extension and CodeQL, you can compile and run queries. You can download the extension from the Visual Studio Code Marketplace or by downloading the CodeQL VSIX file. The extension uses your installed CLI found on your `PATH` if it's available. If not, the extension automatically manages access to the executable of the CLI for you. In doing so, this ensures that the CLI is compatible with the CodeQL extension.
