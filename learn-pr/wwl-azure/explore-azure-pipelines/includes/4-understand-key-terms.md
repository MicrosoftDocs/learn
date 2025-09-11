Understanding these key terms will help you work confidently with Azure Pipelines and communicate effectively with your team.

:::image type="content" source="../media/key-pipeline-concepts-overview-ca80c85c.png" alt-text="Diagram that shows key pipeline terms with a trigger action, starting the pipeline with multiple stages, using various jobs and tasks to create a build artifact, and start the deployment.":::

## Core building blocks

### Pipeline

- **What it is**: A pipeline is like a recipe that describes exactly how to build, test, and deploy your application.
- **Think of it as**: A step-by-step instruction manual that tells Azure Pipelines what to do with your code.
- **Example**: "First build the app, then run tests, then deploy to staging, finally deploy to production."

### Stage

- **What it is**: Stages are the major phases of your pipeline. Each stage represents a logical boundary in your process.
- **Think of it as**: Chapters in your instruction manual, each focusing on a different goal.
- **Common examples**:
  - **Build stage** - "Compile the code and create the application."
  - **Test stage** - "Run all automated tests to verify quality."
  - **Deploy stage** - "Release the application to users."

### Job

- **What it is**: A job is a collection of related tasks that run together on the same computer (agent).
- **Think of it as**: A set of related steps that need to happen in the same place.
- **Example**: One job might compile your code and run unit tests, while another job runs security scans.

### Task

- **What it is**: A task is a single action or step in your pipeline.
- **Think of it as**: Individual instructions like "compile code," "run tests," or "copy files."
- **Examples**:
  - Build a .NET application.
  - Run JavaScript tests.
  - Deploy to Azure App Service.
  - Send a notification email.

## Execution and automation

### Agent

- **What it is**: An agent is a computer (virtual or physical) that actually runs your pipeline tasks.
- **Think of it as**: The worker that follows your pipeline instructions and does the actual work.
- **Types**:
  - **Microsoft-hosted agents** - Microsoft provides and maintains these (easiest option).
  - **Self-hosted agents** - You provide and maintain your own computers.

### Build

- **What it is**: A build is one complete run of your pipeline from start to finish.
- **Think of it as**: One execution of your recipe, producing a specific result.
- **What it includes**:
  - All the logs showing what happened
  - Test results and reports
  - Any files or packages that were created

### Trigger

- **What it is**: A trigger tells Azure Pipelines when to start running your pipeline.
- **Think of it as**: The event that kicks off your automated process.
- **Common triggers**:
  - **Code changes** - Run when someone commits code
  - **Schedule** - Run at specific times (like every night)
  - **Manual** - Run when someone clicks a button
  - **Other pipelines** - Run when another pipeline completes

## Outputs and deployment

### Artifact

- **What it is**: An artifact is a collection of files produced by your pipeline that other processes can use.
- **Think of it as**: The finished products from your pipeline that you want to keep or deploy.
- **Examples**:
  - Compiled application files ready for deployment
  - Test reports showing what passed or failed
  - Documentation generated from your code
  - Container images ready for deployment

### Deployment target

- **What it is**: A deployment target is where your application will actually run for users.
- **Think of it as**: The destination where your finished application goes to serve real users.
- **Examples**:
  - Azure App Service for web applications
  - Virtual machines in the cloud
  - Kubernetes clusters for containerized apps
  - Azure Functions for serverless code

### Release

**What it is**: A release represents deploying your application to one or more environments.
**Think of it as**: The process of taking your finished application and making it available to users.

> [!NOTE]
> In modern Azure Pipelines, releases are often handled within the same pipeline rather than separate release pipelines.

## Process concepts

### Continuous Integration (CI)

- **What it is**: The practice of automatically building and testing your code whenever changes are made.
- **Why it matters**: Catches problems early when they're easier and cheaper to fix.
- **What happens**:
  1. Developer commits code changes
  2. Pipeline automatically builds the application
  3. Automated tests run to check for problems
  4. Team gets immediate feedback about code quality

### Continuous Delivery (CD)

- **What it is**: The practice of automatically deploying tested code to different environments.
- **Why it matters**: Gets new features to users faster with less risk.
- **What happens**:
  1. Code passes all CI checks
  2. Application is automatically deployed to test environments
  3. Further testing happens in production-like conditions
  4. When ready, code is deployed to production

## How these concepts work together

1. **Developer commits code** → **Trigger** fires
2. **Pipeline** starts and runs through each **Stage**
3. **Agents** execute **Jobs** containing multiple **Tasks**
4. **Build** completes and produces **Artifacts**
5. **Artifacts** get deployed to **Deployment targets**
6. Process repeats with each code change

Understanding these terms helps you:

- **Plan your pipeline strategy** more effectively
- **Communicate clearly** with team members and stakeholders
- **Troubleshoot problems** when they occur
- **Optimize your process** over time

In the next section, we'll test your understanding of these concepts with a knowledge check.
