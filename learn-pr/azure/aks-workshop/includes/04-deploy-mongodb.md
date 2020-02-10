The application stores and retrieves item ratings from a MongoDB database. In this exercise, you deploy MongoDB to the Azure Kubernetes Service (AKS) cluster via Helm.

[Helm](https://helm.sh?azure-portal=true) is an application package manager for Kubernetes. It offers a way to easily deploy applications and services via [charts](https://helm.sh/docs/topics/charts/?azure-portal=true). A chart is a collection of files that describe a related set of Kubernetes resources. You can use a single chart to deploy something simple, like a memcached pod, or something complex, like a full web app stack with HTTP servers, databases, and caches.

Charts are stored in Helm chart repositories. The official chart repository is maintained on [GitHub](https://github.com/helm/charts?azure-portal=true). The [Helm Hub](https://hub.helm.sh?azure-portal=true) provides a way to discover and view documentation of such charts.

By the end of this unit, you'll have a MongoDB deployment done by using Helm. You'll also store the MongoDB credentials in a Kubernetes secret.

![Deployed resources on the Azure Kubernetes Service cluster](../media/04-arch-1.svg)

## Add the Helm stable repository

1. To use Helm, you need the `helm` command, which is already installed in Azure Cloud Shell. Helm provides a standard repository of charts for many different software packages. It has one for [MongoDB](https://github.com/helm/charts/tree/master/stable/mongodb?azure-portal=true). The MongoDB chart is part of the official Helm *stable* charts repository. Configure the Helm client to use the stable repository by running the `helm repo add` command.

    ```bash
    helm repo add stable https://kubernetes-charts.storage.googleapis.com/
    ```

1. After the repo is added, list the charts you can install.

    ```bash
    helm search repo stable
    ```

    You'll see a list of the available charts, like this example.

    ```output
    NAME                           CHART VERSION   APP VERSION   DESCRIPTION
    stable/acs-engine-autoscaler   2.2.2           2.1.1         DEPRECATED Scales worker nodes within agent pools
    stable/aerospike               0.2.8           v4.5.0.5      A Helm chart for Aerospike in Kubernetes
    stable/airflow                 4.1.0           1.10.4        Airflow is a platform to programmatically autho...
    stable/ambassador              4.1.0           0.81.0        A Helm chart for Datawire Ambassador
    ...
    ```

## Install the MongoDB chart

1. To install a chart, run the `helm install` command. In the following example, the release is called `ratings` and is deployed into the `ratingsapp` namespace. Replace `<username>` and `<password>` with values of your choice, and note them for later use.

    ```bash
    helm install ratings stable/mongodb \
        --namespace ratingsapp \
        --set mongodbUsername=<username>,mongodbPassword=<password>,mongodbDatabase=ratingsdb
    ```

    You provide parameters with the `--set` switch and a comma-separated list of `key=value` pairs. Pay attention to the `mongodbUsername`, `mongodbPassword`, and `mongodbDatabase` parameters and their values, which set the username, password, and database name, respectively. The application expects that the database is called **ratingsdb**. The `helm install` command is a powerful command with many capabilities. To learn more about it, see [Using Helm](https://helm.sh/docs/intro/using_helm/?azure-portal=true).

1. After the installation is finished, you should get an output similar to this example. Make a note of the MongoDB host, which should be `ratings-mongodb.ratingsapp.svc.cluster.local`, if you used the same parameters.

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

 Kubernetes has a concept of [secrets](https://kubernetes.io/docs/concepts/configuration/secret/?azure-portal=true). Secrets let you store and manage sensitive information, such as passwords. Putting this information in a secret is safer and more flexible than hard coding it in a pod definition or a container image.

 In the previous step, you installed MongoDB by using Helm, with a specified username, password, and database name. Now you store those details in a Kubernetes secret to use later.

 The ratings API expects to find the connection details to the MongoDB database in the form of `mongodb://<username>:<password>@<endpoint>:27017/ratingsdb`. Replace `<username>`, `<password>`, and `<endpoint>` with the ones you used when you created the database, for example, `mongodb://ratingsuser:ratingspassword@ratings-mongodb.ratingsapp.svc.cluster.local:27017/ratingsdb`.

 1. Use the `kubectl create secret generic` command to create a secret called `mongosecret` in the `ratingsapp` namespace. A Kubernetes secret can hold several items and is indexed by a key. In this case, the secret contains only one key, called `MONGOCONNECTION`. The value is the constructed connection string from the previous step. Replace `<username>` and `<password>` with the ones you used when you created the database.

    ```bash
    kubectl create secret generic mongosecret \
        --namespace ratingsapp \
        --from-literal=MONGOCONNECTION="mongodb://<username>:<password>@ratings-mongodb.ratingsapp.svc.cluster.local:27017/ratingsdb"
    ```

1. To validate that the secret was created, run the `kubectl describe secret` command.

    ```bash
    kubectl describe secret mongosecret --namespace ratingsapp
    ```

    The output from this command looks similar to this example.

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

You now have an Azure Kubernetes Service cluster created and configured with a namespace called `ratingsapp`. In that namespace, there should be Kubernetes resources that correspond to the MongoDB database that was deployed:

- **Deployment/ratings-mongodb**: A deployment represents one or more identical pods managed by the Kubernetes Deployment Controller. This deployment defines the number of replicas (pods) to create for MongoDB. The Kubernetes Scheduler ensures that if pods or nodes encounter problems, additional pods are scheduled on healthy nodes.
- **Pod/ratings-mongodb-{random-string}**: Kubernetes uses pods to run an instance of MongoDB.
- **Service/ratings-mongodb**: To simplify the network configuration, Kubernetes uses services to group a set of pods and provide network connectivity logically. Connectivity to the MongoDB database is exposed via this service through the DNS name **ratings-mongodb.ratingsapp.svc.cluster.local**.
- **Secret/mongosecret**: A Kubernetes secret is used to inject sensitive data into pods, such as access credentials or keys. This secret holds the MongoDB connection details. You'll use it in the next unit to configure the API to communicate with MongoDB.
