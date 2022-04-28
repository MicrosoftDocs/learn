Now that you've extracted your code to a database, You can analyze it using CodeQL queries. GitHub experts, security researchers, and community contributors write and maintain the default CodeQL queries. You can also write your own queries.

You can use CodeQL queries in code scanning analysis to find problems in your source code and to find potential security vulnerabilities. You can also write custom queries to identify problems for each language you are using in your source code.

There are two important types of queries:

- **Alert queries**: highlight issues in specific locations of your code. 
- **Path queries**:  describe the flow of information between a source and a sink in your code.

## Write a simple CodeQL query

The basic CodeQL query structure has the file extension `.ql` and contains a `select` clause.

Here is an example query structure:

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

Using CodeQL with code scanning converts results in a way that highlights the potential issue that the queries are designed to find. Queries contain metadata properties that indicate how the results should be interpreted. Use query metadata to identify your custom queries when you add them to your GitHub repository. The metadata provides information about the query's purpose. The metadata also specifies how to interpret and display the query results.

Other queries display a series of locations that represent steps along a data-flow or control-flow. Queries also include a message explaining the significance of the result.

Queries that don't have metadata aren't interpreted. Those results are output as a table and not displayed in the source code.

This is an example of metadata for one of the standard Java queries:

:::image type="content" source="../media/query-metadata.png" alt-text="Screenshot showing query metadata." border="false":::

## QL syntax

Queries are written using QL. The QL basic syntax is similar to SQL.

QL is a programming language made up of logical formulas. Common logical connectives such as `and`, `or`, and `not` are used. Quantifiers such as `forall` and `exists` are also used. QL also uses important logical concepts such as predicates. Furthermore, you can write complex recursive queries, because QL supports recursion and aggregates. You can also write complex recursive queries using simple QL syntax as well as aggregates like `count`, `sum`, and `average`.

## Path queries

Create path queries to visualize the flow of information through a codebase. Use path queries to track the path taken by data from its possible starting points (source) to its possible end points (sink). To model paths, your query must provide information about the source and the sink, as well as the data flow steps that link them.

The easiest way to start writing your own path query is to use one of the existing queries as a template.

Your path query will require certain metadata, query predicates, and `select` statement structures. Many of the built-in path queries included in CodeQL follow a simple structure. Those structures depend on how CodeQL models the language you are analyzing.

Below is a path query template:

>
```
/**
 * ...
 * @kind path-problem
 * ...
 */
import <language>
// For some languages (Java/C++/Python) you need to explicitly import the data flow library, such as
// import semmle.code.java.dataflow.DataFlow
import DataFlow::PathGraph
...

from MyConfiguration config, DataFlow::PathNode source, DataFlow::PathNode sink
where config.hasFlowPath(source, sink)
select sink.getNode(), source, sink, "<message>"
```

Where:

- `DataFlow::Pathgraph` is the path graph module you need to import from the standard CodeQL library.
- `source` and `sink` are nodes on the path graph, and `DataFlow::PathNode` is their type.
- `MyConfiguration` is a class containing the predicates which define how data may flow between the `source` and the `sink`.

The following sections describe the main requirements for a valid path query.

### How to write a path query

Your query needs to compute a path graph in order to generate path explanations. To do so, define a query predicate called `edges`. A query predicate is a non-member predicate with a `query` annotation. The query annotation returns all the tuples that the predicate evaluates. The `edges` defines the edge relations of the graph that you are computing. It is used to compute the paths related to each result that your query generates. You can also import a predefined `edges` predicate from a path graph module in one of the standard data flow libraries. The data flow libraries contain the other `classes`, `predicates`, and `modules` that are commonly used in data flow analysis in addition to the path graph module. The CodeQL data flow libraries function by modeling its data flow graph or implementing data flow analysis. Normal data flow libraries are used to analyze the information flow in which data values are preserved at each step.

Here is the example statement that imports the `pathgraph` module from the data flow library (`DataFlow.qll`), in which `edges` is defined.

- `import DataFlow::PathGraph`

You can import many additional libraries included with CodeQL. You can also import libraries specifically designed to implement data flow analysis in various common frameworks and environments.

The class `PathNode` is an example that is specifically designed to implement data flow analysis. It is a `Node` augmented with a call context (except for sinks), an access path, and a configuration. Only those `PathNodes` that are reachable from a source are generated.

Here is an example of the import path:

`import semmle.code.cpp.ir.dataflow.internal.DataFlowImpl`

You can optionally define a `nodes` query predicate, which specifies the nodes of the path graph for all languages. When you define `nodes`, only edges with endpoints are defined by the nodes selected. When you do not define `nodes`, you need to select all possible endpoints of `edges`.


## Analyze your database

You'll receive meaningful results in the context of the source code when you use queries to analyze a CodeQL database. The results will be styled as alerts or paths in Static Analysis Results Interchange Format (SARIF) or another interpreted format.

Here is an example of a CodeQL database command. This command combines the effect of the `codeql database run-queries` and `codeql database interpret-results` commands. 

`codeql database analyze --format=<format> 
---output=<output> [--threads=<num>] [--ram=<MB>] <options>... -- <database> <query|dir|suite>...`

Alternatively, you can run queries that don't meet the requirements for being interpreted as source-code alerts. To do so use `codeql-database run-queries` or `codeql query run`. Then `codeql bqrs decode` to convert the raw results to a readable notation.

### Use a SARIF file with categories

CodeQL supports Static Analysis Results Interchange Format (SARIF) for sharing static analysis results. SARIF is designed to represent the output of a broad range of static analysis tools. You need to specify a category when using SARIF output for CodeQL analysis. Categories can distinguish multiple analyses performed on the same commit repository and on different languages or different parts of the code. However, SARIF files with the same category will overwrite each other.

Each SARIF output file can be scanned with CodeQL to analyze different languages within the same code when the values are consistent between the analysis runs. 

Here is one example. This value will appear (with a trailing slash appended if not already present) as the `<run>.automationId` property in SARIF v1, the `<run>.automationLogicalId` property in SARIF v2, and the `<run>.automationDetails.id` property in SARIF v2.1.0.

### Posting the SARIF results to GitHub

Once the database is ready, you can query it interactively, or run a suite of queries to generate a set of results in SARIF format and upload the results to GitHub.com. This example uploads a SARIF file to GitHub code scanning.

`codeql github upload-results --sarif=<file> [--github-auth-stdin] [--github-url=<url>] [--repository=<repository-name>] [--ref=<ref>] [--commit=<commit>] [--checkout-path=<path>] <options>...`

To upload results to GitHub each Continuous integration (CI) server needs a GitHub App or personal access token for the CodeQL CLI to use. You must use an access token or a GitHub App with the `security_events` write permission. You could potentially allow the CodeQL CLI to use the same token if CI servers already use a token with this scope to check out repositories from GitHub. Otherwise, create a new token with the `security_events` write permission and add this to the CI system's secret store. Best practice for security is to set the `--github-auth-stdin` flag and pass the token to the command through the standard input.

### Upload 3rd party SARIF results

For code scanning to display results from a third-party static analysis tool in your GitHub repository, your results must be stored in a SARIF file that supports a specific subset of the SARIF 2.1.0 JSON schema. Alternatively, your results will display in your repository on GitHub automatically if you use the default CodeQL static analysis engine. Fingerprint data is included in SARIF files created by the CodeQL analysis workflow or using the CodeQL runner.

SARIF specifications use the JSON property name, `partialFingerprints`. A dictionary from named fingerprint types to the fingerprint. This will contain, at a minimum, a value for the `primaryLocationLineHash`, which provides a fingerprint based on the context of the primary location.

GitHub attempts to populate the `partialFingerprints` field from the source files if you upload a SARIF file using the `upload-sarif` action and this data is missing. Additionally, users may see duplicate alerts when code scanning alerts are processed and displayed, if you upload a SARIF file without fingerprint data using the `/code-scanning/sarifs` API endpoint.

To avoid seeing duplicate alerts, you should calculate fingerprint data and populate the `partialFingerprints` property before you upload the SARIF file. A helpful starting point is to use the same script as the `upload-sarif` action.
