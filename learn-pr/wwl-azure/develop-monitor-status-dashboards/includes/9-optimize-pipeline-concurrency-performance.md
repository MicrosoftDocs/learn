Concurrency optimization enables pipelines to execute multiple jobs simultaneously, dramatically reducing total execution time while managing associated costs. The key is finding the optimal balance between parallelism (how many jobs run at once) and resource costs (infrastructure expenses).

**Benefits of concurrency:**

- **Faster feedback:** Developers get build results sooner—shorter feedback loops
- **Higher throughput:** More builds/deployments complete per day
- **Better resource utilization:** Keep agents busy instead of idle
- **Improved developer experience:** Less waiting, more productivity

**Cost considerations:**

- **Agent licensing:** Parallel jobs require additional parallel job licenses
- **Infrastructure costs:** More concurrent agents = higher compute costs
- **Diminishing returns:** 2× agents doesn't always = 2× speed

**Optimization goal:** Maximize pipeline throughput and minimize execution time while controlling infrastructure and licensing costs.

## Parallel jobs and stages

**Job-level parallelism:**

- **Independent jobs:** Run jobs that don't depend on each other simultaneously
- **Matrix builds:** Test multiple configurations (OS, runtime, browser) in parallel
- **Example:** Build + Unit Tests + Integration Tests run concurrently—saves 10+ minutes

**Stage-level parallelism:**

- **Multi-region deployments:** Deploy to multiple regions simultaneously
- **Environment-specific tests:** Run smoke tests for each environment in parallel
- **Example:** Deploy to East US, West US, Europe in parallel instead of sequentially

**Test parallelization:**

- **Distribute tests:** Split test suite across multiple agents
- **Tools:** Azure Pipelines test splitting, pytest-xdist, parallel test runners
- **Example:** 1000 tests on 10 agents = 10× faster than single agent

**Cost-benefit analysis:**

**Scenario 1: Build without parallelism**

- **Duration:** 30 minutes serial execution
- **Cost:** 1 agent × 30 minutes = 30 agent-minutes
- **Feedback time:** 30 minutes

**Scenario 2: Build with 3 parallel jobs**

- **Duration:** 10 minutes (jobs run simultaneously)
- **Cost:** 3 agents × 10 minutes = 30 agent-minutes
- **Feedback time:** 10 minutes
- **Value:** 3× faster feedback, same cost

**Finding the balance:**

- **Too few parallel jobs:** Long wait times, frustrated developers
- **Too many parallel jobs:** Costs increase with diminishing speed returns
- **Sweet spot:** Enough parallelism for acceptable speed at reasonable cost

## Job dependencies and execution order

**Dependency modeling:**

- **dependsOn:** Specify which jobs must complete before others start
- **Critical path:** Identify longest dependency chain—optimize these jobs first
- **Parallel opportunities:** Jobs without dependencies can run simultaneously

**Example pipeline structure:**

```yaml
jobs:
  - job: Build
    # No dependencies—starts immediately

  - job: UnitTests
    dependsOn: Build # Waits for Build

  - job: IntegrationTests
    dependsOn: Build # Waits for Build (runs parallel to UnitTests)

  - job: Deploy
    dependsOn: [UnitTests, IntegrationTests] # Waits for both tests
```

**Conditional execution:**

- **Skip unnecessary work:** Use conditions to avoid running irrelevant jobs
- **Branch-specific logic:** Different concurrency for main vs. feature branches
- **Example:** Skip expensive integration tests on draft PRs

**Resource contention prevention:**

- **Separate agent pools:** Use different pools for compute-intensive vs. lightweight jobs
- **Demands:** Ensure jobs with special requirements get appropriate agents
- **Locks:** Prevent multiple jobs from accessing shared resources simultaneously

## Agent sizing and pool management

**Agent size selection:**

**Microsoft-hosted agents:**

- **Standard:** 2 vCPU, 7 GB RAM—sufficient for most workloads
- **Cost:** Pay per minute of usage
- **Pros:** Zero maintenance, automatic scaling
- **Cons:** Limited customization, potential queue times

**Self-hosted agents:**

- **Small:** 2 vCPU, 4 GB RAM—lightweight builds
- **Medium:** 4 vCPU, 16 GB RAM—typical builds
- **Large:** 8+ vCPU, 32+ GB RAM—compute-intensive builds
- **Pros:** Full control, pre-installed tools, can be cheaper at scale
- **Cons:** Requires maintenance, capacity planning

**Sizing strategy:**

- **Profile workloads:** Monitor CPU, memory, disk usage during builds
- **Match to needs:** Don't overprovision—wastes money
- **Specialized pools:** Create pools for specific workload types

**Multiple agent pools:**

**Pool strategy:**

- **Default pool:** Standard agents for typical builds (4 vCPU)
- **Heavy pool:** High-performance agents for large builds (8+ vCPU)
- **Fast pool:** NVMe SSD agents for I/O-intensive workloads
- **Example assignment:** Mobile app builds → Heavy pool, API builds → Default pool

**Dynamic scaling (self-hosted):**

- **Azure VMSS:** Auto-scale agent pools based on demand
- **Scale up:** Add agents when queue depth increases
- **Scale down:** Remove idle agents to save costs
- **Example:** Scale from 5 agents (overnight) to 20 agents (business hours)

## Monitoring and tuning concurrency

**Key metrics:**

**Queue time:**

- **Definition:** Time jobs wait for available agent
- **Target:** < 1 minute for interactive builds
- **Action if high:** Add more agents or parallel job licenses

**Agent utilization:**

- **Definition:** Percentage of time agents are busy vs. idle
- **Target:** 60-80% utilization (allows burst capacity)
- **Action if low:** Reduce agent pool size or consolidate pools
- **Action if high:** Add more agents

**Concurrency efficiency:**

- **Metric:** Total agent-minutes / (wall clock time × agent count)
- **Target:** > 80% (indicates effective parallelization)
- **Low efficiency:** Jobs waiting on dependencies, poor parallelization

**Dashboard metrics:**

- **Current queue depth:** How many jobs waiting right now
- **Average queue time:** Typical wait time over last 24 hours
- **Agent busy percentage:** How much agents are utilized
- **Parallelism factor:** Average concurrent jobs / available agents

**Tuning approach:**

**Step 1: Establish baseline**

- Measure current queue times, durations, agent utilization
- Identify peak hours and usage patterns

**Step 2: Identify bottlenecks**

- **Long queue times:** Need more agents
- **Low utilization:** Too many agents
- **Long durations:** Need parallelization or faster agents

**Step 3: Implement changes**

- Add/remove agents incrementally
- Adjust parallel job limits
- Optimize pipeline structure for parallelism

**Step 4: Measure impact**

- Compare metrics before/after changes
- Validate improvements justify costs

**Step 5: Iterate**

- Continuously monitor and adjust
- Respond to workload changes over time

**Cost optimization strategies:**

**Right-size for workload:**

- **Morning rush:** Scale up for peak commit activity
- **Overnight/weekend:** Scale down during low activity
- **Automated scaling:** Use VMSS or similar for dynamic adjustment

**Parallel job licenses:**

- **Microsoft-hosted:** Buy just enough for peak concurrent demand
- **Self-hosted:** Unlimited parallelism included—no incremental cost

**Example optimization:**

- **Before:** 10 parallel jobs, average 5 min queue time, $500/month
- **After:** 15 parallel jobs, average 30 sec queue time, $650/month
- **Value:** $150/month buys 4.5 min faster feedback—worth it for team productivity
