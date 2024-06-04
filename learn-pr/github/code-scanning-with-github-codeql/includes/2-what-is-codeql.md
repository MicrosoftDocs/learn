CodeQL is the analysis engine used by developers to automate security checks, and by security researchers to perform variant analysis.

In CodeQL, code is treated like data. Security vulnerabilities, bugs, and other errors are modeled as queries that can be executed against databases extracted from code. You can run the standard CodeQL queries, written by GitHub researchers and community contributors, or write your own to use in custom analyses. Queries that find potential bugs highlight the result directly in the source file.

In this unit, you'll learn about the CodeQL static analysis tool and how it uses databases, query suites, and query language packs to perform variant analysis.

## Variant analysis

Variant analysis is the process of using a known security vulnerability as a seed to find similar problems in your code. It’s a technique that security engineers use to identify potential vulnerabilities and ensure these threats are properly fixed across multiple codebases.

Querying code using CodeQL is the most efficient way to perform variant analysis. You can use the standard CodeQL queries to identify seed vulnerabilities, or find new vulnerabilities by writing your own custom CodeQL queries. Then, you can develop or iterate over the query to automatically find logical variants of the same bug that could be missed using traditional manual techniques.

## CodeQL databases

CodeQL databases contain queryable data extracted from a codebase, for a single language at a particular point in time. The database contains a full, hierarchical representation of the code, including a representation of the abstract syntax tree, the data-flow graph, and the control-flow graph.

Each language has its own unique database schema that defines the relations used to create a database. The schema provides an interface between the initial lexical analysis performed during the extraction process and the actual complex analysis of the CodeQL query evaluator. The schema specifies, for instance, that there's a table for every language construct.

For each language, the CodeQL libraries define classes to provide a layer of abstraction over the database tables. This provides an object-oriented view of the data, which makes it easier to write queries.

For example, in a CodeQL database for a Java program, two key tables are:

* The `expressions` table, containing a row for every single expression in the source code that was analyzed during the build process.
* The `statements` table, containing a row for every single statement in the source code that was analyzed during the build process.

The CodeQL library defines classes to provide a layer of abstraction over each of these tables (and the related auxiliary tables): `Expr` and `Stmt`.

## Query suites

CodeQL query suites provide a way of selecting queries, based on their filename, location on disk or in a QL pack, or metadata properties. Create query suites for the queries that you want to frequently use in your CodeQL analyses.

Query suites allow you to pass multiple queries to CodeQL without having to specify the path to each query file individually. Query suite definitions are stored in YAML files with the extension `.qls`. A suite definition is a sequence of instructions where each instruction is a YAML mapping with (usually) a single key. The instructions are executed in the order they appear in the query suite definition. After all the instructions in the suite definition have been executed, the result is a set of selected queries.

### Default query suites

There are two built-in query suites for CodeQL:

* `default`: These are the queries run by default in CodeQL code scanning on GitHub, available with the default setup of code scanning. The queries in this query suite are highly precise and return few false positive code scanning results. Relative to the `security-extended` query suite, the default suite returns fewer low-confidence code scanning results.
* `security-extended`: This suite contains all of the queries from the `default` suite, plus extra security queries with slightly lower precision and severity. It is available with the default setup of code scanning and is listed as the "Extended" option in the query suites dropdown. Relative to the `default` query suite, this suite may return a greater number of false positive code scanning results.

The default setup of code scanning will use the `default` query suite. This can be changed by selecting the overflow icon to view the CodeQL configuration and then selecting to the edit button. Under "Scan settings" you may choose one of the above two options as the query suite.

## CodeQL packs

CodedQL packs are used to organize the files used in CodeQL analysis so you can create, share, depend on, and run CodeQL queries and libraries easily. They contain queries, library files, query suites, and important metadata. With CodeQL packs and the package management commands in the CodeQL CLI, you can publish your custom queries and integrate them into your codebase analysis.

There are three types of CodeQL packs: query packs, library packs, and model packs.

* Query packs are designed to be run. When a query pack is published, the bundle includes all the transitive dependencies and pre-compiled representations of each query, in addition to the query sources. This ensures consistent and efficient execution of the queries in the pack.
* Library packs are designed to be used by query packs (or other library packs) and do not contain queries themselves. The libraries are not compiled separately.
* Model packs can be used to expand code scanning analysis to include dependencies that are not supported by default. Model packs are currently in beta and subject to change. During the beta, model packs are available for Java analysis at the repository level. For more information about creating your own model packs, see "Creating a CodeQL model pack."

### CodeQL pack structure

The CodeQL CLI can be used to being developing and publishing a pack using the `pack init` command. This command will create the directory structure and files required, including the main file called `qlpack.yml` in its root directory. The metadata in each `qlpack.yml` file tells CodeQL how to compile any queries in the pack, what libraries the pack depends on, and where to find query suite definitions.

The contents of the CodeQL pack (queries or libraries used in CodeQL analysis) is included in the same directory as `qlpack.yml`, or its subdirectories.

The directory containing the qlpack.yml file serves as the root directory for the content of the CodeQL pack. That is, for all `.ql` and `.qll`s files in the pack, CodeQL will resolve all import statements relative to the directory containing the qlpack.yml file at the pack’s root.

Here's an example `qlpack.yml` file:

```yml
name: codeql/java-queries
version: 0.0.6-dev
groups: java
suites: codeql-suites
extractor: java
defaultSuiteFile: codeql-suites/java-code-scanning.qls
dependencies:
    codeql/java-all: "*"
    codeql/suite-helpers: "*"
```

For more information on creating and publishing your own CodeQL packs, see "Publishing and using CodeQL packs."<sup>[1]</sup>
