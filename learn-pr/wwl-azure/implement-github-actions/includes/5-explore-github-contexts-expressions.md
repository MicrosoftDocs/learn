Contexts are a way to access information about workflow runs, variables, runner environments, jobs, and steps. Each context is an object that contains properties, which can be strings or other objects.

You can access contexts using the expression syntax. An expression can be any combination of literal values, references to a context, or functions. You can combine literals, context references, and functions using operators.

## Contexts

When creating workflows and actions, you should always consider whether your code might execute untrusted input from possible attackers. Certain contexts should be treated as untrusted input, as an attacker could insert their own malicious content. For more information, visit [Security hardening for GitHub Actions](https://docs.github.com/actions/security-guides/security-hardening-for-github-actions#understanding-the-risk-of-script-injections)."

The following table contains examples of contexts available in GitHub, it's not a complete listing.

| Context name | Type     | Description |
| --- | --- | --- |
| `github` | `object` | Information about the workflow run. |
| `env` | `object` | Contains variables set in a workflow, job, or step. |
| `vars` | `object` | Contains variables set at the repository, organization, or environment levels. |
| `job` | `object` | Information about the currently running job. |

> [!TIP]
> For a complete listing of contexts, visit [About contexts](https://docs.github.com/actions/learn-github-actions/contexts#about-contexts).

### Determining when to use contexts

GitHub Actions include two collections of variables called *default variables* and *contexts*. These variables are intended for use at different points in the workflow:

* **Default environment variables**: These environment variables exist only on the runner that is executing your job.
* **Contexts**: You can use most contexts at any point in your workflow, including when *default variables* would be unavailable.

In the following example, the `if` statement checks the `github.ref` context to determine the current branch name. The `if` check is processed, and the job is only sent to the runner if the result is `true`. Once the job is sent to the runner, the step is executed and refers to the `$GITHUB_REF` variable from the runner.

```yml
name: CI
on: push
jobs:
  prod-check:
    if: ${{ github.ref == 'refs/heads/main' }}
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploying to production server on branch $GITHUB_REF"
```

### Contexts available in GitHub Actions

The following table contains the available top-level contexts, a brief description, and a link to more information on the object's properties.

| Top-level context | Description  | Properties and examples |
| --- | --- | --- |
| `github` | The top-level context available during any job or step in a workflow.  | [Properties of the `github` context.](https://docs.github.com/actions/learn-github-actions/contexts#github-context)     |
| `env` | Contains variables set in a workflow, job, or step. It doesn't contain variables inherited by the runner process. | [Properties of the `env` context.](https://docs.github.com/actions/learn-github-actions/contexts#env-context) |
| `vars` | Contains custom configuration variables set at the organization, repository, and environment levels.  | [Examples of `vars` usage.](https://docs.github.com/actions/learn-github-actions/contexts#vars-context)                 |
| `job`             | Contains information about the currently running job. | [Properties of the `job` context.](https://docs.github.com/actions/learn-github-actions/contexts#job-context) |
| `jobs` | Only available in reusable workflows, and can only be used to set outputs for a reusable workflow. | [Properties of the `jobs` context.](https://docs.github.com/actions/learn-github-actions/contexts#jobs-context) |
| `steps` | Contains information about the completed steps in the current job that have an `id` specified.                    | [Properties of the `steps` context.](https://docs.github.com/actions/learn-github-actions/contexts#steps-context)       |
| `runner` | Contains information about the runner that is executing the current job. | [Properties of the `runner` context.](https://docs.github.com/actions/learn-github-actions/contexts#runner-context) |
| `secrets` | Contains the names and values of secrets that are available to a workflow run. | [Properties of the `secrets` context.](https://docs.github.com/actions/learn-github-actions/contexts#secrets-context) |
| `strategy` | Contains information about the matrix execution strategy for the current job. | [Properties of the `strategy` context.](https://docs.github.com/actions/learn-github-actions/contexts#strategy-context) |
| `matrix` | Contains the matrix properties defined in the workflow file that apply to the current job. | [Properties of the `matrix` context.](https://docs.github.com/actions/learn-github-actions/contexts#matrix-context) |
| `needs` | Contains outputs from all jobs that are defined as a direct dependency of the current job. | [Properties of the `matrix` context.](https://docs.github.com/actions/learn-github-actions/contexts#needs-context) |
| `inputs` | Contains input properties passed to an action, to a reusable workflow, or to a manually triggered workflow. | [Properties of the `inputs` context.](https://docs.github.com/actions/learn-github-actions/contexts#inputs-context) |

## Expressions

You can use expressions to programmatically set environment variables in workflow files and access contexts. An expression can be any combination of literal values, references to a context, or functions. You can combine literals, context references, and functions using operators.

Expressions are commonly used with the conditional `if` keyword in a workflow file to determine whether a step should run. When an `if` conditional is `true`, the step runs.

You need to use specific syntax, `${{ <expression> }}`, to tell GitHub to evaluate an expression rather than treat it as a string. The exception to this rule is when you're using expressions in an `if` clause, where they can usually be omitted `${{` and `}}`.

The following code sample shows setting an environment variable.

```yml
env:
  MY_ENV_VAR: ${{ <expression> }}
```

### Literals

As part of an expression, you can use `boolean`, `null`, `number`, or `string` data types. In conditionals, falsy values (`false`, `0`, `-0`, `""`, `''`, `null`) are coerced to `false` and truthy (`true` and other non-falsy values) are coerced to `true`. The following shows examples of implementing literals.

```yml
env:
  myNull: ${{ null }}
  myBoolean: ${{ false }}
  myIntegerNumber: ${{ 711 }}
  myFloatNumber: ${{ -9.2 }}
  myHexNumber: ${{ 0xff }}
  myExponentialNumber: ${{ -2.99e-2 }}
  myString: Mona the Octocat
  myStringInBraces: ${{ 'It''s open source!' }}
```

### Operators

Operators play a crucial role in evaluating expressions. An expression can consist of literal values, references to contexts, or functions. Operators allow you to combine these elements to create more complex expressions. Here are some key operators:

* **Logical Operators**:
  * `&&` (and): Combines two conditions, both of which must be true for the overall expression to evaluate as true.
  * `||` (or): Combines two conditions, and the expression evaluates as true if either condition is true.
  * `!` (not): Negates a condition, flipping its truth value.

* **Equality Operators**:
  * `==` (equal): Compares two values for equality.
  * `!=` (not equal): Checks if two values aren't equal.

* **Comparison Operators**:
  * `<` (less than)
  * `>` (greater than)
  * `<=` (less than or equal to)
  * `>=` (greater than or equal to)

These operators allow you to create dynamic workflows by determining when specific steps should run based on conditions. Remember to use the correct syntax for expressions, such as `$\{\{ <expression> \}\}$`, to ensure proper evaluation.

For more information on operators, visit [Operators](https://docs.github.com/actions/learn-github-actions/expressions#operators).
