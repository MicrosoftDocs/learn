Health probes protect your users during rollouts by preventing traffic from reaching unhealthy replicas. For AI APIs, readiness probes are especially important because startup often includes loading models, warming caches, or establishing dependency connections. Liveness probes help you recover when a process becomes stuck, but overly aggressive liveness settings can create unnecessary restarts and increase cold starts.

> [!NOTE]
> Probe support and the exact YAML schema can evolve. Use the examples in this unit as patterns, and validate the current schema in the Azure Container Apps documentation before you adopt these settings.

## Understand readiness versus liveness

Readiness answers the question, “Can this replica receive traffic right now?” If readiness fails, the platform should avoid routing requests to that replica. Liveness answers the question, “Is this process healthy enough to keep running?” If liveness fails, the platform restarts the replica.

In an AI solution, you commonly treat readiness as a guard for model loading and dependency readiness. You treat liveness as a safety valve for deadlocks and runaway memory issues. You tune both probes so they match your real startup and steady-state behavior.

## Recognize common probe failure causes

Probe failures are frequently configuration issues rather than code issues. When a new revision fails probes, validate the simple causes first so you do not spend time chasing the wrong layer.

Common causes include:

- The probe targets the wrong **port**.
- The probe targets the wrong **path**.
- The probe **timeouts** are too short for model loading or warmup.
- The service requires a dependency call at startup, and that call fails or is slow.

## Configure probes in the container app template

Probe configuration lives alongside your container definition. The following YAML fragment shows the intent of the configuration. You should adapt the values to match how your AI service starts, and you should confirm that the endpoint returns success only after the service is truly ready.

```yaml
# Code fragment - focus on readiness and liveness probes
properties:
  template:
    containers:
    - name: api
      image: <registry>/<repo>@sha256:<digest>
      probes:
      - type: Readiness
        httpGet:
          path: /health/ready
          port: 8080
        initialDelaySeconds: 20
        periodSeconds: 10
        timeoutSeconds: 2
        failureThreshold: 3
      - type: Liveness
        httpGet:
          path: /health/live
          port: 8080
        initialDelaySeconds: 60
        periodSeconds: 10
        timeoutSeconds: 2
        failureThreshold: 3
```

## Troubleshoot probe failures during rollout

When probes fail, combine revision status and logs. Revision status tells you whether the platform considers the revision healthy, and logs tell you whether the application started successfully and which endpoint it exposed. You should also confirm that the probe endpoints do not depend on external systems that might be unavailable during an incident.

If an AI service loads a model at startup, tune `initialDelaySeconds` and `failureThreshold` to give the process enough time to reach a ready state. If you see liveness failures shortly after startup, liveness is likely too aggressive or the process is failing fast due to misconfiguration.

## Additional resources

Health probes interact directly with revision rollouts, traffic routing, and restart behavior. Use these links to confirm the current schema and to understand how probe failures surface in revision status.

- [Azure Container Apps health probes](/azure/container-apps/health-probes)
- [Azure Container Apps revisions](/azure/container-apps/revisions)
