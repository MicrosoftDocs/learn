Creating quality GitHub Actions requires following best practices for security, reliability, and usability.

## Design principles for quality actions

### Single responsibility principle

Design actions that do one thing well rather than trying to solve multiple problems:

```yaml
# DON'T: Monolithic action that does everything
name: 'Build-Test-Deploy-Notify Action'
description: 'Builds app, runs tests, deploys to cloud, and sends notifications'

# DO: Focused, composable actions
name: 'Setup Node.js with Cache'
description: 'Sets up Node.js with intelligent dependency caching'
```

**Benefits of focused actions:**

- Easier to understand, test, and maintain
- Reusable across different workflow scenarios
- Simpler debugging when issues arise
- Better composability in complex workflows

### Composable and chainable design

Create actions that work well together in workflow sequences:

```yaml
# Example of well-designed action chain
steps:
  - name: Checkout code
    uses: actions/checkout@v4

  - name: Setup Node.js with cache
    uses: myorg/setup-node-with-cache@v2
    with:
      node-version: "20"

  - name: Run security audit
    uses: myorg/security-audit@v1

  - name: Build and test
    uses: myorg/build-and-test@v3
    with:
      test-command: "npm test"

  - name: Upload coverage
    uses: myorg/upload-coverage@v1
    with:
      coverage-file: "coverage/lcov.info"
```

## Action metadata and documentation

### Complete action.yml specification

```yaml
name: "Secure Docker Build"
description: "Build and scan Docker images with security best practices"
author: "DevSecOps Team <team@company.com>"

# Visual identity in marketplace
branding:
  icon: "shield"
  color: "blue"

# Clear input definition
inputs:
  dockerfile-path:
    description: "Path to the Dockerfile"
    required: true
    default: "./Dockerfile"
  image-name:
    description: "Name for the built image"
    required: true
  registry-url:
    description: "Container registry URL"
    required: false
    default: "ghcr.io"
  security-scan:
    description: "Enable security vulnerability scanning"
    required: false
    default: "true"
  scan-severity:
    description: "Minimum severity level for scan failures"
    required: false
    default: "HIGH"

# Expected outputs
outputs:
  image-digest:
    description: "SHA256 digest of the built image"
  security-report:
    description: "Path to security scan report"
  image-size:
    description: "Size of the built image in bytes"

runs:
  using: "composite"
  steps:
    - name: Build Docker image
      shell: bash
      run: |
        docker build -f ${{ inputs.dockerfile-path }} -t ${{ inputs.image-name }} .
        echo "image-digest=$(docker inspect --format='{{index .RepoDigests 0}}' ${{ inputs.image-name }})" >> $GITHUB_OUTPUT

    - name: Security scan
      if: inputs.security-scan == 'true'
      shell: bash
      run: |
        # Security scanning logic
        trivy image --severity ${{ inputs.scan-severity }} ${{ inputs.image-name }}
```

### Complete README documentation

````markdown
# Secure Docker Build Action

Build and scan Docker images with integrated security best practices.

## Features

- Flexible Dockerfile path configuration
- Integrated security vulnerability scanning
- Detailed build and security reports
- Optimized for CI/CD pipelines
- Security-first design

## Usage

### Basic usage

```yaml
- name: Build and scan Docker image
  uses: myorg/secure-docker-build@v2
  with:
    dockerfile-path: "./Dockerfile"
    image-name: "my-app:latest"
```
````

### Advanced configuration

```yaml
- name: Build with custom security settings
  uses: myorg/secure-docker-build@v2
  with:
    dockerfile-path: "./docker/Dockerfile.prod"
    image-name: "my-app:${{ github.sha }}"
    registry-url: "myregistry.azurecr.io"
    security-scan: "true"
    scan-severity: "MEDIUM"
```

## Inputs

| Input             | Description                   | Required | Default        |
| ----------------- | ----------------------------- | -------- | -------------- |
| `dockerfile-path` | Path to Dockerfile            | Yes      | `./Dockerfile` |
| `image-name`      | Docker image name             | Yes      | -              |
| `registry-url`    | Container registry            | No       | `ghcr.io`      |
| `security-scan`   | Enable security scanning      | No       | `true`         |
| `scan-severity`   | Minimum severity for failures | No       | `HIGH`         |

## Outputs

| Output            | Description                  |
| ----------------- | ---------------------------- |
| `image-digest`    | SHA256 digest of built image |
| `security-report` | Path to security scan report |
| `image-size`      | Size of built image in bytes |

## Security Considerations

This action implements security best practices:

- Vulnerability scanning with Trivy
- Non-root container execution
- Minimal base image recommendations
- Security report generation

````

## Version management and release strategy

### Semantic versioning implementation

```bash
# Release tagging strategy
git tag -a v1.0.0 -m "Initial stable release"
git tag -a v1.0.1 -m "Bug fix: Handle empty Dockerfile paths"
git tag -a v1.1.0 -m "Feature: Add multi-arch build support"
git tag -a v2.0.0 -m "Breaking: Change input parameter names"

# Major version tags for easy consumption
git tag -f v1 v1.1.0  # Point v1 to latest v1.x.x
git tag -f v2 v2.0.0  # Point v2 to latest v2.x.x
````

### Release automation workflow

```yaml
name: Release Action

on:
  release:
    types: [published]

jobs:
  tag-major-version:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Update major version tag
        run: |
          TAG=${GITHUB_REF#refs/tags/}
          MAJOR_VERSION=$(echo $TAG | cut -d. -f1)

          git config user.name "Release Bot"
          git config user.email "release@company.com"

          git tag -fa $MAJOR_VERSION -m "Point $MAJOR_VERSION to $TAG"
          git push origin $MAJOR_VERSION --force
```

## Security best practices for actions

### Input validation and sanitization

```yaml
# In action.yml
inputs:
  file-path:
    description: "Path to file"
    required: true

runs:
  using: "composite"
  steps:
    - name: Validate inputs
      shell: bash
      run: |
        # Validate file path to prevent directory traversal
        FILE_PATH="${{ inputs.file-path }}"

        # Check for dangerous characters
        if [[ "$FILE_PATH" =~ \.\. ]]; then
          echo "Invalid file path: contains '..' (directory traversal)"
          exit 1
        fi

        # Ensure path is within workspace
        REAL_PATH=$(realpath "$FILE_PATH" 2>/dev/null || echo "")
        WORKSPACE_PATH=$(realpath "$GITHUB_WORKSPACE")

        if [[ ! "$REAL_PATH" == "$WORKSPACE_PATH"* ]]; then
          echo "File path outside workspace: $FILE_PATH"
          exit 1
        fi

        echo "File path validated: $FILE_PATH"
```

### Secure secret handling

```yaml
# Proper secret usage in composite actions
- name: Use secrets securely
  shell: bash
  env:
    # Pass secrets through environment variables
    API_TOKEN: ${{ inputs.api-token }}
  run: |
    # Never log secrets
    echo "Authenticating with API..."

    # Use secrets in secure contexts
    curl -H "Authorization: Bearer $API_TOKEN" \
         -H "Content-Type: application/json" \
         https://api.example.com/data

    # Clean up sensitive data
    unset API_TOKEN
```

### Principle of least privilege

```yaml
# Define minimal permissions needed
permissions:
  contents: read
  security-events: write # Only if security scanning
  packages: write # Only if publishing packages

jobs:
  secure-action:
    runs-on: ubuntu-latest
    steps:
      - name: Minimal permission usage
        uses: myorg/secure-action@v2
        with:
          # Only pass necessary inputs
          required-input: "value"
```

## Performance and efficiency guidelines

### Efficient resource usage

```yaml
# Optimize action performance
runs:
  using: "composite"
  steps:
    - name: Cache dependencies
      uses: actions/cache@v4
      with:
        path: ~/.cache/my-tool
        key: ${{ runner.os }}-my-tool-${{ hashFiles('**/config.json') }}

    - name: Parallel processing where possible
      shell: bash
      run: |
        # Use background processes for independent tasks
        task1 &
        task2 &
        task3 &

        # Wait for all tasks to complete
        wait
```

### Container action optimization

```dockerfile
# Dockerfile for container actions
FROM node:20-alpine

# Create non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001

# Install only production dependencies
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# Copy application code
COPY . .

# Set proper ownership
RUN chown -R nextjs:nodejs /app
USER nextjs

ENTRYPOINT ["/entrypoint.sh"]
```

## Testing and quality assurance

### Action testing workflow

```yaml
name: Test Action

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test-action:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        test-case:
          - name: "Basic functionality"
            dockerfile-path: "./test/Dockerfile.basic"
            expected-outcome: "success"
          - name: "Security scan failure"
            dockerfile-path: "./test/Dockerfile.vulnerable"
            expected-outcome: "failure"
          - name: "Custom configuration"
            dockerfile-path: "./test/Dockerfile.custom"
            security-scan: "false"
            expected-outcome: "success"

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Test action
        id: test
        uses: ./ # Test local action
        with:
          dockerfile-path: ${{ matrix.test-case.dockerfile-path }}
          image-name: "test-image:latest"
          security-scan: ${{ matrix.test-case.security-scan || 'true' }}
        continue-on-error: ${{ matrix.test-case.expected-outcome == 'failure' }}

      - name: Validate outcome
        run: |
          if [[ "${{ steps.test.outcome }}" == "${{ matrix.test-case.expected-outcome }}" ]]; then
            echo "Test passed: ${{ matrix.test-case.name }}"
          else
            echo "Test failed: Expected ${{ matrix.test-case.expected-outcome }}, got ${{ steps.test.outcome }}"
            exit 1
          fi
```

## Marketplace and community guidelines

### Marketplace submission preparation

- **Clear naming**: Use descriptive, searchable names
- **Quality README**: Include usage examples, inputs/outputs documentation
- **Proper categorization**: Choose appropriate marketplace categories
- **Version stability**: Ensure release versions are stable and tested

### Community engagement

```yaml
# Include community templates
# .github/ISSUE_TEMPLATE/bug_report.yml
name: Bug Report
description: File a bug report for this action
body:
  - type: markdown
    attributes:
      value: |
        Thanks for taking the time to report a bug!

  - type: input
    id: action-version
    attributes:
      label: Action Version
      description: Which version of the action are you using?
      placeholder: v2.1.0
    validations:
      required: true

  - type: textarea
    id: workflow-snippet
    attributes:
      label: Workflow Configuration
      description: Share your workflow configuration
      render: yaml
    validations:
      required: true
```

Following these best practices ensures your GitHub Actions are professional, secure, maintainable, and valuable to the community. Focus on creating actions that solve real problems while being easy to use and understand.
