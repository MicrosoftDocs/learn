Azure Blob Storage and Azure OpenAI Service work together to enable deterministic replay debugging for multi-agent production failures. Azure Blob Storage stores complete execution snapshots—model versions, system prompts, tool call responses, and trace context—that the replay framework uses to reproduce the exact conditions of a production failure in an isolated environment.

Production bugs in multi-agent systems are frustratingly nondeterministic. A customer reports a checkout failure, but when the support engineer tries the same product in staging, checkout completes successfully. The original failure involved a specific combination of model version, cached prompt, customer context, and tool response timing that's difficult to recreate manually. Traditional debugging—"try to reproduce it and add logging"—fails because you can't reliably reproduce the conditions. Agent replay debugging solves this by capturing complete execution context from production failures and replaying it deterministically in an isolated environment. Engineers can then step through execution, modify inputs, and identify exactly where behavior diverged from expectations.

## Why replay-based debugging is essential for multi-agent systems

Multi-agent systems exhibit nondeterministic behavior from multiple sources. Language model outputs vary slightly between invocations even with identical inputs due to sampling strategies and internal model state. Tool calls access live data sources that change over time—the inventory level returned today differs from yesterday. Agent-to-agent delegation decisions depend on runtime routing logic that considers current load and availability. Caching introduces variability where the same question might hit cache on one run and miss on another. These sources of nondeterminism make traditional "just run it again" debugging unreliable.

Replay debugging eliminates nondeterminism by capturing and freezing all variable inputs from the production execution. When a failure occurs in production, the replay system records everything needed to reproduce it exactly. This includes the customer input text, model deployment versions for each agent invoked (gpt-4o-2025-01-21 for agent A, gpt-4o-mini-2024-07-18 for agent B), system prompt versions with content hashes, tool call responses or mocked equivalents, cache hit/miss decisions, and the OpenTelemetry trace context for timeline reconstruction. With this snapshot, the replay framework can execute the exact same agent chain in a debug environment and produce identical behavior to production.

Deterministic replay enables debugging workflows that are impossible with live systems. Engineers can set breakpoints at specific agent boundaries and inspect context state, inject different tool responses to test hypotheses about which data caused the failure, swap in experimental prompt versions to validate fixes before deploying, and run the replay thousands of times with different variations to identify edge cases. The production system remains untouched while debugging happens in isolated safety.

## What must be captured for reliable replay

Reliable replay requires comprehensive context capture that goes beyond standard application logging. Adventure Works' replay snapshot schema includes five critical categories of data.

**Input data** captures the exact customer request that triggered the agent chain: the raw text of the customer's message, any structured inputs (product IDs, order numbers), session context (customer tier, account state), and conversation history from earlier turns if the failure occurred mid-session. These inputs are stored exactly as the production system received them, with no normalization or modification.

**Model deployment metadata** records which specific model versions handled each agent invocation. Azure OpenAI deployments are versioned (gpt-4o-2025-01-21 differs from gpt-4o-2024-11-20), and model behavior can vary between versions. The snapshot includes the deployment name, model version identifier, and inference endpoint URL for each agent. If the production system used three different agents, the snapshot lists all three model deployments.

**System prompt versions** are captured with content hashes to ensure exact reconstruction. Prompts change frequently as teams optimize agent behavior, and a bug might be introduced by a recent prompt update. The snapshot stores the complete system prompt text for each agent plus an SHA-256 hash. During replay, the framework verifies that loaded prompts match the hashed versions from production. If prompts have changed since the production failure, the replay framework alerts the engineer that perfect reproduction isn't possible.

**Tool call responses** capture either the actual API responses from production or mocked versions that preserve response structure. Storing actual tool responses creates PII and data consistency challenges (what if the order referenced in the response was deleted?), so Adventure Works uses mock equivalents: the replay framework intercepts tool calls and returns predefined responses that match the production data structure but use synthetic values. For example, if production called `order_lookup(order_id=12345)` and received an order record, the mock returns a structurally identical record using synthetic values.

**OpenTelemetry trace context** provides timeline reconstruction: which agents were called in which order, how long each step took, where errors occurred, what the parent-child relationships between spans were. The complete trace ID allows the replay framework to load the full execution timeline from Application Insights and recreate the exact call sequence.

| Snapshot component | Purpose | Example |
|-------------------|---------|---------|
| Input data | Exact customer request | "I want to return order 12345" |
| Model versions | Specific model deployments | `gpt-4o-2025-01-21` |
| System prompts | Exact prompts with hashes | `sha256:abc123...` |
| Tool responses | Mocked equivalent data | Synthetic order record |
| Trace context | Execution timeline | OpenTelemetry trace ID |

The snapshot is stored as a JSON file in Azure Blob Storage, indexed by trace ID and timestamp. When an engineer needs to debug a production failure, they load the snapshot by trace ID and initiate replay.

## Implementing deterministic replay infrastructure

The replay infrastructure has four components. A snapshot recorder captures production execution context. A replay runner executes agent chains with captured inputs. A mock tool interceptor provides deterministic tool responses. A comparison validator detects divergences between replay and production outputs.

The snapshot recorder integrates with the application's OpenTelemetry instrumentation. When an agent chain completes (successfully or with error), the instrumentation middleware checks whether the trace is flagged for debugging. Flagging happens automatically for all failed requests and can be triggered manually for specific traces that need investigation. If flagged, the recorder queries Application Insights for the complete trace, extracts all the snapshot components, serializes them to JSON, and uploads to Blob Storage with trace ID as the filename.

The replay runner provides a CLI interface for engineers: `python replay_agent.py --trace-id trace-abc123def456`. The runner loads the snapshot from Blob Storage, initializes agent clients with the captured model deployments, injects the captured system prompts with hash verification, and configures the mock tool interceptor. With the environment prepared, it sets a replay-mode flag in context that all agent code checks before executing side effects, runs the agent chain with the captured inputs, and compares outputs at each step to the production trace.

```python
import json
import hashlib
from typing import Dict, Any, List
from azure.storage.blob import BlobServiceClient
from openai import AzureOpenAI

class AgentReplayFramework:
    def __init__(self, blob_connection_string: str, insights_connection_string: str):
        self.blob_client = BlobServiceClient.from_connection_string(blob_connection_string)
        self.insights_connection = insights_connection_string
        self.mock_responses = {}
    
    def capture_snapshot(self, trace_id: str) -> Dict[str, Any]:
        """Capture complete execution snapshot for a production trace."""
        # Query Application Insights for trace details
        trace_data = self.query_trace_from_insights(trace_id)
        
        snapshot = {
            "trace_id": trace_id,
            "timestamp": trace_data["timestamp"],
            "input_data": {
                "customer_message": trace_data["root_span"]["attributes"]["customer.message"],
                "session_context": trace_data["root_span"]["attributes"].get("session.context", {}),
                "conversation_history": trace_data["root_span"]["attributes"].get("conversation.history", [])
            },
            "model_deployments": {},
            "system_prompts": {},
            "tool_responses": {},
            "trace_timeline": []
        }
        
        # Extract model deployments and prompts from each agent span
        for span in trace_data["spans"]:
            if span["name"].startswith("agent_"):
                agent_id = span["attributes"]["agent.id"]
                
                # Capture model deployment
                snapshot["model_deployments"][agent_id] = {
                    "deployment_name": span["attributes"]["model.deployment"],
                    "model_version": span["attributes"]["model.version"],
                    "endpoint": span["attributes"]["model.endpoint"]
                }
                
                # Capture system prompt with hash
                system_prompt = span["attributes"]["prompt.system"]
                prompt_hash = hashlib.sha256(system_prompt.encode()).hexdigest()
                
                snapshot["system_prompts"][agent_id] = {
                    "content": system_prompt,
                    "hash": prompt_hash
                }
            
            # Capture tool call responses (mocked for replay)
            if span["name"].startswith("tool_"):
                tool_name = span["attributes"]["tool.name"]
                tool_response = span["attributes"]["tool.response"]
                
                # Create mock response preserving structure
                mock_response = self.create_mock_response(tool_name, tool_response)
                snapshot["tool_responses"][span["span_id"]] = {
                    "tool_name": tool_name,
                    "mock_response": mock_response
                }
            
            # Timeline reconstruction
            snapshot["trace_timeline"].append({
                "span_id": span["span_id"],
                "parent_id": span.get("parent_id"),
                "name": span["name"],
                "duration_ms": span["duration_ms"],
                "status": span["status"]
            })
        
        # Store snapshot to Blob Storage
        blob_container = self.blob_client.get_container_client("replay-snapshots")
        blob_container.upload_blob(
            name=f"{trace_id}.json",
            data=json.dumps(snapshot, indent=2),
            overwrite=True
        )
        
        return snapshot
```

The `capture_snapshot` method records the complete execution state from Application Insights—including model deployments, system prompt hashes, tool responses, and the full trace timeline. The snapshot is stored in Azure Blob Storage for later replay. The next methods load stored snapshots and verify that the current environment matches the production conditions at the time of the incident:

```python
    def load_snapshot(self, trace_id: str) -> Dict[str, Any]:
        """Load previously captured snapshot from Blob Storage."""
        blob_container = self.blob_client.get_container_client("replay-snapshots")
        blob_data = blob_container.download_blob(f"{trace_id}.json").readall()
        return json.loads(blob_data)
    
    def verify_prompt_hashes(self, snapshot: Dict[str, Any], current_prompts: Dict[str, str]) -> List[str]:
        """Verify that current prompts match snapshot hashes."""
        mismatches = []
        
        for agent_id, prompt_data in snapshot["system_prompts"].items():
            if agent_id not in current_prompts:
                mismatches.append(f"{agent_id}: prompt not found in current deployment")
                continue
            
            current_hash = hashlib.sha256(current_prompts[agent_id].encode()).hexdigest()
            snapshot_hash = prompt_data["hash"]
            
            if current_hash != snapshot_hash:
                mismatches.append(f"{agent_id}: hash mismatch (prompt changed since production failure)")
        
        return mismatches
```

Prompt hash verification detects whether system prompts changed between the production incident and the current replay—a common source of "works on my machine" confusion during debugging. If hashes differ, the replay might not reproduce the original behavior. The `replay_agent_chain` method executes the captured agent sequence with optional tool mocking:

```python
    def replay_agent_chain(self, snapshot: Dict[str, Any], enable_mocks: bool = True) -> Dict[str, Any]:
        """Execute agent chain with captured inputs and compare to production outputs."""
        # Enable replay mode
        replay_context = {"mode": "replay", "snapshot_trace_id": snapshot["trace_id"]}
        
        # Configure mock tool interceptor if enabled
        if enable_mocks:
            self.configure_tool_mocks(snapshot["tool_responses"])
        
        # Initialize agents with captured model deployments
        agent_clients = {}
        for agent_id, deployment in snapshot["model_deployments"].items():
            agent_clients[agent_id] = AzureOpenAI(
                azure_endpoint=deployment["endpoint"],
                api_version="2025-01-01-preview",  # Use the same api_version as the original production deployment for faithful replay
                azure_deployment=deployment["deployment_name"]
            )
        
        # Execute with captured inputs
        replay_result = {
            "snapshot_trace_id": snapshot["trace_id"],
            "replay_timestamp": str(datetime.now()),
            "step_comparisons": [],
            "final_output": None,
            "divergences_detected": []
        }
        
        # Run agent chain (implementation depends on your agent framework)
        # Compare outputs at each step to production trace
        
        return replay_result
```

The replay method initializes agent clients with captured model deployments and configures mock tool interceptors, then executes the agent chain while comparing outputs at each step to the production trace. The helper methods below handle tool response mocking and telemetry queries that support the replay process:

```python
    def create_mock_response(self, tool_name: str, production_response: Any) -> Any:
        """Create mock tool response that preserves structure but uses synthetic data."""
        # Implement mock response generation based on tool type
        if tool_name == "order_lookup":
            return {
                "order_id": "MOCK-12345",
                "status": "delivered",
                "items": [{"product": "MOCK-PRODUCT", "quantity": 1}],
                "total": 99.99
            }
        # Add other tool mocks as needed
        return {"mock": True, "original_structure": type(production_response).__name__}
    
    def configure_tool_mocks(self, tool_responses: Dict[str, Any]):
        """Configure tool interceptor to return mocked responses during replay."""
        self.mock_responses = {
            resp["tool_name"]: resp["mock_response"]
            for resp in tool_responses.values()
        }
    
    def query_trace_from_insights(self, trace_id: str) -> Dict[str, Any]:
        """Query Application Insights for complete trace data."""
        # Implementation using Azure Monitor Query API
        # Returns structured trace data with all spans
        pass
```

## Step-by-step execution and bisection debugging

Advanced replay supports step-by-step execution where engineers can pause between agent invocations, inspect context state, and inject modifications. This enables bisection debugging: when a replay shows divergence from production at step 5, the engineer can execute steps 1-4, pause, inject different inputs at step 5, and observe whether the divergence still occurs. Bisection isolates the exact step and input that caused the failure.

The replay framework also supports component version bisection. If an agent prompt was updated three times between the production failure and the current debug session, the engineer can run replay with each prompt version to identify which update introduced the regression. This is the multi-agent equivalent of git bisect—systematically narrowing the search space until the exact change that caused the bug is identified.

## Safe replay environment and production safeguards

Replay must never trigger real actions. A replay of a checkout failure shouldn't actually charge the customer's credit card, send order confirmation emails, or decrement inventory. Adventure Works implements a replay-mode flag that all agent code checks before executing side effects. When `context.get("mode") == "replay"`, all tool calls route through mock interceptors that return predefined responses without calling actual APIs.

The replay environment uses separate Azure resources from production: isolated model deployments (can use different quotas without affecting production), test storage accounts (won't corrupt production data), internal-only endpoints (no external network access), and restricted permissions (no write access to production databases). This isolation ensures that replay debugging can't accidentally cause production side effects.

Deterministic replay gives engineers something traditional debugging can't: the ability to test a proposed fix against the exact conditions of the original failure before shipping it to production. Root cause analysis builds on this foundation—replay becomes one tool in a broader process for tracing failures back to their origin.

## Key takeaways

- **Deterministic replay** captures complete execution context from production failures—inputs, model versions, system prompts, tool responses, and trace context—enabling exact reproduction in isolated environments.
- **Snapshot recording** integrates with OpenTelemetry instrumentation to automatically capture replay data for all failed requests, storing serialized JSON in Azure Blob Storage indexed by trace ID.
- **Mock tool interceptors** replace live API calls with predefined responses during replay, preventing side effects like charging credit cards or decrementing inventory while preserving response structure.
- **Bisection debugging** enables engineers to pause between agent steps, inject modifications, and systematically narrow which specific input or version change caused a failure.
- **Safe replay environments** use isolated Azure resources with separate model deployments, test storage, and restricted permissions to ensure replay can't cause production side effects.
