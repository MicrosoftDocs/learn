Enterprise agent deployments require multiple isolated environments that progress from development experimentation to production operation. Each environment needs its own infrastructure, configuration, and access controls. Changes flow through the environment sequence—dev to staging to production—with validation gates at each boundary.

| Environment | Purpose | Data Characteristics | Deployment Frequency |
|-------------|---------|---------------------|---------------------|
| Development | Experimentation, rapid iteration | Synthetic test data | Multiple times per day |
| Staging | Production parity validation | Anonymized production data | Daily |
| Production | Customer-facing operations | Live customer data | Weekly or triggered |

## Progress changes through environment tiers

The environment progression model ensures that changes are validated at increasing levels of realism before reaching customers. Development environments use inexpensive models (GPT-4o-mini) and synthetic data to enable rapid iteration. Staging environments mirror production infrastructure and use production-equivalent models with sanitized data to validate performance characteristics. Production serves live customer traffic.

Each environment requires its own Azure AI Foundry project, agent deployments, and connected resources. Use consistent naming conventions to identify environment boundaries:

```text
fabrikam-agents-dev-eastus
fabrikam-agents-staging-eastus
fabrikam-agents-prod-eastus

fabrikam-agents-dev-kv
fabrikam-agents-staging-kv
fabrikam-agents-prod-kv
```

The environment suffix appears in every resource name, making it immediately clear which environment you're operating in. This prevents accidental modifications to production resources during development work.

## Configure environment-specific agent behavior

Agents behave differently across environments to balance cost, performance, and data sensitivity. Production uses GPT-4o for maximum quality. Development uses GPT-4o-mini for 97% cost reduction. Production connects to authenticated customer code repositories. Development uses public code examples from GitHub.

Store environment-specific configuration in Azure App Configuration with environment-based namespaces:

```text
Namespace: dev
  agents:orchestrator:model = gpt-4o-mini
  agents:orchestrator:temperature = 0.7
  agents:security-scanner:model = gpt-4o-mini
  data:repository_connection = mock

Namespace: staging
  agents:orchestrator:model = gpt-4o
  agents:orchestrator:temperature = 0.3
  agents:security-scanner:model = gpt-4o
  data:repository_connection = anonymized_production

Namespace: production
  agents:orchestrator:model = gpt-4o
  agents:orchestrator:temperature = 0.3
  agents:security-scanner:model = gpt-4o
  data:repository_connection = live_customer_repos
```

Agents load configuration based on the `ENVIRONMENT` variable set by the container runtime. This approach centralizes environment differences in configuration rather than scattering them through code.

## Deploy infrastructure with environment-parameterized templates

Use infrastructure as code to define agent deployments and their dependencies. Bicep templates parameterized by environment ensure consistency across environments while allowing environment-specific values for scale, redundancy, and security settings.

Here's a Bicep module that deploys a Fabrikam code review agent with environment-specific configuration:

```bicep
// modules/agent-deployment.bicep
@description('Environment name: dev, staging, or production')
@allowed(['dev', 'staging', 'production'])
param environment string

@description('Azure region for deployment')
param location string = resourceGroup().location

@description('Agent name')
param agentName string

// Environment-specific configurations
var environmentConfig = {
  dev: {
    modelDeployment: 'gpt-4o-mini'
    containerCpu: '0.5'
    containerMemory: '1.0Gi'
    minReplicas: 1
    maxReplicas: 2
  }
  staging: {
    modelDeployment: 'gpt-4o'
    containerCpu: '1.0'
    containerMemory: '2.0Gi'
    minReplicas: 2
    maxReplicas: 5
  }
  production: {
    modelDeployment: 'gpt-4o'
    containerCpu: '2.0'
    containerMemory: '4.0Gi'
    minReplicas: 5
    maxReplicas: 20
  }
}

var config = environmentConfig[environment]

resource containerApp 'Microsoft.App/containerApps@2023-05-01' = {
  name: 'fabrikam-${agentName}-${environment}'
  location: location
  properties: {
    configuration: {
      ingress: {
        external: false
        targetPort: 8000
      }
      secrets: [
        {
          name: 'ai-project-key'
          keyVaultUrl: 'https://fabrikam-${environment}-kv.vault.azure.net/secrets/ai-project-key'
          identity: 'system'
        }
      ]
    }
    template: {
      containers: [
        {
          name: agentName
          image: 'fabrikam.azurecr.io/${agentName}:latest'
          resources: {
            cpu: json(config.containerCpu)
            memory: config.containerMemory
          }
          env: [
            {
              name: 'ENVIRONMENT'
              value: environment
            }
            {
              name: 'MODEL_DEPLOYMENT'
              value: config.modelDeployment
            }
            {
              name: 'AI_PROJECT_KEY'
              secretRef: 'ai-project-key'
            }
          ]
        }
      ]
      scale: {
        minReplicas: config.minReplicas
        maxReplicas: config.maxReplicas
      }
    }
  }
  identity: {
    type: 'SystemAssigned'
  }
}
```

This Bicep module adjusts compute resources, model selection, and scaling limits based on the environment parameter. Deploy with:

```azurecli
az deployment group create \
  --resource-group fabrikam-agents-staging \
  --template-file modules/agent-deployment.bicep \
  --parameters environment=staging agentName=orchestrator
```

Using infrastructure as code ensures that environment configurations are versioned, auditable, and reproducible.

## Isolate secrets with environment-specific Key Vaults

Never share Key Vaults across environments. Production secrets must be accessible only to production workloads with tightly controlled access. Development secrets can be accessible to the entire development team. Each environment gets its own Key Vault with environment-appropriate access controls.

Configure Azure RBAC assignments that grant agent managed identities access to their environment's Key Vault:

```azurecli
# Grant production orchestrator agent access to production Key Vault only
az role assignment create \
  --assignee <production-orchestrator-managed-identity-id> \
  --role "Key Vault Secrets User" \
  --scope /subscriptions/<subscription-id>/resourceGroups/fabrikam-agents-production/providers/Microsoft.KeyVault/vaults/fabrikam-prod-kv

# Development agents cannot access production secrets
az role assignment list \
  --assignee <dev-orchestrator-managed-identity-id> \
  --scope /subscriptions/<subscription-id>/resourceGroups/fabrikam-agents-production
# Returns empty - no access granted
```

This isolation prevents development environment compromises from affecting production data or credentials.

## Gate promotions between environments with approvals

Moving from staging to production requires explicit approval and optionally human sign-off from designated reviewers. GitHub Actions environment protection rules enforce approval gates:

```yaml
# .github/workflows/deploy-production.yml
name: Deploy to Production
on:
  workflow_dispatch:
    inputs:
      version:
        description: 'Version tag to deploy'
        required: true

jobs:
  deploy-production:
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://fabrikam-agents-prod.azurewebsites.net
    steps:
      - uses: actions/checkout@v4
        with:
          ref: ${{ inputs.version }}
      
      - name: Azure Login
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS_PROD }}
      
      - name: Deploy agent infrastructure
        run: |
          az deployment group create \
            --resource-group fabrikam-agents-production \
            --template-file infrastructure/main.bicep \
            --parameters environment=production version=${{ inputs.version }}
```

Configure the `production` environment in GitHub repository settings with required reviewers. When this workflow runs, GitHub pauses execution at the `environment: production` declaration and notifies reviewers. Deployment proceeds only after approval.

This approval gate provides a human checkpoint before production changes. Reviewers verify that staging validation passed, evaluation metrics are acceptable, and the deployment timing aligns with customer maintenance windows.

> [!TIP]
> **Pause and reflect:** Your team is about to deploy a new agent version that passed all staging tests. A production customer has a version pin expiring in 3 days, and another customer requires EU data residency. How would you sequence the promotion to avoid violating either constraint?

With multi-environment configuration and promotion gates in place, you have a structured path from development to production. The final component of a robust CI/CD system is automated rollback when deployments cause quality regressions.

## Developer environment standardization

Multi-agent systems involve multiple languages, runtimes, and cloud CLI tools. Without standardized developer environments, onboarding takes days and "works on my machine" issues waste sprint time. The architect's job is to define the SDLC artifact set that governs how developers and AI assistants interact with the codebase, parallel to how `CONTRIBUTING.md` defines human contribution patterns.

Five SDLC artifacts standardize the multi-agent developer environment:

1. **Dev containers** — A `.devcontainer/devcontainer.json` file specifies the complete developer environment: base image (Python 3.12 + Azure CLI), VS Code extensions to install on container start, post-create setup scripts, and port forwarding rules. Every developer opens the same environment. GitHub Codespaces uses the same configuration for fully cloud-hosted development — the `devcontainer.json` is the single source of truth for "what does a correct development environment look like."

2. **VS Code extension manifests** — `.vscode/extensions.json` lists baseline-required extensions (Python, GitHub Copilot, Azure CLI Tools, Bicep) and recommended extensions (REST Client, Azure AI Inference). The architect decision: baseline-required extensions go in `extensions.json`; the dev container's `customizations.vscode.extensions` array installs them automatically; recommended extensions are listed as suggestions but not auto-installed.

3. **CLI tooling pinning** — Pin CLI tool versions in CI configuration to ensure reproducible automation. The standard tool set for Azure AI multi-agent development: Azure CLI (`az`), Azure Developer CLI (`azd`) for provisioning and deploying full-stack applications, Bicep CLI for IaC compilation, and GitHub CLI (`gh`) for PR automation. In GitHub Actions, pin these versions explicitly rather than relying on the runner's default versions.

4. **Dependency management** — Python lock files ensure deterministic installs. Use `uv` or `pip-tools` to generate `requirements.lock` from `requirements.in`; commit both files to source control. The architect decision: lock-file commit policy (always commit) + dependency-update automation (Dependabot or Renovate to propose updates as PRs with automated test runs). Unpinned dependencies are a production stability risk in long-running agent deployments.

5. **AI instructions files** — Repository-wide AI assistant context is a first-class SDLC artifact. `.github/copilot-instructions.md` provides Copilot with codebase conventions that apply to every chat and inline suggestion in the repository. `AGENTS.md` is the emerging cross-tool standard for agent-development context (used by Claude, GitHub Copilot, and other AI coding assistants). A well-maintained AI instructions file includes: naming conventions, which patterns are approved vs. deprecated, key module boundaries, and the case-company context that frames code contributions.

> [!NOTE]
> **AI instructions files (Training only):** The specific file names (`.github/copilot-instructions.md`, `AGENTS.md`) and their runtime behaviors evolve as tooling matures. The architect principle is stable: AI assistants need the same codebase context that human contributors get from `CONTRIBUTING.md`. Authoring and maintaining AI instructions files is a first-class SDLC responsibility. This topic is not a direct AI-500 exam blueprint item.

## Azure Well-Architected Framework alignment for compute selection

Infrastructure decisions in multi-agent CI/CD pipelines connect to the Azure Well-Architected Framework (WAF) five pillars. When choosing compute options for agent hosting (Container Apps, AKS, Azure Functions) and CI/CD infrastructure, each pillar provides a lens:

| WAF Pillar | CI/CD and compute design consideration |
|---|---|
| **Reliability** | Multi-region deployment strategies, health probes, circuit breakers, and automated rollback (this module) ensure agents remain available when deployments fail |
| **Security** | RBAC per environment, Key Vault isolation, OIDC-based GitHub Actions authentication (no stored credentials), managed identity for all agent-to-service calls (LP3 M2) |
| **Cost Optimization** | Environment-tier compute sizing (GPT-4o-mini in dev, GPT-4o in prod), Container Apps scale-to-zero for non-production environments, model routing (LP3 M4) |
| **Operational Excellence** | IaC-parameterized Bicep templates, promotion gates with explicit approval, DTAP environment naming conventions, AI instructions files for developer tooling consistency |
| **Performance Efficiency** | AKS warm pods for latency-sensitive agents, Container Apps burst scaling for variable load, parallel agent spawning (LP1 M2 Unit 5) for throughput |

Frame every compute sizing and hosting decision in your architecture review against these five pillars. WAF pillar compliance is also the standard lens for Azure Architecture Reviews — the same vocabulary enables faster architectural feedback from Azure experts.

## DTAP environment naming

The **DTAP** (Development, Test, Acceptance, Production) vocabulary is the standard enterprise naming convention for environment tiers. Some teams add a fifth tier (Pre-production or Staging between Acceptance and Production). Regardless of the exact tier count, the DTAP convention names the concern: each tier validates progressively higher-fidelity representations of the production environment, and no tier promotes changes backward. The `dev → staging → production` three-tier model used throughout this module is a DTAP-compatible structure — "staging" corresponds to the Acceptance tier in the four-tier model.

## Key takeaways

- **Environment tiers** progress changes through dev, staging, and production with increasing validation realism at each boundary.
- **Environment-specific configuration** uses Azure App Configuration namespaces to vary model selection, temperature, and data connections per environment.
- **Infrastructure as code** parameterizes Bicep templates by environment to ensure consistent, auditable, and reproducible deployments.
- **Key Vault isolation** gives each environment its own secrets store with RBAC preventing cross-environment access.
- **Promotion gates** require explicit approval—including optional human sign-off—before changes move from staging to production.
