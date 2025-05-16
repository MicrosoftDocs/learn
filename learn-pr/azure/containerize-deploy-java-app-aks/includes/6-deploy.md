In this unit, you deploy a container image to Azure Kubernetes Service (AKS). With AKS, you configure your Kubernetes cluster to run in a desired state via a *deployment*, which is the process of providing declarative updates to pods and ReplicaSets. This declaration of state is administered in the manifest YAML file, and the Kubernetes controller changes the current state to the declared state when instructed. You create this **deployment.yml** manifest file and instruct your AKS instance to run in a desired state with pods configured to pull and run the `flightbookingsystemsample` container image contained in the Azure container registry that you pushed in the previous unit. Without this manifest file, you have to manually create, update, and delete pods, instead of letting Kubernetes orchestrate the process.

> [!NOTE]
> If your session has idled out or you're doing this step at another point in time or from another CLI, you might have to reinitialize your environment variables and reauthenticate by using the following commands:
>
> ```azurecli
> export AZ_RESOURCE_GROUP=java-containerization-demo-rg
> export AZ_CONTAINER_REGISTRY=<your-container-registry>
> export AZ_KUBERNETES_CLUSTER=java-containerization-demo-aks
> export AZ_LOCATION=<your-Azure-region>
> export AZ_KUBERNETES_CLUSTER_DNS_PREFIX=<your-unique-DNS-prefix-to-access-your-AKS-cluster>
> az login
> az acr login --name $AZ_CONTAINER_REGISTRY
> ```

## Deploy a container image

Now you deploy the `flightbookingsystemsample` container image to your AKS cluster. Within the root folder of your project, **Flight-Booking-System-JavaServlets_App/Project/Airlines**, create a file named **deployment.yml** by using the following command:

```bash
vi deployment.yml
```

Add the following contents to **deployment.yml**, and then save and exit. Be sure to replace the `<AZ_CONTAINER_REGISTRY>` placeholder with the value of the `AZ_CONTAINER_REGISTRY` environment variable value that you set earlier. To save and exit, press <kbd>ESC</kbd>, type **:wq!**, and then press <kbd>Enter</kbd>.

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
> Optionally, you can use the **deployment_solution.yml** file in the root folder of your project, which contains the contents you need. You might find it easier to rename or update the contents of that file.

In the preceding **deployment.yml**, the file contains a deployment and a service. The deployment is used to administer a set of pods, and the service is used to allow network access to the pods. The pods are configured to pull a single image, `<AZ_CONTAINER_REGISTRY>.azurecr.io/flightbookingsystemsample:latest`, from Azure Container Registry. The service is configured to allow incoming HTTP pod traffic to port 8080, similar to the way you ran the container image locally with the `-p` port argument.

If the deployment succeeded, you now have an AKS cluster. Configure your Azure CLI to access your AKS cluster via the `kubectl` command. Install `kubectl` locally by using the following command:

```azurecli
az aks install-cli
```

Configure kubectl to connect to your AKS cluster by using the following command:

```azurecli
az aks get-credentials \
    --resource-group $AZ_RESOURCE_GROUP \
    --name $AZ_KUBERNETES_CLUSTER
```

The following output is typical:

```output
Merged AZ_KUBERNETES_CLUSTER as current context in ~/.kube/config
```

Use AKS to apply **deployment.yml** changes to your cluster by using the following command:

```azurecli
kubectl apply -f deployment.yml
```

The following output is typical:

```output
deployment.apps/flightbookingsystemsample created
service/flightbookingsystemsample created
```

Monitor the status of the deployment by using the following command:

```azurecli
kubectl get all
```

The following output is typical:

```output
kubectl get all
NAME                                            READY   STATUS    RESTARTS   AGE
pod/flightbookingsystemsample-b7fd6684f-4j8vf   1/1     Running   0          37s

NAME                                TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)          AGE
service/flightbookingsystemsample   LoadBalancer   10.0.62.153   <external-IP>   8080:30534/TCP   37s
service/kubernetes                  ClusterIP      10.0.0.1      <none>          443/TCP          11h

NAME                                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/flightbookingsystemsample   1/1     1            1           37s

NAME                                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/flightbookingsystemsample-b7fd6684f   1         1         1       37s
```

If your `POD` status is `Running`, the app should be accessible. View the app logs within each pod by using the following command:

```bash
kubectl logs pod/flightbookingsystemsample-<pod-identifier-from-your-running-pod>
```

The following output is typical:

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

Use the `EXTERNAL-IP` from your `kubectl get services flightbookingsystemsample` output to access the running app within AKS. The following output is typical:

```output
kubectl get services flightbookingsystemsample
NAME                        TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)          AGE
flightbookingsystemsample   LoadBalancer   10.0.62.153   <external-IP>   8080:30534/TCP   3m28s
```

> [!NOTE]
> Substitute the IP address `<external-IP>` in the following URL with your `EXTERNAL-IP` value from the command you previously executed:

Open a browser and visit the Flight Booking System Sample landing page at `http://<external-IP>:8080/AirlinesReservationSample/`. Your browser should look similar to the following screenshot:

:::image type="content" source="../media/deploy.png" alt-text="Screenshot showing the running app.":::

You can optionally sign in with any user from **tomcat-users.xml** - for example, `someuser@azure.com: password`.

## Clean up resources

The resources you created in this module might incur ongoing costs. To clean up the resources, delete the resource group that contains them, by using the following command:

```azurecli
az group delete --name $AZ_RESOURCE_GROUP
```
