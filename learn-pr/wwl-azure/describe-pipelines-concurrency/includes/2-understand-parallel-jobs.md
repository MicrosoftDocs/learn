Parallel jobs represent the number of jobs your organization can run simultaneously. If you have one parallel job, only one pipeline job runs at a time. Additional jobs wait in a queue until the running job finishes.

:::image type="content" source="../media/parallel-job-consumption-8af32918.png" alt-text="Screenshot of Parallel job consumption.":::

## How parallel jobs work

When you run a pipeline:

- Each job consumes one parallel job slot
- Jobs run on available agents (Microsoft-hosted or self-hosted)
- If no parallel jobs are available, new jobs wait in queue
- Jobs release their slot when they complete

## Parallel job consumption example

Here's how parallel jobs work in practice:

1. **Build starts**: FabrikamFiber CI Build 102 (main branch) begins - uses 1 parallel job
2. **Release triggered**: FabrikamFiber Release 11 starts deployment - uses 1 parallel job
3. **Build queued**: FabrikamFiber CI Build 101 (feature branch) waits because no parallel jobs available
4. **Waiting for approval**: Release 11 pauses for approval - releases parallel job, Build 101 starts
5. **Release approved**: Release 11 waits for Build 101 to finish before resuming

## Key concepts

**Pipeline jobs vs parallel jobs**:

- **Pipeline jobs**: Individual work units within your pipeline (build, test, deploy)
- **Parallel jobs**: Capacity to run pipeline jobs simultaneously across your organization

**Jobs that don't use parallel jobs**:

- Server jobs (jobs without agents)
- Deployment group jobs
- Jobs waiting for manual approval
