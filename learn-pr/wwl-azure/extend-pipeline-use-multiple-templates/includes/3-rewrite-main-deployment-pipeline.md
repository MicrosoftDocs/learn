Azure Pipelines allows you to define build and release processes using YAML templates. Templates are reusable and enable you to define your pipelines declaratively. It means you can define your pipelines as code, commit the code to your source control repository, and have it versioned and managed like any other code.

In this unit, examine the template types to use YAML templates in Azure Pipelines and rewrite the main deployment pipeline with examples of template usage.

## Template types and usage

Azure Pipelines supports four types of templates:

- **Stage template** - You can use a stage template to define a stage you want to reuse in multiple pipelines. For example, you can specify a stage template that deploys an application to a specific environment. You can reuse the stage template in multiple pipelines to deploy the application to different environments.

- **Job template** - You can define a job template that builds a specific application. You can reuse the job template in multiple pipelines to build the application for different platforms.

- **Step template** - You can define a step template that creates a resource group. You can reuse the step template in multiple pipelines to create a resource group for different applications.

- **Variable template** - You can define a variable template that establishes a connection string to a database. You can reuse the variable template in multiple pipelines to connect to the database.

### Stage template

You can define a set of stages in one file and use it multiple times in other files.

In this example, a stage is repeated twice for two testing regimes. The stage itself is specified only once.

```YAML
# File: stages/test.yaml

parameters:
  name: ''
  testFile: ''

stages:

- stage: Test_${{ parameters.name }}
  jobs:

  - job: ${{ parameters.name }}_Windows
    pool:
      vmImage: windows-latest
    steps:

    - script: npm install
    - script: npm test -- --file=${{ parameters.testFile }}

  - job: ${{ parameters.name }}_Mac
    pool:
      vmImage: macOS-latest
    steps:

    - script: npm install
    - script: npm test -- --file=${{ parameters.testFile }}

```

Templated pipeline:

```YAML
# File: stages/test.yaml

stages:

- template: stages/test.yaml # Template reference
  parameters:
    name: Mini
    testFile: tests/miniSuite.js

- template: stages/test.yaml
  parameters:
    name: Full
    testFile: tests/fullSuite.js

```

### Job templates

You can define a set of jobs in one file and use it multiple times in others.

In this example, a single job is repeated on three platforms. The job itself is specified only once.

```YAML
# File: jobs/build.yaml

parameters:
  name: ''
  pool: ''
  sign: false

jobs:

- job: ${{ parameters.name }}
  pool: ${{ parameters.pool }}
  steps:

  - script: npm install
  - script: npm test

  - ${{ if eq(parameters.sign, 'true') }}:
    - script: sign

```

Templated pipeline:

```YAML
# File: azure-pipelines.yaml

jobs:

- template: jobs/build.yaml  # Template reference
  parameters:
    name: macOS
    pool:
      vmImage: 'macOS-latest'


- template: jobs/build.yaml  # Template reference
  parameters:
    name: Linux
    pool:
      vmImage: 'ubuntu-latest'


- template: jobs/build.yaml  # Template reference
  parameters:
    name: Windows
    pool:
      vmImage: 'windows-latest'
    sign: true  # Extra step on Windows only

```

### Step templates

You can define a set of steps in one file and use it multiple times in another.

```YAML
# File: steps/build.yaml

steps:

- script: npm install
- script: npm test

```

Templated pipeline:

```YAML
# File: azure-pipelines.yaml

jobs:

- job: macOS
  pool:
    vmImage: 'macOS-latest'
  steps:

  - template: steps/build.yaml # Template reference


- job: Linux
  pool:
    vmImage: 'ubuntu-latest'
  steps:

  - template: steps/build.yaml # Template reference


- job: Windows
  pool:
    vmImage: 'windows-latest'
  steps:

  - template: steps/build.yaml # Template reference
  - script: sign              # Extra step on Windows only

```

### Variable templates

You can define a set of variables in one file and use it multiple times in other files.

In this example, a set of variables is repeated across multiple pipelines. The variables are specified only once.

```YAML
# File: variables/build.yaml
variables:

- name: vmImage
  value: windows-latest

- name: arch
  value: x64

- name: config
  value: debug

```

Templated pipelines:

```YAML
# File: component-x-pipeline.yaml
variables:

- template: variables/build.yaml  # Template reference
pool:
  vmImage: ${{ variables.vmImage }}
steps:

- script: build x ${{ variables.arch }} ${{ variables.config }}

```

```YAML
# File: component-y-pipeline.yaml
variables:

- template: variables/build.yaml  # Template reference
pool:
  vmImage: ${{ variables.vmImage }}
steps:

- script: build y ${{ variables.arch }} ${{ variables.config }}

```

## Challenge yourself

Create a reusable template for a common task in your organization's deployment pipeline. It can be anything from creating a resource group to deploying a specific application.

For more information about templates and YAML pipelines, see:

- [Security through templates.](https://learn.microsoft.com/azure/devops/pipelines/security/templates)
- [Template types & usage.](https://learn.microsoft.com/azure/devops/pipelines/process/templates/)
