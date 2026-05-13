## Understand Pod Security Standards

Kubernetes defines three **Pod Security Standards** that describe increasingly strict security postures for pod configurations. The **Pod Security Admission (PSA)** controller, built into Kubernetes since version 1.25, enforces these standards at the namespace level. Each standard defines a set of permitted and prohibited fields in pod specifications:

- **Privileged**: No restrictions. Reserved for system and infrastructure namespaces that require full host access—such as namespaces running node agents or storage drivers. Don't apply this profile to application workloads.
- **Baseline**: Prevents known privilege escalations. This profile blocks privileged containers, `hostPID`, `hostIPC`, `hostNetwork`, and most `hostPath` volume mounts. It provides a minimum security posture without breaking most containerized applications.
- **Restricted**: Heavily restricted. Enforces all baseline restrictions and additionally requires nonroot execution, prohibits privilege escalation, mandates a `seccompProfile`, and limits volume types. Recommended for application workloads and most production deployments.

## Apply Pod Security Standards to namespaces

Pod Security Standards are enforced through namespace labels. Each label specifies a profile and an enforcement mode. Three enforcement modes are available:

- **enforce**: Pods that violate the policy are rejected at admission.
- **warn**: Pods that violate the policy are allowed but the user receives an API warning at apply time.
- **audit**: Pods that violate the policy are allowed and the violation is recorded in the audit log.

Apply the Restricted profile to an application namespace:

```bash
kubectl label namespace retail-app \
  pod-security.kubernetes.io/enforce=restricted \
  pod-security.kubernetes.io/warn=restricted \
  pod-security.kubernetes.io/audit=restricted
```

Applying all three modes together gives you enforcement at admission, developer-visible warnings at apply time, and an audit trail of any violations that reach the cluster.

> [!TIP]
> Enable `warn` and `audit` modes in staging environments before enforcing in production. This surfaces workloads that would fail the Restricted standard and lets you fix them before the policy blocks deployments.

## Configure security contexts in pod specifications

Pod Security Standards set namespace-level guardrails. Security contexts specify the security configuration for individual containers. A pod spec that explicitly defines security context settings is easier to audit, more portable across clusters, and less likely to fail unexpectedly when namespace-level policies change.

The following pod spec demonstrates the key security context settings for a production workload:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: retail-api
  namespace: retail-app
spec:
  securityContext:
    runAsNonRoot: true
    seccompProfile:
      type: RuntimeDefault
  containers:
  - name: api
    image: contoso.azurecr.io/retail-api:latest
    securityContext:
      runAsUser: 1000
      readOnlyRootFilesystem: true
      allowPrivilegeEscalation: false
      capabilities:
        drop:
        - ALL
```

These settings enforce the following behaviors:

- **runAsNonRoot**: The container must run as a nonroot user. The admission controller rejects the pod if the image's default user is root and no `runAsUser` is specified.
- **runAsUser: 1000**: Sets a specific UID. Use a nonzero UID that matches a nonprivileged user defined in your container image.
- **readOnlyRootFilesystem**: Mounts the container's root filesystem as read-only. This prevents compromised processes from writing to disk or modifying application binaries.
- **allowPrivilegeEscalation: false**: Prevents any process in the container from acquiring more privileges than it started with—including through `setuid` binaries or Linux capabilities.
- **capabilities.drop: ALL**: Drops all Linux capabilities. Add back only the specific capabilities your application requires rather than inheriting the default capability set.
- **seccompProfile.type: RuntimeDefault**: Applies the container runtime's default seccomp profile, which restricts which system calls the container can make to the kernel.

## Improve host isolation with user namespaces

By default, the root user inside a container (UID 0) maps to the root user on the host node (also UID 0). A container breakout—a process escaping the container isolation boundary—gives the attacker root on the node. User namespaces decouple container UIDs from host UIDs.

When user namespaces are enabled and a pod opts in, the root user inside the container maps to an unprivileged UID on the host. Even if a vulnerability allows a process to escape the container, it's unprivileged on the node. Enable user namespaces for a pod by setting `hostUsers: false` in the pod spec:

```yaml
spec:
  hostUsers: false
```

This is a significant defense-in-depth improvement for workloads that process untrusted input or handle data from external sources.

## Apply AppArmor profiles for mandatory access control

AppArmor is a Linux kernel module that enforces mandatory access control for processes. Unlike Linux capabilities, which restrict which system calls a process can make, AppArmor restricts what resources a process can access by path—files, network sockets, and other system objects.

AKS nodes include AppArmor. Apply a per-pod profile using a pod annotation:

```yaml
metadata:
  annotations:
    container.apparmor.security.beta.kubernetes.io/api: runtime/default
```

The `runtime/default` profile restricts access to paths outside the container's filesystem. For higher-assurance workloads, load a custom profile on the node and reference it by name in the annotation.

With Pod Security Standards enforced at the namespace level, security contexts defining container-level restrictions, and optional user namespace and AppArmor hardening in place, each workload in Contoso Retail's cluster has an explicitly defined and auditable security posture.
