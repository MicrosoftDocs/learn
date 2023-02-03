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

### 1. Download the CodeQL CLI zip package

You'll need two things to begin using the CodeQL CLI:

- The CLI 
- The query libraries, which include the local CodeQL queries in that repo

The CodeQL CLI download package is a zip archive containing tools, scripts, and various CodeQL-specific files. You can download the `codeql-PLATFORM.zip` file for the specific CLI platform you want to use. Alternatively, you can download the `codeql.zip` file that contains the CLI for all supported platforms.

Download the zip archive for Linux, Windows, or macOS, from [github/codeql-cli-binaries](https://github.com/github/codeql-cli-binaries). Then download the appropriate `codeql-PLATFORM.zip` file for a specific platform. Alternatively, you can download `codeql.zip` that contains the CLI for all supported platforms.

### 2. Create a new CodeQL directory

Place the CLI and any queries and libraries you want to use into a CodeQL directory.

Here's an example of a new CodeQL directory: `$HOME/codeql-home`.

The CLI's built-in search operations automatically looks in all sibling directories for the files used in the database creation and analysis. The analysis can only complete successfully when the necessary query libraries are found in a related sibling directory. 

You can prevent the CLI from searching unrelated sibling directories by keeping the components in their own directory. Keeping the components in their own directory ensures all files are available without specifying any further options on the command line.

### 3. Obtain a local copy of the CodeQL queries

The CodeQL repository on GitHub contains the queries and libraries for CodeQL analysis of C/C++, C#, Java, JavaScript/TypeScript, Python, and Ruby. The CodeQL for Go repository on GitHub is contained within the CodeQL repository and contains the libraries and queries for Go analysis.

Clone a copy of the repository into your CodeQL directory `codeql-home`. The root of the cloned repository will be called`codeql` by default. After creating the clone, rename the folder`codeql-repo` so that you don't have a conflict with the CodeQL CLI that you'll extract in the next step.

You can also clone and rename the repository in a single step when using git from the command line by running `git clone git@github.com:github/codeql.git codeql-repo` in the `codeql-home`.

For example, if the root of the cloned CodeQL repository is `$HOME/codeql-home/codeql-repo`, then the root of the cloned CodeQL for Go repository should be `$HOME/codeql-home/codeql-go`.

The queries and libraries are organized into QL packs within these repositories. QL packs contain important metadata that tells the CodeQL CLI how to process the query files, along with the queries themselves. You'll learn more about the QL language in the next unit.

### 4. Extract the zip archive

If you're using Linux, Windows, and macOS, you can extract the zip archive into the directory you created in step 2.

For example, if the path to your copy of the CodeQL repository is `$HOME/codeql-home/codeql-repo`, then extract the CLI into `$HOME/codeql-home/`.

### 5. Launch `codeql`

After extraction, you can follow one of the below steps to use the `codeql` executable to run the CodeQL processes.

- Execute `<extraction-root>/codeql/codeql`, where `<extraction-root>` is the folder where you extracted the CodeQL CLI package.
- Add `<extraction-root>/codeql` to your `PATH`, so that you can run the executable as just `codeql`.

Now you're able to execute CodeQL commands.

## Verify your CodeQL CLI setup

You can also execute CodeQL CLI subcommands to verify that you correctly set up and can analyze databases.

- Run `codeql resolve languages` to show which languages are available for database creation. This will list the languages supported by default in your CodeQL CLI package.
- Run `codeql resolve qlpacks` to show which QL packs the CLI can find. This will display the names of the QL packs included in the CodeQL repositories: `codeql-cpp`, `codeql-csharp`, `codeql-go`, `codeql-java`, `codeql-javascript`, and `codeql-python`. The CodeQL repositories also contain ‘upgrade’ packs and ‘legacy’ packs. 
    - Upgrade packs are used by the CLI when you want to upgrade a database so that it can be analyzed with a newer version of the CodeQL toolchain than was used to create it. 
    - Legacy packs ensure that custom queries and libraries created using older products are compatible with your version of CodeQL.

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

Additionally, you can create a new directory that can include the CLI and any queries you want to use. The CLI's built-in search operations automatically look in all of the directory's sibling directories for the files used in the database creation.

For example:
>
```
- $HOME/codeql-home
```
>

## Extractors

An extractor is a tool that produces the relational data and source reference for each input file, from which a CodeQL database can be built. Each language supported by CodeQL has one extractor. This ensures that the extraction process is as accurate as possible.

Each extractor defines its own set of configuration options. For CodeQL CLI v2.7.1 and above, typing `codeql resolve extractor --format=betterjson` will result in data formatted like the following example:

>
```
{
     "
     extractor_root" : "/home/user/codeql/java",
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

You need to use a language matrix for `autobuild` to build each of the compiled languages listed in the matrix. If you don't use a matrix, then `autobuild` attempts to build the supported compiled language with the most source files in the repository. Analysis of compiled languages, other than Go, will fail unless you supply explicit commands. A matrix can be used to create jobs for more than one supported version of a programming language, operating system, or tool.

The `autobuild` step behavior varies depending on the operating system that the extractor runs on. The `autobuild` step attempts to autodetect a suitable build method for C/C++ on Windows. It reviews the files present in the repository to determine the system used on Linux and macOS. You must understand the operating system and language used for CodeQL to work correctly.

You will use build projects for compiled languages without specifying any build commands with CodeQL autobuilders. CodeQL examines the source for evidence of a build system and attempts to run the optimal commands required to extract a database when an autobuilder is invoked.

## VS Code extension

Additionally, you can use Visual Studio (VS) Code and the CodeQL extension, as long as you're using VS Code 1.39 or later. Using the extension and CodeQL, you can compile and run queries. You can download the extension from the Visual Studio Code Marketplace. Download the CodeQL VSIX file. The extension uses your installed CLI found on your `PATH`, if it's available. This most likely occurred if you create your own CodeQL databases. If not, the extension automatically manages access to the executable of the CLI for you. In doing so, this ensures that the CLI is compatible with the CodeQL extension.
