Workflows define the automation required. It details the events that should trigger the workflow.

Also, define the jobs that should run when the workflow is triggered.

The job defines the location in which the actions will run, like which runner to use.

Workflows are written in YAML and live within a GitHub repository at the place **.github/workflows.**

Example workflow:

```YAML
# .github/workflows/build.yml
name: Node Build.

on: [push]

jobs:
    mainbuild:
 
        runs-on: ${{ matrix.os }}
     
    strategy:
        matrix:
            node-version: [12.x]
            os: [windows-latest]
         
    steps:

    - uses: actions/checkout@v1
    - name: Run node.js on latest Windows.
      uses: actions/setup-node@v1
      with:
        node-version: ${{ matrix.node-version }}

    - name: Install NPM and build.
      run: |
        npm ci
        npm run build

```

You can find a set of starter workflows here: [Starter Workflows](https://github.com/actions/starter-workflows).

You can see the allowable syntax for workflows here: [Workflow syntax for GitHub Actions](https://docs.github.com/actions/learn-github-actions/workflow-syntax-for-github-actions).
