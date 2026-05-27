Tool updates happen continuously in production systems. Northwind Health adds a new parameter to the drug interaction tool, restructures the lab reference response format, and retires the legacy appointment scheduling tool in favor of a FHIR-compliant replacement. Without governance workflows, these changes break deployed agents unpredictably. You implement tool registries as the single source of truth for versions and dependencies, semantic versioning rules, compatibility validation in CI/CD pipelines, and deprecation workflows that give agent teams time to migrate.

| Lifecycle Stage | Registry State | Agent Impact |
|----------------|----------------|--------------|
| Active | `status: active` | Tool available for all agents |
| Deprecated | `status: deprecated`, sunset date set | Tool available, warning logged on invocation |
| Sunset | `status: retired` | Tool returns specific error with migration guidance |

## Establish the tool registry as source of truth

The tool registry serves as more than a routing database — it's the authoritative record of which tool versions exist, their compatibility requirements, their lifecycle status, and which agents depend on them. Before deploying a new tool version, validate that all registered agents can handle the changes. Before retiring a tool, identify which agents still invoke it and coordinate migration.

Expand registry entries to include lifecycle status (active, deprecated, retired), compatibility requirements expressed as minimum agent SDK version, deprecation announcement date and sunset date for retired tools, and dependency graph showing which agents invoke each tool. This metadata transforms the registry from a passive directory into an active governance system that prevents breaking changes from deploying.

```python
from enum import Enum
from datetime import datetime, date
from typing import List, Optional

class ToolLifecycleStatus(Enum):
    ACTIVE = "active"
    DEPRECATED = "deprecated"
    RETIRED = "retired"

@dataclass
class ToolVersionMetadata:
    version: str
    released: date
    lifecycle_status: ToolLifecycleStatus
    deprecation_date: Optional[date] = None
    sunset_date: Optional[date] = None
    breaking_changes: List[str] = None
    min_agent_sdk_version: Optional[str] = None

@dataclass
class AgentDependency:
    agent_id: str
    agent_version: str
    tool_version_used: str
    last_invocation: datetime

class EnterpriseToolRegistry(ToolRegistry):
    def __init__(self):
        super().__init__()
        self.tool_versions = {}  # tool_name -> [ToolVersionMetadata]
        self.agent_dependencies = {}  # tool_name -> [AgentDependency]
    
    def register_version(
        self,
        tool_name: str,
        version_metadata: ToolVersionMetadata
    ):
        """Register a new tool version with lifecycle metadata"""
        if tool_name not in self.tool_versions:
            self.tool_versions[tool_name] = []
        self.tool_versions[tool_name].append(version_metadata)
    
    def record_agent_dependency(
        self,
        tool_name: str,
        agent_id: str,
        agent_version: str,
        tool_version: str
    ):
        """Track which agents depend on which tool versions"""
        if tool_name not in self.agent_dependencies:
            self.agent_dependencies[tool_name] = []
        
        dependency = AgentDependency(
            agent_id=agent_id,
            agent_version=agent_version,
            tool_version_used=tool_version,
            last_invocation=datetime.now()
        )
        self.agent_dependencies[tool_name].append(dependency)
    
    def get_active_dependencies(self, tool_name: str, tool_version: str) -> List[AgentDependency]:
        """Find agents currently using a specific tool version"""
        if tool_name not in self.agent_dependencies:
            return []
        
        # Filter to dependencies that invoked this version in last 7 days
        cutoff = datetime.now() - timedelta(days=7)
        return [
            dep for dep in self.agent_dependencies[tool_name]
            if dep.tool_version_used == tool_version
            and dep.last_invocation >= cutoff
        ]
```

When an agent invokes a tool, the MCP server extracts the agent's identity from the Azure AD token and records the dependency in the registry. Over time, the registry builds a complete dependency graph showing that 15 agents invoke drug_interaction v1.0, 3 agents invoke v1.1, and 0 agents invoke the retired v0.9. This visibility makes deprecation decisions data-driven rather than guesswork.

## Apply semantic versioning for tool changes

Semantic versioning communicates the impact of changes through version numbers. A MAJOR version increment (1.0 → 2.0) signals breaking changes that require agent updates. A MINOR version increment (1.0 → 1.1) adds backward-compatible functionality that agents can optionally adopt. A PATCH version increment (1.0.0 → 1.0.1) fixes bugs without changing behavior.

Breaking changes for MCP tools include removing a required parameter from the schema, changing a parameter's type (string → integer), removing a response field agents expect, or changing response structure fundamentally. When Northwind Health restructures the drug interaction response from `{"severity": "moderate"}` to `{"severity": {"level": "moderate", "score": 5}}`, this breaks agents parsing `response["severity"]` directly and requires MAJOR version 2.0.0.

| Change Type | Version Increment | Example |
|-------------|-------------------|---------|
| Remove required parameter | MAJOR | `lookup_drug_interaction(drug_a, drug_b)` → `(drugs: list)` |
| Add optional parameter | MINOR | Add `patient_age: int = None` parameter |
| Fix bug in logic | PATCH | Correct interaction severity calculation |
| Change response structure | MAJOR | Nested severity object instead of flat string |
| Add response field | MINOR | Add `clinical_guidance` field to response |

Document what constitutes a breaking change in the tool governance policy. Northwind Health's policy states: parameter removal, type changes, and response field removal are breaking. Adding optional parameters, adding response fields, and changing error messages are non-breaking. This clarity prevents debates during code review about whether a change requires major version increment.

## Implement compatibility validation in CI/CD

Automated compatibility validation prevents deploying tool versions that break production agents. Add a GitHub Actions step that runs before tool deployment: downloads the compatibility matrix from the registry, identifies all agents that invoke this tool, retrieves their declared compatible tool versions, and validates that the deploying version satisfies all compatibility constraints.

For Northwind Health's drug interaction tool, the validation step queries the registry to find that 12 agents invoke this tool with versions 1.0.x through 1.2.x. The deployment pipeline verifies that deploying version 1.3.0 (MINOR increment) remains compatible with all agent versions because it adds optional parameters without removing existing ones. Deploying version 2.0.0 (MAJOR increment) fails validation because it breaks agents declaring compatibility only with 1.x versions.

```yaml
# .github/workflows/deploy-tool.yml
name: Deploy MCP Tool

on:
  push:
    branches: [main]

jobs:
  validate-compatibility:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Extract tool version from code
        id: version
        run: |
          VERSION=$(grep 'VERSION = ' tool.py | cut -d'"' -f2)
          echo "version=$VERSION" >> $GITHUB_OUTPUT
      
      - name: Query registry for dependencies
        id: dependencies
        run: |
          python scripts/query_registry_dependencies.py \
            --tool-name lookup_drug_interaction \
            --output dependencies.json
      
      - name: Validate compatibility
        run: |
          python scripts/validate_compatibility.py \
            --deploying-version ${{ steps.version.outputs.version }} \
            --dependencies dependencies.json \
            --fail-on-breaking-change true
      
      - name: Deploy to Azure Container Apps
        if: success()
        run: |
          az containerapp update \
            --name drug-interaction-tool \
            --image ${{ env.REGISTRY }}/drug-tool:${{ steps.version.outputs.version }}
```

The validation script implements semantic version comparison. It parses the deploying version (2.0.0) and each agent's supported version range (^1.0.0 meaning ≥1.0.0 <2.0.0), determines if the deploying version satisfies each range, and fails the deployment if any incompatibility exists. This prevents the deployment and triggers notification to the tool team: "Cannot deploy v2.0.0, would break 12 agents. Agents must update to support ^2.0.0 before deployment."

## Design tool deprecation workflows

Tool deprecation follows a phased approach that gives agent teams time to migrate. When Northwind Health decides to retire drug interaction tool v1.0 in favor of v2.0's improved accuracy, announce the deprecation with a 90-day sunset period. Update the tool's lifecycle status in the registry to DEPRECATED, set the sunset date, and begin logging warnings on every v1.0 invocation.

The deprecation workflow includes: registry update to `lifecycle_status: deprecated` with sunset date, implementation of warning responses on deprecated tool invocations, weekly reports to agent teams showing their remaining deprecation dependencies, and sunset enforcement that returns errors instead of results after the sunset date.

```python
def check_deprecation_status(tool_name: str, tool_version: str) -> Optional[dict]:
    """Check if tool version is deprecated and return warning"""
    if tool_name not in registry.tool_versions:
        return None
    
    for version_meta in registry.tool_versions[tool_name]:
        if version_meta.version == tool_version:
            if version_meta.lifecycle_status == ToolLifecycleStatus.DEPRECATED:
                days_until_sunset = (
                    version_meta.sunset_date - date.today()
                ).days
                
                if days_until_sunset <= 0:
                    # Past sunset, return error
                    return {
                        "status": "retired",
                        "message": f"Tool {tool_name} v{tool_version} was retired on {version_meta.sunset_date}",
                        "migration_guide": f"https://docs.northwind.health/tools/{tool_name}/migration",
                        "replacement_version": "2.0.0"
                    }
                else:
                    # Still deprecated, return warning
                    return {
                        "status": "deprecated",
                        "days_until_sunset": days_until_sunset,
                        "message": f"Tool {tool_name} v{tool_version} will be retired on {version_meta.sunset_date}",
                        "migration_guide": f"https://docs.northwind.health/tools/{tool_name}/migration"
                    }
    return None

@mcp.tool()
async def lookup_drug_interaction(drug_a: str, drug_b: str, _agent_id: str = None):
    """Check drug interactions with deprecation enforcement"""
    # Check deprecation status
    deprecation_info = check_deprecation_status("lookup_drug_interaction", "1.0.0")
    
    if deprecation_info and deprecation_info["status"] == "retired":
        # Tool is retired, return error
        return deprecation_info
    
    # Proceed with tool logic
    result = _perform_drug_interaction_check(drug_a, drug_b)
    
    # Attach deprecation warning if applicable
    if deprecation_info and deprecation_info["status"] == "deprecated":
        result["_deprecation_warning"] = deprecation_info
    
    return result
```

Track deprecation dependencies through registry queries. Generate weekly reports showing each agent team the deprecated tool versions they still invoke, the sunset date, and migration guidance. For Northwind Health, the report shows: "clinical-agent-prod v3.2 invoked drug_interaction v1.0 (deprecated) 1,247 times this week. Sunset in 45 days. Migration guide: [link]". This visibility creates urgency and tracks progress.

After the sunset date, the tool stops performing work and returns structured error responses with migration guidance. This forcing function ensures agents update. The error response includes the retired status, sunset date that passed, link to migration documentation, and the recommended replacement version. Agents log these errors prominently, creating production incidents that escalate to engineering teams who complete the migration.

These governance workflows transform tool evolution from an ad-hoc process into a managed lifecycle. Northwind Health's clinical tool ecosystem maintains stability while continuously improving because compatibility validation prevents breaking changes, deprecation workflows give teams time to adapt, and the registry provides visibility into the entire dependency graph.

## Unit summary

- **Tool registry as source of truth** tracks lifecycle status, compatibility requirements, deprecation dates, and agent dependency graphs — enabling data-driven governance rather than guesswork
- **Semantic versioning** communicates change impact — MAJOR for breaking changes (parameter removal, response restructuring), MINOR for backward-compatible additions, PATCH for bug fixes
- **CI/CD compatibility validation** prevents deploying tool versions that break production agents by checking the deploying version against all registered agent dependency ranges before deployment proceeds
- **Phased deprecation workflows** give agent teams 90-day migration windows with progressive enforcement — warnings during invocation, weekly dependency reports, and hard errors after the sunset date
- **Dependency tracking** records which agents invoke which tool versions via Azure AD identity extraction, building a real-time dependency graph that makes deprecation impact assessment concrete
