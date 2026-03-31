Securing CI/CD pipelines is fundamental to DevSecOps practices, protecting source code, credentials, secrets, and deployment processes from unauthorized access and malicious activities. Pipeline security breaches can result in compromised credentials, malicious code injection, unauthorized deployments, and data exfiltration. Implementing comprehensive pipeline security controls prevents attacks targeting development workflows, ensures compliance with security policies, and maintains the integrity of software delivery processes.

Azure Pipelines and GitHub Actions provide built-in security features, but organizations must configure and enforce security controls consistently across all pipelines. This unit explores essential security practices for protecting pipelines, secrets, service connections, agents, and deployment processes.

## Secrets management

**Credential protection challenges:**

Pipelines require access to credentials, API keys, connection strings, and certificates for building, testing, and deploying applications. Storing secrets directly in pipeline definitions, source code, or configuration files creates severe security risks including credential exposure, unauthorized access, and compliance violations.

**Azure Key Vault integration:**

**Azure Key Vault** provides centralized, secure storage for secrets with access control, audit logging, and automatic rotation capabilities.

**Configure Key Vault for pipeline access:**

```yaml
# Azure Pipelines - Key Vault integration
trigger:
  - main

pool:
  vmImage: "ubuntu-latest"

steps:
  - task: AzureKeyVault@2
    inputs:
      azureSubscription: "Production-Service-Connection"
      KeyVaultName: "contoso-prod-kv"
      SecretsFilter: "DatabasePassword,ApiKey,StorageAccountKey"
      RunAsPreJob: true

  - script: |
      echo "Connecting to database..."
      # Database password is available as $(DatabasePassword)
      # API key is available as $(ApiKey)
    displayName: "Deploy application with secrets from Key Vault"
    env:
      DB_PASSWORD: $(DatabasePassword)
      API_KEY: $(ApiKey)
```

**Key Vault benefits:**

- **Centralized management:** Single location for all secrets with consistent access policies.
- **Access control:** Azure RBAC and Key Vault access policies restrict secret access to authorized pipelines and users.
- **Audit logging:** All secret access attempts are logged for compliance and security monitoring.
- **Automatic rotation:** Secrets can rotate automatically without pipeline changes.
- **Encryption:** Secrets are encrypted at rest and in transit using Azure-managed encryption keys.

**Pipeline variable security:**

**Secure variables** in Azure Pipelines encrypt secret values and prevent them from appearing in logs.

```yaml
variables:
  - group: Production-Secrets # Variable group from Azure DevOps Library
  - name: BuildConfiguration
    value: "Release"

steps:
  - script: |
      echo "Build configuration: $(BuildConfiguration)"
      # Secure variable $(ProductionApiKey) won't be logged
      curl -H "Authorization: Bearer $(ProductionApiKey)" https://api.contoso.com/deploy
    displayName: "Deploy with secure variables"
```

**Secure variable best practices:**

- **Mark secrets as secret:** Configure variables as secret in Azure Pipelines to prevent logging.
- **Use variable groups:** Organize related secrets into variable groups for easier management.
- **Restrict access:** Limit variable group access to specific pipelines and users with role-based permissions.
- **Rotate regularly:** Implement regular secret rotation schedules for all credentials.
- **Avoid hardcoding:** Never hardcode secrets in pipeline YAML, scripts, or source code.

**GitHub Secrets:**

**GitHub Actions** provides encrypted secrets at repository, environment, and organization levels.

```yaml
# GitHub Actions - Secrets usage
name: Deploy to Production

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: production

    steps:
      - uses: actions/checkout@v3

      - name: Deploy application
        env:
          DATABASE_PASSWORD: ${{ secrets.DATABASE_PASSWORD }}
          API_KEY: ${{ secrets.API_KEY }}
          AZURE_CREDENTIALS: ${{ secrets.AZURE_CREDENTIALS }}
        run: |
          echo "Deploying with secure credentials..."
          az login --service-principal -u $CLIENT_ID -p $CLIENT_SECRET --tenant $TENANT_ID
          ./deploy.sh
```

**GitHub secrets scoping:**

- **Repository secrets:** Available to all workflows in a single repository.
- **Environment secrets:** Available only to workflows targeting specific environments (production, staging).
- **Organization secrets:** Shared across multiple repositories in an organization with access policies.

## Service connection security

**Service connections** (Azure Pipelines) or **repository secrets** (GitHub Actions) provide authentication to external services including Azure subscriptions, container registries, Kubernetes clusters, and third-party platforms.

**Azure DevOps service connection configuration:**

**Secure service connection setup:**

1. **Navigate to Project Settings** in Azure DevOps.
2. **Click Service connections** under Pipelines.
3. **Create new service connection** (Azure Resource Manager, Docker Registry, Kubernetes, etc.).
4. **Configure authentication:**
   - **Service principal (automatic):** Azure DevOps creates service principal with contributor access to subscription or resource group.
   - **Service principal (manual):** Use existing service principal with least-privilege permissions.
   - **Managed identity:** Use managed identity for Azure VM or Azure DevOps agents running in Azure.
5. **Restrict access:**
   - **Limit to specific pipelines:** Configure "Grant access permission to all pipelines" to OFF.
   - **Require approval:** Enable approvals for service connections used in production deployments.
   - **Set security roles:** Assign User, Administrator, or Reader roles to control who can manage the service connection.

**Service connection best practices:**

- **Least-privilege access:** Grant service principals minimum permissions required for pipeline operations (avoid Contributor or Owner roles when possible).
- **Separate connections per environment:** Use different service connections for development, staging, and production to prevent cross-environment access.
- **Regular auditing:** Review service connection usage and permissions quarterly.
- **Connection validation:** Test service connections regularly to detect expired credentials or revoked permissions.
- **Expire unused connections:** Delete service connections no longer in use to reduce attack surface.

**Service principal permission scoping:**

```azurecli
# Create service principal with specific role and scope
az ad sp create-for-rbac \
  --name "AzurePipelines-Prod-Deploy" \
  --role "Contributor" \
  --scopes /subscriptions/{subscription-id}/resourceGroups/production-rg \
  --sdk-auth
```

## Pipeline permissions and RBAC

**Access control for pipeline definitions:**

Implement **role-based access control (RBAC)** to restrict who can create, edit, view, and execute pipelines.

**Azure Pipelines permissions:**

- **Reader:** View pipeline runs and history but cannot edit or queue pipelines.
- **Contributor:** Create and edit pipelines, queue builds, manage pipeline variables.
- **Administrator:** Full control including deleting pipelines and managing permissions.
- **Build administrator:** Manage build pipelines, retention policies, and agent pools.

**Pipeline security configuration:**

1. **Navigate to Pipelines** in Azure DevOps.
2. **Select pipeline** to secure.
3. **Click Security** (three dots menu).
4. **Configure permissions:**
   - Remove "Project Collection Build Service" from administrator role if not needed.
   - Grant specific teams or users minimum required permissions.
   - Disable "Allow users to queue builds" for production pipelines unless necessary.

**Branch protection policies:**

**Branch policies** enforce security requirements before code merges into protected branches.

**Configure branch policies:**

1. **Navigate to Repos → Branches** in Azure DevOps.
2. **Select main branch** and click "Branch policies."
3. **Enable required policies:**
   - **Require a minimum number of reviewers:** Enforce peer review (minimum 2 reviewers for production code).
   - **Check for linked work items:** Ensure traceability between code changes and work items.
   - **Require build validation:** Run CI pipeline successfully before allowing merge.
   - **Require comment resolution:** All PR comments must be resolved before merge.
   - **Limit merge types:** Restrict to squash merge or rebase to maintain clean history.

**Build validation policy:**

```yaml
# Build validation pipeline enforced by branch policy
trigger: none # Only runs as PR validation

pool:
  vmImage: "ubuntu-latest"

steps:
  - task: UseDotNet@2
    inputs:
      version: "8.x"

  - script: dotnet restore
    displayName: "Restore dependencies"

  - script: dotnet build --configuration Release
    displayName: "Build application"

  - script: dotnet test --no-build --configuration Release
    displayName: "Run tests"

  - task: WhiteSource@21
    inputs:
      projectName: "Contoso-Web-App"
    displayName: "Security scan dependencies"
```

## Agent security

**Pipeline agents** execute build and deployment tasks. Securing agents prevents malicious code execution, credential theft, and unauthorized resource access.

**Microsoft-hosted agents vs. self-hosted agents:**

**Microsoft-hosted agents:**

- **Managed by Microsoft:** Automatically updated with latest tools, patches, and security updates.
- **Ephemeral:** Fresh virtual machine for each pipeline run, reducing persistent threat risk.
- **Limited customization:** Standard tool set may not support all organizational requirements.
- **Best for:** Standard builds and deployments without specialized software or networking requirements.

**Self-hosted agents:**

- **Managed by organization:** Organization maintains agent machines, tools, and security updates.
- **Persistent state:** Agents can cache dependencies but may retain sensitive data between runs.
- **Full customization:** Install any required software, tools, or certificates.
- **Network access:** Can access on-premises resources, private networks, and restricted endpoints.
- **Best for:** Specialized builds, deployments to on-premises infrastructure, or compliance requirements.

**Self-hosted agent security best practices:**

- **Isolate agent machines:** Run agents in separate VMs or containers isolated from production systems.
- **Regular patching:** Apply OS and tool updates promptly to address security vulnerabilities.
- **Minimize installed software:** Install only required build tools and dependencies to reduce attack surface.
- **Restrict network access:** Use firewalls and network security groups to limit agent connectivity.
- **Use managed identities:** Leverage Azure managed identities for authentication instead of storing credentials on agents.
- **Monitor agent activity:** Enable logging and monitoring for suspicious activities on agent machines.
- **Rotate agent registration:** Re-register agents periodically to refresh authentication tokens.

**Agent pool permissions:**

```yaml
# Azure Pipelines - Specify agent pool with restricted access
pool:
  name: "Production-Agent-Pool" # Self-hosted pool with restricted permissions
  demands:
    - Agent.OS -equals Linux
    - Docker -equals true

steps:
  - script: docker build -t myapp:latest .
    displayName: "Build Docker image on secure agent"
```

## Secure pipeline design patterns

**Immutable infrastructure:**

Deploy infrastructure using **Infrastructure as Code (IaC)** templates stored in version control. If pipeline or infrastructure is compromised, redeploy from known-good templates.

**ARM template deployment:**

```yaml
# Azure Pipelines - ARM template deployment
trigger:
  - main

pool:
  vmImage: "ubuntu-latest"

steps:
  - task: AzureResourceManagerTemplateDeployment@3
    inputs:
      azureResourceManagerConnection: "Production-Service-Connection"
      subscriptionId: "$(AzureSubscriptionId)"
      resourceGroupName: "production-rg"
      location: "East US"
      templateLocation: "Linked artifact"
      csmFile: "$(Build.SourcesDirectory)/infrastructure/main.bicep"
      overrideParameters: "-environment production -location eastus"
      deploymentMode: "Incremental"
```

**Benefits:**

- **Reproducible deployments:** Recreate infrastructure identically from source control.
- **Version control:** Track infrastructure changes through Git history.
- **Automated recovery:** Quickly rebuild compromised infrastructure from templates.
- **Security baselines:** Enforce consistent security configurations across all deployments.

**Security scanning integration:**

Integrate **static application security testing (SAST)**, **software composition analysis (SCA)**, and **container scanning** into pipelines to detect vulnerabilities before deployment.

```yaml
# Azure Pipelines - Security scanning integration
steps:
  - task: UseDotNet@2
    inputs:
      version: "8.x"

  - script: dotnet build --configuration Release
    displayName: "Build application"

  # SAST - Static code analysis
  - task: DotNetCoreCLI@2
    inputs:
      command: "custom"
      custom: "tool"
      arguments: "run security-scan"
    displayName: "Run SAST security scan"

  # SCA - Dependency vulnerability scanning
  - task: WhiteSource@21
    inputs:
      projectName: "ContosoWebApp"
      checkPolicies: true
      failOnPolicyViolation: true
    displayName: "Scan dependencies for vulnerabilities"

  # Container scanning
  - task: AquaScanner@4
    inputs:
      image: "contosoapp:$(Build.BuildId)"
      scanType: "local"
      register: false
    displayName: "Scan container image for vulnerabilities"
```

**Deployment gates and approvals:**

**Pre-deployment approvals** require manual approval before deploying to production environments, ensuring security review and authorization.

**Configure approvals:**

1. **Navigate to Pipelines → Environments** in Azure DevOps.
2. **Select production environment**.
3. **Click "Approvals and checks."**
4. **Add approval:**
   - **Approvers:** Security team, operations team, or release managers.
   - **Timeout:** Approval must be granted within specified timeframe (e.g., 24 hours).
   - **Instructions:** Provide approval criteria (security scan passed, testing complete, change approved).

**Business hours gate:**

```yaml
# GitHub Actions - Deployment requiring approval and business hours
jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: production
      # Configured in GitHub: requires approval from security team

    steps:
      - name: Check business hours
        run: |
          HOUR=$(date +%H)
          DAY=$(date +%u)
          if [ $DAY -gt 5 ] || [ $HOUR -lt 9 ] || [ $HOUR -gt 17 ]; then
            echo "Deployments only allowed during business hours (Mon-Fri 9am-5pm)"
            exit 1
          fi

      - name: Deploy to production
        run: ./deploy.sh
```

## Audit logging and monitoring

**Pipeline execution monitoring:**

Enable comprehensive logging for all pipeline activities including:

- **Pipeline runs:** Start time, duration, success/failure status, triggered by user.
- **Secret access:** When secrets or Key Vault variables are accessed (without logging secret values).
- **Service connection usage:** Which pipelines use which service connections.
- **Agent assignments:** Which agents execute which pipeline runs.
- **Approval decisions:** Who approved or rejected deployment approvals.

**Azure DevOps audit logging:**

**Enable auditing:**

1. **Navigate to Organization Settings** in Azure DevOps.
2. **Click Auditing** under Security.
3. **Download audit logs** for security analysis and compliance reporting.

**Audit log contents:**

- User authentication and authorization events.
- Pipeline creation, modification, and deletion.
- Service connection changes.
- Variable group access and modifications.
- Agent pool configuration changes.

**Azure Monitor integration:**

**Stream pipeline logs to Azure Monitor:**

```yaml
# Azure Pipelines - Log Analytics integration
steps:
  - task: PublishBuildArtifacts@1
    inputs:
      PathtoPublish: "$(Build.ArtifactStagingDirectory)"
      ArtifactName: "drop"

  - task: AzureCLI@2
    inputs:
      azureSubscription: "Production-Service-Connection"
      scriptType: "bash"
      scriptLocation: "inlineScript"
      inlineScript: |
        az monitor log-analytics workspace create \
          --resource-group security-monitoring-rg \
          --workspace-name devops-pipeline-logs

        # Send custom pipeline metrics to Log Analytics
        az monitor metrics alert create \
          --name pipeline-failure-alert \
          --resource-group security-monitoring-rg \
          --condition "count > 3" \
          --description "Alert when pipeline fails more than 3 times"
```

**Monitoring alerts:**

- **Failed pipelines:** Alert when pipelines fail repeatedly (potential attack or misconfiguration).
- **Suspicious access patterns:** Unusual pipeline execution times or unauthorized users triggering pipelines.
- **Service connection failures:** Authentication failures may indicate compromised credentials.
- **Secret access spikes:** Unusual volume of Key Vault access may indicate credential harvesting attempt.

## Authentication and authorization

**Multifactor authentication (MFA):**

**Enforce MFA** for all users with access to Azure DevOps, GitHub, and Azure subscriptions to protect against credential theft and phishing attacks.

**Conditional Access policies:**

**Microsoft Entra ID (Azure AD) Conditional Access** enforces security requirements based on user, location, device, and risk level.

**Example policy:**

- **Require MFA** for all users accessing Azure DevOps from outside corporate network.
- **Require compliant devices** (managed by Intune) for accessing production pipelines.
- **Block access from high-risk locations** identified by Entra ID Protection.

**Just-in-time (JIT) administration:**

**Azure PowerShell Just Enough Administration (JEA)** and **Privileged Identity Management (PIM)** provide temporary, time-limited administrative access.

**PIM for pipeline administration:**

1. **Configure eligible role** for "Build Administrator" in Azure DevOps.
2. **User requests activation** when administrative access is needed.
3. **Approval workflow** requires justification and approval from security team.
4. **Time-limited access** expires after specified duration (e.g., 4 hours).
5. **Audit trail** records all PIM activations and actions performed.

**Benefits:**

- **Reduces standing privileges:** Users don't have permanent administrative access.
- **Audit trail:** All privileged actions are logged with justification.
- **Approval workflow:** Security team reviews and approves privileged access requests.

## Dynamic application security testing (DAST)

**Runtime security testing:**

**DAST** tests running applications with known attack patterns to identify vulnerabilities exploitable in production environments.

**OWASP ZAP integration:**

```yaml
# Azure Pipelines - OWASP ZAP DAST scanning
steps:
  - task: Docker@2
    inputs:
      command: "run"
      arguments: >
        -v $(Build.SourcesDirectory):/zap/wrk/:rw
        -t owasp/zap2docker-stable zap-baseline.py
        -t https://staging.contoso.com
        -r zapreport.html
    displayName: "Run OWASP ZAP security scan"

  - task: PublishBuildArtifacts@1
    inputs:
      PathtoPublish: "$(Build.SourcesDirectory)/zapreport.html"
      ArtifactName: "security-scan-results"
    displayName: "Publish DAST scan results"
```

**DAST best practices:**

- **Scan staging environments:** Test against staging environment identical to production to avoid impacting production availability.
- **Authenticated scanning:** Provide test credentials to DAST tools to scan authenticated application areas.
- **Baseline scans:** Run regular baseline scans to detect new vulnerabilities introduced by code changes.
- **Fail pipeline on critical findings:** Configure pipeline to fail if critical or high-severity vulnerabilities are detected.

## Production monitoring

**Microsoft Defender for Cloud** provides unified security monitoring for Azure resources including virtual machines, containers, databases, and storage accounts. Defender for Cloud detects threats, provides security recommendations, and integrates with **Microsoft Sentinel** for Security Information and Event Management (SIEM) capabilities.

**Defender for Cloud integration:**

- **Continuous assessment:** Automatic security posture assessment with remediation recommendations.
- **Threat detection:** Behavioral analytics and machine learning detect suspicious activities.
- **Compliance monitoring:** Track compliance with regulatory standards (PCI DSS, ISO 27001, HIPAA).
- **Just-in-time VM access:** Reduce attack surface by enabling RDP/SSH access only when needed.

**Azure Monitor and Application Insights:**

- **Application performance monitoring:** Detect anomalies in application behavior indicating security incidents.
- **Log Analytics:** Centralized logging for security event correlation and investigation.
- **Alert rules:** Automated alerts for suspicious patterns (unusual traffic, failed authentication attempts, privilege escalation).

Implementing comprehensive pipeline security protects development workflows, credentials, deployment processes, and production systems from unauthorized access and malicious activities. By integrating security controls throughout the pipeline lifecycle, organizations establish robust DevSecOps practices that maintain security without sacrificing development velocity. The next unit explores Microsoft Defender for Cloud for unified cloud security management.
