Environment variables are essential for creating flexible and maintainable GitHub Actions workflows. They allow you to configure behavior, pass data between steps, and adapt workflows to different environments without hardcoding values.

## Understanding environment variables in GitHub Actions

Environment variables provide a way to store and access configuration data within your workflows. They can be set at different scopes and used throughout your automation pipeline for consistent and secure configuration management.

### Variable scopes and hierarchy

GitHub Actions supports environment variables at multiple levels:

**Workflow level**: Available to all jobs in the workflow
**Job level**: Available to all steps in a specific job  
**Step level**: Available only to that specific step

```yaml
name: Multi-level Environment Variables

# Workflow-level variables
env:
  NODE_VERSION: "20"
  BUILD_CONFIGURATION: "Release"

jobs:
  build:
    runs-on: ubuntu-latest

    # Job-level variables
    env:
      DATABASE_NAME: "production_db"
      API_TIMEOUT: "30000"

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}

      - name: Run tests with custom config
        run: npm test
        # Step-level variables
        env:
          TEST_ENVIRONMENT: "ci"
          LOG_LEVEL: "debug"
```

## Built-in GitHub environment variables

GitHub automatically provides numerous environment variables with information about the workflow context:

### Essential built-in variables

| Variable            | Description                                     | Example Value          |
| ------------------- | ----------------------------------------------- | ---------------------- |
| `GITHUB_WORKFLOW`   | Name of the workflow                            | `"CI Pipeline"`        |
| `GITHUB_ACTION`     | Unique identifier of the action                 | `"__actions_checkout"` |
| `GITHUB_REPOSITORY` | Repository name (owner/repo)                    | `"microsoft/vscode"`   |
| `GITHUB_REF`        | Branch or tag reference                         | `"refs/heads/main"`    |
| `GITHUB_SHA`        | Commit SHA that triggered the workflow          | `"ffac537e6cbb..."`    |
| `GITHUB_ACTOR`      | Username of the user who triggered the workflow | `"octocat"`            |
| `GITHUB_EVENT_NAME` | Event that triggered the workflow               | `"push"`               |
| `RUNNER_OS`         | Operating system of the runner                  | `"Linux"`              |

### Advanced built-in variables

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Display workflow context
        run: |
          echo "Workflow: $GITHUB_WORKFLOW"
          echo "Repository: $GITHUB_REPOSITORY"
          echo "Branch: ${GITHUB_REF#refs/heads/}"
          echo "Commit: $GITHUB_SHA"
          echo "Actor: $GITHUB_ACTOR"
          echo "Event: $GITHUB_EVENT_NAME"
          echo "Runner OS: $RUNNER_OS"
```

**Important naming rules:**

- Built-in variables use the `GITHUB_` prefix
- You cannot create custom variables with the `GITHUB_` prefix
- Variable names are case-sensitive in most contexts

## Practical environment variable patterns

### Configuration management

```yaml
name: Environment-specific Deployment

env:
  # Global configuration
  APP_NAME: "my-awesome-app"
  DOCKER_REGISTRY: "ghcr.io"

jobs:
  deploy-staging:
    if: github.ref == 'refs/heads/develop'
    runs-on: ubuntu-latest
    env:
      ENVIRONMENT: "staging"
      API_URL: "https://api.staging.example.com"
      DATABASE_TIER: "basic"
    steps:
      - name: Deploy to staging
        run: |
          echo "Deploying $APP_NAME to $ENVIRONMENT"
          echo "API URL: $API_URL"
          docker build -t $DOCKER_REGISTRY/$APP_NAME:$GITHUB_SHA .

  deploy-production:
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    env:
      ENVIRONMENT: "production"
      API_URL: "https://api.example.com"
      DATABASE_TIER: "premium"
    steps:
      - name: Deploy to production
        run: |
          echo "Deploying $APP_NAME to $ENVIRONMENT"
          echo "API URL: $API_URL"
          docker build -t $DOCKER_REGISTRY/$APP_NAME:latest .
```

### Dynamic variable creation

```yaml
steps:
  - name: Generate build metadata
    id: metadata
    run: |
      BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ')
      BUILD_NUMBER=$GITHUB_RUN_NUMBER
      VERSION_TAG=${GITHUB_REF#refs/tags/}

      echo "BUILD_DATE=$BUILD_DATE" >> $GITHUB_ENV
      echo "BUILD_NUMBER=$BUILD_NUMBER" >> $GITHUB_ENV
      echo "VERSION_TAG=$VERSION_TAG" >> $GITHUB_ENV

  - name: Use generated variables
    run: |
      echo "Build Date: $BUILD_DATE"
      echo "Build Number: $BUILD_NUMBER"
      echo "Version: $VERSION_TAG"
```

### Multi-platform configuration

```yaml
jobs:
  build:
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        include:
          - os: ubuntu-latest
            BUILD_COMMAND: "make build-linux"
            PACKAGE_EXT: ".deb"
          - os: windows-latest
            BUILD_COMMAND: "msbuild /p:Configuration=Release"
            PACKAGE_EXT: ".msi"
          - os: macos-latest
            BUILD_COMMAND: "xcodebuild -configuration Release"
            PACKAGE_EXT: ".dmg"

    runs-on: ${{ matrix.os }}
    env:
      BUILD_COMMAND: ${{ matrix.BUILD_COMMAND }}
      PACKAGE_EXT: ${{ matrix.PACKAGE_EXT }}

    steps:
      - name: Build application
        run: ${{ env.BUILD_COMMAND }}
```

## Security best practices for environment variables

### Sensitive data handling

```yaml
# DON'T: Store secrets in plain environment variables
env:
  DATABASE_PASSWORD: 'super-secret-password'  # Visible in logs!

# DO: Use GitHub Secrets for sensitive data
env:
  DATABASE_HOST: 'db.example.com'
  DATABASE_PORT: '5432'
  DATABASE_USER: 'app_user'
  DATABASE_PASSWORD: ${{ secrets.DATABASE_PASSWORD }}  # Secure!
```

### Environment variable validation

```yaml
steps:
  - name: Validate required environment variables
    run: |
      required_vars=("API_URL" "DATABASE_HOST" "ENVIRONMENT")

      for var in "${required_vars[@]}"; do
        if [ -z "${!var}" ]; then
          echo "ERROR: Required environment variable $var is not set"
          exit 1
        else
          echo "OK: $var is set"
        fi
      done
```

## Advanced techniques

### Conditional environment variables

```yaml
steps:
  - name: Set environment-specific variables
    run: |
      if [ "$GITHUB_REF" = "refs/heads/main" ]; then
        echo "LOG_LEVEL=info" >> $GITHUB_ENV
        echo "CACHE_TTL=3600" >> $GITHUB_ENV
      elif [ "$GITHUB_REF" = "refs/heads/develop" ]; then
        echo "LOG_LEVEL=debug" >> $GITHUB_ENV
        echo "CACHE_TTL=300" >> $GITHUB_ENV
      else
        echo "LOG_LEVEL=warn" >> $GITHUB_ENV
        echo "CACHE_TTL=60" >> $GITHUB_ENV
      fi
```

### Environment variable templating

```yaml
env:
  APP_VERSION: ${{ github.ref_name }}
  BUILD_ID: ${{ github.run_number }}
  FULL_VERSION: ${{ github.ref_name }}-build.${{ github.run_number }}
  CONTAINER_TAG: ${{ github.repository }}:${{ github.ref_name }}
```

Environment variables are a powerful tool for creating flexible, maintainable, and secure GitHub Actions workflows. Use them strategically to avoid hardcoded values and enable easy configuration management across different environments.

For complete documentation on environment variables, see [Environment variables in GitHub Actions](https://docs.github.com/actions/learn-github-actions/variables).
