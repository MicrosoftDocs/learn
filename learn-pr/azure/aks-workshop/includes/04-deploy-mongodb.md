The application stores and retrieves item ratings from a MongoDB. In this excercise, you're going to deploy MongoDB to the Azure Kubernetes Service (AKS) cluster via Helm.

[Helm](https://helm.sh?azure-portal=true) is an application package manager for Kubernetes and offers a way to easily deploy applications and services, via what are called [charts](https://helm.sh/docs/topics/charts/?azure-portal=true). A chart is a collection of files that describe a related set of Kubernetes resources. A single chart might be used to deploy something simple, like a memcached pod, or something complex, like a full web app stack with HTTP servers, databases, caches, and so on.

Charts are stored in Helm chart repositories. The official chart repository is maintained [here](https://github.com/helm/charts?azure-portal=true) and the [Helm Hub](https://hub.helm.sh?azure-portal=true) provides a way to discover and view documentation of such charts.

By the end of this unit, you should have deployed MongoDB using Helm. You'll also store the MongoDB credentials in a Kubernetes secret.

![Deployed resources on the Azure Kubernetes Service cluster](../media/04-arch-1.svg)

## Add the Helm stable repository

1. To use Helm you will need the `helm` command, which is already installed in the Cloud Shell. Helm provides a standard repository of charts for many different software packages, and it has one for [MongoDB](https://github.com/helm/charts/tree/master/stable/mongodb?azure-portal=true). The MongoDB chart is part of the official Helm **stable** charts repository. You'll need to configure the Helm client to use the stable repository by running the `helm repo add` command.

    ```bash
    helm repo add stable https://kubernetes-charts.storage.googleapis.com/
    ```

1. Once this is added, you will be able to list the charts you can install.

    ```bash
    helm search repo stable
    ```

    You should see a list of the available charts.

    ```output
    NAME                                    CHART VERSION   APP VERSION                     DESCRIPTION
    stable/acs-engine-autoscaler            2.2.2           2.1.1                           DEPRECATED Scales worker nodes within agent pools
    stable/aerospike                        0.2.8           v4.5.0.5                        A Helm chart for Aerospike in Kubernetes
    stable/airflow                          4.1.0           1.10.4                          Airflow is a platform to programmatically autho...
    stable/ambassador                       4.1.0           0.81.0                          A Helm chart for Datawire Ambassador
    ...
    ```

## Install the MongoDB chart

1. To install a chart, you can run the `helm install` command. In the example below, the release is called **ratings** and is deployed into the **ratingsapp** namespace. Replace `<username>` and `<password>` below with values of your choice, and note for later use.

    ```bash
    helm install ratings stable/mongodb \
        --namespace ratingsapp \
        --set mongodbUsername=<username>,mongodbPassword=<password>,mongodbDatabase=ratingsdb
    ```

    You provide parameters with the `--set` switch and a comma separated list of `key=value` pairs. Pay attention to the `mongodbUsername`, `mongodbPassword` and `mongodbDatabase` parameters and their values, which set the username, password and database name respectively. The application expects that the database is called **ratingsdb**. The `helm install` command is a very powerful command with many capabilities. To learn more about it, check out the [Using Helm Guide](https://helm.sh/docs/intro/using_helm/?azure-portal=true).

1. Once released, you should get an output similar to this. Make note of the MongoDB host, which should be **ratings-mongodb.ratingsapp.svc.cluster.local**, if you used the same parameters.

    ```output
    NAME: ratings
    LAST DEPLOYED: Mon Dec 30 23:00:47 2019
    NAMESPACE: ratingsapp
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None
    NOTES:
    ** Please be patient while the chart is being deployed **

    MongoDB can be accessed via port 27017 on the following DNS name from within your cluster:

        ratings-mongodb.ratingsapp.svc.cluster.local
    ```

## Create a Kubernetes secret to hold the MongoDB details

 Kubernetes has a concept of [secrets](https://kubernetes.io/docs/concepts/configuration/secret/?azure-portal=true). Secrets let you store and manage sensitive information, such as passwords. Putting this information in a secret is safer and more flexible than hard coding it in a pod definition or in a container image.

 In the previous step, you installed MongoDB using Helm, with a specified username, password and a database name. You're now going to store those details in a Kubernetes secret that will be used later.

 The ratings API expects to find the connection details to the MongoDB in the form of `mongodb://<username>:<password>@<endpoint>:27017/ratingsdb`. You’ll need to replace the `<username>`, `<password>` and `<endpoint>` with the ones you used when creating the database. For example `mongodb://ratingsuser:ratingspassword@ratings-mongodb.ratingsapp.svc.cluster.local:27017/ratingsdb`.

 1. Use the `kubectl create secret generic` command to create a secret called **mongosecret** in the **ratingsapp** namespace. A Kubernetes secret can hold several items, indexed by key. In this case, the secret will only contain one key, called **MONGOCONNECTION** and the value will be the constructed connection string from the previous step. Replace `<username>` and `<password>` with the ones you used when creating the database.

    ```bash
    kubectl create secret generic mongosecret \
        --namespace ratingsapp \
        --from-literal=MONGOCONNECTION="mongodb://<username>:<password>@ratings-mongodb.ratingsapp.svc.cluster.local:27017/ratingsdb"
    ```

1. You can validate that the secret has been created by running the `kubectl describe secret` command.

    ```bash
    kubectl describe secret mongosecret --namespace ratingsapp
    ```

    You should get an output similar to this.

    ```output
    Name:         mongosecret
    Namespace:    ratingsapp
    Labels:       <none>
    Annotations:  <none>

    Type:  Opaque

    Data
    ====
    MONGOCONNECTION:  98 bytes
    ```

You now have an Azure Kubernetes Service cluster created and configured with a namespace called **ratingsapp**. In that namespace, there should be Kubernetes resources corresponding to the MongoDB deployed.

- **Deployment/ratings-mongodb**. A deployment represents one or more identical pods, managed by the Kubernetes Deployment Controller. This deployment defines the number of replicas (pods) to create for MongoDB and the Kubernetes Scheduler ensures that if pods or nodes encounter problems, additional pods are scheduled on healthy nodes.
- **Pod/ratings-mongodb-{random-string}**. Kubernetes uses pods to run an instance of MongoDB.
- **Service/ratings-mongodb**. To simplify the network configuration, Kubernetes uses Services to logically group a set of pods together and provide network connectivity. Connectivity to the MongoDB is exposed via this service through the DNS name **ratings-mongodb.ratingsapp.svc.cluster.local**.
- **Secret/mongosecret**. A Kubernetes Secret is used to inject sensitive data into pods, such as access credentials or keys. This secret holds the MongoDB connection details, and will be used in the next unit to configure the API to communicate with MongoDB.
