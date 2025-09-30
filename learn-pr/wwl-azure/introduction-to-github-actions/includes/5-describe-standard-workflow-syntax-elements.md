GitHub Actions workflows use YAML syntax with specific elements that define when, where, and how your automation runs. Understanding these core syntax elements is essential for creating effective workflows.

## Essential workflow elements

### Top-level workflow configuration

```yaml
name: CI/CD Pipeline # Workflow name (optional but recommended)
on: # Event triggers
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]
  schedule:
    - cron: "0 2 * * 1" # Weekly Monday 2 AM UTC

jobs:# Job definitions
  # Job configurations go here
```

### Core syntax elements explained

| Element   | Purpose                               | Required     | Example                     |
| --------- | ------------------------------------- | ------------ | --------------------------- |
| `name`    | Workflow display name in GitHub UI    | Optional     | `name: "Build and Test"`    |
| `on`      | Event triggers for workflow execution | **Required** | `on: [push, pull_request]`  |
| `jobs`    | Collection of jobs to execute         | **Required** | `jobs: build: ...`          |
| `runs-on` | Specifies runner environment          | **Required** | `runs-on: ubuntu-latest`    |
| `steps`   | Sequential actions within a job       | **Required** | `steps: - name: ...`        |
| `uses`    | References pre-built actions          | Optional     | `uses: actions/checkout@v4` |
| `run`     | Executes shell commands               | Optional     | `run: npm test`             |

## Complete workflow example

```yaml
name: Node.js CI/CD Pipeline

# Event configuration
on:
  push:
    branches: [main, develop]
    paths-ignore: ["docs/**", "*.md"]
  pull_request:
    branches: [main]
    types: [opened, synchronize, reopened]

# Environment variables (workflow-level)
env:
  NODE_VERSION: "20"
  CI: true

# Job definitions
jobs:
  # Test job
  test:
    name: Run Tests
    runs-on: ubuntu-latest

    # Job-level environment variables
    env:
      DATABASE_URL: ${{ secrets.TEST_DATABASE_URL }}

    # Job steps
    steps:
      - name: Check out code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: "npm"

      - name: Install dependencies
        run: |
          npm ci
          npm audit --audit-level=high

      - name: Run tests
        run: |
          npm run test:coverage
          npm run test:integration
        env:
          NODE_ENV: test

      - name: Upload coverage reports
        uses: actions/upload-artifact@v4
        if: always()
        with:
          name: coverage-reports
          path: coverage/
          retention-days: 30

  # Build job (depends on test)
  build:
    name: Build Application
    needs: test
    runs-on: ubuntu-latest

    outputs:
      build-version: ${{ steps.version.outputs.version }}

    steps:
      - uses: actions/checkout@v4

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: "npm"

      - name: Install and build
        run: |
          npm ci --production
          npm run build

      - name: Generate version
        id: version
        run: |
          VERSION=$(date +%Y%m%d)-${GITHUB_SHA::8}
          echo "version=$VERSION" >> $GITHUB_OUTPUT

      - name: Save build artifacts
        uses: actions/upload-artifact@v4
        with:
          name: build-${{ steps.version.outputs.version }}
          path: |
            dist/
            package.json
```

## Advanced syntax elements

### Conditional execution

```yaml
steps:
  - name: Deploy to production
    if: github.ref == 'refs/heads/main' && success()
    run: ./deploy.sh

  - name: Notify on failure
    if: failure()
    run: ./notify-failure.sh
```

### Matrix strategies

```yaml
jobs:
  test:
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node-version: [18, 20, 22]
        include:
          - os: ubuntu-latest
            node-version: 22
            experimental: true
      fail-fast: false
    runs-on: ${{ matrix.os }}
```

### Reusable workflows

```yaml
jobs:
  call-reusable-workflow:
    uses: ./.github/workflows/reusable-tests.yml
    with:
      environment: production
      node-version: "20"
    secrets:
      DATABASE_URL: ${{ secrets.DATABASE_URL }}
```

## Best practices for workflow syntax

### Structure and organization

- Use descriptive names for workflows, jobs, and steps
- Group related steps logically within jobs
- Keep workflows focused on specific purposes (CI, CD, maintenance)

### Efficiency optimization

- Use `paths` and `paths-ignore` to limit unnecessary runs
- Cache dependencies with `actions/cache` or built-in caching
- Run independent jobs in parallel

### Security considerations

```yaml
permissions:
  contents: read
  security-events: write
  pull-requests: write

env:
  # Use secrets for sensitive data
  API_KEY: ${{ secrets.API_KEY }}
  # Use variables for non-sensitive configuration
  ENVIRONMENT: ${{ vars.ENVIRONMENT }}
```

### Error handling and debugging

```yaml
steps:
  - name: Debug information
    if: env.ACTIONS_STEP_DEBUG == 'true'
    run: |
      echo "Runner OS: $RUNNER_OS"
      echo "Workflow: $GITHUB_WORKFLOW"
      echo "Event: $GITHUB_EVENT_NAME"
```

For comprehensive syntax documentation, see the official [Workflow syntax for GitHub Actions](https://docs.github.com/actions/learn-github-actions/workflow-syntax-for-github-actions) reference.
