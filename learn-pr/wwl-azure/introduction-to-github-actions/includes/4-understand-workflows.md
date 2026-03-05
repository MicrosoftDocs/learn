Workflows are automated processes that you define to build, test, package, release, or deploy your project. They consist of one or more jobs that run in response to specific events in your repository.

## Workflow structure

Every workflow includes these key components:

### Triggers (Events)

Define when your workflow should run - on push, pull request, schedule, or manual trigger.

### Jobs

A set of steps that execute on the same runner. Jobs run in parallel by default but can be configured to run sequentially.

### Steps

Individual tasks within a job that can run commands, setup tasks, or use actions.

### Runners

The compute environment where your jobs execute - either GitHub-hosted or self-hosted.

## Workflow location and naming

Workflows are stored as YAML files in the `.github/workflows` directory of your repository. The filename becomes the workflow identifier in the GitHub UI.

## Modern workflow example

Here's a comprehensive example using current best practices:

```yaml
# .github/workflows/ci.yml
name: CI Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]
  schedule:
    - cron: "0 2 * * 0" # Weekly dependency check

env:
  NODE_VERSION: "20"

jobs:
  test:
    name: Test and Lint
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: "npm"

      - name: Install dependencies
        run: npm ci

      - name: Run linting
        run: npm run lint

      - name: Run tests with coverage
        run: npm run test:coverage

      - name: Upload coverage reports
        uses: codecov/codecov-action@v3
        with:
          token: ${{ secrets.CODECOV_TOKEN }}

  build:
    name: Build Application
    runs-on: ubuntu-latest
    needs: test

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: "npm"

      - name: Install dependencies
        run: npm ci

      - name: Build application
        run: npm run build

      - name: Upload build artifacts
        uses: actions/upload-artifact@v4
        with:
          name: build-files
          path: dist/
```

## Key improvements in modern workflows

This example demonstrates current best practices:

- **Latest action versions**: Using `@v4` versions of popular actions
- **Dependency caching**: Speeds up workflow execution
- **Environment variables**: Centralized configuration management
- **Job dependencies**: `build` job runs only after `test` succeeds
- **Artifact handling**: Proper storage and sharing of build outputs
- **Security**: Using secrets for sensitive data like tokens

## Additional resources

Explore these resources to enhance your workflow knowledge:

- [Starter Workflows](https://github.com/actions/starter-workflows) - Pre-built templates for common scenarios
- [Workflow Syntax Reference](https://docs.github.com/actions/using-workflows/workflow-syntax-for-github-actions) - Complete syntax documentation
- [Marketplace Actions](https://github.com/marketplace?type=actions) - Community-contributed actions
