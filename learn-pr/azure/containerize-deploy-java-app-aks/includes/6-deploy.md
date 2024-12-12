In this unit, you'll deploy a container image to Azure Kubernetes Service.

With Azure Kubernetes Service, you’ll configure your Kubernetes Cluster to run in a desired state via a Deployment, which is the process of providing declarative updates to Pods and ReplicaSets. This declaration of state is administered in the manifest (YAML) file, and the Kubernetes controller will change the current state to the declared state when instructed. You’ll create this ```deployment.yml``` manifest file and instruct your Azure Kubernetes Service to run in a desired state with pods configured to pull/run the ```flightbookingsystemsample``` container image that resides in Azure Container Registry (that we pushed in the previous unit). Without this manifest file, you'd have to manually create, update, and delete pods instead of letting the Kubernetes orchestrate the process.

> [!NOTE]
> If your session has idled out or you're doing this step at another point in time and/or from another CLI, you might have to reinitialize your environment variables and reauthenticate with the following CLI commands.
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
> Update with your AZ_CONTAINER_REGISTRY environment variable value that you set earlier; for example, `javacontainerizationdemoacr`.

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
> Optionally, the `deployment_solution.yml` file in the root of your project contains the contents needed; you might find it easier to rename/update the contents of that file.

In the preceding `deployment.yml`, you'll notice the file contains a Deployment and a Service. The deployment is used to administer a set of pods, and the service is used to allow network access to the pods. You'll notice the pods are configured to pull a single image, the ```<AZ_CONTAINER_REGISTRY>.azurecr.io/flightbookingsystemsample:latest``` from Azure Container Registry. You'll also notice the service is configured to allow incoming HTTP pod traffic to port 8080, similar to the way you ran the container image locally with the ```-p``` port argument.

By now, your Azure Kubernetes Cluster creation should have successfully completed.

You'll want to configure your Azure CLI to access your Azure Kubernetes Cluster via the ```kubectl``` command. Install kubectl locally using the ```az aks install-cli``` command. Run the following command in your CLI:

```bash
az aks install-cli
```

Configure kubectl to connect to your Kubernetes cluster using the `az aks get-credentials` command. Run the following command in your CLI:

```bash
az aks get-credentials --resource-group $AZ_RESOURCE_GROUP --name $AZ_KUBERNETES_CLUSTER
```

You’ll get output similar to the following:

```output
Merged AZ_KUBERNETES_CLUSTER as current context in ~/.kube/config
```

You'll now instruct Azure Kubernetes Service to apply deployment.yml changes to your cluster. Run the following command in your CLI:

```bash
kubectl apply -f deployment.yml
```

You’ll get output similar to the following:

```output
deployment.apps/flightbookingsystemsample created
service/flightbookingsystemsample created
```

You can now use ```kubectl``` to monitor the status of the deployment. Run the following command in your CLI:

```bash
kubectl get all
```

You’ll get output similar to the following:

```output
kubectl get all
NAME                                            READY   STATUS    RESTARTS   AGE
pod/flightbookingsystemsample-b7fd6684f-4j8vf   1/1     Running   0          37s

NAME                                TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)          AGE
service/flightbookingsystemsample   LoadBalancer   10.0.62.153   4.190.122.192   8080:30534/TCP   37s
service/kubernetes                  ClusterIP      10.0.0.1      <none>          443/TCP          11h

NAME                                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/flightbookingsystemsample   1/1     1            1           37s

NAME                                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/flightbookingsystemsample-b7fd6684f   1         1         1       37s
```

If your ```POD``` status is ```Running```, the app should be accessible.

You can view the app logs within each pod, as well. Run the following command in your CLI:

```bash
kubectl logs pod/flightbookingsystemsample-<POD_IDENTIFIER_FROM_YOUR_RUNNING_POD>
```

You’ll get output similar to the following:

```output
 kubectl logs pod/flightbookingsystemsample-b7fd6684f-4j8vf 
15-Nov-2024 12:31:51.208 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server version name:   Apache Tomcat/10.1.33
15-Nov-2024 12:31:51.211 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server built:          Nov 7 2024 22:28:55 UTC
15-Nov-2024 12:31:51.212 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server version number: 10.1.33.0
15-Nov-2024 12:31:51.212 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log OS Name:               Linux
15-Nov-2024 12:31:51.212 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log OS Version:            5.15.0-1074-azure
15-Nov-2024 12:31:51.212 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Architecture:          amd64
15-Nov-2024 12:31:51.216 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Java Home:             /usr/lib/jvm/msopenjdk-17
15-Nov-2024 12:31:51.216 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log JVM Version:           17.0.13+11-LTS
15-Nov-2024 12:31:51.216 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log JVM Vendor:            Microsoft
15-Nov-2024 12:31:51.216 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log CATALINA_BASE:         /usr/local/tomcat
15-Nov-2024 12:31:51.216 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log CATALINA_HOME:         /usr/local/tomcat
15-Nov-2024 12:31:51.226 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties
15-Nov-2024 12:31:51.226 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager
15-Nov-2024 12:31:51.227 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djdk.tls.ephemeralDHKeySize=2048
15-Nov-2024 12:31:51.227 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.protocol.handler.pkgs=org.apache.catalina.webresources
15-Nov-2024 12:31:51.227 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dorg.apache.catalina.security.SecurityListener.UMASK=0027
15-Nov-2024 12:31:51.227 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.lang=ALL-UNNAMED
15-Nov-2024 12:31:51.228 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.io=ALL-UNNAMED
15-Nov-2024 12:31:51.228 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.util=ALL-UNNAMED
15-Nov-2024 12:31:51.228 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.util.concurrent=ALL-UNNAMED
15-Nov-2024 12:31:51.229 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED
15-Nov-2024 12:31:51.229 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dcatalina.base=/usr/local/tomcat
15-Nov-2024 12:31:51.229 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dcatalina.home=/usr/local/tomcat
15-Nov-2024 12:31:51.229 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.io.tmpdir=/usr/local/tomcat/temp
15-Nov-2024 12:31:51.231 INFO [main] org.apache.catalina.core.AprLifecycleListener.lifecycleEvent The Apache Tomcat Native library which allows using OpenSSL was not found on the java.library.path: [/usr/java/packages/lib:/usr/lib64:/lib64:/lib:/usr/lib]
15-Nov-2024 12:31:51.565 INFO [main] org.apache.coyote.AbstractProtocol.init Initializing ProtocolHandler ["http-nio-8080"]
15-Nov-2024 12:31:51.602 INFO [main] org.apache.catalina.startup.Catalina.load Server initialization in [616] milliseconds
15-Nov-2024 12:31:51.658 INFO [main] org.apache.catalina.core.StandardService.startInternal Starting service [Catalina]
15-Nov-2024 12:31:51.659 INFO [main] org.apache.catalina.core.StandardEngine.startInternal Starting Servlet engine: [Apache Tomcat/10.1.33]
15-Nov-2024 12:31:51.689 INFO [main] org.apache.catalina.startup.HostConfig.deployWAR Deploying web application archive [/usr/local/tomcat/webapps/AirlinesReservationSample.war]
15-Nov-2024 12:31:53.264 INFO [main] org.apache.jasper.servlet.TldScanner.scanJars At least one JAR was scanned for TLDs yet contained no TLDs. Enable debug logging for this logger for a complete list of JARs that were scanned but no TLDs were found in them. Skipping unneeded JARs during scanning can improve startup time and JSP compilation time.
15-Nov-2024 12:31:55.155 INFO [main] com.sun.xml.ws.server.MonitorBase.createRoot Metro monitoring rootname successfully set to: com.sun.metro:pp=/,type=WSEndpoint,name=/AirlinesReservationSample-PriceAndSeats-PriceAndSeatsPort
15-Nov-2024 12:31:55.347 INFO [main] com.sun.xml.ws.transport.http.servlet.WSServletDelegate.<init> WSSERVLET14: XML-WS servlet initializing
WARNING:Error in the metadata of the table SEATS: table's row count in the metadata is 5 but 6 records have been found and loaded by UCanAccess. All will work fine, but it's better to repair your database.
15-Nov-2024 12:31:56.248 INFO [main] com.sun.xml.ws.transport.http.servlet.WSServletContextListener.contextInitialized WSSERVLET12: XML-WS context listener initializing
15-Nov-2024 12:31:56.249 INFO [main] com.sun.xml.ws.transport.http.servlet.WSServletContextListener.contextInitialized WSSERVLET12: XML-WS context listener initializing
15-Nov-2024 12:31:56.284 INFO [main] org.apache.catalina.startup.HostConfig.deployWAR Deployment of web application archive [/usr/local/tomcat/webapps/AirlinesReservationSample.war] has finished in [4,595] ms
15-Nov-2024 12:31:56.285 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deploying web application directory [/usr/local/tomcat/webapps/docs]
15-Nov-2024 12:31:56.315 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deployment of web application directory [/usr/local/tomcat/webapps/docs] has finished in [30] ms
15-Nov-2024 12:31:56.316 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deploying web application directory [/usr/local/tomcat/webapps/examples]
15-Nov-2024 12:31:56.439 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deployment of web application directory [/usr/local/tomcat/webapps/examples] has finished in [123] ms
15-Nov-2024 12:31:56.440 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deploying web application directory [/usr/local/tomcat/webapps/manager]
15-Nov-2024 12:31:56.456 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deployment of web application directory [/usr/local/tomcat/webapps/manager] has finished in [16] ms
15-Nov-2024 12:31:56.457 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deploying web application directory [/usr/local/tomcat/webapps/ROOT]
15-Nov-2024 12:31:56.468 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deployment of web application directory [/usr/local/tomcat/webapps/ROOT] has finished in [11] ms
15-Nov-2024 12:31:56.468 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deploying web application directory [/usr/local/tomcat/webapps/host-manager]
15-Nov-2024 12:31:56.481 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deployment of web application directory [/usr/local/tomcat/webapps/host-manager] has finished in [13] ms
15-Nov-2024 12:31:56.484 INFO [main] org.apache.coyote.AbstractProtocol.start Starting ProtocolHandler ["http-nio-8080"]
15-Nov-2024 12:31:56.501 INFO [main] org.apache.catalina.startup.Catalina.start Server startup in [4897] milliseconds
```

You can now use the ```EXTERNAL-IP``` from your ```kubectl get services flightbookingsystemsample``` output to access the running app within Azure Kubernetes Service.

```output
kubectl get services flightbookingsystemsample 
NAME                        TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)          AGE
flightbookingsystemsample   LoadBalancer   10.0.62.153   4.190.122.192   8080:30534/TCP   3m28s
```

> [!NOTE]
> Substitute the ip address in the following (4.190.122.192) with that of your EXTERNAL-IP from the command you previously executed.

Open a browser and visit the Flight Booking System Sample landing page at [http://4.190.122.192:8080/AirlinesReservationSample/](http://4.190.122.192:8080/AirlinesReservationSample/)

You’ll get a page similar to this one:

:::image type="content" source="../media/deploy.png" alt-text="Screenshot showing the running app.":::

You can optionally sign in with any user from `tomcat-users.xml`; for example, `someuser@azure.com: password`.

## Clean up resources

The resources you created in this module might incur ongoing costs. To clean up the resources, you only need to delete the resource group that contains them:

```bash
az group delete --name $AZ_RESOURCE_GROUP
```
