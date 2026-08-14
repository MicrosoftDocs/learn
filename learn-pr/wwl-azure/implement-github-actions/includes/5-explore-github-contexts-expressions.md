Contexts are a way to access information about workflow runs, variables, runner environments, jobs, and steps. Each context is an object that contains properties, which can be strings or other objects.

You can access contexts using the expression syntax. An expression can be any combination of literal values, references to a context, or functions. You can combine literals, context references, and functions using operators.

## Contexts

When creating workflows and actions, treat context values that can contain user-controlled data as untrusted input. An attacker can insert malicious content into some contexts, so validate or safely handle those values before using them in commands. For more information, visit [Security hardening for GitHub Actions](https://docs.github.com/actions/security-guides/security-hardening-for-github-actions#understanding-the-risk-of-script-injections).

The following table contains examples of contexts available in GitHub. It isn't a complete list.

| Context name | Type     | Description |
| --- | --- | --- |
| `github` | `object` | Information about the workflow run. |
| `env` | `object` | Contains variables set in a workflow, job, or step. |
| `vars` | `object` | Contains variables set at the repository, organization, or environment levels. |
| `job` | `object` | Information about the currently running job. |

> [!TIP]
> For a complete listing of contexts, visit [About contexts](https://docs.github.com/actions/learn-github-actions/contexts#about-contexts).

### Choose when to use contexts

GitHub Actions include two collections of variables called *default variables* and *contexts*. These variables are intended for use at different points in the workflow:

* **Default environment variables:** These environment variables exist only on the runner that's executing your job.
* **Contexts:** You can use most contexts at any point in your workflow, including when *default variables* would be unavailable.

In the following example, the `if` statement checks the `github.ref` context to determine the current branch name. GitHub evaluates the `if` check and sends the job to the runner only when the result is `true`. After the runner receives the job, the step executes and refers to the `$GITHUB_REF` variable.

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

The following table contains the available top-level contexts, a brief description, and a link to more information about each object's properties. You can use the linked references to identify the properties available at each point in a workflow.

| Top-level context | Description  | Properties and examples |
| --- | --- | --- |
| `github` | The top-level context available during any job or step in a workflow.  | [Properties of the `github` context.](https://docs.github.com/actions/learn-github-actions/contexts#github-context)     |
| `env` | Contains variables set in a workflow, job, or step. It doesn't contain variables inherited by the runner process. | [Properties of the `env` context.](https://docs.github.com/actions/learn-github-actions/contexts#env-context) |
| `vars` | Contains custom configuration variables set at the organization, repository, and environment levels.  | [Examples of `vars` usage.](https://docs.github.com/actions/learn-github-actions/contexts#vars-context)                 |
| `job`             | Contains information about the currently running job. | [Properties of the `job` context.](https://docs.github.com/actions/learn-github-actions/contexts#job-context) |
| `jobs` | Only available in reusable workflows, and can only be used to set outputs for a reusable workflow. | [Properties of the `jobs` context.](https://docs.github.com/actions/learn-github-actions/contexts#jobs-context) |
| `steps` | Contains information about the completed steps in the current job that have an `id` specified.                    | [Properties of the `steps` context.](https://docs.github.com/actions/learn-github-actions/contexts#steps-context)       |
| `runner` | Contains information about the runner that's executing the current job. | [Properties of the `runner` context.](https://docs.github.com/actions/learn-github-actions/contexts#runner-context) |
| `secrets` | Contains the names and values of secrets that are available to a workflow run. | [Properties of the `secrets` context.](https://docs.github.com/actions/learn-github-actions/contexts#secrets-context) |
| `strategy` | Contains information about the matrix execution strategy for the current job. | [Properties of the `strategy` context.](https://docs.github.com/actions/learn-github-actions/contexts#strategy-context) |
| `matrix` | Contains the matrix properties defined in the workflow file that apply to the current job. | [Properties of the `matrix` context.](https://docs.github.com/actions/learn-github-actions/contexts#matrix-context) |
| `needs` | Contains outputs from all jobs that are defined as a direct dependency of the current job. | [Properties of the `matrix` context.](https://docs.github.com/actions/learn-github-actions/contexts#needs-context) |
| `inputs` | Contains input properties passed to an action, to a reusable workflow, or to a manually triggered workflow. | [Properties of the `inputs` context.](https://docs.github.com/actions/learn-github-actions/contexts#inputs-context) |

## Expressions

You can use expressions to programmatically set environment variables in workflow files and access contexts. An expression can be any combination of literal values, references to a context, or functions. You can combine literals, context references, and functions using operators.

Expressions are commonly used with the conditional `if` keyword in a workflow file to determine whether a step should run. When an `if` conditional is `true`, the step runs.

You can use the `${{ <expression> }}` syntax to tell GitHub to evaluate an expression rather than treat it as a string. In an `if` clause, you can usually omit the `${{` and `}}` delimiters because GitHub automatically evaluates the conditional expression.

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

* **Logical operators:**
    * `&&` (and): Combines two conditions, both of which must be true for the overall expression to evaluate as true.
    * `||` (or): Combines two conditions, and the expression evaluates as true if either condition is true.
    * `!` (not): Negates a condition, flipping its truth value.

* **Equality operators:**
    * `==` (equal): Compares two values for equality.
    * `!=` (not equal): Checks if two values aren't equal.

* **Comparison operators:**
    * `<` (less than)
    * `>` (greater than)
    * `<=` (less than or equal to)
    * `>=` (greater than or equal to)

These operators allow you to create dynamic workflows by determining when specific steps run based on conditions. You can use expression syntax such as `${{ <expression> }}` to ensure that GitHub evaluates the value.

For more information on operators, visit [Operators](https://docs.github.com/actions/learn-github-actions/expressions#operators).
