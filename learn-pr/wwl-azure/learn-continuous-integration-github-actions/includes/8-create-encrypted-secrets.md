GitHub Actions workflows often need access to sensitive information like API keys, passwords, certificates, and tokens. GitHub provides encrypted secrets to securely store and access this sensitive data without exposing it in your code or workflow files.

## Understanding GitHub secrets

GitHub secrets are encrypted environment variables that you can create at different levels within your GitHub organization. Once created, secrets are encrypted and can only be decrypted during workflow execution in authorized contexts.

**Key characteristics of GitHub secrets:**

- **Encrypted storage**: All secrets are encrypted using industry-standard encryption
- **Controlled access**: Only authorized workflows can access secrets
- **Masked in logs**: Secret values are automatically masked in workflow logs
- **Immutable**: Once created, secret values cannot be viewed, only replaced

## Secret scopes and hierarchy

### Repository-level secrets

Repository secrets are available only to workflows in that specific repository:

```yaml
# Using repository secret in workflow
name: Deploy Application

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to production
        env:
          API_KEY: ${{ secrets.PRODUCTION_API_KEY }}
          DATABASE_URL: ${{ secrets.DATABASE_CONNECTION_STRING }}
        run: |
          echo "Deploying with API key starting with: ${API_KEY:0:8}..."
          ./deploy.sh
```

### Organization-level secrets

Organization secrets can be shared across multiple repositories with controlled access:

```yaml
# Organization secret with repository access control
name: Shared CI Pipeline

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Run integration tests
        env:
          # This secret is available to authorized repositories
          SHARED_TEST_API_KEY: ${{ secrets.INTEGRATION_TEST_API_KEY }}
        run: |
          npm test -- --api-key="$SHARED_TEST_API_KEY"
```

### Environment-level secrets

Environment secrets provide fine-grained control for deployment environments:

```yaml
name: Multi-Environment Deploy

on:
  push:
    branches: [main, develop]

jobs:
  deploy-staging:
    if: github.ref == 'refs/heads/develop'
    runs-on: ubuntu-latest
    environment: staging
    steps:
      - name: Deploy to staging
        env:
          # Environment-specific secrets
          DEPLOYMENT_KEY: ${{ secrets.STAGING_DEPLOY_KEY }}
          API_ENDPOINT: ${{ secrets.STAGING_API_URL }}
        run: ./deploy.sh staging

  deploy-production:
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    environment: production
    steps:
      - name: Deploy to production
        env:
          DEPLOYMENT_KEY: ${{ secrets.PRODUCTION_DEPLOY_KEY }}
          API_ENDPOINT: ${{ secrets.PRODUCTION_API_URL }}
        run: ./deploy.sh production
```

## Creating and managing secrets

### Repository secrets setup

1. **Navigate to repository settings**:

   - Go to your repository on GitHub
   - Click **Settings** tab
   - Select **Secrets and variables** > **Actions**

2. **Create new repository secret**:

   ```
   Name: PRODUCTION_API_KEY
   Value: your-actual-api-key-value
   ```

3. **Use in workflow**:
   ```yaml
   env:
     API_KEY: ${{ secrets.PRODUCTION_API_KEY }}
   ```

### Organization secrets management

```yaml
# Example of organization secret usage with access policies
name: Organization-wide CI

on: [push]

jobs:
  security-scan:
    runs-on: ubuntu-latest
    steps:
      - name: Security vulnerability scan
        env:
          # Organization secret with controlled repository access
          SECURITY_SCAN_TOKEN: ${{ secrets.ORG_SECURITY_SCAN_TOKEN }}
        run: |
          security-scanner --token="$SECURITY_SCAN_TOKEN" .
```

**Organization secret access policies:**

- **All repositories**: Available to all repositories in the organization
- **Private repositories**: Available only to private repositories
- **Selected repositories**: Available only to specifically chosen repositories

### Environment secrets with protection rules

```yaml
name: Protected Production Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://myapp.production.com
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Deploy with environment protection
        env:
          # Protected by environment rules (approvals, wait timers)
          PROD_DEPLOY_TOKEN: ${{ secrets.PRODUCTION_DEPLOY_TOKEN }}
          PROD_DB_PASSWORD: ${{ secrets.PRODUCTION_DATABASE_PASSWORD }}
        run: |
          echo "Deploying to production environment..."
          ./scripts/deploy-production.sh
```

## Security best practices for secrets

### Secret naming conventions

```yaml
# Good: Clear, descriptive names
secrets:
  PRODUCTION_API_KEY
  STAGING_DATABASE_URL
  AWS_ACCESS_KEY_ID
  AZURE_CLIENT_SECRET
  DOCKER_REGISTRY_TOKEN

# Avoid: Vague or generic names
secrets:
  KEY
  PASSWORD
  TOKEN
  SECRET
```

### Principle of least privilege

```yaml
# Good: Specific secrets for specific purposes
name: Database Migration

jobs:
  migrate:
    runs-on: ubuntu-latest
    steps:
      - name: Run database migration
        env:
          # Read-only database connection for migrations
          DB_MIGRATION_URL: ${{ secrets.DB_MIGRATION_CONNECTION }}
        run: |
          migrate up --database-url="$DB_MIGRATION_URL"

  backup:
    runs-on: ubuntu-latest
    steps:
      - name: Create database backup
        env:
          # Backup-specific credentials with limited scope
          BACKUP_ACCESS_KEY: ${{ secrets.DB_BACKUP_ACCESS_KEY }}
        run: |
          backup-db --credentials="$BACKUP_ACCESS_KEY"
```

### Secret rotation and lifecycle management

```yaml
name: Secret Health Check

on:
  schedule:
    - cron: "0 6 * * 1" # Weekly on Monday at 6 AM

jobs:
  check-secret-health:
    runs-on: ubuntu-latest
    steps:
      - name: Test API key validity
        env:
          API_KEY: ${{ secrets.PRODUCTION_API_KEY }}
        run: |
          # Test if API key is still valid
          response=$(curl -s -o /dev/null -w "%{http_code}" \
            -H "Authorization: Bearer $API_KEY" \
            https://api.example.com/health)
            
          if [ "$response" != "200" ]; then
            echo "API key may be expired or invalid"
            # Create issue or notify team
            gh issue create --title "API Key Health Check Failed" \
              --body "The production API key failed health check. Response code: $response"
          else
            echo "API key is healthy"
          fi
```

### Conditional secret usage

```yaml
name: Flexible Secret Usage

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Run tests
        env:
          # Use different secrets based on event type
          API_KEY: ${{ github.event_name == 'push' && secrets.INTEGRATION_API_KEY || secrets.TESTING_API_KEY }}
          DATABASE_URL: ${{ github.ref == 'refs/heads/main' && secrets.PROD_DB_URL || secrets.TEST_DB_URL }}
        run: |
          echo "Running tests with appropriate credentials..."
          npm test
```

## Advanced secret patterns

### Multi-value secrets (JSON configuration)

```yaml
name: Complex Configuration

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Parse complex secret
        env:
          # Store complex configuration as JSON in secret
          AWS_CONFIG: ${{ secrets.AWS_DEPLOYMENT_CONFIG }}
        run: |
          # Parse JSON secret
          echo "$AWS_CONFIG" | jq -r '.access_key_id' > /tmp/aws_key
          echo "$AWS_CONFIG" | jq -r '.secret_access_key' > /tmp/aws_secret
          echo "$AWS_CONFIG" | jq -r '.region' > /tmp/aws_region

          # Configure AWS CLI
          aws configure set aws_access_key_id "$(cat /tmp/aws_key)"
          aws configure set aws_secret_access_key "$(cat /tmp/aws_secret)"
          aws configure set default.region "$(cat /tmp/aws_region)"

          # Clean up temporary files
          rm -f /tmp/aws_*
```

### Secret inheritance and composition

```yaml
name: Composed Secrets

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Build connection string
        env:
          DB_HOST: ${{ secrets.DATABASE_HOST }}
          DB_USER: ${{ secrets.DATABASE_USER }}
          DB_PASS: ${{ secrets.DATABASE_PASSWORD }}
          DB_NAME: ${{ secrets.DATABASE_NAME }}
        run: |
          # Compose connection string from individual secrets
          CONNECTION_STRING="postgresql://$DB_USER:$DB_PASS@$DB_HOST:5432/$DB_NAME"

          # Use composed string (never log it)
          echo "Connecting to database..."
          psql "$CONNECTION_STRING" -c "SELECT version();"
```

### Secret validation and testing

```yaml
name: Secret Validation

jobs:
  validate-secrets:
    runs-on: ubuntu-latest
    steps:
      - name: Validate API credentials
        env:
          API_KEY: ${{ secrets.API_KEY }}
          API_SECRET: ${{ secrets.API_SECRET }}
        run: |
          # Test API credentials without exposing values
          if [ -z "$API_KEY" ] || [ -z "$API_SECRET" ]; then
            echo "Missing required API credentials"
            exit 1
          fi

          # Test key format (without revealing the key)
          if [[ ${#API_KEY} -lt 32 ]]; then
            echo "API key appears to be invalid (too short)"
            exit 1
          fi

          # Test authentication
          response=$(curl -s -w "%{http_code}" -o /dev/null \
            -H "Authorization: Bearer $API_KEY" \
            https://api.example.com/auth/test)
            
          if [ "$response" = "200" ]; then
            echo "API credentials validated successfully"
          else
            echo "API credential validation failed (HTTP $response)"
            exit 1
          fi
```

## Common pitfalls and security considerations

### Avoiding secret exposure

```yaml
# DON'T: Never echo or log secrets directly
- name: Bad secret usage
  env:
    API_KEY: ${{ secrets.API_KEY }}
  run: |
    echo "Using API key: $API_KEY"  # This will expose the secret!

# DO: Use secrets safely without exposure
- name: Safe secret usage
  env:
    API_KEY: ${{ secrets.API_KEY }}
  run: |
    # Use the secret without logging it
    curl -H "Authorization: Bearer $API_KEY" https://api.example.com/data
    echo "API request completed successfully"
```

### Proper error handling

```yaml
- name: Secure error handling
  env:
    DATABASE_PASSWORD: ${{ secrets.DATABASE_PASSWORD }}
  run: |
    # Set error handling to avoid secret leaks
    set +x  # Disable command echoing

    if ! psql "postgresql://user:$DATABASE_PASSWORD@host/db" -c "SELECT 1"; then
      # Log error without exposing secret
      echo "Database connection failed"
      exit 1
    fi

    echo "Database connection successful"
```

### Secret scope management

```yaml
# Good: Limit secret scope to specific steps
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        # No secrets available here

      - name: Deploy application
        env:
          DEPLOY_KEY: ${{ secrets.DEPLOY_KEY }} # Secret only in this step
        run: |
          ./deploy.sh

      - name: Run post-deploy tests
        # No secrets available here
        run: |
          ./test.sh
```

Proper secret management is crucial for maintaining the security of your CI/CD pipelines. Always follow the principle of least privilege, use descriptive naming, and implement proper validation to ensure your secrets remain secure while enabling powerful automation capabilities.
