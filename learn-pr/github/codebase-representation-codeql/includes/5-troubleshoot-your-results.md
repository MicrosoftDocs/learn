This unit provides common tips for troubleshooting your queries.

## Optimize CodeQL analysis runtimes

There are several reasons why your CodeQL analysis may be taking too long to complete:

- If you use self-hosted runners for CodeQL analysis, you can increase the memory or the number of cores.
- Problems can also occur when a repository contains multiple languages. The analysis of each language runs in parallel with the default CodeQL analysis workflow in order to build a matrix of languages. You can modify your workflow to use a matrix that speeds up the analysis of multiple languages.
- The amount of code being analyzed may cause long runtimes. Analysis time is typically proportional to the amount of code being analyzed. You can reduce the size of the code by excluding test code or breaking the code into multiple workflows to only analyze a subset with each scan.
- You may want to only trigger analysis on the `schedule` event if your analysis is too slow while running during `push` or `pull_request` events.

## Analysis still failing on the default branch

If the CodeQL analysis workflow still fails on a commit made on the default branch, check the following items:

- Whether Dependabot authored the commit
- Whether the pull request that includes the commit has been merged using `@dependabot squash and merge`

This type of merge commit is authored by Dependabot. Therefore, any workflows running on the commit will have read-only permissions. Avoid using the Dependabot `@dependabot squash and merge` command if you enabled code scanning and Dependabot security updates or version updates on your repository.

Instead, you can enable auto-merge for your repository. This means that pull requests will be automatically merged when all required reviews are met and status checks have passed.

## Best practices

The following are best practices for optimizing your CodeQL queries:

### Eliminate cartesian products

Another issue that may be affecting performance is that you are receiving too many results. You can often determine the performance of a predicate by considering roughly how many results it has. One way of creating badly performing predicates is by using two variables without relating them in any way. Another is by only relating them using a negation. This leads to computing the Cartesian product between the sets of possible values for each variable. This potentially generates a huge table of results, which can occur if you don’t specify restrictions on your variables. The Cartesian product of two sets A and B, denoted A × B, is the set of all ordered pairs (a, b) where a is in A and b is in B.

Here's an example that could return many results:
>
```
predicate mayAccess(Method m, Field f) {
  f.getAnAccess().getEnclosingCallable() = m
  or
  not exists(m.getBody())
}
```
The predicate holds if `m` contains an access to `f`. But, also conservatively assumes that methods without bodies (for example, native methods) may access *any* field. However, if `m` is a native method, the table computed by `mayAccess` will contain a row `m, f` for all fields `f` in the codebase, making it potentially very large.

### Use specific types

"Types" provide an upper bound on the *size* of a relation. This helps the query optimizer be more effective, so it's generally good to use the most specific types possible.

For example, `predicate *foo*(LoggingCall e)` is preferred over `predicate *foo*(Expr e)`

From the type context, the query optimizer deduces that some parts of the query are redundant and removes or *specializes* them.

### Determine the most specific types of a variable

You can use CodeQL to determine what types an entity has if you're unfamiliar with the library used in a query. The predicate `getAQlClass()` returns the most specific QL types of the entity that it's called on.

>
```
import java
from Expr e, Callable c
where
c.getDeclaringType().hasQualifiedName("my.namespace.name", "MyClass")
and c.getName() = "c"
and e.getEnclosingCallable() = c
select e, e.getAQlClass()
```

The result of this query is a list of the most specific types of every `Expr` in that function. You will see multiple results for expressions that are represented by more than one type, so it will likely return a very large table of results.

Use `getAQlClass()` as a debugging tool. However, this tool also slows down performance so don't include it in the final version of your query.

### Avoid complex recursion

"Recursion" is about self-referencing definitions. This is extremely powerful when used appropriately. In order to do so, you should try to make recursive predicates as simple as possible. You should define a *base case* that allows the predicate to *bottom out*, along with a single *recursive call*.

>
```
int depth(Stmt s) {
  exists(Callable c | c.getBody() = s | result = 0) // base case
  or
  result = depth(s.getParent()) + 1 // recursive call
}
```

The query optimizer deduces that some parts of the query are redundant and removes, or specializes, them from the type context. The query optimizer has special data structures for dealing with transitive closures. If possible, use a transitive closure over a simple recursive predicate, as it is likely to be computed faster.

### Fold predicates

Sometimes you can assist the query optimizer by "folding" parts of the larger predicates out into smaller parts.

There are two general principles to split off chunks of work:

- **linear**, prevents too much branching
- **tightly bound**, the chunks join with each other on as many variables as possible

Here is an example, with some lookups on two `Elements`:
>
```
predicate similar(Element e1, Element e2) {
  e1.getName() = e2.getName() and
  e1.getFile() = e2.getFile() and
  e1.getLocation().getStartLine() = e2.getLocation().getStartLine()
}
```

Going from `Element -> File` and `Element -> Location -> StartLine` is linear. That is, there is only one `File`, `Location`, etc. for each `Element`.

### Debug data-flow queries using partial flow

You can use partial flow to debug the problem if a data-flow query doesn't produce the results you expect. You can also use data flow analysis to compute the possible values that a variable can hold at various points in a program in CodeQL.

Here is an example of a typical data-flow query:

>
```
class MyConfig extends TaintTracking::Configuration {
  MyConfig() { this = "MyConfig" }
override predicate isSource(DataFlow::Node node) { node instanceof MySource }

override predicate isSink(DataFlow::Node node) { node instanceof MySink }
}

from MyConfig config, DataFlow::PathNode source, DataFlow::PathNode sink
where config.hasFlowPath(source, sink)
select sink.getNode(), source, sink, "Sink is reached from $@.", source.getNode(), "here"
```

If a data-flow query that you have written doesn’t produce the results you expect, you can debug it by following the steps described below: 

- Checking sources and sinks
- Checking the `fieldFlowBranchLimit`: this gets the virtual dispatch branching limit when calculating field flow. This can be overridden to a smaller value to improve performance (a value of 0 disables field flow), or a larger value to get more results
- Partial flow: you can use partial flow to debug the problem if a data-flow query doesn’t produce the results you expect to see

### Debug artifacts

Additionally, you can obtain artifacts to help you debug CodeQL. The data contains the CodeQL logs, CodeQL database(s), and any SARIF file(s) produced by the workflow. The debug artifacts are uploaded to the workflow run as an artifact named `debug-artifacts`. Modify the `init` step of your CodeQL workflow file and set `debug: true`. These artifacts help you debug problems with CodeQL code scanning.

## Troubleshoot CodeQL for Visual Studio Code

The Visual Studio extension log files have detailed information to help you troubleshoot.

Progress and error messages are displayed as notifications in the bottom right corner of the workspace. You can use the dropdown list to select the logs you need.

:::image type="content" source="../media/log-files.png" alt-text="Screenshot showing how to select the logs in the Output view." border="false":::

## Common error messages

You will need to be familiar with some common error messages in order to troubleshoot your CodeQL workflow.

### Error: "Server error"

Try running the workflow again if the run of a workflow for code scanning fails due to a server error.

### Error: "Out of disk" or "Out of memory"

CodeQL may run out of disk or memory on the runner for very large projects. Contact GitHub Support so that we can investigate this type of issue on a hosted GitHub Actions runner.

### Error: 403 "Resource not accessible by integration" when using Dependabot

Dependabot is considered untrusted when it triggers a workflow run. The workflow will run with read-only scopes. Uploading code scanning results for a branch usually requires the `security_events: write scope`. However, code scanning always allows the uploading of results when the `pull_request` event triggers the action run. We recommend for Dependabot branches that you use the `pull_request` event instead of the `push` event.

A simple approach is to run on pushes to the default branch and any other important long-running branches, as well as pull requests opened against this set of branches. 

Here is an example:
>
```
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
```
### Warning: "git checkout HEAD^2 is no longer necessary"

If you're using an old CodeQL workflow you may get the following warning in the output from the "Initialize CodeQL" action:
>
```
Warning: 1 issue was detected with this workflow: git checkout HEAD^2 is 
no longer necessary. Please remove this step as Code Scanning recommends 
analyzing the merge commit for best results.
```

Here's an example of how to fix this issue by removing the following lines from the CodeQL workflow. These lines were included in the `steps` section of the `Analyze` job in initial versions of the CodeQL workflow.
>
```
        with:
          # We must fetch at least the immediate parents so that if this is
          # a pull request then we can checkout the head.
          fetch-depth: 2

      # If this run was triggered by a pull request event, then checkout
      # the head of the pull request instead of the merge commit.
      - run: git checkout HEAD^2
        if: ${{ github.event_name == 'pull_request' }}
```

The revised `steps` section of the workflow will look like this:
>
```
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      # Initializes the CodeQL tools for scanning.
      - name: Initialize CodeQL
        uses: github/codeql-action/init@v1

      ...
`
```

## Important points about CodeQL and the QL language

Here are some things to keep in mind when using CodeQL and the QL language. 

- CodeQL predicates and classes are evaluated to database tables.
- Large predicates generate large tables with many rows, and are therefore expensive to compute
- The QL language is implemented using standard database operations and relational algebra, such as join, projection, and union.
- Queries are evaluated *bottom-up*, which means that a predicate is not evaluated until *all* of the predicates that it depends on are evaluated.

## Analysis of Python code 

You may see different results depending on whether you run the CodeQL analysis workflow on Linux, macOS, or Windows, or if you're analyzing code written in Python.

The CodeQL analysis workflow tries to install and analyze Python dependencies, which could lead to more results on GitHub-hosted runners that use Linux. To disable the auto-install, add `setup-python-dependencies: false` to the "Initialize CodeQL" step of the workflow.

