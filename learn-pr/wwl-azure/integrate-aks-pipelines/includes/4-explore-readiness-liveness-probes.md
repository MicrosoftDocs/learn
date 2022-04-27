You might need to wait for a container to be ready to serve clients when it first starts. Or you might want to check if a container is still alive.

For these purposes, you'll need readiness or liveness probes.

Kubernetes offers various readiness probes. In the configuration YAML file, you can configure the type of probe:

 -  startupProbe
 -  livenessProbe
 -  readinessProbe

You can also configure the initialDelaySeconds (how long after the start before checking) and periodSeconds (how often to check).

Restarting an unresponsive container can be achieved by configuring the restartPolicy setting in the configuration file.

An example is:

```YAML
ports:

- name: liveness-port
  containerPort: 8080
  hostPort: 8080

livenessProbe:
  httpGet:
    path: /health-check
    port: liveness-port
  failureThreshold: 2
  periodSeconds: 15

startupProbe:
  httpGet:
    path: /health-check
    port: liveness-port
  failureThreshold: 40
  periodSeconds: 15

```

For more information on Kubernetes readiness probes, see here: [Configure Liveness, Readiness, and Startup Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/).
