CodeQL treats code like data. CodeQL analysis relies on extracting relational data from your code and using it to build a CodeQL database. These databases contain all of the important information about a codebase.

You can then run CodeQL queries against this database to identify security vulnerabilities, bugs, and other errors. You can write your own queries or run standard CodeQL queries written by GitHub researchers and community contributors.

You can use the standalone CodeQL CLI to create and analyze a CodeQL database. Analyzing the database generates results in **Static Analysis Results Interchange Format (SARIF)**, which can be uploaded to a GitHub repository to view alert details.

## CodeQL scanning architecture

CodeQL scanning follows a pipeline that transforms source code into queryable data, executes security queries, and publishes the results as code scanning alerts.

The scanning workflow is:

1. **Source code:** CodeQL starts with the repository contents at the commit being analyzed.
2. **Extraction:** A language-specific extractor reads the code and collects facts about source files, syntax, control flow, and data flow.
3. **Database creation:** The extracted facts are stored in a CodeQL database. Each database represents one language in the codebase.
4. **Query execution:** CodeQL runs GitHub-maintained queries, community queries, or custom queries against the database.
5. **SARIF generation:** Query results are written in **Static Analysis Results Interchange Format (SARIF)**.
6. **GitHub code scanning:** SARIF results are uploaded to GitHub and displayed as code scanning alerts.

This architecture separates code extraction from query execution. After a database has been created, you can run different query suites against the same database without extracting the code again.

## Language strategy

CodeQL supports both compiled and interpreted languages, but the extraction strategy depends on the language type.

### Compiled languages

For compiled languages such as:

- C/C++
- C#
- Java
- Kotlin
- Rust
- Swift
- Go

CodeQL often needs to understand how the project builds. During database creation, CodeQL may monitor the build process so it can extract the source files processed by the compiler.

For the most reliable results, configure explicit build commands rather than relying on **autobuild** or **no build** options.

### Interpreted languages

For interpreted languages such as:

- Python
- JavaScript/TypeScript
- Ruby

CodeQL extracts information directly from the source code without requiring a separate build command.

### Multi-language repositories

For repositories containing multiple supported languages:

- Create a separate database for each language.
- In GitHub Actions, use a **language matrix** so each language is initialized, extracted, and analyzed correctly.

## Database preparation for CodeQL

Before generating a CodeQL database:

1. Install and configure the CodeQL CLI.
2. Check out the version of the codebase you want to analyze.

For compiled languages:

- Ensure the project is ready to build.
- Install all required dependencies beforehand.
- CodeQL extracts a relational representation of every source file to create the database.

For interpreted languages:

- The extractor runs directly on the source code.
- Dependencies are resolved automatically during extraction.

For compiled languages, CodeQL monitors the normal build process. Each time the compiler processes a source file, CodeQL creates a copy and extracts all relevant information required for analysis.

## CLI setup

Follow these steps to install the CodeQL CLI.

### 1. Download the CodeQL CLI bundle

The recommended installation method is downloading the bundled package, which ensures compatibility between the CLI, libraries, and query packs.

The bundle includes:

- The CodeQL CLI
- Compatible CodeQL queries and libraries
- Precompiled query packs

To download the bundle:

1. Go to the **Releases** page of the CodeQL public repository.
2. Download the platform-specific bundle under **Assets**.

The Releases page also includes:

- Release notes
- Previous versions
- `codeql-bundle.tar.gz`, which supports all platforms

### 2. Extract the archive

Extract the `.zip` archive into a directory of your choice.

Users of **macOS Catalina** (or later) must complete additional setup steps as described in the CodeQL CLI documentation.

### 3. Run CodeQL

After extraction, either:

- Run:

```text
<extraction-root>/codeql/codeql
```

or

- Add:

```text
<extraction-root>/codeql
```

to your system `PATH` so you can invoke the CLI simply as:

```text
codeql
```

You can now run CodeQL commands.

## Verify your CLI setup

Run the following commands to verify that your installation is working correctly.

Display installed CodeQL packs:

```text
codeql resolve packs
```

If the executable isn't in your `PATH`, use:

```text
<extraction-root>/codeql/codeql resolve packs
```

If expected language packs are missing, verify that you downloaded the **CodeQL bundle**, not the standalone CLI.

Display supported languages:

```text
codeql resolve languages
```

## Database creation

Create a CodeQL database from the root of your project:

```text
codeql database create <database> --language=<language-identifier>
```

Replace:

- `<database>` with the destination directory.
- `<language-identifier>` with the language identifier to analyze.

You can also use the following options:

| **Option** | **Purpose** |
| :--- | :--- |
| `--source-root` | Specifies the root directory containing the source code. |
| `--db-cluster` | Creates databases for multiple languages. |
| `--command` | Specifies the build command for compiled languages. Not required for Python, Ruby, or JavaScript. |
| `--no-run-unnecessary-builds` | Skips unnecessary builds when used with `--db-cluster`. |

After successful execution:

- A new database directory is created.
- When using `--db-cluster`, a subdirectory is created for each language.

Each database contains:

- Relational analysis data
- Source archive
- Metadata required for CodeQL analysis

The source archive is a snapshot of the source files at the time the database was created and is used when displaying analysis results.

## Database generation and performance considerations

After creating a CodeQL database, it's important to understand how database generation works and how it affects performance.

### Database generation methods

You can generate CodeQL databases using either:

#### CodeQL CLI

Create databases and run analysis manually.

This approach is useful for:

- Local development
- Debugging
- Advanced configurations

#### GitHub Actions workflows

Most organizations automate database generation through GitHub Actions.

A typical workflow:

1. Initializes CodeQL.
2. Creates databases.
3. Runs queries.
4. Uploads SARIF results to GitHub.

### Per-language databases

CodeQL creates a separate database for every supported language.

Each language:

- Uses its own extractor.
- Uses its own database schema.
- Is analyzed independently.

For multi-language repositories, either:

- Use the `--db-cluster` option with the CLI.
- Configure a language matrix in GitHub Actions.

A language matrix enables parallel analysis and complete language coverage.

### Build-based extraction for compiled languages

For compiled languages:

- CodeQL monitors the build process.
- The build must complete successfully.
- Automatic **autobuild** doesn't work reliably for every project.

For the best results, define explicit build steps before analysis.

For interpreted languages, CodeQL extracts directly from source code without requiring a build.

### Performance considerations

Database creation and analysis time depends on several factors.

#### Repository size

Larger repositories require more extraction and analysis time.

#### Multiple languages

Use a language matrix to analyze languages in parallel and reduce total runtime.

#### CI resources

CodeQL analysis can be resource intensive.

Increasing CPU or memory for runners can significantly improve performance.

#### Scope of analysis

You can reduce analysis time by limiting the code that is scanned, for example by excluding:

- Test files
- Generated code

In general, analysis time is proportional to the amount of source code being processed.


## Database creation and regeneration

A CodeQL database represents a snapshot of the codebase at a specific point in time.

- A new database is created for each analysis run.
- Databases are not incrementally updated.
- Any change to the codebase requires a new database.

You typically regenerate databases when:

- New commits are pushed.
- Pull requests are opened or updated.
- Build configuration changes.
- Query sets or analysis configuration changes.

Because database generation is part of each scan, it's important to align scans with meaningful events, such as pull requests or scheduled runs.

## Extractors

An extractor is a tool that produces the relational data and source reference for each input file, from which a CodeQL database can be built. Each language that CodeQL supports has one extractor. This structure ensures that the extraction process is as accurate as possible.

Each extractor defines its own set of configuration options. Entering `codeql resolve extractor --format=betterjson` results in data formatted like the following example:

```json
{
  "extractor_root": "/home/user/codeql/java",
  "extractor_options": {
    "option1": {
      "title": "Java extractor option 1",
      "description": "An example string option for the Java extractor.",
      "type": "string",
      "pattern": "[a-z]+"
    },
    "group1": {
      "title": "Java extractor group 1",
      "description": "An example option group for the Java extractor.",
      "type": "object",
      "properties": {
        "option2": {
          "title": "Java extractor option 2",
          "description": "An example array option for the Java extractor",
          "type": "array",
          "pattern": "[1-9][0-9]*"
        }
      }
    }
  }
}
```

To find out which options are available for your language's extractor, enter:

- `codeql resolve languages --format=betterjson`, or
- `codeql resolve extractor --format=betterjson`.

The `betterjson` output format also provides the extractor's root and other language-specific options.

## Data in a CodeQL database

A CodeQL database is a single directory that contains all of the data required for analysis. This data includes relational data, copied source files, and a language-specific database schema that specifies the mutual relations in the data. CodeQL imports this data after extraction.

CodeQL databases provide a snapshot of a particular language's queryable data that was extracted from a codebase. This data is a full, hierarchical representation of the code. It includes:

- A representation of the abstract syntax tree (AST).
- The data-flow graph.
- The control-flow graph.

Databases are generated one language at a time for multiple-language codebases. Each language has its own unique database schema. The schema provides an interface between the initial lexical analysis during the extraction process and the complex analysis through CodeQL.

A CodeQL database includes two main tables:

- The **expressions** table contains a row for every expression in the source code that CodeQL analyzed during the build process.
- The **statements** table contains a row for every statement in the source code that CodeQL analyzed during the build process.

The CodeQL library defines classes to provide a layer of abstraction over each of these tables. This layer includes the related auxiliary tables `Expr` and `Stmt`.

## Potential CodeQL shortfalls

Database creation in the code scanning workflow has some potential shortfalls. This section specifically discusses using the GitHub CodeQL Action.

You need to use a language matrix for autobuild to build each of the compiled languages listed in the matrix. You can use a matrix to create jobs for more than one supported version of a programming language, operating system, or tool.

If you don't use a matrix, autobuild tries to build the supported compiled language with the most source files in the repository. Analysis of compiled languages, other than Go, often fails unless you supply explicit commands to build the code before performing the analysis step.

The behavior of the autobuild step varies depending on the operating system that the language extractor runs on. The autobuild step tries to automatically detect a suitable build method for the language based on the operating system. This behavior can lead to unreliable results for compiled languages and can often result in a failed run.

We recommend that you configure a build step within the code scanning workflow file that runs before analysis, rather than letting autobuild try to build compiled languages. This way, the workflow file is tailored to your system's and project's build requirements for more reliable scans.

You can read more on specific languages and the autobuild steps in the CodeQL autobuild documentation.

## VS Code extension

You can use Visual Studio Code (VS Code) and the CodeQL extension to compile and run queries, as long as you're using VS Code 1.39 or later. You can download the extension from the Visual Studio Code Marketplace or by downloading the CodeQL VSIX file.

The extension uses your installed CLI found in `PATH` if it's available. If not, the extension automatically manages access to the executable file of the CLI for you. Automatic management ensures that the CLI is compatible with the CodeQL extension.
