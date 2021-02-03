One of the biggest issues when working with distributed applications is how to manage its sensitive information, like passwords, connections and similar data. Kubernetes allows us to secure this data with a resource called **Secret**.

## Understand Secrets

Secrets are a type of resource present in Kubernetes that let you store sensitive information in a safer way than using them in plain text format in pods and deployments. A Secret can contain a small amount of data. They're designed to store passwords and other sensitive data.

Secrets encode their data in a Base64 format, which isn't an encryption algorithm, but Kubernetes is smart enough to see that the information is encoded and hide it from command outputs such as `kubectl describe`, which doesn't happen with plain text configuration. A secret is always scoped to a single namespace, which avoids added exposure of sensitive data to other workloads in the cluster.

### Types of Secrets

Secrets can be of various types. The most common (and default) type is `Opaque`, which holds user-defined, arbitrary data. The other common types are:

- `kubernetes.io/service-account-token`: Defines a Service Account Token, automatically created when a new Service Account is created.
- `kubernetes.io/basic-auth`: Credentials for basic authentication.
- `kubernetes.io/tls`: TLS client or server data, used to serve HTTPS connections from within an Ingress resource, for example.

> [!TIP]
> You can check all the information about all these Secret types and more in the [official documentation](https://kubernetes.io/docs/concepts/configuration/secret/#secret-types)
## Create and Use a Secret

A secret can be used in one of three ways, according to the [official Kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/secret/#overview-of-secrets):

- Mounted as files in a volume on containers inside a Pod or Deployment.
- Referenced as an environment variable in the Pod or Deployment specification.
- Used by the Kubelet when pulling images from private registries via the `imagePullSecret` key in the Pod specification.

Later on, in this application, we'll use secrets mounted as part of the Pod's environment variables.

A Secret can be created like any other Kubernetes resource, either via a YAML manifest file or a `kubectl` command. The Secret specification is as follows:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: secret-name
  namespace: secret-namespace
type: Opaque
data:
  key_name: "key value in base64 format"
```

For this secret, you'll need to encode the values *before* creating the secret. If you want to create a secret with the plain text value and let Kubernetes encode it automatically, you use `stringData` instead of `data`:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: secret-name
  namespace: secret-namespace
type: Opaque
stringData:
  key_name: "key value in plain format"
```

The application will receive the *decoded* Secret string as the value passed to it instead of the encoded one.

### Secret updates

All Secrets that *are mounted as volumes* inside a pod are automatically updated once their value is changed.

This change may not occur immediately because of the [Kubelet configuration](https://kubernetes.io/docs/concepts/configuration/configmap/#mounted-configmaps-are-updated-automatically), but they'll be eventually updated and there's no need to restart the Pod.

Secrets that are bound to environment variables though, won't. If the Secret is bound to an environment variable, it's necessary to restart the Pod for the changes to take effect.
