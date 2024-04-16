In a managed Kubernetes environment, addressing security involves understanding and mitigating threats across various instances. Here’s a breakdown of threat factors in specific instances:

## Compromised Account

 -  Threat Factor: An attacker gains access to a Kubernetes cluster through stolen credentials, API tokens, or keys. This can lead to unauthorized access, data theft, and malicious deployments.
 -  Mitigation: Implement strong authentication mechanisms, multifactor authentication (MFA), regular rotation of credentials, and least privilege access principles.

## Vulnerable or Misconfigured Images

 -  Threat Factor: Container images with vulnerabilities or misconfigurations can be exploited by attackers once deployed. These vulnerabilities could include outdated software, insecure default settings, or embedded secrets.
 -  Mitigation: Use image scanning tools to detect vulnerabilities before deployment, enforce image provenance policies, and adopt a container image signing process.

## Environment Misconfiguration

 -  Threat Factor: Misconfigurations in Kubernetes settings or deployment descriptors can expose clusters to attacks. Common issues include exposed dashboard interfaces, overly permissive RBAC settings, and unsecured endpoints.
 -  Mitigation: Follow best practices for secure configuration, regularly audit configurations with automated tools, and employ admission controllers to enforce policy compliance.

## Application Attack Level

 -  Threat Factor: Applications running in containers might be vulnerable to traditional web attack vectors, such as SQL injection or cross-site scripting (XSS), which can compromise the container or lead to further cluster exploitation.
 -  Mitigation: Employ application security best practices, such as input validation and output encoding, and use Web Application Firewalls (WAFs). Implement security in the Continuous integration (CI)/Continuous delivery and or deployment (CD) pipeline including static and dynamic analysis tools.

## Node Level Attack

 -  Threat Factor: If an attacker gains access to a Kubernetes node, they can potentially escalate privileges to control the entire cluster. Vulnerabilities might arise from outdated operating systems or Kubernetes components.
 -  Mitigation: Keep nodes updated with the latest security patches, restrict access to nodes using network policies and firewalls, and employ host-based intrusion detection systems (HIDS).

## Unauthorized Traffic

 -  Threat Factor: Unauthorized access to or from the cluster can occur if network policies are not correctly configured, allowing attackers to exfiltrate data, deliver malware, or exploit exposed services.
 -  Mitigation: Implement strict network policies to control ingress and egress traffic, segregate sensitive workloads using namespaces, and monitor traffic for anomalous patterns.

Addressing these threats in a managed Kubernetes environment requires a layered security approach that encompasses both Kubernetes-specific practices and traditional security measures. Continuous monitoring, regular audits, and adherence to the principle of least privilege across all aspects of the cluster are essential components of a robust Kubernetes security strategy.

:::image type="content" source="../media/managed-kubernetes-threat-factors-657fe885.png" alt-text="Diagram showing an example of na managed Kubernetes threat factors.":::


## Common attack techniques

 -  Exploit vulnerable images - a public-facing vulnerable application in a cluster that enables initial access to the cluster. Infamous cases: SolarWinds, Log4j<br>
 -  Access exposed applications - a sensitive interface exposed to the internet poses a security risk. Some popular frameworks were not intended to be exposed to the internet, and therefore don’t require authentication by default. Thus, exposing them to the internet allows unauthenticated access to a sensitive interface which might enable running code or deploying containers in the cluster by a malicious actor. Examples of such interfaces that were seen exploited include Apache NiFi, Kubeflow, Argo Workflows, Weave Scope, and the Kubernetes dashboard.<br>
 -  Deploy backdoor containers - Attackers run their malicious code in a container in the cluster. By using the Kubernetes controllers such as DaemonSets or Deployments, attackers ensured that a constant number of containers run in one, or all, the nodes in the cluster.<br>
 -  Abuse over permissive roles SA – Service account (SA) represents an application identity in Kubernetes. By default, an SA is mounted to every created pod in the cluster. Using the SA, containers in the pod can send requests to the Kubernetes API server. Attackers who get access to a pod accesses to the SA token and perform actions in the cluster, according to the SA permissions. If RBAC is not enabled, the SA has unlimited permissions in the cluster. If RBAC is enabled, its permissions are determined by the RoleBindings and ClusterRoleBindings that are associated with it.<br>
 -  Escape to the host - hostPath volume mounts a directory or a file from the host to the container. Attackers who have permissions to create a new container in the cluster may create one with a writable hostPath volume and gain persistence on the underlying host. For example, the latter can be achieved by creating a cron job on the host.

:::image type="content" source="../media/common-attacks-1295b506.png" alt-text="Diagram showing an example of Kubernetes common attack techniques.":::
