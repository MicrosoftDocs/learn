Single-agent CI/CD follows a linear path: test the agent, build the container, deploy to staging, verify functionality, promote to production. The dependency chain is simple because there's only one component to coordinate. Multi-agent systems introduce complexity—each agent has its own pipeline, and inter-agent dependencies create a deployment graph where one agent's API contract becomes another agent's integration requirement.

| Deployment Aspect | Single Agent | Multi-Agent System |
|-------------------|-------------|-------------------|
| Pipeline structure | Linear test → build → deploy | Dependency graph with coordinated stages |
| Version management | Single version tag | Version matrix across agents |
| Integration testing | Agent + external services | Agent + dependent agents |
| Rollback scope | One component | Coordinated multi-component rollback |

## Model agent dependencies as a deployment graph

The first step in coordinated deployment is understanding which agents depend on which other agents. In Fabrikam's code review system, the orchestrator agent depends on all specialist agents because it calls their tool interfaces. The reporting agent depends on the orchestrator because it consumes the orchestrator's structured output. The security scanner and style checker don't depend on each other—they work in parallel.

You model these relationships as a directed acyclic graph (DAG). Each node represents an agent, and each edge represents a dependency relationship. Agent A depends on Agent B means that Agent A calls Agent B's tools or consumes Agent B's output schema. If Agent B changes its tool schema, Agent A might break unless it's compatible with the change.

Express this dependency graph in a configuration file that your CI/CD system can parse. Here's an example dependency manifest for Fabrikam's system:

```yaml
# agent-dependencies.yml
agents:
  - name: ingestion
    depends_on: []
    
  - name: syntax-analyzer
    depends_on: [ingestion]
    
  - name: style-checker
    depends_on: [ingestion]
    
  - name: security-scanner
    depends_on: [ingestion]
    
  - name: performance-profiler
    depends_on: [syntax-analyzer]
    
  - name: orchestrator
    depends_on: [syntax-analyzer, style-checker, security-scanner, performance-profiler]
    
  - name: reporting
    depends_on: [orchestrator]
```

This manifest defines the deployment order constraints. You can't deploy the orchestrator before deploying the agents it depends on, unless you've verified backward compatibility.

## Validate version compatibility before deployment

Before deploying Agent B version 2.0, check that all agents depending on Agent B can still function with the new version. This requires contract testing: comparing the API contract that Agent B v2.0 exposes against the contracts that dependent agents currently expect.

Contract testing for agents focuses on tool schemas. When Agent A calls Agent B using the AI Foundry agent runtime, it expects specific tool input parameters and output structures. If Agent B v2.0 adds a required parameter to an existing tool, Agent A breaks unless it also updates to send that parameter.

Implement contract validation as a GitHub Actions job that runs before any deployment:

```yaml
# .github/workflows/validate-compatibility.yml
name: Agent Compatibility Validation
on:
  pull_request:
    paths:
      - 'agents/**'

jobs:
  validate-contracts:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Extract tool schemas from updated agents
        run: |
          python scripts/extract_agent_schemas.py \
            --agent-path agents/ \
            --output contracts/current.json
      
      - name: Compare against baseline contracts
        run: |
          python scripts/validate_compatibility.py \
            --baseline contracts/baseline.json \
            --current contracts/current.json \
            --dependency-graph agent-dependencies.yml
      
      - name: Check for breaking changes
        run: |
          if [ -f contracts/breaking-changes.txt ]; then
            echo "Breaking changes detected:"
            cat contracts/breaking-changes.txt
            exit 1
          fi
```

The validation script loads the dependency graph, identifies which agents depend on the modified agent, and checks whether the tool schema changes are backward compatible. Adding optional parameters is safe. Changing required parameter types or removing tools are breaking changes that require coordinated updates.

## Order deployments based on dependency graph

When deploying a set of related agent updates, order matters. If Agent A depends on Agent B, and both are being updated, you must deploy Agent B first. Otherwise, Agent A tries to call the new tool interface before Agent B exposes it.

Implement deployment ordering using GitHub Actions job dependencies with the `needs` keyword. Build the deployment DAG directly from your dependency manifest:

```yaml
# .github/workflows/deploy-agents.yml
name: Deploy Multi-Agent System
on:
  workflow_dispatch:
    inputs:
      environment:
        type: choice
        options: [staging, production]
        required: true

jobs:
  deploy-ingestion:
    runs-on: ubuntu-latest
    steps:
      - name: Deploy ingestion agent
        run: |
          az containerapp update \
            --name ingestion-agent \
            --resource-group fabrikam-${{ inputs.environment }} \
            --image fabrikam.azurecr.io/ingestion:${{ github.sha }}
  
  deploy-syntax-analyzer:
    needs: [deploy-ingestion]
    runs-on: ubuntu-latest
    steps:
      - name: Deploy syntax analyzer agent
        run: |
          az containerapp update \
            --name syntax-agent \
            --resource-group fabrikam-${{ inputs.environment }} \
            --image fabrikam.azurecr.io/syntax-analyzer:${{ github.sha }}
  
  deploy-style-checker:
    needs: [deploy-ingestion]
    runs-on: ubuntu-latest
    steps:
      - name: Deploy style checker agent
        run: |
          az containerapp update \
            --name style-agent \
            --resource-group fabrikam-${{ inputs.environment }} \
            --image fabrikam.azurecr.io/style-checker:${{ github.sha }}
  
  deploy-orchestrator:
    needs: [deploy-syntax-analyzer, deploy-style-checker]
    runs-on: ubuntu-latest
    steps:
      - name: Deploy orchestrator agent
        run: |
          az containerapp update \
            --name orchestrator-agent \
            --resource-group fabrikam-${{ inputs.environment }} \
            --image fabrikam.azurecr.io/orchestrator:${{ github.sha }}
```

This workflow deploys the ingestion agent first because it has no dependencies. The syntax analyzer and style checker deploy in parallel once ingestion completes. The orchestrator waits until both its dependencies finish. GitHub Actions ensures jobs run only when their prerequisites succeed.

For complex dependency graphs with many agents, generate the workflow YAML programmatically from the dependency manifest rather than maintaining it manually.

## Test contracts between dependent agents

Contract tests verify that Agent B's new version produces outputs that Agent A can consume. Unlike unit tests that validate individual agent behavior, contract tests validate the integration boundary between two agents.

Implement contract testing using the Pact framework or custom schema validation. For Azure AI Foundry agents, the contract is the tool schema plus the JSON structure of tool responses. A contract test for the orchestrator calling the style checker looks like this:

```python
# tests/contracts/test_style_checker_contract.py
import json
from azure.ai.agents import AgentsClient
from azure.identity import DefaultAzureCredential

def test_style_checker_returns_expected_schema():
    """Verify style checker tool output matches orchestrator expectations."""
    
    # Initialize agents
    agents_client = AgentsClient(
        endpoint=os.environ["PROJECT_ENDPOINT"],
        credential=DefaultAzureCredential(),
    )
    
    style_agent = agents_client.get_agent("style-checker-v2.0")
    
    # Execute tool call with sample input
    thread = agents_client.threads.create()
    agents_client.messages.create(
        thread_id=thread.id,
        role="user",
        content=json.dumps({
            "code_file": "sample.py",
            "style_guide": "pep8"
        })
    )
    run = agents_client.runs.create_and_process(thread_id=thread.id, agent_id=style_agent.id)
    messages = list(agents_client.messages.list(thread_id=thread.id))
    
    # Validate response structure matches contract
    result = json.loads(messages[0].text_messages[0].text.value)
    
    assert "violations" in result, "Missing required field: violations"
    assert isinstance(result["violations"], list), "Violations must be a list"
    
    if result["violations"]:
        violation = result["violations"][0]
        assert "line" in violation, "Missing field: line"
        assert "rule" in violation, "Missing field: rule"
        assert "severity" in violation, "Missing field: severity"
        assert violation["severity"] in ["error", "warning", "info"], \
            "Invalid severity value"
```

Run these contract tests in your validation job before deploying any agent changes. If a contract test fails, the deployment pipeline stops, preventing the incompatible version from reaching production.

With dependency modeling, compatibility validation, ordered deployments, and contract testing in place, you transform multi-agent deployments from a coordination nightmare into a predictable, automated process. The next step is implementing progressive deployment strategies that minimize risk when changes reach production.

## Key takeaways

- **Dependency graphs** model which agents depend on which, defining deployment order constraints as a directed acyclic graph (DAG).
- **Contract testing** validates that updated agents maintain compatible tool schemas before deployment proceeds.
- **Ordered deployments** use GitHub Actions `needs` keyword to deploy agents in dependency-graph order automatically.
- **Compatibility validation** catches breaking changes—like new required parameters or removed tools—before they reach production.
