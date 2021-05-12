Although most applications you intend to deploy to AKS on Azure Stack HCI are stateless, Contoso developers identified a few stateful workloads that they are planning to containerize. To accommodate this requirement, you need to explore the support for preserving state of running pods by relying on Kubernetes persistent volumes. 

## Implement persistent volumes for AKS on Azure Stack HCI

By default, individual pods operate as stateless resources. If a pod that is part of a deployment fails for some reason, Kubernetes scheduler automatically creates a new one that provides the matching functionality, ensuring that the containerized application remains available. However, without additional provisions for preserving state, any data that the failed pod might have been working on is lost. 

There are scenarios in which pods must be able to persist and share their data and state. In these scenarios, you can use persistent volumes, which are cluster resources that allow for storing data of containerized workloads beyond the lifespan of individual pods. 

To implement a volume in a Kubernetes cluster, you need to define a persistent volume claim for a specific storage class. A storage class represents the characteristics of the underlying storage, such as performance or support for shared access. Persistent volume claim includes information about the required access mode and volume size. Kubernetes API server uses the persistent volume claim definition to dynamically provision a suitable storage volume whenever required by deployed pods.

> [!NOTE] 
> AKS on Azure Stack HCI offers the default storage class, which implements VHDX-based disks.

Define storage requirements of deployed pods by including persistent volume specifications in the corresponding manifest files. Besides triggering dynamic provisioning, this also automatically mounts the volume within the pods.

For example, the following manifest defines a persistent volume claim for a 100 GB non-shared disk that uses the default storage class. 

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
 name: pvc-akshci
spec:
 accessModes:
 - ReadWriteOnce
 resources:
  requests:
   storage: 100Gi
```

To implement this persistent volume claim, you can store this manifest as a YAML file and run the kubectl command line utility to create the corresponding resource (where the `pvc_definition.yaml` represents the YAML file):

```kubectl
kubectl create -f pvc_definition.yaml
```

To define a corresponding persistent volume for a pod, you could use the following manifest:

```yaml
kind: Pod
apiVersion: v1
metadata:
  name: win-appserver
spec:
  containers:
    - name: win-appserver
      image: mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019 
      volumeMounts:
      - name: akshciscsi
        mountPath: "/mnt/akshciscsi"
  volumes:
    - name: akshciscsi
      persistentVolumeClaim:
        claimName: pvc-akshci
  nodeSelector:
     kubernetes.io/os: windows
```

To implement this persistent volume also, you can store the pod manifest as a YAML file and run the kubectl command line utility to provision the volume and mount it (where the `pv_definition.yaml` represents the YAML file):

```kubectl
kubectl create -f pv_definition.yaml
```

The resulting pod will have a volume of 100 GB in size mounted within the file system path designated by the value of the `mountPath` element.

To delete the persistent volume claim, you need to first delete any pods and deployments that are currently using it. At that point, to complete the task, you can use the `kubectl delete PersistentVolumeClaim` command, followed by the name of the persistent volume claim.

---
## Check your knowledge

## Multiple Choice
Because Contoso developers are working on containerizing stateful workloads, you want to test the implementation of persistent pod storage by using your deployment of AKS on Azure Stack HCI. What do you have to define first?
(x) Persistent volume claim. {{Correct. To implement a volume in a Kubernetes cluster, you need to first define a persistent volume claim.}}
( ) Storage class. {{Incorrect. AKS on Azure Stack HCI offers the default storage class, which implements VHDX-based disks.}}
( ) Persistent volume. {{Incorrect. Persistent volumes require you to first define a persistent volume claim.}}