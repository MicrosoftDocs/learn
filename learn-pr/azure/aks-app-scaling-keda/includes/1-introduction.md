Kubernetes Event Driven Autoscaler (KEDA) works alongside standard Kubernetes components like the Horizontal Pod Autoscaler (HPA), and the Cluster Autoscaler which can extend functionality without overwriting or duplication.

## Example scenario

You work for a growing video editing company that provides a cloud-based video rendering service.  Usage of its client application peaks at various times during a 24-hr period. Due to increasing and decreasing demand, the company needs to scale its application accordingly to provide a better experience to all customers. Since the application is event driven and receives a significant number of messages, CPU and Memory based metrics are not sufficient to scale properly. As the DevOps Engineer, you need to assess which tools will help achieve the company's scaling needs.  

After experimenting with various options, you've determined that using Azure Kubernetes Services (AKS) and KEDA fulfills all the requirements to scale for peak and off-peak usage. With clearance from leadership, you begin the journey of an event driven application that supports the company now and in the future!

In this module, you'll deploy KEDA into an AKS environment and deploy a scaler object to autoscale containers based on the number of messages in a list.

## What will we be doing?

Here, you'll deploy a KEDA scaler object to AKS to autoscale containers based on the number messages in a list:

* **Deploy**: KEDA within AKS

* **Deploy**: a built-in KEDA scaler

* **Understand**: K8S scaling options including KEDA, Cluster Autoscaling (CA), and Horizontal Pod Autoscaling (HPA)

## What is the main goal?

By the end of this session, you'll be able to understand which Kubernetes scaling option you should choose based on your scenario.
