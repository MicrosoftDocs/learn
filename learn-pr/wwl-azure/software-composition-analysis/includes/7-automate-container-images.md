Container images package applications along with all their dependencies, making them convenient deployment artifacts. However, this convenience introduces significant security challenges—vulnerabilities in base images, system packages, or application dependencies can compromise deployed containers. Automating container image scanning throughout the development and deployment lifecycle ensures that only secure, compliant images reach production environments.

## Understanding container security risks

Container images introduce multiple security risk categories:

### Base image vulnerabilities

**Operating system packages:**

- **System libraries:** Base images include operating system libraries (glibc, OpenSSL, zlib) that may contain vulnerabilities.
- **Package managers:** System package managers (apt, yum, apk) and their packages frequently have security issues.
- **Shell utilities:** Common utilities (bash, curl, wget) in base images can have vulnerabilities.
- **Update lag:** Official base images may include outdated packages between releases.

**Base image selection impact:**

- **Alpine vs Debian:** Alpine Linux base images are smaller but use different libraries (musl instead of glibc), affecting vulnerability profiles.
- **Distroless images:** Google's distroless images contain only application runtime dependencies, dramatically reducing attack surface.
- **Slim variants:** Slim image variants exclude common utilities, reducing size and vulnerability exposure.
- **Version currency:** Using `latest` tags can introduce unexpected changes; specific version tags provide stability but require manual updates.

### Application dependency vulnerabilities

**Language-specific packages:**

- **npm packages:** Node.js applications bring hundreds of npm dependencies that may have vulnerabilities.
- **Python packages:** Python applications include PyPI packages with potential security issues.
- **Java dependencies:** Maven and Gradle dependencies transitively include many JAR files.
- **.NET packages:** NuGet packages in .NET applications can contain vulnerabilities.

**Transitive dependencies:**

- **Deep dependency trees:** Application dependencies have their own dependencies, creating deep dependency trees.
- **Hidden vulnerabilities:** Vulnerabilities in transitive dependencies are easy to overlook without automated scanning.
- **Update complexity:** Updating transitive dependencies requires understanding compatibility across the entire dependency chain.

### Image layer accumulation

**Layered filesystem:**

- **Layer inheritance:** Each Dockerfile instruction creates a new layer, and vulnerabilities in any layer affect the final image.
- **Deleted files persist:** Files deleted in later layers still exist in earlier layers and contribute to image size and security profile.
- **Secrets in history:** Secrets accidentally committed to early layers remain in image history even if removed in later layers.
- **Build-time dependencies:** Dependencies needed only during build (compilers, build tools) shouldn't appear in final runtime images.

### Configuration vulnerabilities

**Dockerfile misconfigurations:**

- **Running as root:** Containers running as root user have unnecessary privileges.
- **Exposed ports:** Unnecessarily exposed ports expand attack surface.
- **SUID binaries:** SUID/SGID binaries enable privilege escalation attacks.
- **Insecure defaults:** Default configurations may not follow security best practices.

## Container scanning approaches

Effective container security requires scanning at multiple points in the lifecycle:

### Registry scanning

**Continuous registry monitoring:**
Container registries provide centralized locations for scanning and policy enforcement.

**Azure Container Registry scanning with Microsoft Defender:**

- **Automatic scanning:** Microsoft Defender for Containers automatically scans images pushed to Azure Container Registry.
- **Trigger-based scanning:** Scans trigger on push, import, and pull operations.
- **Continuous re-scanning:** Images are periodically rescanned for newly disclosed vulnerabilities.
- **Recommendations:** Security Center provides remediation recommendations for discovered vulnerabilities.

**Registry scan triggers:**

- **Push triggers:** New images automatically scan when pushed to the registry.
- **Import triggers:** Images imported from external registries are scanned.
- **Pull triggers:** Images are scanned within 24 hours after being pulled.
- **Periodic rescanning:** Previously scanned images are rescanned daily (last 90 days for pushed images, last 30 days for pulled images).

### Build-time scanning

**CI/CD pipeline integration:**
Scanning during image builds catches vulnerabilities before images reach registries.

**Azure Pipelines container scanning:**

```yaml
trigger:
  branches:
    include:
      - main

pool:
  vmImage: "ubuntu-latest"

variables:
  imageName: "myapp"
  dockerfilePath: "$(Build.SourcesDirectory)/Dockerfile"

steps:
  - task: Docker@2
    displayName: "Build container image"
    inputs:
      command: "build"
      repository: "$(imageName)"
      dockerfile: "$(dockerfilePath)"
      tags: "$(Build.BuildNumber)"

  - task: AquaScannerCLI@4
    displayName: "Scan image with Aqua Security"
    inputs:
      image: "$(imageName):$(Build.BuildNumber)"
      scanType: "local"
      register: false
      hideBase: false
      showNegligible: false

  - script: |
      docker run --rm \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v $(Build.SourcesDirectory):/src \
        aquasec/trivy image \
        --severity HIGH,CRITICAL \
        --exit-code 1 \
        $(imageName):$(Build.BuildNumber)
    displayName: "Scan with Trivy (fail on high/critical)"

  - task: Docker@2
    displayName: "Push image to registry"
    condition: succeeded()
    inputs:
      command: "push"
      repository: "$(imageName)"
      tags: "$(Build.BuildNumber)"
```

**GitHub Actions container scanning:**

```yaml
name: Container Build and Scan

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

env:
  IMAGE_NAME: myapp
  REGISTRY: ghcr.io

jobs:
  build-and-scan:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write
      security-events: write

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2

      - name: Build container image
        uses: docker/build-push-action@v4
        with:
          context: .
          load: true
          tags: ${{ env.IMAGE_NAME }}:${{ github.sha }}
          cache-from: type=gha
          cache-to: type=gha,mode=max

      - name: Scan image with Trivy
        uses: aquasecurity/trivy-action@master
        with:
          image-ref: "${{ env.IMAGE_NAME }}:${{ github.sha }}"
          format: "sarif"
          output: "trivy-results.sarif"
          severity: "CRITICAL,HIGH"

      - name: Upload Trivy results to GitHub Security
        uses: github/codeql-action/upload-sarif@v2
        if: always()
        with:
          sarif_file: "trivy-results.sarif"

      - name: Scan with Snyk
        uses: snyk/actions/docker@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
        with:
          image: ${{ env.IMAGE_NAME }}:${{ github.sha }}
          args: --severity-threshold=high --file=Dockerfile

      - name: Log in to GitHub Container Registry
        if: github.event_name == 'push'
        uses: docker/login-action@v2
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Push image to registry
        if: github.event_name == 'push'
        run: |
          docker tag ${{ env.IMAGE_NAME }}:${{ github.sha }} \
            ${{ env.REGISTRY }}/${{ github.repository }}:${{ github.sha }}
          docker push ${{ env.REGISTRY }}/${{ github.repository }}:${{ github.sha }}
```

**GitHub Advanced Security container scanning:**
GitHub Advanced Security provides additional container security capabilities through CodeQL and dependency scanning.

```yaml
name: Container Security with GitHub Advanced Security

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  schedule:
    - cron: "0 0 * * 0" # Weekly scheduled scan

env:
  IMAGE_NAME: myapp
  REGISTRY: ghcr.io

jobs:
  build-and-scan:
    runs-on: ubuntu-latest
    permissions:
      actions: read
      contents: read
      security-events: write
      packages: write

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Initialize CodeQL
        uses: github/codeql-action/init@v2
        with:
          languages: "javascript" # Adjust based on your language

      - name: Build container image
        run: |
          docker build -t ${{ env.IMAGE_NAME }}:${{ github.sha }} .

      - name: Perform CodeQL Analysis
        uses: github/codeql-action/analyze@v2
        with:
          category: "/language:javascript"

      - name: Run CodeQL container scanning
        uses: github/codeql-action/analyze@v2
        with:
          category: "/language:dockerfile"

      - name: Scan container dependencies
        uses: anchore/scan-action@v3
        with:
          image: ${{ env.IMAGE_NAME }}:${{ github.sha }}
          fail-build: true
          severity-cutoff: high

      - name: Upload Anchore scan SARIF report
        uses: github/codeql-action/upload-sarif@v2
        if: always()
        with:
          sarif_file: results.sarif

      - name: Push image to registry
        if: github.event_name == 'push'
        run: |
          echo ${{ secrets.GITHUB_TOKEN }} | docker login ${{ env.REGISTRY }} -u ${{ github.actor }} --password-stdin
          docker tag ${{ env.IMAGE_NAME }}:${{ github.sha }} ${{ env.REGISTRY }}/${{ github.repository }}:${{ github.sha }}
          docker push ${{ env.REGISTRY }}/${{ github.repository }}:${{ github.sha }}
```

**Build-time scanning benefits:**

- **Fail fast:** Prevent vulnerable images from being built and pushed to registries.
- **Developer feedback:** Provide immediate feedback to developers during build process.
- **Policy enforcement:** Enforce security policies before images reach registries or production.
- **Build artifact validation:** Ensure only compliant images progress through deployment pipeline.

### Runtime scanning

**Deployed container monitoring:**
Runtime scanning detects vulnerabilities in actually deployed containers.

**Kubernetes admission controllers:**
Admission controllers enforce policies before containers are deployed to Kubernetes clusters.

**OPA Gatekeeper policy example:**

```yaml
apiVersion: templates.gatekeeper.sh/v1
kind: ConstraintTemplate
metadata:
  name: k8srequiredscanstatus
spec:
  crd:
    spec:
      names:
        kind: K8sRequiredScanStatus
      validation:
        openAPIV3Schema:
          type: object
          properties:
            maxSeverity:
              type: string
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8srequiredscanstatus

        violation[{"msg": msg}] {
          container := input.review.object.spec.containers[_]
          not scan_clean(container.image)
          msg := sprintf("Image %v has not been scanned or has vulnerabilities", [container.image])
        }

        scan_clean(image) {
          # Query registry for scan status
          # This is simplified; actual implementation queries scan results
          scan_result := data.scans[image]
          scan_result.status == "passed"
        }
```

**Azure Kubernetes Service runtime protection:**
Microsoft Defender for Containers provides runtime threat detection:

- **Behavioral analytics:** Monitors container behavior to detect anomalous activities.
- **Threat intelligence:** Compares observed behaviors against known attack patterns.
- **MITRE ATT&CK mapping:** Maps detected threats to MITRE ATT&CK framework.
- **Alert generation:** Generates security alerts for suspicious container activities.

## Container scanning tools

### Trivy (Aqua Security)

**Trivy** is a comprehensive open-source container vulnerability scanner.

**Key features:**

- **Comprehensive scanning:** Scans OS packages, application dependencies, IaC configurations, and secrets.
- **Multi-format support:** Scans container images, filesystems, git repositories, and Kubernetes clusters.
- **Offline scanning:** Can operate in air-gapped environments with offline vulnerability databases.
- **Fast performance:** Lightweight scanner with fast scan times.
- **SBOM generation:** Generates CycloneDX and SPDX software bill of materials.

**Azure Pipelines Trivy integration:**

```yaml
- script: |
    wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
    echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/trivy.list
    sudo apt-get update
    sudo apt-get install trivy

    trivy image \
      --severity HIGH,CRITICAL \
      --exit-code 1 \
      --no-progress \
      --format json \
      --output trivy-results.json \
      $(imageName):$(Build.BuildNumber)
  displayName: "Scan image with Trivy"
```

### Snyk Container

**Snyk Container** provides container image scanning integrated with Snyk's developer-focused platform.

**Key features:**

- **Base image recommendations:** Suggests alternative base images with fewer vulnerabilities.
- **Prioritization:** Prioritizes vulnerabilities based on exploitability and business impact.
- **Fix guidance:** Provides specific remediation steps for discovered vulnerabilities.
- **Kubernetes integration:** Scans images deployed to Kubernetes clusters.

### Aqua Security

**Aqua Security** offers enterprise-grade container security across the full lifecycle.

**Key features:**

- **Image assurance:** Comprehensive image scanning with customizable policies.
- **Runtime protection:** Monitors running containers for suspicious behavior.
- **Compliance checking:** Validates images against CIS Docker Benchmark and custom policies.
- **Supply chain security:** Verifies image provenance and detects supply chain attacks.

### Anchore Engine

**Anchore Engine** is an open-source container image scanner with policy-based analysis.

**Key features:**

- **Policy-driven:** Flexible policy engine for defining security and compliance rules.
- **Deep inspection:** Analyzes image layers, packages, and configuration.
- **Custom policies:** Define organization-specific security and compliance policies.
- **API-driven:** REST API for integration with custom tooling.

### GitHub Advanced Security

**GitHub Advanced Security** provides enterprise-grade security features for repositories including container scanning capabilities.

**Container security features:**

- **Dependency scanning:** Automatically detects vulnerable dependencies in container images.
- **Secret scanning:** Identifies exposed secrets (API keys, tokens, credentials) in container layers and Dockerfiles.
- **Code scanning:** CodeQL analysis of Dockerfiles and application code within containers.
- **Security advisories:** Integration with GitHub Advisory Database for vulnerability intelligence.
- **Supply chain security:** Dependency graph and Dependabot integration for container dependencies.

**Running CodeQL in containers:**
GitHub Advanced Security supports running CodeQL code scanning within container environments for comprehensive analysis:

**CodeQL container scanning workflow:**

```yaml
name: CodeQL Container Analysis

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  analyze-container:
    runs-on: ubuntu-latest
    permissions:
      actions: read
      contents: read
      security-events: write

    strategy:
      fail-fast: false
      matrix:
        language: ["javascript", "python"]

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Initialize CodeQL
        uses: github/codeql-action/init@v2
        with:
          languages: ${{ matrix.language }}
          queries: security-extended,security-and-quality

      - name: Build application in container
        run: |
          docker build -t app:latest .
          docker create --name temp-container app:latest
          docker cp temp-container:/app/built-artifacts ./artifacts
          docker rm temp-container

      - name: Perform CodeQL Analysis
        uses: github/codeql-action/analyze@v2
        with:
          category: "/language:${{ matrix.language }}"

      - name: Scan Dockerfile
        uses: github/codeql-action/analyze@v2
        with:
          category: "/language:dockerfile"
```

**Secret scanning for containers:**

```yaml
name: Container Secret Scanning

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  scan-secrets:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      security-events: write

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Build container image
        run: docker build -t myapp:${{ github.sha }} .

      - name: Scan image for secrets
        uses: trufflesecurity/trufflehog@main
        with:
          path: ./
          base: ${{ github.event.repository.default_branch }}
          head: HEAD

      - name: Scan container layers for secrets
        run: |
          docker save myapp:${{ github.sha }} -o image.tar
          docker run --rm -v $(pwd):/scan \
            trufflesecurity/trufflehog:latest \
            filesystem /scan/image.tar \
            --json > secrets-report.json

      - name: Upload secret scan results
        uses: github/codeql-action/upload-sarif@v2
        if: always()
        with:
          sarif_file: secrets-report.sarif
```

**GitHub Advanced Security benefits:**

- **Native integration:** Deeply integrated with GitHub workflows and security features.
- **Unified dashboard:** Centralized security overview in GitHub Security tab.
- **Policy enforcement:** Branch protection rules can require passing security checks.
- **Compliance reporting:** Built-in compliance reports for SOC 2, ISO 27001, and other frameworks.
- **Team collaboration:** Security findings integrated into pull request reviews and issue tracking.

**Enabling GitHub Advanced Security:**

For organizations:

1. Navigate to organization **Settings → Code security and analysis**.
2. Enable **GitHub Advanced Security** for all or selected repositories.
3. Configure **Dependabot alerts**, **Secret scanning**, and **Code scanning**.
4. Set up **Security policies** and **Security advisories**.

For repositories:

1. Go to repository **Settings → Code security and analysis**.
2. Enable **Dependency graph** (free for public repositories).
3. Enable **Dependabot alerts** and **Dependabot security updates**.
4. Enable **Secret scanning** (requires GitHub Advanced Security license for private repos).
5. Enable **Code scanning** with CodeQL or third-party tools.

**Advanced Security for container registries:**

```yaml
name: Registry Security Monitoring

on:
  schedule:
    - cron: "0 */6 * * *" # Every 6 hours
  workflow_dispatch:

jobs:
  scan-registry:
    runs-on: ubuntu-latest
    permissions:
      packages: read
      security-events: write

    steps:
      - name: Login to GitHub Container Registry
        uses: docker/login-action@v2
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Pull images from registry
        run: |
          docker pull ghcr.io/${{ github.repository }}/app:latest
          docker pull ghcr.io/${{ github.repository }}/app:staging

      - name: Scan registry images
        uses: aquasecurity/trivy-action@master
        with:
          image-ref: "ghcr.io/${{ github.repository }}/app:latest"
          format: "sarif"
          output: "trivy-registry.sarif"

      - name: Upload scan results
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: trivy-registry.sarif
          category: "registry-scan"

      - name: Check for critical vulnerabilities
        run: |
          CRITICAL_COUNT=$(docker run --rm \
            -v /var/run/docker.sock:/var/run/docker.sock \
            aquasec/trivy image \
            --severity CRITICAL \
            --format json \
            ghcr.io/${{ github.repository }}/app:latest | \
            jq '.Results[].Vulnerabilities | length')

          if [ "$CRITICAL_COUNT" -gt 0 ]; then
            echo "::error::Found $CRITICAL_COUNT critical vulnerabilities"
            exit 1
          fi
```

**Integration with GitHub security features:**

- **Security overview:** Organization-wide security dashboard showing container vulnerabilities.
- **Security alerts:** Automated alerts for vulnerable container dependencies.
- **Dependabot updates:** Automated pull requests to update vulnerable base images and dependencies.
- **Code owners integration:** Route security findings to appropriate teams via CODEOWNERS file.
- **Audit logs:** Complete audit trail of security events and remediation actions.

## Best practices for container scanning

### Implement multi-stage builds

**Separate build and runtime dependencies:**

```dockerfile
# Build stage
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Runtime stage
FROM node:18-slim
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY package*.json ./
USER node
EXPOSE 3000
CMD ["node", "dist/server.js"]
```

**Benefits:**

- **Smaller images:** Runtime images don't include build tools and intermediate artifacts.
- **Fewer vulnerabilities:** Build dependencies (compilers, SDKs) don't appear in final images.
- **Better performance:** Smaller images push, pull, and start faster.

### Use minimal base images

**Choose appropriate base images:**

- **Alpine:** Small base image (~5 MB) with minimal attack surface.
- **Distroless:** Contains only application and runtime dependencies, no shell or package manager.
- **Slim variants:** Official `*-slim` variants exclude unnecessary utilities.
- **Specific versions:** Use specific version tags instead of `latest` for reproducibility.

**Example distroless image:**

```dockerfile
FROM golang:1.21 AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build -o myapp .

FROM gcr.io/distroless/static-debian11
COPY --from=builder /app/myapp /
USER nonroot:nonroot
CMD ["/myapp"]
```

### Scan early and often

**Scanning frequency:**

- **Developer workstation:** Scan images locally before committing.
- **Pull request validation:** Scan in CI pipelines on every pull request.
- **Main branch builds:** Comprehensive scans on main branch merges.
- **Registry admission:** Scan images before accepting them into registries.
- **Scheduled rescanning:** Periodically rescan stored images for newly disclosed vulnerabilities.
- **Pre-deployment:** Final validation before deploying to production.

### Implement security gates

**Policy enforcement points:**

```yaml
- task: Trivy@1
  inputs:
    image: "$(imageName):$(Build.BuildNumber)"
    severityThreshold: "HIGH"
    exitCode: 1
  displayName: "Security gate: block high/critical vulnerabilities"
```

**Gate examples:**

- **Vulnerability severity:** Fail builds with critical or high severity vulnerabilities.
- **License compliance:** Block images with prohibited licenses.
- **Configuration issues:** Prevent deployment of images running as root.
- **Secret detection:** Fail if secrets are detected in image layers.

### Automate remediation

**Automated updates:**

- **Dependabot for Dockerfiles:** Enable Dependabot to update base image versions and dependencies in Dockerfiles.
- **Automated rebuilds:** Configure pipelines to automatically rebuild images when base images are updated.
- **Patch automation:** Use tools to automatically patch base images or dependencies.
- **Testing pipelines:** Ensure automated updates trigger comprehensive testing.

**GitHub Dependabot configuration for Docker:**

```yaml
version: 2
updates:
  - package-ecosystem: "docker"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 5
```

### Maintain scan result history

**Tracking and trending:**

- **Centralized reporting:** Aggregate scan results in centralized dashboards.
- **Trend analysis:** Track vulnerability counts over time to measure security posture.
- **Compliance audits:** Maintain scan result history for compliance evidence.
- **SBOM archiving:** Archive software bill of materials for deployed images.

### Implement image signing

**Verify image provenance:**

```yaml
- task: Docker@2
  inputs:
    command: "sign"
    arguments: "--key $(signingKey) $(imageName):$(Build.BuildNumber)"
  displayName: "Sign container image"

- script: |
    docker trust inspect --pretty $(imageName):$(Build.BuildNumber)
  displayName: "Verify image signature"
```

**Image signing benefits:**

- **Provenance verification:** Confirm images originated from trusted sources.
- **Tampering detection:** Detect if images have been modified after signing.
- **Policy enforcement:** Deploy only signed images to production environments.

Automating container image scanning across the development and deployment lifecycle ensures comprehensive vulnerability detection and policy enforcement. By scanning early, scanning often, and implementing automated remediation, organizations can maintain secure container deployments without sacrificing development velocity. The next unit examines how to interpret and prioritize alerts from security scanner tools.
