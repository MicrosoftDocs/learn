Secrets aren't passed automatically to the runners when workflows are executed. To make a secret available to an action, you must set the secret as an input or environment variable in the workflow file. To accomplish this, you can use the secrets context as illustrated in following example:

Using secrets effectively in GitHub Actions workflows requires understanding how to access them securely, apply them appropriately, and work within their limitations. This section covers practical patterns and techniques for integrating secrets into your CI/CD workflows.

## Accessing secrets in workflows

Secrets are not automatically available to workflow steps. You must explicitly expose them through inputs or environment variables using the `secrets` context.

### Basic secret usage patterns

```yaml
name: Database Operations

on: [push]

jobs:
  database-operations:
    runs-on: ubuntu-latest
    steps:
      # Method 1: Using secrets as environment variables
      - name: Connect to database
        env:
          DB_USERNAME: ${{ secrets.DB_USERNAME }}
          DB_PASSWORD: ${{ secrets.DB_PASSWORD }}
          DB_HOST: ${{ secrets.DB_HOST }}
        run: |
          # Use environment variables safely
          psql -h "$DB_HOST" -U "$DB_USERNAME" -d myapp <<EOF
          SELECT version();
          EOF

      # Method 2: Passing secrets to actions as inputs
      - name: Deploy application
        uses: my-org/deploy-action@v2
        with:
          api-key: ${{ secrets.DEPLOYMENT_API_KEY }}
          environment: production

      # Method 3: Using secrets in composite actions
      - name: Security scan
        uses: security-org/scan-action@v1
        with:
          token: ${{ secrets.SECURITY_SCAN_TOKEN }}
          severity-threshold: "high"
```

### Cross-shell secret usage

```yaml
jobs:
  multi-shell-example:
    runs-on: ubuntu-latest
    steps:
      # Bash shell
      - name: Bash operations
        shell: bash
        env:
          API_TOKEN: ${{ secrets.API_TOKEN }}
        run: |
          curl -H "Authorization: Bearer $API_TOKEN" \
               https://api.example.com/deploy

      # PowerShell
      - name: PowerShell operations
        shell: pwsh
        env:
          API_TOKEN: ${{ secrets.API_TOKEN }}
        run: |
          $headers = @{ Authorization = "Bearer $env:API_TOKEN" }
          Invoke-RestMethod -Uri "https://api.example.com/status" -Headers $headers

      # Python script
      - name: Python operations
        shell: python
        env:
          API_TOKEN: ${{ secrets.API_TOKEN }}
        run: |
          import os
          import requests

          token = os.environ['API_TOKEN']
          headers = {'Authorization': f'Bearer {token}'}
          response = requests.get('https://api.example.com/data', headers=headers)
          print(f"Status: {response.status_code}")
```

## Advanced secret usage patterns

### Conditional secret usage

```yaml
name: Environment-Aware Deployment

on:
  push:
    branches: [main, develop, "feature/*"]

jobs:
  deploy:
    runs-on: ubuntu-latest
    env:
      # Set secrets as job-level environment variables for conditional access
      PROD_API_KEY: ${{ secrets.PRODUCTION_API_KEY }}
      STAGING_API_KEY: ${{ secrets.STAGING_API_KEY }}
      DEV_API_KEY: ${{ secrets.DEVELOPMENT_API_KEY }}
    steps:
      - name: Determine target environment
        id: env
        run: |
          if [[ "${{ github.ref }}" == "refs/heads/main" ]]; then
            echo "target=production" >> $GITHUB_OUTPUT
            echo "api_key_var=PROD_API_KEY" >> $GITHUB_OUTPUT
          elif [[ "${{ github.ref }}" == "refs/heads/develop" ]]; then
            echo "target=staging" >> $GITHUB_OUTPUT
            echo "api_key_var=STAGING_API_KEY" >> $GITHUB_OUTPUT
          else
            echo "target=development" >> $GITHUB_OUTPUT
            echo "api_key_var=DEV_API_KEY" >> $GITHUB_OUTPUT
          fi

      - name: Deploy to environment
        run: |
          # Use indirect variable reference
          API_KEY_VAR="${{ steps.env.outputs.api_key_var }}"
          API_KEY="${!API_KEY_VAR}"

          echo "Deploying to ${{ steps.env.outputs.target }} environment"
          ./deploy.sh --environment=${{ steps.env.outputs.target }} --api-key="$API_KEY"
```

### Secret validation and health checks

```yaml
name: Secret Health Validation

jobs:
  validate-secrets:
    runs-on: ubuntu-latest
    steps:
      - name: Validate required secrets
        env:
          REQUIRED_SECRETS: |
            API_KEY=${{ secrets.API_KEY }}
            DATABASE_URL=${{ secrets.DATABASE_URL }}
            REDIS_URL=${{ secrets.REDIS_URL }}
        run: |
          echo "$REQUIRED_SECRETS" | while IFS='=' read -r name value; do
            if [ -z "$value" ]; then
              echo "ERROR: Missing required secret: $name"
              exit 1
            else
              echo "OK: Secret $name is present"
            fi
          done

      - name: Test secret functionality
        env:
          API_KEY: ${{ secrets.API_KEY }}
          DATABASE_URL: ${{ secrets.DATABASE_URL }}
        run: |
          # Test API key
          if curl -f -H "Authorization: Bearer $API_KEY" https://api.example.com/health; then
            echo "API key is valid"
          else
            echo "ERROR: API key validation failed"
            exit 1
          fi

          # Test database connection
          if pg_isready -d "$DATABASE_URL"; then
            echo "Database connection is healthy"
          else
            echo "ERROR: Database connection failed"
            exit 1
          fi
```

### Secret composition and transformation

```yaml
name: Complex Secret Handling

jobs:
  process-secrets:
    runs-on: ubuntu-latest
    steps:
      - name: Compose configuration from secrets
        env:
          # Individual secret components
          DB_HOST: ${{ secrets.DB_HOST }}
          DB_PORT: ${{ secrets.DB_PORT }}
          DB_USER: ${{ secrets.DB_USER }}
          DB_PASS: ${{ secrets.DB_PASSWORD }}
          DB_NAME: ${{ secrets.DB_NAME }}

          # SSL certificate components
          SSL_CERT: ${{ secrets.SSL_CERTIFICATE }}
          SSL_KEY: ${{ secrets.SSL_PRIVATE_KEY }}
          SSL_CA: ${{ secrets.SSL_CA_CERTIFICATE }}
        run: |
          # Create connection string
          CONNECTION_STRING="postgresql://$DB_USER:$DB_PASS@$DB_HOST:$DB_PORT/$DB_NAME?sslmode=require"

          # Write SSL files securely
          echo "$SSL_CERT" > /tmp/client-cert.pem
          echo "$SSL_KEY" > /tmp/client-key.pem
          echo "$SSL_CA" > /tmp/ca-cert.pem

          # Set proper permissions
          chmod 600 /tmp/client-key.pem
          chmod 644 /tmp/client-cert.pem /tmp/ca-cert.pem

          # Use composed configuration
          psql "$CONNECTION_STRING" \
            --set=sslcert=/tmp/client-cert.pem \
            --set=sslkey=/tmp/client-key.pem \
            --set=sslrootcert=/tmp/ca-cert.pem \
            -c "SELECT version();"

          # Clean up sensitive files
          rm -f /tmp/client-*.pem /tmp/ca-cert.pem
```

## Working with conditional logic

### Using secrets in conditional statements

Since secrets cannot be directly referenced in `if` conditions, use environment variables as intermediaries:

```yaml
name: Conditional Secret Usage

jobs:
  conditional-deployment:
    runs-on: ubuntu-latest
    env:
      # Make secrets available as environment variables
      DEPLOY_KEY: ${{ secrets.DEPLOY_KEY }}
      FEATURE_FLAG_API_KEY: ${{ secrets.FEATURE_FLAG_API_KEY }}
      MONITORING_TOKEN: ${{ secrets.MONITORING_TOKEN }}
    steps:
      - name: Deploy if deployment key exists
        if: ${{ env.DEPLOY_KEY != '' }}
        run: |
          echo "Deploying with available deployment key"
          ./deploy.sh --key="$DEPLOY_KEY"

      - name: Enable feature flags if configured
        if: ${{ env.FEATURE_FLAG_API_KEY != '' }}
        run: |
          echo "Configuring feature flags"
          feature-flags configure --api-key="$FEATURE_FLAG_API_KEY"

      - name: Setup monitoring if token available
        if: ${{ env.MONITORING_TOKEN != '' }}
        run: |
          echo "Setting up monitoring"
          monitoring setup --token="$MONITORING_TOKEN"

      - name: Fallback for missing secrets
        if: ${{ env.DEPLOY_KEY == '' }}
        run: |
          echo "WARNING: No deployment key available, running in dry-run mode"
          ./deploy.sh --dry-run
```

### Multiple condition handling

```yaml
name: Multi-Condition Secret Logic

jobs:
  smart-deployment:
    runs-on: ubuntu-latest
    env:
      PROD_KEY: ${{ secrets.PRODUCTION_KEY }}
      STAGING_KEY: ${{ secrets.STAGING_KEY }}
      CANARY_ENABLED: ${{ secrets.CANARY_DEPLOYMENT_ENABLED }}
    steps:
      - name: Production deployment
        if: ${{ github.ref == 'refs/heads/main' && env.PROD_KEY != '' }}
        run: |
          echo "Production deployment with canary: $CANARY_ENABLED"
          if [ "$CANARY_ENABLED" = "true" ]; then
            ./deploy.sh --environment=production --canary --key="$PROD_KEY"
          else
            ./deploy.sh --environment=production --key="$PROD_KEY"
          fi

      - name: Staging deployment
        if: ${{ github.ref == 'refs/heads/develop' && env.STAGING_KEY != '' }}
        run: |
          echo "🔧 Staging deployment"
          ./deploy.sh --environment=staging --key="$STAGING_KEY"

      - name: Missing configuration warning
        if: ${{ (github.ref == 'refs/heads/main' && env.PROD_KEY == '') || (github.ref == 'refs/heads/develop' && env.STAGING_KEY == '') }}
        run: |
          echo "WARNING: Missing deployment keys for target environment"
          echo "Branch: ${{ github.ref }}"
          echo "Production key available: ${{ env.PROD_KEY != '' }}"
          echo "Staging key available: ${{ env.STAGING_KEY != '' }}"
```

## Security best practices in workflows

### Minimize secret exposure scope

```yaml
name: Scoped Secret Access

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        # No secrets needed for checkout

      - name: Build application
        run: |
          npm install
          npm run build
        # No secrets needed for build

      - name: Deploy application (secrets only here)
        env:
          DEPLOY_TOKEN: ${{ secrets.DEPLOY_TOKEN }}
        run: |
          # Secret only available in this specific step
          ./deploy.sh --token="$DEPLOY_TOKEN"
```

### Safe error handling with secrets

```yaml
name: Safe Secret Error Handling

jobs:
  secure-operations:
    runs-on: ubuntu-latest
    steps:
      - name: Safe secret usage with error handling
        env:
          API_KEY: ${{ secrets.API_KEY }}
        run: |
          # Disable bash debugging to prevent secret exposure
          set +x

          # Capture command output without exposing secrets
          if output=$(api-call --key="$API_KEY" 2>&1); then
            echo "API call successful"
            echo "$output" | grep -v "$API_KEY"  # Filter out any secret remnants
          else
            exit_code=$?
            echo "ERROR: API call failed with exit code: $exit_code"
            # Don't log the actual error which might contain the secret
            echo "Check API key validity and network connectivity"
            exit $exit_code
          fi
```

### Secret rotation detection

```yaml
name: Secret Rotation Detection

on:
  schedule:
    - cron: "0 8 * * *" # Daily at 8 AM

jobs:
  check-secret-rotation:
    runs-on: ubuntu-latest
    steps:
      - name: Check secret age and validity
        env:
          API_KEY: ${{ secrets.API_KEY }}
          WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK }}
        run: |
          # Test current secret validity
          if curl -f -H "Authorization: Bearer $API_KEY" https://api.example.com/auth/validate; then
            echo "Current API key is valid"
          else
            echo "ERROR: API key validation failed - rotation may be needed"
            
            # Notify team via webhook
            curl -X POST "$WEBHOOK_URL" \
              -H "Content-Type: application/json" \
              -d '{"text": "🔐 API key rotation needed for repository: ${{ github.repository }}"}'
          fi
```

## Understanding limitations and workarounds

### Secret size limitations

```yaml
name: Large Secret Handling

jobs:
  handle-large-secrets:
    runs-on: ubuntu-latest
    steps:
      # For secrets under 48KB - direct usage
      - name: Use normal secret
        env:
          SMALL_CONFIG: ${{ secrets.APPLICATION_CONFIG }}
        run: |
          echo "$SMALL_CONFIG" > config.json

      # For larger secrets - use encrypted storage
      - name: Handle large secret
        env:
          # Store encryption passphrase as secret (under 48KB)
          DECRYPTION_KEY: ${{ secrets.LARGE_SECRET_DECRYPTION_KEY }}
        run: |
          # Download encrypted large secret from repository
          curl -H "Authorization: Bearer ${{ secrets.GITHUB_TOKEN }}" \
               -o encrypted-config.enc \
               https://api.github.com/repos/${{ github.repository }}/contents/secrets/large-config.enc

          # Decrypt using the passphrase secret
          openssl enc -aes-256-cbc -d -in encrypted-config.enc -out large-config.json -pass pass:"$DECRYPTION_KEY"

          # Use the decrypted configuration
          cat large-config.json | jq '.database.connection_string'

          # Clean up
          rm -f encrypted-config.enc large-config.json
```

### Fork repository limitations

```yaml
name: Fork-Aware Secret Usage

on: [push, pull_request]

jobs:
  secure-ci:
    runs-on: ubuntu-latest
    steps:
      - name: Check if secrets are available
        env:
          # GITHUB_TOKEN is always available, others may not be in forks
          HAS_API_KEY: ${{ secrets.API_KEY != '' }}
        run: |
          echo "Running in fork: ${{ github.event.pull_request.head.repo.fork }}"
          echo "Secrets available: $HAS_API_KEY"

      - name: Full integration tests (only for main repo)
        if: ${{ !github.event.pull_request.head.repo.fork && secrets.API_KEY != '' }}
        env:
          API_KEY: ${{ secrets.API_KEY }}
        run: |
          echo "🔐 Running full integration tests with secrets"
          npm run test:integration

      - name: Limited tests (for forks)
        if: ${{ github.event.pull_request.head.repo.fork || secrets.API_KEY == '' }}
        run: |
          echo "🔓 Running limited tests without secrets"
          npm run test:unit
```

Understanding these patterns and limitations helps you build robust workflows that handle secrets securely while maintaining functionality across different execution contexts and repository configurations.
