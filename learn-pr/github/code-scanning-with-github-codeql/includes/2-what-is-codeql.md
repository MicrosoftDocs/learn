CodeQL is the analysis engine used by developers to automate security checks, and by security researchers to perform variant analysis.

In CodeQL, code is treated like data. Security vulnerabilities, bugs, and other errors are modeled as queries that can be executed against databases extracted from code. You can run the standard CodeQL queries, written by GitHub researchers and community contributors, or write your own to use in custom analyses. Queries that find potential bugs highlight the result directly in the source file.

In this unit, you'Ll learn about the CodeQL static analysis tool and how it uses databases, query suites, and query language packs to perform variant analysis.

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

There are three default query suites for CodeQL:

* `code-scanning`: queries run by default in CodeQL code scanning on GitHub.
* `security-extended`: queries from `code-scanning`, plus extra security queries with slightly lower precision and severity.
* `security-and-quality`: queries from `code-scanning`, `security-extended`, plus extra maintainability and reliability queries.

## Query Language (QL) packs

QL packs are used to organize the files used in CodeQL analysis. They contain queries, library files, query suites, and important metadata.

The CodeQL repository contains QL packs for C/C++, C#, Java, JavaScript, Python, and Ruby. The CodeQL for Go repository contains a QL pack for Go analysis. You can also make custom QL packs to contain your own queries and libraries.

### QL pack structure

A QL pack must contain a file called `qlpack.yml` in its root directory. The other files and directories within the pack should be logically organized. For example:

* Queries are organized into directories for specific categories.
* Queries for specific products, libraries, and frameworks are organized into their own top-level directories.
* There is a top-level directory named `<owner>/<language>` for query library (`.qll`) files. Within this directory, `.qll` files should be organized into subdirectories for specific categories.

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
