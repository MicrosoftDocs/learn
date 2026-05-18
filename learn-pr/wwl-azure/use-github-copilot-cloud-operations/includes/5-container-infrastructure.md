Containerization is no longer a separate concern from infrastructure. When your application runs on Kubernetes, the Dockerfile, the Kubernetes manifests, and the underlying Azure infrastructure are all part of the same IaC estate. They share the same version control, the same CI/CD pipeline, and the same review process.

GitHub Copilot is well-suited for container infrastructure because Dockerfile syntax and Kubernetes YAML are highly structured and pattern-rich. These characteristics are the same qualities that make Bicep generation effective. Most containerization patterns appear frequently in open-source projects, giving Copilot strong coverage of best practices.

## Generating Dockerfiles with GitHub Copilot

### The anatomy of a good Dockerfile prompt

An effective Dockerfile prompt specifies the application type, the base image, the runtime requirements, and the security requirements. Missing any of these core container components, leads Copilots to default to simpler but less secure patterns.

**A minimal but problematic prompt:**
```
Create a Dockerfile for a Node.js app.
```

Copilot may produce a single-stage Dockerfile that runs as root, includes dev dependencies, and uses an unpinned base image tag. Each of these is a security or efficiency concern.

**A better prompt:**
```
Generate a production-grade multi-stage Dockerfile for a Node.js Express application.
Requirements:
- Build stage: node:20-alpine, install all dependencies, no build step needed (pure JS)
- Runtime stage: node:20-alpine
- Copy only node_modules and application files to the runtime stage
- Do not include devDependencies in the runtime image
- Create a non-root user with UID 1001 and run the process as that user
- Set NODE_ENV=production
- Expose port 3000
- Add a HEALTHCHECK that polls GET /health every 30 seconds
- Pin the base image to a specific digest for reproducibility
```

### Multi-stage builds

A single-stage Dockerfile copies everything into the final image, including build tools, dev dependencies, test files, and source maps. This approach potentially inflates the image size and increases the attack surface. Multi-stage builds separate the build environment from the runtime environment. Only the artifacts needed to run the application are copied into the final image.

```dockerfile
# Stage 1: Build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .

# Stage 2: Runtime
FROM node:20-alpine AS runtime
WORKDIR /app

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup -u 1001

# Copy only what is needed from the build stage
COPY --from=builder --chown=appuser:appgroup /app/node_modules ./node_modules
COPY --from=builder --chown=appuser:appgroup /app/package.json ./
COPY --from=builder --chown=appuser:appgroup /app/server.js ./
COPY --from=builder --chown=appuser:appgroup /app/routes ./routes

ENV NODE_ENV=production
USER appuser
EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://localhost:3000/health || exit 1

CMD ["node", "server.js"]
```

### Using Copilot as a security reviewer

After generating a Dockerfile, ask Copilot to review it:

```
Review this Dockerfile for security vulnerabilities and best practices.
Check for:
1. Processes running as root
2. Sensitive files or environment variables that might be copied into the image
3. Unpinned or mutable image tags (e.g., "latest")
4. Unnecessary packages or capabilities included in the runtime image
5. Missing HEALTHCHECK instruction
6. Layer caching inefficiencies that could expose secrets in build history
```

Copilot flags specific line numbers and explains each concern. This review prompt works on any Dockerfile, not just ones generated with Copilot.

## Generating Kubernetes manifests with GitHub Copilot

### What to include in a Kubernetes prompt

Kubernetes manifests interact with cluster-specific resources: ingress controllers, storage classes, namespaces, and identity systems. A good Kubernetes prompt specifies:

- The resource types needed (Deployment, Service, Ingress, ConfigMap, and so on)
- The application's port and protocol
- Resource requests and limits
- Health probe endpoints
- Environment variables and their source (ConfigMap, Secret, or direct value)
- Namespace
- The ingress class name if applicable

### Generating a full deployment stack

```
Generate Kubernetes YAML manifests for a Node.js API application on AKS.
Include the following resources separated by ---:

Deployment:
- 3 replicas
- Image: iaclab-api:v1 (from a private ACR registry acr-iaclab.azurecr.io)
- Resource requests: 100m CPU, 128Mi memory
- Resource limits: 500m CPU, 512Mi memory
- Liveness probe: GET /health on port 3000, initialDelaySeconds 10, periodSeconds 15
- Readiness probe: GET /ready on port 3000, initialDelaySeconds 5, periodSeconds 10
- Environment variable APP_ENV sourced from a ConfigMap named "iaclab-config"
- Pod anti-affinity: prefer to spread replicas across different nodes
  (preferredDuringSchedulingIgnoredDuringExecution)

Service:
- ClusterIP type
- Port 80 mapping to container port 3000

Ingress:
- Ingress class: nginx
- Host: iaclab.training.azure.com
- Path: / (prefix)
- TLS: reference a secret named "iaclab-tls"

ConfigMap:
- Name: iaclab-config
- Key APP_ENV with value "staging"

Apply namespace: iaclab to all resources.
```

### Understanding health probes

Kubernetes uses two types of probes to manage container lifecycle.

**Liveness probe** answers the question: is this container alive? If the liveness probe fails repeatedly, Kubernetes kills the container and starts a new one. Use it to detect when the application entered an unrecoverable state such as a deadlock or crash loop.

**Readiness probe** answers the question: is this container ready to receive traffic? If the readiness probe fails, Kubernetes removes the pod from the Service endpoint list. Traffic stops flowing to it until the probe recovers. Use it to signal when the application finished startup or is temporarily overloaded.

To add a startup probe:

```
Add a startupProbe to the Deployment container spec. The startup probe should
call GET /health on port 3000, with a failureThreshold of 30 and
periodSeconds of 10. This gives the container up to 5 minutes to start before
liveness probes begin checking.
```

### Hardening with security contexts

By default, Kubernetes containers run with more privileges than necessary. A `securityContext` at the pod and container level restricts what the container can do.

```
Add security contexts to the Deployment in this manifest:

Pod-level securityContext:
- runAsNonRoot: true
- seccompProfile type: RuntimeDefault

Container-level securityContext:
- runAsUser: 1001
- runAsGroup: 1001
- readOnlyRootFilesystem: true
- allowPrivilegeEscalation: false
- capabilities: drop ALL

Also add an emptyDir volume mounted at /tmp so the application can write
temporary files despite the read-only root filesystem.
```

After Copilot generates the updated manifest, ask it to explain each setting:

```
Explain each field in the securityContext in plain language.
For each setting, describe what attack or misuse it prevents.
```

This pattern works well for team learning. Use Copilot to generate, then use Copilot to explain.

### AKS-specific patterns

AKS introduces Azure-specific concepts that standard Kubernetes manifests don't address. Copilot knows these patterns well.

**Workload Identity:**
```
Add Azure Workload Identity annotations to the Deployment and ServiceAccount.
The workload should use a managed identity with client ID
"00000000-0000-0000-0000-000000000000".
Add the required azure.workload.identity/client-id annotation to the
ServiceAccount and the azure.workload.identity/use: "true" label to the pod spec.
```

**Azure Disk Persistent Volume:**
```
Add a PersistentVolumeClaim for 10Gi using the managed-csi storage class
(Azure Disk). Mount it at /data in the container with ReadWriteOnce access mode.
```

**Pod Disruption Budget:**
```
Add a PodDisruptionBudget for the Deployment that ensures at least 2 replicas
are always available during voluntary disruptions (node drains, upgrades).
```

## Reviewing existing manifests

Paste any Kubernetes manifest into Copilot Chat and ask for a review:

```
Review this Kubernetes manifest for:
1. Security issues (missing security context, running as root, privileged containers)
2. Missing resource requests or limits
3. Missing health probes
4. Configurations that would cause problems in a production AKS cluster
5. Any deprecated API versions (e.g., apps/v1beta is deprecated)

For each issue, identify the line, explain the risk, and provide the corrected YAML.
```

This review prompt is useful for teams that accumulated manifests over time and want to bring them up to current standards without manually auditing each file.

## Helm chart scaffolding

For reusable application packaging, Copilot can scaffold Helm chart structures. Use a prompt that specifies the chart name, the resources to include, the values to parameterize, and any AKS-specific requirements such as ingress class or workload identity. Copilot generates the `Chart.yaml`, `values.yaml`, and template files in the expected directory structure. Review the generated `values.yaml` carefully to ensure sensitive defaults aren't committed to source control.
