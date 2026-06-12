Azure OpenAI Service meters usage by input and output tokens, making token consumption a direct cost driver in multi-agent systems that process long conversation chains.

A customer contacts Adventure Works about a complex return situation. The orchestrator agent analyzes the request and routes to the order lookup agent, which finds the order and passes context to the eligibility agent, which checks return policy and consults the exception handling agent, which escalates to the approval agent. By the time the fifth agent in the chain processes the request, the accumulated context includes: the original customer message (150 tokens), the order lookup results (400 tokens), the policy retrieval (800 tokens), the exception analysis (300 tokens), and conversation history (500 tokens). Total context: 2,150 tokens. The actual question the approval agent needs to answer requires maybe 200 tokens of relevant context. Token waste at scale creates cost overruns—Adventure Works needs systematic context management to keep token budgets under control.

## Token budget creep in multi-agent conversations

Token consumption in multi-agent systems grows through three mechanisms: context accumulation as requests move through agent chains, conversation history retention in multi-turn sessions, and tool result injection where APIs return comprehensive data but agents need only specific fields. Each mechanism contributes to budget creep, and addressing all three requires different strategies.

**Context accumulation** occurs when each agent in a chain adds its working context to the shared state. The first agent receives the customer's question and adds its analysis. The second agent receives the question plus the first agent's analysis and adds its own findings. The third agent receives all previous context plus its contribution. By the time the request reaches the fifth agent, 80% of the context is irrelevant to that agent's specific task, but the orchestrator includes it anyway "just in case." The result: token usage grows geometrically rather than linearly with chain length.

**Conversation history bloat** happens in multi-turn customer service sessions. The customer asks a question, the agent responds, the customer asks a follow-up, the agent responds again. After seven turns, the context includes 14 messages, but only the most recent two or three turns are actually relevant to the current question. Keeping the full history "for context" burns tokens on information the model ignores. Adventure Works found that retaining all conversation history increased average token usage by 3x compared to intelligent history pruning.

**Tool result over-injection** wastes tokens on unused data. The inventory API returns 50-field product records with detailed specifications, warehouse locations, supplier information, and historical sales data. The agent needs three fields: product name, current stock level, and price. Injecting the full 50-field record into context consumes 400 tokens; extracting just the needed fields consumes 30 tokens. Across thousands of tool calls per day, the difference is substantial. The solution: define agent-specific tool result schemas that extract only required fields before context injection.

## Context summarization for agent chains

Instead of passing full conversation history and all previous agents' outputs to each downstream agent, Adventure Works' orchestrator maintains a compressed context digest that captures only the essential established facts. The digest is a structured summary that each agent can read quickly and update incrementally.

The digest format uses a key-value structure: customer identified (true/false), customer tier (gold/standard/basic), order number (if found), order status (if retrieved), return eligibility (if determined), exception required (true/false), approval status (pending/approved/rejected). Each agent in the chain reads the relevant fields from the digest, performs its task, and updates only the fields it's responsible for. The downstream agent receives the updated digest plus minimal context about what the previous agent decided, not the full reasoning chain.

For example, the order lookup agent receives the customer's question and the empty digest. It finds order #12345, updates the digest with order number and status, and passes control to the eligibility agent. The eligibility agent receives the digest (which now includes the order number), retrieves the return policy, determines eligibility, updates the digest, and passes to the exception agent. The exception agent sees only the digest fields relevant to its decision—it doesn't need the full order lookup results or the detailed policy retrieval that the eligibility agent used.

Summarization reduces token usage but introduces risk: if the summary loses critical information, downstream agents make incorrect decisions. Adventure Works mitigates this risk through summary validation. After generating a digest update, a lightweight validation model checks whether the summary preserves all facts that appeared in the original context. If the validator detects information loss, the system falls back to full context for that request and logs the failure for digest schema refinement.

## Rolling context windows with importance filtering

Multi-turn customer service conversations naturally focus on recent exchanges—the customer's question from 10 minutes ago is rarely relevant to their current question unless it's part of an ongoing issue. Rolling context windows keep only the N most recent conversation turns, dramatically reducing token usage while maintaining coherent conversations.

Adventure Works implements a 3-turn rolling window: the system retains the three most recent customer-agent exchanges (six messages total) plus an optional importance-filtered selection from earlier in the conversation. The importance filter identifies turns that should be retained beyond the window:

- Turns where the customer explicitly stated a preference, for example "I prefer email communication."
- Turns where critical context was established, for example "This is for my business account, not personal."
- Turns where the agent made a commitment, for example "I'll follow up with you by Friday."

Importance classification uses a small classifier model that scores each conversation turn on a 0-1 scale for long-term relevance. Turns scoring above 0.75 are flagged as "important" and retained outside the rolling window. The classifier is trained on historical conversation data where human reviewers labeled which past turns were referenced in later turns—if turn 3 was referenced in turn 15, turn 3 was important and should have been retained.

```python
from openai import AzureOpenAI
import tiktoken

class ContextAssembler:
    def __init__(self, openai_client, max_tokens=4000):
        self.openai_client = openai_client
        self.max_tokens = max_tokens
        self.encoder = tiktoken.encoding_for_model("gpt-4")
    
    def count_tokens(self, text):
        """Count tokens in text string."""
        return len(self.encoder.encode(text))
    
    def build_digest(self, conversation_history):
        """Build compressed context digest from conversation history."""
        digest = {
            "customer_identified": False,
            "customer_tier": "unknown",
            "order_number": None,
            "order_status": None,
            "return_eligible": None,
            "exception_required": False,
            "approval_status": None
        }
        
        # Extract facts from conversation history
        for turn in conversation_history:
            if "order" in turn.get("content", "").lower() and turn.get("role") == "assistant":
                # Extract order number using regex or NER
                import re
                match = re.search(r'order #?(\d+)', turn["content"], re.IGNORECASE)
                if match:
                    digest["order_number"] = match.group(1)
            
            if "gold member" in turn.get("content", "").lower():
                digest["customer_tier"] = "gold"
            
            if "return" in turn.get("content", "").lower() and "not eligible" in turn.get("content", "").lower():
                digest["return_eligible"] = False
        
        return digest
```

The `build_digest` method scans Adventure Works conversation history and extracts structured facts—customer tier, order number, return eligibility—into a compact dictionary. This digest replaces verbose conversation replay with a few key-value pairs, cutting hundreds of tokens down to a single line of established context.

```python
    def filter_important_turns(self, conversation_history, importance_threshold=0.75):
        """Identify conversation turns that should be retained for long-term context."""
        important_turns = []
        
        for turn in conversation_history:
            # Lightweight importance scoring using keyword patterns
            importance_score = 0.0
            content = turn.get("content", "").lower()
            
            # Flag explicit preferences
            if any(phrase in content for phrase in ["i prefer", "please don't", "make sure to"]):
                importance_score = max(importance_score, 0.8)
            
            # Flag commitments
            if turn.get("role") == "assistant" and any(phrase in content for phrase in ["i'll", "we will", "expect"]):
                importance_score = max(importance_score, 0.85)
            
            # Flag account type declarations
            if "business account" in content or "corporate" in content:
                importance_score = max(importance_score, 0.9)
            
            if importance_score >= importance_threshold:
                important_turns.append(turn)
        
        return important_turns
```

Not every past conversation turn deserves retention. The `filter_important_turns` method scores each turn using keyword heuristics—flagging explicit customer preferences, agent commitments, and account type declarations—so the assembler can selectively retain high-value turns outside the rolling window without consuming budget on routine exchanges.

```python
    def assemble_context(self, conversation_history, digest, system_prompt, tool_results, token_budget):
        """Assemble agent context within token budget using compression strategies."""
        # Start with system prompt (always included, uses prompt caching)
        context_parts = [{"role": "system", "content": system_prompt}]
        tokens_used = self.count_tokens(system_prompt)
        
        # Add compressed digest
        digest_text = "Established facts: " + ", ".join(f"{k}={v}" for k, v in digest.items() if v)
        context_parts.append({"role": "system", "content": digest_text})
        tokens_used += self.count_tokens(digest_text)
        
        # Add tool results (extract only needed fields to reduce tokens)
        if tool_results:
            compressed_tool_results = self.compress_tool_results(tool_results)
            tool_text = f"Tool results: {compressed_tool_results}"
            context_parts.append({"role": "system", "content": tool_text})
            tokens_used += self.count_tokens(tool_text)
        
        # Add important turns from history
        important_turns = self.filter_important_turns(conversation_history[:-6])  # Exclude recent window
        for turn in important_turns:
            if tokens_used + self.count_tokens(turn["content"]) > token_budget * 0.7:
                break  # Reserve 30% for rolling window
            context_parts.append(turn)
            tokens_used += self.count_tokens(turn["content"])
        
        # Add rolling window (most recent 6 messages)
        rolling_window = conversation_history[-6:]
        for turn in rolling_window:
            if tokens_used + self.count_tokens(turn["content"]) > token_budget:
                # Emergency compression: summarize the turn
                turn["content"] = turn["content"][:100] + "..."
            context_parts.append(turn)
            tokens_used += self.count_tokens(turn["content"])
        
        return context_parts, tokens_used
    
    def compress_tool_results(self, tool_results):
        """Extract only essential fields from tool results."""
        compressed = {}
        
        for tool_name, result in tool_results.items():
            if tool_name == "product_lookup":
                # Extract only name, price, stock from 50-field product record
                compressed[tool_name] = {
                    "name": result.get("product_name"),
                    "price": result.get("current_price"),
                    "stock": result.get("stock_level")
                }
            elif tool_name == "order_lookup":
                # Extract only order number, status, items from full order record
                compressed[tool_name] = {
                    "order_id": result.get("order_id"),
                    "status": result.get("fulfillment_status"),
                    "items": len(result.get("items", []))
                }
        
        return compressed
```

## Per-agent token budgets with enforcement

Adventure Works assigns each agent an explicit token budget that defines the maximum context size it can consume per request. The budget allocation reflects the agent's task complexity: simple lookup agents get 2,000-token budgets, reasoning agents get 4,000-token budgets, and complex policy interpretation agents get 8,000-token budgets. When an agent's assembled context exceeds its budget, the context assembler applies aggressive compression before invocation.

Budget enforcement works through priority-based pruning. The assembler categorizes context components by priority, and when the assembled context exceeds the budget, it removes or compresses the lowest-priority components first until the context fits within the limit.

| Priority | Component | Pruning behavior |
|----------|-----------|-----------------|
| 1 | System prompt | Never pruned |
| 2 | Digest | Rarely pruned |
| 3 | Tool results | Compressed first |
| 4 | Important conversation turns | Pruned if necessary |
| 5 | Rolling window turns | Summarized if budget is tight |

Logging budget violations helps identify optimization opportunities. Each time an agent exceeds its token budget and triggers compression, the system logs the violation with context about what was compressed and why. Monthly budget analysis reveals which agents consistently exceed their budgets—these agents either need larger budgets (reassess task complexity) or better-designed system prompts (remove verbose instructions). Adventure Works discovered that three agents regularly exceeded budgets because their system prompts included 800-token policy documents that could have been moved to retrieval tools, freeing budget for conversation context.

An agent that consistently exceeds its token budget because tool results inject full API responses is a good candidate for tool result schema redesign. Consider which fields the agent actually references in its decisions, and extract only those fields before injecting results into context.

Token budget optimization is the final pillar of cost control. Combined with intelligent model routing and multi-level caching, these three strategies transform Adventure Works' multi-agent system from a cost liability into a sustainable, scalable platform. The last step: balancing these cost optimizations against quality and latency requirements to ensure customer experience doesn't suffer in the pursuit of efficiency.

## Key takeaways

- Per-agent token budgets are essential for controlling the cost of model inference in multi-agent systems.
- Priority-based pruning is a powerful technique for managing context size within token limits.
- Logging and analyzing budget violations helps identify optimization opportunities.
- Tool result schema redesign can significantly reduce the token usage of multi-agent systems.
- Balancing cost optimizations with quality and latency requirements is crucial for maintaining customer experience.
