## Multiple Choice
What is the benefit of using Kubernetes Deployments instead of scheduling individual pods?
( ) Deployments allow for more resource allocation to each pod {{Incorrect. Deployments do not allocate more resources to each pod, but rather manage a group of identical pods.}}
( ) Deployments provide higher security for the pods {{Incorrect. Deployments do not provide higher security for the pods, but rather ensure high availability and redundancy.}}
(x) Deployments enable automation and validation of the creation and teardown of environments to help deliver secure and stable application hosting platforms {{Correct. Deployments enable automation and validation of the creation and teardown of environments, which helps deliver secure and stable application hosting platforms by ensuring high availability and redundancy.}}

## Multiple Choice
What is the purpose of a StorageClass in AKS?
( ) To determine the access mode of the persistent volume {{Incorrect. The access mode is determined by the PersistentVolumeClaim, not the StorageClass.}}
( ) To define the size of the persistent volume claim {{Incorrect. The StorageClass defines storage characteristics, not size.}}
(x) To define storage characteristics and the reclaim policy for underlying Azure storage resources {{Correct. The StorageClass defines the type of Azure storage to create and the reclaim policy for the underlying storage resource.}}

## Multiple Choice
What is the purpose of creating a custom storage class in an AKS cluster?
( ) To deploy a pod with a persistent volume mount {{Incorrect. A custom storage class is created before creating a persistent volume claim.}}
( ) To list the content of a directory in the AKS cluster {{Incorrect. Listing the content of a directory is not related to creating a custom storage class.}}
(x) To define the properties of a persistent volume that will be used by a persistent volume claim {{Correct. A custom storage class defines the properties of a persistent volume that will be used by a persistent volume claim, such as the storage class name, the provisioner, and the reclaim policy.}}

## Multiple Choice
What are the storage options available for AKS containerized workloads?
( ) Use only Azure Premium SSD v2 for applications that require consistently low latency, high I/O operations per second (IOPS), and high throughput. {{Incorrect. Azure Premium SSD v2 is one of the options for block level access to data, but it is not the only option.}}
( ) Use only Azure NetApp Files for shared application data that requires high performance. {{Incorrect. Azure NetApp Files is one of the options for file level access to data, but it is not the only option.}}
(x) Choose from platform managed databases, disks, and file and blob storage. {{Correct. AKS supports both stateless and stateful workloads. To accommodate this requirement, you can apply a range of native Azure services, including managed databases, disks, and file and blob storage. Each of these options offers different SKUs, sizes, and performance characteristics.}}

