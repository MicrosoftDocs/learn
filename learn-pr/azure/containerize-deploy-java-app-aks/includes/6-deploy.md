In this unit, you'll deploy a container image to Azure Kubernetes Service.

With Azure Kubernetes Service, you’ll be configuring your Kubernetes Cluster to run in a desired state via a Deployment, which is the process of providing declarative updates to Pods and ReplicaSets. This declaration of state is administered in the manifest (YAML) file, and the Kubernetes controller will change the current state to the declared state when instructed. You’ll create this ```deployment.yml``` manifest file in the following unit and instruct your Azure Kubernetes Service to run in a desired state with pods configured to pull/run the ```flightbookingsystemsample``` container image that resides in Azure Container Registry (that we pushed in the previous unit). Without this deployment.yml, you'd have to manually create, update, and delete pods instead of letting the Kubernetes orchestrate the process.

> [!NOTE]
> If your session has idled out, your doing this step at another point in time and/or from another CLI you may have to re initialize your environment variables and re authenticate with the following CLI commands.
>
>AZ_RESOURCE_GROUP=javacontainerizationdemorg
>
>AZ_CONTAINER_REGISTRY=<YOUR_CONTAINER_REGISTRY>
>
>AZ_KUBERNETES_CLUSTER=javacontainerizationdemoaks
>
>AZ_LOCATION=<YOUR_AZURE_REGION>
>
>AZ_KUBERNETES_CLUSTER_DNS_PREFIX=<YOUR_UNIQUE_DNS_PREFIX_TO_ACCESS_YOUR_AKS_CLUSTER>
>
>az login
>
>az acr login -n $AZ_CONTAINER_REGISTRY

## Deploy a container image

Here, you'll deploy the ```flightbookingsystemsample``` container image to your Azure Kubernetes Cluster.

Within the root of your project, Flight-Booking-System-JavaServlets_App/Project/Airlines, Create a file called deployment.yml. Run the following command in your CLI:

```bash
vi deployment.yml
```

Add the following contents to deployment.yml, then save and exit:

> [!NOTE]
> You'll want to update with your AZ_CONTAINER_REGISTRY environment variable value that you set earlier; for example: `javacontainerizationdemoacr`.

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: flightbookingsystemsample
spec:
  replicas: 1
  selector:
    matchLabels:
      app: flightbookingsystemsample
  template:
    metadata:
      labels:
        app: flightbookingsystemsample
    spec:
      containers:
      - name: flightbookingsystemsample
        image: <AZ_CONTAINER_REGISTRY>.azurecr.io/flightbookingsystemsample:latest
        resources:
          requests:
            cpu: "1"
            memory: "1Gi"
          limits:
            cpu: "2"
            memory: "2Gi"
        ports:
        - containerPort: 8080
---
apiVersion: v1
kind: Service
metadata:
  name: flightbookingsystemsample
spec:
  type: LoadBalancer
  ports:
  - port: 8080
    targetPort: 8080
  selector:
    app: flightbookingsystemsample
```

> [!NOTE]
> Optionally, the `deployment_solution.yml` file in the root of your project contains the contents needed; you may find it easier to rename/update the contents of that file.

In the preceding `deployment.yml`, you'll notice the file contains a Deployment and a Service. The deployment is used to administer a set of pods, while the service is used to allow network access to the pods. You'll notice the pods are configured to pull a single image, the ```<AZ_CONTAINER_REGISTRY>.azurecr.io/flightbookingsystemsample:latest``` from Azure Container Registry. You'll also notice the service is configured to allow incoming HTTP pod traffic to port 8080, similar to the way you ran the container image locally with the ```-p``` port argument.

By now your Azure Kubernetes Cluster creation should have successfully completed.

You'll want to configure your Azure CLI to access your Azure Kubernetes Cluster via the ```kubectl``` command. Install kubectl locally using the ```az aks install-cli``` command. Run the following command in your CLI:

```bash
az aks install-cli
```

Configure kubectl to connect to your Kubernetes cluster using the `az aks get-credentials` command. Run the following command in your CLI:

```bash
az aks get-credentials --resource-group $AZ_RESOURCE_GROUP --name $AZ_KUBERNETES_CLUSTER
```

You’ll get output similar to the following:

```bash
Merged AZ_KUBERNETES_CLUSTER as current context in ~/.kube/config
```

You'll now instruct Azure Kubernetes Service to apply deployment.yml changes to your cluster. Run the following command in your CLI:

```bash
kubectl apply -f deployment.yml
```

You’ll get output similar to the following:

```bash
deployment.apps/flightbookingsystemsample created
service/flightbookingsystemsample created
```

You can now use ```kubectl``` to monitor the status of the deployment. Run the following command in your CLI:

```bash
kubectl get all
```

You’ll get output similar to the following:

```bash
NAME                                   READY   STATUS    RESTARTS   AGE
pod/flightbookingsystemsample-75647c4c98-v4v4r   1/1     Running   2          13d

NAME                      TYPE           CLUSTER-IP    EXTERNAL-IP    PORT(S)          AGE
service/kubernetes        ClusterIP      10.0.0.1      <none>         443/TCP          66d
service/flightbookingsystemsample   LoadBalancer   10.0.34.128   20.81.13.151   8080:30265/TCP   66d

NAME                              READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/flightbookingsystemsample   1/1     1            1           66d

NAME                                         DESIRED   CURRENT   READY   AGE
replicaset.apps/flightbookingsystemsample-75647c4c98   1         1         1       66d
replicaset.apps/flightbookingsystemsample-7564c58f55   0         0         0       13d
```

If your ```POD``` status is ```Running```, the app should be accessible.

You can view the app logs within each pod as well. Run the following command in your CLI:

```bash
 kubectl logs pod/flightbookingsystemsample-<POD_IDENTIFIER_FROM_YOUR_RUNNING_POD>
```

You’ll get output similar to the following:

```bash
NOTE: Picked up JDK_JAVA_OPTIONS:  --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/java.util.concurrent=ALL-UNNAMED --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED
07-Oct-2021 18:31:14.073 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server version name:   Apache Tomcat/8.5.71
07-Oct-2021 18:31:14.164 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server built:          Sep 9 2021 18:43:14 UTC
07-Oct-2021 18:31:14.164 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server version number: 8.5.71.0
07-Oct-2021 18:31:14.165 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log OS Name:               Linux
07-Oct-2021 18:31:14.166 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log OS Version:            5.4.0-1051-azure
07-Oct-2021 18:31:14.166 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Architecture:          amd64
07-Oct-2021 18:31:14.166 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Java Home:             /usr/local/openjdk-11
07-Oct-2021 18:31:14.167 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log JVM Version:           11.0.12+7
07-Oct-2021 18:31:14.167 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log JVM Vendor:            Oracle Corporation
07-Oct-2021 18:31:14.167 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log CATALINA_BASE:         /usr/local/tomcat
07-Oct-2021 18:31:14.168 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log CATALINA_HOME:         /usr/local/tomcat
07-Oct-2021 18:31:14.261 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.lang=ALL-UNNAMED
07-Oct-2021 18:31:14.261 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.io=ALL-UNNAMED
07-Oct-2021 18:31:14.261 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.util=ALL-UNNAMED
07-Oct-2021 18:31:14.262 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.util.concurrent=ALL-UNNAMED
07-Oct-2021 18:31:14.262 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED
07-Oct-2021 18:31:14.262 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties
07-Oct-2021 18:31:14.263 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager
07-Oct-2021 18:31:14.263 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djdk.tls.ephemeralDHKeySize=2048
07-Oct-2021 18:31:14.263 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.protocol.handler.pkgs=org.apache.catalina.webresources
07-Oct-2021 18:31:14.263 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dorg.apache.catalina.security.SecurityListener.UMASK=0027
07-Oct-2021 18:31:14.264 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dignore.endorsed.dirs=
07-Oct-2021 18:31:14.264 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dcatalina.base=/usr/local/tomcat
07-Oct-2021 18:31:14.264 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dcatalina.home=/usr/local/tomcat
07-Oct-2021 18:31:14.265 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.io.tmpdir=/usr/local/tomcat/temp
07-Oct-2021 18:31:14.265 INFO [main] org.apache.catalina.core.AprLifecycleListener.lifecycleEvent Loaded Apache Tomcat Native library [1.2.31] using APR version [1.7.0].
07-Oct-2021 18:31:14.265 INFO [main] org.apache.catalina.core.AprLifecycleListener.lifecycleEvent APR capabilities: IPv6 [true], sendfile [true], accept filters [false], random [true], UDS [{4}].
07-Oct-2021 18:31:14.266 INFO [main] org.apache.catalina.core.AprLifecycleListener.lifecycleEvent APR/OpenSSL configuration: useAprConnector [false], useOpenSSL [true]
07-Oct-2021 18:31:14.361 INFO [main] org.apache.catalina.core.AprLifecycleListener.initializeSSL OpenSSL successfully initialized [OpenSSL 1.1.1k  25 Mar 2021]
07-Oct-2021 18:31:14.763 INFO [main] org.apache.coyote.AbstractProtocol.init Initializing ProtocolHandler ["http-nio-8080"]
07-Oct-2021 18:31:14.962 INFO [main] org.apache.tomcat.util.net.NioSelectorPool.getSharedSelector Using a shared selector for servlet write/read
07-Oct-2021 18:31:15.071 INFO [main] org.apache.catalina.startup.Catalina.load Initialization processed in 6497 ms
07-Oct-2021 18:31:15.771 INFO [main] org.apache.catalina.core.StandardService.startInternal Starting service [Catalina]
07-Oct-2021 18:31:15.772 INFO [main] org.apache.catalina.core.StandardEngine.startInternal Starting Servlet engine: [Apache Tomcat/8.5.71]
07-Oct-2021 18:31:16.261 INFO [localhost-startStop-1] org.apache.catalina.startup.HostConfig.deployWAR Deploying web app archive [/usr/local/tomcat/webapps/FlightBookingSystemSample.war]
07-Oct-2021 18:31:30.782 INFO [localhost-startStop-1] org.apache.jasper.servlet.TldScanner.scanJars At least one JAR was scanned for TLDs yet contained no TLDs. Enable debug logging for this logger for a complete list of JARs that were scanned but no TLDs were found in them. Skipping unneeded JARs during scanning can improve startup time and JSP compilation time.
WARNING: An illegal reflective access operation has occurred
WARNING: Illegal reflective access by com.sun.xml.ws.policy.privateutil.MethodUtil (file:/usr/local/tomcat/webapps/FlightBookingSystemSample/WEB-INF/lib/webservices-rt-2.3.1.jar) to method sun.reflect.misc.MethodUtil.invoke(java.lang.reflect.Method,java.lang.Object,java.lang.Object[])
WARNING: Please consider reporting this to the maintainers of com.sun.xml.ws.policy.privateutil.MethodUtil
WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
WARNING: All illegal access operations will be denied in a future release
07-Oct-2021 18:31:53.370 INFO [localhost-startStop-1] com.sun.xml.ws.server.MonitorBase.createRoot Metro monitoring rootname successfully set to: com.sun.metro:pp=/,type=WSEndpoint,name=/FlightBookingSystemSample-PriceAndSeats-PriceAndSeatsPort
07-Oct-2021 18:31:54.864 INFO [localhost-startStop-1] com.sun.xml.ws.transport.http.servlet.WSServletDelegate.<init> WSSERVLET14: JAX-WS servlet initializing
07-Oct-2021 18:32:02.869 INFO [localhost-startStop-1] com.sun.xml.ws.transport.http.servlet.WSServletContextListener.contextInitialized WSSERVLET12: JAX-WS context listener initializing
07-Oct-2021 18:32:02.870 INFO [localhost-startStop-1] com.sun.xml.ws.transport.http.servlet.WSServletContextListener.contextInitialized WSSERVLET12: JAX-WS context listener initializing
07-Oct-2021 18:32:03.069 INFO [localhost-startStop-1] org.apache.catalina.startup.HostConfig.deployWAR Deployment of web app archive [/usr/local/tomcat/webapps/FlightBookingSystemSample.war] has finished in [46,808] ms
07-Oct-2021 18:32:03.165 INFO [main] org.apache.coyote.AbstractProtocol.start Starting ProtocolHandler ["http-nio-8080"]
07-Oct-2021 18:32:03.267 INFO [main] org.apache.catalina.startup.Catalina.start Server startup in 48195 ms
```

You can now use the ```EXTERNAL-IP``` from your ```kubectl get services flightbookingsystemsample``` output to access the running app within Azure Kubernetes Service.

> [!NOTE]
> You'll want to substitute the ip address in the following (20.81.13.151) with that of your EXTERNAL-IP from the command you previously executed.

Open up a browser and visit the Flight Booking System Sample landing page at [http://20.81.13.151:8080/FlightBookingSystemSample](http://20.81.13.151:8080/FlightBookingSystemSample)

You’ll get a page similar to this one:

![Screenshot showing the running app.](../media/deploy.png)

You can optionally sign in with any user from tomcat-users.xml; for example, `someuser@azure.com: password`.
