A deployment command can succeed while users experience incorrect results. The EShopOnWeb search fix might remove out-of-stock items correctly but introduce slow queries under production traffic. Exposing every user immediately would make that discovery more expensive.

Progressive exposure limits the initial impact and creates decision points before expanding the audience. It doesn't replace build verification or make production testing harmless. You need a target architecture that supports the chosen pattern, meaningful signals, and an enforceable way to stop.

## Choose the exposure mechanism for the risk

Deployment places a version in an environment. Release makes its behavior available to an audience. A feature flag can separate those events when the application is designed to support it.

| Pattern | What changes | Main design consideration |
| --- | --- | --- |
| Blue-green or deployment slots | Switch traffic between prepared versions/environments | Preserve compatible dependencies and confirm which settings and state remain shared |
| Rolling update | Replace instances in batches | Old and new versions coexist; capacity and protocol compatibility matter |
| Canary | Send a limited share of traffic or users to the candidate | Identify which requests actually use the candidate and compare relevant signals |
| Early-adopter rings | Expand through defined cohorts, such as staff, selected customers, then the wider audience | Early cohorts may not represent every later region, tenant, or workload |
| Dark launch | Run hidden functionality, sometimes using shadow traffic, without returning its result to users | Prevent duplicate writes or other unintended side effects |
| Feature flag | Enable a code path for an approved audience | Control flag changes, evaluation consistency, and the behavior when configuration is unavailable |
| A/B test | Compare variants against an experiment objective | Business-result experimentation isn't a substitute for release-safety gates |

These approaches can be combined. For example, deploy a package with a feature disabled, verify it in staging, then enable it for a small production cohort. Don't assume that changing a flag reverses a database migration or undoes a write.

For the search example, suppose the team chooses a stable, explicitly targeted cohort before wider exposure. This is an illustrative design choice, not a feature already supplied by the sample application. The implementation must preserve cohort assignment well enough to interpret the resulting evidence.

### Combine environment promotion with a release strategy

For EShopOnWeb, rehearse the accepted candidate in dev/test and a representative staging environment before exposing production users. Then choose the production mechanism:

- **Early adopters:** Enable the corrected search path for an explicitly selected staff or customer ring. Observe their actual use before adding another audience. Opting in is not proof that the cohort represents production load.
- **Canary:** Route a small, measured population to the candidate and compare candidate-specific correctness, errors, and latency with a suitable baseline. A percentage is an exposure limit, not a success criterion.
- **Blue-green:** Prepare a second version or deployment pool, warm and verify it, then change traffic. Keep the previous acceptable version available during the recovery window. Shared database state and slot-specific configuration can make swapping back unsafe.

A blue-green topology can support a canary traffic step before a complete switch, but a slot swap alone doesn't implement measured progressive exposure. A dev/test -> staging -> production sequence also doesn't automatically create canary or early-adopter behavior. Those mechanisms require workload support, routing or flag control, cohort attribution, and enforceable health decisions.

On App Service, deployment slots require a supported plan tier. Inspect which settings swap and which stay with the slot. Platform warm-up isn't a functional acceptance test; validate application behavior, dependencies, and configuration before changing traffic.

## Define health before defining the next ring

A useful gate combines technical health with the user outcome. HTTP success alone can't establish that search results exclude unavailable products. Conversely, one passing functional test can't establish acceptable production latency.

Define each signal's population, measurement window, source, threshold, and response to missing data. Compare equivalent endpoints, regions, and traffic classes. A global average can hide a regression in the new cohort, and a quiet cohort can appear healthy simply because it receives no traffic.

The following **fictional acceptance contract** illustrates the required precision. The thresholds are teaching values, not industry benchmarks or proven EShopOnWeb requirements:

| Signal | Illustrative acceptance rule |
| --- | --- |
| Observation window | At least two hours from the time the cohort first receives the enabled candidate behavior |
| Usage | At least 1,000 search requests attributed to that candidate and cohort during the observation window |
| Server errors | HTTP 5xx search responses divided by all search requests in that population must be below 1% |
| Latency | The 95th percentile of server-side search-request duration for that same population/window must not exceed 500 ms |
| Correctness | All approved known-stock search checks pass, including the out-of-stock case |
| Evidence freshness | At evaluation, the telemetry source confirms ingestion through a time no more than five minutes before the decision |

Minimum duration and request volume are both required. If two hours elapse without enough traffic, hold rather than infer success. Extend observation under the approved procedure; don't lower the sample requirement just to finish a deployment window. In a real workload, choose bake times long enough to cover meaningful usage cycles, potentially hours or days.

Use the known-stock checks as one signal, not proof of every possible production search result. Record the test-data state and result revision so that another reviewer can reproduce the check. Define immediate stop conditions for severe user impact separately; you don't wait for the full observation window to respond to an incident.

## Put gates at enforceable boundaries

Run predeployment checks before mutation, smoke tests after deployment, and cohort-health evaluation before the next exposure increase. A gate needs executable validation or independently reviewed evidence; a YAML comment that says "check health" doesn't implement it.

### Carry security and quality evidence into the gate

Run applicable checks as early as useful, then make delivery depend on their results for the accepted candidate. Moving the release decision here doesn't mean delaying security analysis until deployment.

| Control | Distinct question |
| --- | --- |
| Static application security testing | Does source analysis identify unsafe patterns or data flows? |
| Secret scanning | Are supported credential patterns exposed in the reviewed inputs? |
| Software composition analysis | Do dependencies introduce known vulnerabilities or policy violations? |
| Functional and quality checks | Do required suites execute and do changed-code quality rules pass? |

License decisions, vulnerability severity/reachability, and complexity or duplication trends need their own policy context. A high coverage percentage or repository-wide quality score doesn't compensate for a failed requirement. Distinguish accepted historical debt from new regressions using a trusted baseline.

Separate product enablement, scan execution, result publication, and enforcement. Confirm applicable licensing, supported ecosystems, discovered components, and results for the correct revision/artifact. An empty default-branch alert view doesn't prove a PR was scanned. GitHub dependency review and its workflow action are different from requiring the action's result; Azure DevOps scanning likewise needs an applicable enabled capability and an executing scan.

Define each gate's input, blocking rule, failure behavior, owner, and evidence reference. Missing, stale, skipped, or incorrectly scoped required reports mean unknown validation, not success. Preserve early results when they still cover the same candidate; reassess when inputs or the applicable policy change.

An exception identifies the finding/control, candidate, risk rationale, compensating control, accountable owner, independent approval, and expiry. A suppression without these fields isn't acceptance. Review gate changes separately from the application: the proposal must not pass by excluding its failing suite, weakening a threshold, or adding bypass permission. Copilot may explain findings or propose a correction, not approve its own exception.

Azure Pipelines resource owners configure approvals and checks outside the pipeline YAML. In GitHub Actions, environment protection rules can require approval or other permitted checks before a job proceeds. Supported rules depend on the repository plan and visibility. A waiting period supplies time, not evidence that the workload remained healthy.

Separate a human authorization from a measured health result. Approval doesn't repair a failed required check, and a passing metric doesn't authorize an identity to change production. Protect the gate configuration itself so that the proposed release can't quietly relax its own requirements.

## Make stopping and cleanup part of the design

For each ring, name the promotion owner, maximum permitted exposure, stop authority, and action on degraded or unavailable evidence. Holding promotion leaves the current exposure in place; it doesn't necessarily contain existing harm. Define who can disable a flag, stop routing new traffic, or initiate the approved recovery procedure.

Give temporary flags an owner and retirement condition. Remove obsolete branches and configuration only after compatibility and recovery needs are addressed. Retain the release record, including flag state, so later investigations can reconstruct what users actually experienced.

You now have a bounded rollout contract for Copilot to preserve when proposing YAML. The next unit evaluates that proposal; subsequent promotion uses the measured results rather than the assistant's confidence.

Learn more about [safe deployment practices](/azure/well-architected/operational-excellence/safe-deployments), [Azure DevOps dependency scanning](/azure/devops/repos/security/github-advanced-security-dependency-scanning?view=azure-devops), [GitHub dependency review](https://docs.github.com/en/code-security/concepts/supply-chain-security/dependency-review), [Azure Pipelines approvals and checks](/azure/devops/pipelines/process/approvals?view=azure-devops), and [GitHub deployment protection rules](https://docs.github.com/en/actions/reference/workflows-and-actions/deployments-and-environments).
