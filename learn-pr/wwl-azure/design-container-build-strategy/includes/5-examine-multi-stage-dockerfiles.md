Multi-stage Dockerfiles enable complex build processes within a single file, eliminating the need for separate build scripts and intermediate images. They implement the builder pattern efficiently by using multiple FROM statements with named stages.

Example multi-stage Dockerfile:

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

## Multi-Stage Build Mechanics

Multi-stage builds use named stages that can reference each other. Key concepts:

**Named Stages**: `FROM build AS publish` creates a stage named "publish" that inherits from the "build" stage, not a registry image.

**Cross-Stage Copying**: `COPY --from=publish /app/publish .` copies files between stages, enabling separation of build and runtime environments.

**Optimized Images**: Compile with full SDK images while deploying minimal runtime images, reducing final image size and attack surface.

## Stage Breakdown

**Stage 1 (base)**: Runtime foundation using optimized ASP.NET Core runtime image with production configurations and exposed ports.

**Stage 2 (build)**: Build environment with complete SDK for compilation, containing all development tools and dependencies.

**Stage 3 (publish)**: Publishing stage that prepares deployment artifacts by collecting all required binaries, assets, and dependencies into a single directory.

**Stage 4 (final)**: Production image combining the minimal runtime base with published artifacts, creating an optimized deployment container.

## Testing Integration

Separate build and publish stages enable test execution between compilation and deployment:

```docker
FROM build AS test
WORKDIR /src/Web.test
RUN dotnet test
```

This pattern ensures code quality by failing the build process if tests fail, preventing deployment of broken code.

## Stage Ordering Strategy

Placing the base stage first provides development and performance benefits:

**Development Efficiency**: Development tools can target specific stages using `docker build --target base`, enabling rapid iteration without executing full build pipelines.

**Debug Optimization**: Visual Studio Container Tools can mount compiled binaries directly into the base stage, bypassing build stages during debugging sessions.

**Build Performance**: Targeting early stages reduces build time during development by skipping unnecessary compilation steps.
