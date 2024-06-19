With your code extracted to a database, you can now analyze it by using CodeQL queries. GitHub experts, security researchers, and community contributors write and maintain the default CodeQL queries. You can also write your own queries.

You can use CodeQL queries in code-scanning analysis to find problems in your source code and to find potential security vulnerabilities. You can also write custom queries to identify problems for each language that you're using in your source code.

There are two important types of queries:

- *Alert queries* highlight problems in specific locations of your code.
- *Path queries* describe the flow of information between a source and a sink in your code.

## Simple CodeQL query

The basic CodeQL query structure has the file extension `.ql` and contains a `select` clause. Here's an example query structure:

>
```
/**
 *
 * Query metadata
 *
 */
import /* ... CodeQL libraries or modules ... */
/* ... Optional, define CodeQL classes and predicates ... */
from /* ... variable declarations ... /
where / ... logical formula ... /
select / ... expressions ... */
```

## Query metadata

Using CodeQL with code scanning converts results in a way that highlights the potential problems that the queries are designed to find. Queries contain metadata properties that indicate how the results should be interpreted. Use query metadata to:

- Identify your custom queries when you add them to your GitHub repository.
- Provide information about the query's purpose.

Metadata information can include a description of the query, a unique ID, and the kind of problem it is (alert or path). Metadata also specifies how to interpret and display the query results.

GitHub has a recommended style guide for query metadata. You can find it in the [CodeQL documentation](https://github.com/github/codeql/blob/main/docs/query-metadata-style-guide.md).

This is an example of metadata for one of the standard Java queries:

:::image type="content" source="../media/query-metadata.png" alt-text="Screenshot showing query metadata." border="false":::

CodeQL doesn't interpret queries that don't have metadata. It shows those results as a table and doesn't display them in the source code.

## QL syntax

QL is a declarative, object-oriented query language. It's optimized to enable efficient analysis of hierarchical data structures, and in particular, databases that represent software artifacts.

The syntax of QL is similar to SQL, but the semantics of QL are based on Datalog. Datalog is a declarative logic programming language that's often used as a query language. Because QL is primarily a logic language, all operations in QL are logical operations. QL also inherits recursive predicates from Datalog. QL adds support for aggregates to make even complex queries concise and simple.

The QL language consists of logical formulas. It uses common logical connectives such as `and`, `or`, and `not`, along with quantifiers such as `forall` and `exists`. Because QL inherits recursive predicates, you can also write complex recursive queries by using simple QL syntax and aggregates like `count`, `sum`, and `average`.

For more information on the QL language, see the [CodeQL documentation](https://codeql.github.com/docs/ql-language-reference/about-the-ql-language/).

## Path queries

The way information flows through a program is important. Data that seems benign can flow in unexpected ways that allow it to be used maliciously.

Creating path queries can help you visualize the flow of information through a codebase. A query can track the path that data takes from its possible starting points (`source`) to its possible endpoints (`sink`). To model paths, your query must provide information about the source, the sink, and the data-flow steps that link them.

The easiest way to start writing your own path query is to use one of the existing queries as a template. To get these queries for supported languages, see the [CodeQL documentation](https://codeql.github.com/codeql-query-help/).

Your path query requires certain metadata, query predicates, and `select` statement structures. Many of the built-in path queries in CodeQL follow a simple structure. The structure depends on how CodeQL models the language that you're analyzing.

Here's an example template for a path query:

>
```
/**
 * ...
 * @kind path-problem
 * ...
 */

import <language>
// For some languages (Java/C++/Python/Swift), you need to explicitly import the data-flow library, such as
// import semmle.code.java.dataflow.DataFlow or import codeql.swift.dataflow.DataFlow
...

module Flow = DataFlow::Global<MyConfiguration>;
import Flow::PathGraph

from Flow::PathNode source, Flow::PathNode sink
where Flow::flowPath(source, sink)
select sink.getNode(), source, sink, "<message>"
```

In that template:

- `MyConfiguration` is a module that contains the predicates that define how data flows between `source` and `sink`.
- `Flow` is the result of the data-flow computation based on `MyConfiguration`.
- `Flow::Pathgraph` is the resulting data-flow graph module that you need to import in order to include path explanations in the query.
- `source` and `sink` are nodes in the graph as defined in the configuration, and `Flow::PathNode` is their type.
- `DataFlow::Global<..>` is an invocation of data flow. You can use `TaintTracking::Global<..>` instead to include a default set of additional taint steps.

### How to write a path query

Your query needs to compute a path graph in order to generate path explanations. To do so, define a query predicate called `edges`. A query predicate is a nonmember predicate with a `query` annotation. The query annotation returns all the tuples that the predicate evaluates.

The `edges` predicate defines the edge relations of the graph that you're computing. It's used to compute the paths related to each result that your query generates. You can also import a predefined `edges` predicate from a path graph module in one of the standard data-flow libraries.

The data-flow libraries contain the other classes, predicates, and modules that are commonly used in data-flow analysis, in addition to the path graph module. The CodeQL data-flow libraries function by modeling the data-flow graph or implementing data-flow analysis. Normal data-flow libraries are used to analyze the information flow in which data values are preserved at each step.

Here's an example statement that imports the `pathgraph` module from the data-flow library (`DataFlow.qll`), in which `edges` is defined:

`import DataFlow::PathGraph`

You can import many additional libraries included with CodeQL. You can also import libraries that are specifically designed to implement data-flow analysis in various common frameworks and environments.

The class `PathNode` is an example that's specifically designed to implement data-flow analysis. It's `Node` augmented with a call context (except for sinks), an access path, and a configuration. Only `PathNode` values that are reachable from a source are generated.

Here's an example of the import path:

`import semmle.code.cpp.ir.dataflow.internal.DataFlowImpl`

You can optionally define a `nodes` query predicate, which specifies the nodes of the path graph for all languages. When you define `nodes`, the selected nodes define only edges with endpoints. When you don't define `nodes`, you need to select all possible endpoints of `edges`.

## Database analysis

 When you use queries to analyze a CodeQL database, you receive meaningful results in the context of the source code. The results are styled as alerts or paths in SARIF or another interpreted format.

Here's an example of a CodeQL database command that analyzes the database by running selected queries against it and interpreting the results:

`codeql database analyze --format=<format>
---output=<output> [--threads=<num>] [--ram=<MB>] <options>... -- <database> <query|dir|suite>...`

This command combines the effect of the `codeql database run-queries` and `codeql database interpret-results` plumbing commands.

Alternatively, you can run queries that don't meet the requirements for being interpreted as source-code alerts. To do so, use `codeql-database run-queries` or `codeql query run`. Then use `codeql bqrs decode` to convert the raw results to a readable notation.

You can get a full list of available CodeQL CLI commands in the [CodeQL CLI manual](https://docs.github.com/en/code-security/codeql-cli/codeql-cli-manual).

### Use a SARIF file with categories

CodeQL supports SARIF for sharing static analysis results. SARIF is designed to represent the output of a broad range of static analysis tools.

You need to specify a category when using SARIF output for CodeQL analysis. Categories can distinguish multiple analyses performed on the same commit repository and on different languages or different parts of the code. However, SARIF files with the same category overwrite each other.

You can scan each SARIF output file by using CodeQL to analyze different languages within the same code base when the category value is consistent between the analysis runs. We recommend that you use the language being scanned as an identifier for the category.

Here's one example. The category value appears (with a trailing slash appended if it's not already present) as the `<run>.automationId` property in SARIF v1, the `<run>.automationLogicalId` property in SARIF v2, and the `<run>.automationDetails.id` property in SARIF v2.1.0.

### Post the SARIF results to GitHub

After the database is ready, you can query it interactively. Or you can run a suite of queries to generate a set of results in SARIF format and upload the results to a target repository on GitHub.com:

`codeql github upload-results --sarif=<file> [--github-auth-stdin] [--github-url=<url>] [--repository=<repository-name>] [--ref=<ref>] [--commit=<commit>] [--checkout-path=<path>] <options>...`

To upload results to GitHub, make sure that each continuous integration (CI) server has a GitHub App or personal access token for the CodeQL CLI to use. You must use an access token or a GitHub App with the `security_events` write permission.

You could potentially allow the CodeQL CLI to use the same token if CI servers already use a token with this scope to check out repositories from GitHub. Otherwise, create a new token with the `security_events` write permission and add this token to the CI system's secret store. A best practice for security is to set the `--github-auth-stdin` flag and pass the token to the command through the standard input.

### Upload SARIF results

For code scanning to display results from a non-Microsoft static analysis tool in your GitHub repository, your results must be stored in a SARIF file that supports a specific subset of the SARIF 2.1.0 JSON schema. You can upload the results by using the code-scanning API or the CodeQL CLI.

Each time you upload the results of a new code scan, CodeQL processes the results and adds alerts to the repository. To prevent duplicate alerts for the same problem, code scanning uses the SARIF `partialFingerprints` property to match results across various runs so that they appear only once in the latest run for the selected branch. This makes it possible to match alerts to the correct line of code when files are edited.

The rule ID for a result has to be the same across analyses. Fingerprint data is automatically included in SARIF files created through the CodeQL analysis workflow or the CodeQL runner.

SARIF specifications use the JSON property name `partialFingerprints`, a dictionary from named fingerprint types to the fingerprint. This property contains, at a minimum, a value for `primaryLocationLineHash`, which provides a fingerprint based on the context of the primary location.

GitHub tries to populate the `partialFingerprints` field from the source files if you upload a SARIF file by using the `upload-sarif` action and this data is missing. Additionally, if you upload a SARIF file without fingerprint data by using the `/code-scanning/sarifs` API endpoint, users might see duplicate alerts when code-scanning alerts are processed and displayed.

To avoid seeing duplicate alerts while you're working with static analysis tools, calculate fingerprint data and populate the `partialFingerprints` property before you upload the SARIF file. A helpful starting point is to use the same script as the `upload-sarif` action.
