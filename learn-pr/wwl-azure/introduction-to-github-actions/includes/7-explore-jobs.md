Workflows contain one or more jobs. A job is a set of steps that will be run in order on a runner.

Steps within a job execute on the same runner and share the same filesystem.

The logs produced by jobs are searchable, and artifacts produced can be saved.

## Jobs with dependencies

By default, if a workflow contains multiple jobs, they run in parallel.

```YAML
jobs:
  startup:
    runs-on: ubuntu-latest
    steps:

      - run: ./setup_server_configuration.sh
  build:
    steps:

      - run: ./build_new_server.sh

```

Sometimes you might need one job to wait for another job to complete.

You can do that by defining dependencies between the jobs.

```YAML
jobs:
  startup:
    runs-on: ubuntu-latest
    steps:

      - run: ./setup_server_configuration.sh
  build:
    needs: startup
    steps:

      - run: ./build_new_server.sh

```

> [!NOTE]
> If the startup job in the example above fails, the build job won't execute.

For more information on job dependencies, see the section **Creating Dependent Jobs** at [Managing complex workflows](https://docs.github.com/actions/learn-github-actions/managing-complex-workflows).
