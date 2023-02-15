Elasticsearch and Kibana help you search, analyze, monitor, and secure your apps and IT.

For Tailwind Traders, once the AKS cluster is set up and Elastic Cloud on Kubernetes is installed (with the Kubernetes operator and RBAC rules), the company needs to deploy Elasticsearch and Kibana for search and visualization functionality.

Here, we'll discuss the process for adding a three-node Elasticsearch cluster and deploying two instances of Kibana.

## Deploy Elasticsearch first

The first step in installing Elasticsearch involves creating a elasticsearch.yaml configuration file, which contains details about the Elasticserach deployment on the Kubernetes cluster. You can utilize the yaml configuration file content provided by Elastic to get started quickly. Then, in Azure Cloud Shell, you'll be able to apply the configuration files to the EKC cluster on AKS using kubectl commands to deploy Elasticsearch.

## Deploy Kibana next

Once that’s running, you’ll need to create a kibana.yaml configuration file with the content provided by Elastic. This yaml file contains details about the Kibana deployment on the Kubernetes.

## Consider the sizing

As previously mentioned, a key question you’ll need to answer before you start is how much Elastic to deploy. Since Elasticsearch is a horizontally scalable distributed system, you can start anywhere, monitor the deployment under the initial load, and scale accordingly.

For most cases, you can start fast by following these two guidelines:

- Start with a three-node Elasticsearch cluster for a production environment. While you may be able to support your use-case with single node Elasticsearch clusters, it's recommended to start with a three-node cluster to provide resiliency for the architecture and room to perform lifecycle operations – such as upgrade, security patching for the underlying infrastructure, and mitigating data loss with replication. Elastic Cloud takes care of this for users so they can focus on onboarding the data into Elastic and getting the insights and value they need from it.
- Use two Kibana instances for High Availability. Kibana is the window into Elastic stack – whether it's the data in Elasticsearch that you're exploring or management of the Elastic components. Given its value to all the use-cases of Elastic – we recommend at least two instances of Kibana behind a load balancer to provide fault tolerance and higher chances of uninterrupted access to Elastic. The affect of an unavailable Kibana doesn't necessarily lead to data loss but can create disruptive experiences for end users.

## Understand quickstart vs. production

The exercises included here are for a quickstart configuration. Quickstart files specify the bare minimum resources for experiencing the environment and aren't recommended for production. However, you can modify these files for your production environment. For example, the quickstart files specify one Elasticsearch node, whereas you'll likely use three or more.
