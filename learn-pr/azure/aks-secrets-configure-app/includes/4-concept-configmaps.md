When looking at the [repository](https://github.com/Azure-Samples/aks-contoso-ships-sample), you came across [this file](https://github.com/Azure-Samples/aks-contoso-ships-sample/blob/434beca73f7bf5504c0e8d38890daace66f7723f/frontend/src/config.js). It's a config file that is loaded in [the `index.html`](https://github.com/Azure-Samples/aks-contoso-ships-sample/blob/f1b1796da12b714fb7ea2a1c807e0e15b0b2abbb/frontend/public/index.html#L5) file to allow the environment variables to be updated without the need of a full image build.

This isn't a sensitive information. It's a configuration file that needs to be loaded along with the container. How can we mount the file in the container without the need of encryption or encoding?

## Understand ConfigMaps

ConfigMaps are the counterpart of Secrets. While Secrets provide a mechanism to store and deliver sensitive data, ConfigMaps are objects used to store non-sensitive data using the same key-value structure as a Secret. This object allows you to decouple configurations from container images, allowing those images to remain stateless.

The motivation behind the creation of a ConfigMap is to store configuration data separately from the application code and load it almost the same way we load Secret objects in the Pod. ConfigMaps can only be referenced by an environment variable or mounted as a file in a volume inside the container.

ConfigMaps have a data size limitation; you can hold up to 1 MiB of data in a ConfigMap. This helps you avoid large, complex configuration files by force users to break large configurations into smaller, more manageable, chunks. This way you can mount only the required configuration files in your containers, allowing for more granularity.

Like Secrets, ConfigMaps are namespaced. This means that a ConfigMap can only be accessed and mounted by the containers present in the same namespace as it was created.

ConfigMaps are also widely used by other tools such as [Helm](https://helm.sh) and Kubernetes Operators to store and read states.

### ConfigMap updates

All ConfigMaps that *are mounted as volumes* inside a pod are automatically updated once their value is changed.

This change may not occur immediately because of the [Kubelet configuration](https://kubernetes.io/docs/concepts/configuration/configmap/#mounted-configmaps-are-updated-automatically), but they'll be eventually updated and there's no need to restart the Pod.

ConfigMaps that are bound to environment variables though, won't. If the ConfigMap is bound to an environment variable, it's necessary to restart the Pod for the changes to take effect.

## Create and Use ConfigMaps

To create a ConfigMap you'll use the same approach as the Secret, a YAML file. This file follows this specification:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: configmap-name
  namespace: default
data:
  key-name: "value as key"
  key.name: |
    multi line
    property, called "file-like" values
```

You can reference ConfigMaps by one or more keys in the specification of a Pod or Deployment:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: configmap-as-env
  namespace: default
spec:
  containers:
    - name: configmap-env
      image: alpine
      command: ["sleep", "3600"]
      env:
        - name: ENVIRONMENT_VARIABLE_NAME
          valueFrom:
            configMapKeyRef:
              name: configmap-name
              key: key-name
```

Or mounted as files inside the pod using read-only volumes:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: configmap-as-env
  namespace: default
spec:
  containers:
    - name: configmap-env
      image: alpine
      command: ["sleep", "3600"]
      volumeMounts:
      - name: volume-name
        mountPath: "/path/to/mount"
        readOnly: true
  volumes:
    - name: volume-name
      configMap:
        name: configmap-name
        items:
        - key: "key-name"
          path: "path/to/mount/the/key"
```
