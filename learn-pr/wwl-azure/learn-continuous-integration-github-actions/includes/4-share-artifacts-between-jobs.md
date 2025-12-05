Artifacts enable you to share data between jobs in a workflow and preserve important files after a workflow completes. They're essential for building robust CI/CD pipelines that can pass build outputs, test results, and other files between different stages of your automation.

## Understanding artifacts in GitHub Actions

Artifacts are files or collections of files that you want to share between jobs or save from a workflow run. Common use cases include:

- **Build outputs**: Compiled applications, packages, or distribution files
- **Test results**: Coverage reports, test logs, or performance benchmarks
- **Documentation**: Generated API docs, deployment guides, or reports
- **Debug information**: Log files, crash dumps, or diagnostic data

### Artifact lifecycle and scope

**Storage duration**: Artifacts are stored temporarily (default: 90 days for public repos, 400 days for private)
**Accessibility**: Available to all jobs in the same workflow run
**Download access**: Accessible via GitHub UI, REST API, or CLI after workflow completion

## Uploading artifacts with upload-artifact

The `actions/upload-artifact` action provides flexible options for saving files from your workflow.

### Basic file upload

```yaml
steps:
  - name: Build application
    run: npm run build

  - name: Upload build artifacts
    uses: actions/upload-artifact@v4
    with:
      name: build-output
      path: dist/
```

### Advanced upload patterns

**Multiple specific files:**

```yaml
- name: Upload test results and logs
  uses: actions/upload-artifact@v4
  with:
    name: test-results
    path: |
      test-results.xml
      coverage/lcov.info
      logs/test.log
    retention-days: 30
```

**Wildcard patterns:**

```yaml
- name: Upload all logs
  uses: actions/upload-artifact@v4
  with:
    name: application-logs
    path: |
      logs/**/*.log
      reports/**/coverage.xml
      build/output/**/*.map
```

**Conditional upload with error handling:**

```yaml
- name: Upload artifacts even on failure
  uses: actions/upload-artifact@v4
  if: always() # Upload even if previous steps failed
  with:
    name: build-artifacts-${{ github.run_number }}
    path: |
      dist/
      !dist/**/*.map  # Exclude source maps
    retention-days: 7
    if-no-files-found: warn # Don't fail if no files found
```

## Downloading artifacts with download-artifact

The `actions/download-artifact` action retrieves artifacts uploaded by previous jobs.

### Basic artifact download

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Build application
        run: npm run build
      - name: Upload build
        uses: actions/upload-artifact@v4
        with:
          name: app-build
          path: dist/

  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Download build artifacts
        uses: actions/download-artifact@v4
        with:
          name: app-build
          path: ./deployment

      - name: Deploy application
        run: |
          ls -la ./deployment
          # Deploy files from ./deployment directory
```

### Advanced download scenarios

**Download all artifacts:**

```yaml
- name: Download all workflow artifacts
  uses: actions/download-artifact@v4
  # Downloads all artifacts to current directory
```

**Multiple artifact downloads:**

```yaml
- name: Download build and test artifacts
  uses: actions/download-artifact@v4
  with:
    pattern: build-* # Downloads all artifacts matching pattern
    path: ./artifacts
    merge-multiple: true # Merge into single directory
```

## Complete workflow example

Here's an example showing artifact usage across multiple jobs:

```yaml
name: Build, Test, and Deploy

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    name: Build Application
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: "20"
          cache: "npm"

      - name: Install dependencies
        run: npm ci

      - name: Build application
        run: |
          npm run build
          npm run build:docs

      - name: Upload build artifacts
        uses: actions/upload-artifact@v4
        with:
          name: build-${{ github.sha }}
          path: |
            dist/
            docs/build/
          retention-days: 30

      - name: Upload source maps separately
        uses: actions/upload-artifact@v4
        with:
          name: sourcemaps-${{ github.sha }}
          path: dist/**/*.map
          retention-days: 7

  test:
    name: Run Tests
    runs-on: ubuntu-latest
    needs: build

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: "20"
          cache: "npm"

      - name: Install dependencies
        run: npm ci

      - name: Download build artifacts
        uses: actions/download-artifact@v4
        with:
          name: build-${{ github.sha }}
          path: ./build-output

      - name: Run tests
        run: |
          npm test -- --coverage
          npm run test:e2e ./build-output/dist

      - name: Upload test results
        uses: actions/upload-artifact@v4
        if: always()
        with:
          name: test-results-${{ github.sha }}
          path: |
            coverage/
            test-results.xml
            screenshots/
          retention-days: 14

  security-scan:
    name: Security Scan
    runs-on: ubuntu-latest
    needs: build

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Download build artifacts
        uses: actions/download-artifact@v4
        with:
          name: build-${{ github.sha }}
          path: ./scan-target

      - name: Run security scan
        run: |
          # Example security scanning
          npm audit --json > audit-results.json

      - name: Upload security reports
        uses: actions/upload-artifact@v4
        with:
          name: security-report-${{ github.sha }}
          path: |
            audit-results.json
            security-scan-report.html
          retention-days: 90

  deploy:
    name: Deploy Application
    runs-on: ubuntu-latest
    needs: [build, test, security-scan]
    if: github.ref == 'refs/heads/main'

    steps:
      - name: Download build artifacts
        uses: actions/download-artifact@v4
        with:
          name: build-${{ github.sha }}
          path: ./deploy

      - name: Download test results
        uses: actions/download-artifact@v4
        with:
          name: test-results-${{ github.sha }}
          path: ./reports

      - name: Deploy to production
        run: |
          echo "Deploying files from ./deploy directory"
          ls -la ./deploy
          # Actual deployment commands here

      - name: Upload deployment logs
        uses: actions/upload-artifact@v4
        if: always()
        with:
          name: deployment-logs-${{ github.sha }}
          path: deployment.log
          retention-days: 30
```

## Best practices for artifact management

### Naming conventions

```yaml
# Use descriptive, unique names with context
name: build-${{ matrix.os }}-${{ github.sha }}
name: test-results-unit-${{ github.run_number }}
name: security-report-${{ github.ref_name }}
```

### Retention optimization

```yaml
# Match retention to artifact importance
- uses: actions/upload-artifact@v4
  with:
    name: critical-logs
    path: logs/
    retention-days: 90 # Long retention for important data

- uses: actions/upload-artifact@v4
  with:
    name: temp-build-cache
    path: .cache/
    retention-days: 1 # Short retention for temporary files
```

### Security considerations

```yaml
# Exclude sensitive files from artifacts
- uses: actions/upload-artifact@v4
  with:
    name: safe-build-output
    path: |
      dist/
      !dist/**/*.env      # Exclude environment files
      !dist/**/*secret*   # Exclude files with 'secret' in name
      !**/.env*           # Exclude all .env files
```

### Performance optimization

```yaml
# Compress large artifacts
- name: Compress large artifacts
  run: tar -czf logs.tar.gz logs/

- uses: actions/upload-artifact@v4
  with:
    name: compressed-logs
    path: logs.tar.gz
```

### Error handling

```yaml
- uses: actions/upload-artifact@v4
  with:
    name: build-output
    path: dist/
    if-no-files-found: error # Fail if no files found
    # Options: error, warn, ignore
```

## Artifact management and cleanup

### Programmatic artifact management

```yaml
- name: List and manage artifacts
  uses: actions/github-script@v7
  with:
    script: |
      // List artifacts for this repository
      const artifacts = await github.rest.actions.listArtifactsForRepo({
        owner: context.repo.owner,
        repo: context.repo.repo,
      });

      console.log(`Found ${artifacts.data.total_count} artifacts`);

      // Delete old artifacts (example logic)
      for (const artifact of artifacts.data.artifacts) {
        const age = Date.now() - new Date(artifact.created_at).getTime();
        const dayInMs = 24 * 60 * 60 * 1000;
        
        if (age > 7 * dayInMs) {  // Older than 7 days
          await github.rest.actions.deleteArtifact({
            owner: context.repo.owner,
            repo: context.repo.repo,
            artifact_id: artifact.id,
          });
          console.log(`Deleted artifact: ${artifact.name}`);
        }
      }
```

### Monitoring artifact usage

```yaml
- name: Check artifact storage usage
  run: |
    echo "Checking repository storage usage..."
    # Use GitHub CLI to check storage
    gh api repos/${{ github.repository }} --jq '.size'
```

Artifacts are useful for CI/CD workflows. Use them to pass data between jobs, preserve build outputs, and create automation pipelines.

For detailed documentation, see [Storing workflow data as artifacts](https://docs.github.com/actions/using-workflows/storing-workflow-data-as-artifacts).
