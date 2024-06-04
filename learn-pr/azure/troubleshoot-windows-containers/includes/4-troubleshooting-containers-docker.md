Alternatively to troubleshooting Windows containers with native Windows tools, you can also leverage Docker to help you understand and fix issues with your environment. Let's take a look at how to do it since it's the first and most popular container toolset for developers.

## Docker inspect

Docker inspect provides detailed information about an object, outputting it in json format. To get details about a container, you can run:

```powershell
docker inspect <container id>
```

## Docker logs

To check logs of a container, you can run the docker logs command. Keep in mind it expects logs in the STDOUT format, so you need LogMonitor running and configured on your container.

```powershell
docker logs <container id>
```

## Docker exec

Docker provides a mechanism to remotely execute a command inside the container and get its output. This is useful when trying to figure out something happening inside the container.

```powershell
docker exec -ti <container id> cmd.exe
```

Alternatively to docker exec, you can also open an interactive session to a container when you create it:

```powershell
docker run -it mcr.microsoft.com/windows/servercore:ltsc2022 powershell
```

## Get resource utilization for all containers

You can also check how much resources the containers are using from the container host. This is useful to identify noise neighbors when you have multiple containers on a single host:

```powershell
docker stats
```

## List process and resource quota

Another helpful trick, is to check the processes running inside a container, and how much resources they're consuming:

```powershell
docker top <container id>
```

## Docker system prune

After a while, your container host will have many unused objects: images, networks, volumes. This happens as you update container images, improve configuration, etc. However, the old objects that aren't used anymore, continue to consume resources from the host, which might impact performance – aside from making it harder to visualize the important resources.

To clean up objects that aren't used anymore, you can run the following command:

```powershell
docker system prune
```

You can also include the `--volumes` flag to include unused volumes as part of the clean-up.

These are some of the most common Docker commands to troubleshoot containers. There are many other available that might come in handy as you build your Windows container environment.
