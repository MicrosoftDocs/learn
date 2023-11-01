
What are multi-stage Dockerfiles? Multi-stage builds give the benefits of the builder pattern without the hassle of maintaining three separate files.

Let us look at a multi-stage Dockerfile.

```docker
FROM mcr.microsoft.com/dotnet/core/aspnetcore:3.1 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY ["WebApplication1.csproj", ""]
RUN dotnet restore "./WebApplication1.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "WebApplication1.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "WebApplication1.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "WebApplication1.dll"]

```

At first, it simply looks like several dockerfiles stitched together. Multi-stage Dockerfiles can be layered or inherited.

When you look closer, there are a couple of key things to realize.

Notice the third stage.

`FROM build AS publish`

build isn't an image pulled from a registry. It's the image we defined in stage 2, where we named the result of our-build (SDK) image "builder." `Docker build` will create a named image we can later reference.

We can also copy the output from one image to another. It's the real power to compile our code with one base SDK image (`mcr.microsoft.com/dotnet/core/sdk:3.1`) while creating a production image based on an optimized runtime image (`mcr.microsoft.com/dotnet/core/aspnet:3.1`). Notice the line.

`COPY --from=publish /app/publish .`

It takes the /app/publish directory from the published image and copies it to the working directory of the production image.

## Breakdown of stages

The first stage provides the base of our optimized runtime image. Notice it derives from `mcr.microsoft.com/dotnet/core/aspnet:3.1`.

We would specify extra production configurations, such as registry configurations, MSIexec of other components. You would hand off any of those environment configurations to your ops folks to prepare the VM.

The second stage is our build environment. `mcr.microsoft.com/dotnet/core/sdk:3.1` This includes everything we need to compile our code. From here, we have compiled binaries we can publish or test—more on testing in a moment.

The third stage derives from our build stage. It takes the compiled output and "publishes" them in .NET terms.

Publish means taking all the output required to deploy your "app/publish/service/component" and placing it in a single directory. It would include your compiled binaries, graphics (images), JavaScript, and so on.

The fourth stage takes the published output and places it in the optimized image we defined in the first stage.

## Why is publish separate from the build?

You'll likely want to run unit tests to verify your compiled code. Or the aggregate of the compiled code from multiple developers being merged continues to function as expected.

You could place the following stage between builder and publish to run unit tests.

```docker
FROM build AS test
WORKDIR /src/Web.test
RUN dotnet test

```

If your tests fail, the build will stop to continue.

## Why is base first?

You could argue it's simply the logical flow. We first define the base runtime image. Get the compiled output ready, and place it in the base image.

However, it's more practical. While debugging your applications under Visual Studio Container Tools, VS will debug your code directly in the base image.

When you hit F5, Visual Studio will compile the code on your dev machine. The first stage then volume mounts the output to the built runtime image.

You can test any configurations you have made to your production image, such as registry configurations or otherwise.

When the `docker build --target base` is executed, docker starts processing the dockerfile from the beginning through the stage (target) defined.

Since the base is the first stage, we take the shortest path, making the F5 experience as fast as possible.

If the base were after compilation (builder), you would have to wait for all the next steps to complete.

One of the perf optimizations we make with VS Container Tools is to take advantage of the Visual Studio compilations on your dev machine.
