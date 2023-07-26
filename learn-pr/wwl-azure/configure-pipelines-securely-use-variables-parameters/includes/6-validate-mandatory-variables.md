In YAML pipelines, variables store and retrieve values during pipeline runs. Ensuring all the required variables are present and set correctly is essential to ensure pipeline security. 

In this unit, learn how to validate mandatory variables in Azure DevOps YAML pipelines.

## Define mandatory and validate mandatory variables

One way to validate mandatory variables is by using the assert expression function in YAML to validate required variables. The assert function allows us to check if a condition is true or false and return an error message if the condition is false. We can use the assert function to validate that the mandatory variables are present and set correctly.

Here's an example of how to validate a mandatory variable named 'myVariable':

```YAML

variables:
- name: myVariable
  value: ''

steps:
- script: echo 'Validate required variable!'
  condition: eq(variables['myVariable'], 'myRequiredValue')

```

The variable 'myVariable' is set to an empty string in this example. The condition expression checks if the variable is equal to 'myRequiredValue'. The script task won't be executed if the variable isn't set to this value.

**output:**
Evaluating: `eq(variables['myVariable'], 'myRequiredValue')`
Expanded: `eq('', 'myRequiredValue')`
Result: False

You can also configure your pipeline to fail if the variable isn't set correctly (false).

## Challenge yourself

Create a YAML pipeline that validates the presence and correctness of the mandatory variables 'myVariable1' and 'myVariable2'. If either variable is missing or not set correctly, the pipeline should fail. Use the assert function to validate the variables.

For more information about expressions, see [Expressions.](https://learn.microsoft.com/azure/devops/pipelines/security/overview/)
