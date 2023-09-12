
## Adopt container modularity

Try to avoid creating overly complex container images that couple together several applications.

Instead, use multiple containers and try to keep each container to a single purpose.

The website and the database for a web application should likely be in separate containers.

There are always exceptions to any rule but breaking up application components into separate containers increases the chances of reusing containers.

It also makes it more likely that you could scale the application.

For example, in the web application mentioned, you might want to add replicas of the website container but not for the database container.

## Avoid unnecessary packages

To help minimize image sizes, it's also essential to avoid including packages that you suspect might be needed but aren't yet sure if they're required.

Only include them when they're required.

## Choose an appropriate base

While optimizing the contents of your Dockerfiles is essential, it's also crucial to choose the appropriate parent (base) image. Start with an image that only contains packages that are required.

## Avoid including application data

While application data can be stored in the container, it will make your images more prominent.

It would be best to consider using **docker volume** support to maintain the isolation of your application and its data. Volumes are persistent storage mechanisms that exist outside the lifespan of a container.

For more information, see [Use multiple-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/).
