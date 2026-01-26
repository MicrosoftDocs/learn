AI applications require fast iteration without sacrificing reliability. When you ship new model versions, dependency updates, or prompt logic, you need deployment controls that let you roll forward confidently and roll back quickly when a change introduces errors or latency regressions. This module guides you through managing containerized workloads on Azure Container Apps across the day-two lifecycle.

Imagine you’re a developer building an AI document processing pipeline. The system exposes an HTTP API that accepts PDFs, and it runs a background worker that performs OCR and classification. Your team deploys both services to Azure Container Apps because you want managed scaling, integrated logging, and a simplified operational model.

You push new container images several times a day as you tune prompts, update model routing, and fix reliability issues. During one rollout, a new revision never becomes ready because it fails health probes. Users continue to hit the older revision, but the on-call engineer still needs to diagnose the failure quickly. At the same time, your platform team expects you to keep revision history clean, to avoid runaway resource cost, and to use logs instead of shell access.

This module focuses on the operational decisions and tools you use to keep Container Apps healthy while you ship frequently. You learn how image updates create revisions, how to manage traffic and rollback, and how to troubleshoot common failures using logs and probe signals.

After completing this module, you’ll be able to:

- Update container images and manage revisions safely during development and release cycles, including activation, deactivation, rollback, and cleanup.
- Perform app lifecycle operations, including start, stop, and restart, and diagnose failing revisions.
- Monitor logs and troubleshoot common revision and runtime issues.
- Configure liveness and readiness probes and troubleshoot probe failures.
- Optimize container resources and scaling settings to balance cost and performance.

> [!NOTE]
> All command examples in this module use Azure CLI patterns that you can adapt to your environment. Azure Container Apps features and Azure CLI flags change over time, so validate the exact syntax against the current documentation before you automate these commands.

## Additional resources

If you want more context before you start the hands-on units, review the core product concepts first. These links provide the baseline terminology for environments, revisions, and the CLI surface you use throughout the module.

- [Azure Container Apps overview](/azure/container-apps/overview)
- [Azure Container Apps revisions](/azure/container-apps/revisions)
- [Azure CLI: az containerapp](/cli/azure/containerapp)
