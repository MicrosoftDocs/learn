## Multiple Choice
What does Kubernetes provide for managing container-based applications?
( ) Kubernetes focuses on the underlying infrastructure components. {{Incorrect. Kubernetes focuses on the application workloads, not the underlying infrastructure components.}}
( ) Kubernetes provides a procedural approach to deployments. {{Incorrect. Kubernetes provides a declarative approach to deployments, backed by a robust set of APIs for management operations.}}
(x) Kubernetes provides a declarative approach to deployments, backed by a robust set of APIs for management operations. {{Correct. Kubernetes provides a declarative approach to deployments, backed by a robust set of APIs for management operations. This allows you to build and run modern, portable, microservices based applications, using Kubernetes to orchestrate and manage the availability of the application components.}}

## Multiple Choice
What is the purpose of Pod Disruption Budgets in Kubernetes?
( ) To define how many replicas in a deployment can be taken down during an update or node upgrade without any restrictions. {{Incorrect. Pod Disruption Budgets define restrictions on how many replicas in a deployment can be taken down during an update or node upgrade.}}
( ) To define the maximum number of replicas that can be created in a deployment. {{Incorrect. Pod Disruption Budgets do not define the maximum number of replicas that can be created in a deployment.}}
(x) To enable the automation and validation of the creation and teardown of environments to help deliver secure and stable application hosting platforms. {{Correct. Pod Disruption Budgets enable the automation and validation of the creation and teardown of environments to help deliver secure and stable application hosting platforms by defining restrictions on how many replicas in a deployment can be taken down during an update or node upgrade.}}

## Multiple Choice
What is the purpose of Kubernetes APIs such as kubectl or the Kubernetes dashboard?
( ) To configure or directly access a control plane {{Incorrect. This is not the purpose of Kubernetes APIs such as kubectl or the Kubernetes dashboard.}}
( ) To deploy a self-managed Kubernetes cluster using Cluster API Provider Azure {{Incorrect. This is not the purpose of Kubernetes APIs such as kubectl or the Kubernetes dashboard.}}
(x) To interact with the control plane {{Correct. Kubernetes APIs such as kubectl or the Kubernetes dashboard are used to interact with the control plane through Kubernetes APIs.}}

## Multiple Choice
What is the purpose of defining resource requests and limits when creating a pod in Kubernetes?
( ) To allow multiple instances of the same pod to run on different nodes {{Incorrect. This is not the purpose of defining resource requests and limits.}}
( ) To ensure that the pod always runs on the same node {{Incorrect. This is not the purpose of defining resource requests and limits.}}
(x) To request a certain amount of CPU or memory resources and prevent a pod from consuming too much compute resource from the underlying node {{Correct. Defining resource requests and limits helps the Kubernetes Scheduler identify necessary, permitted resources and prevent a pod from consuming too much compute resource from the underlying node.}}

