## Template references

You can save reusable parts of your pipeline to separate files. These files are called templates.

Azure Pipelines supports four types of templates:

- Stage
- Job
- Step
- Variable

You can also use templates to control what's allowed in a pipeline and define how to use parameters.

- Parameter

Templates can include other templates. Azure Pipelines supports up to 50 template files in a single pipeline.

## Stage templates

You can define stages in one file and reuse them in other files.

In this example, a stage is repeated twice for two testing regimes. The stage itself is specified only once.

```YAML
# File: stages/test.yml

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

Templated pipeline

```YAML
# File: azure-pipelines.yml

stages:

- template: stages/test.yml  # Template reference
  parameters:
    name: Mini
    testFile: tests/miniSuite.js


- template: stages/test.yml  # Template reference
  parameters:
    name: Full
    testFile: tests/fullSuite.js

```

## Job templates

You can define jobs in one file and reuse them in other files.

In this example, a single job is repeated on three platforms. The job itself is specified only once.

```YAML
# File: jobs/build.yml

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

```YAML
# File: azure-pipelines.yml

jobs:

- template: jobs/build.yml  # Template reference
  parameters:
    name: macOS
    pool:
      vmImage: 'macOS-latest'


- template: jobs/build.yml  # Template reference
  parameters:
    name: Linux
    pool:
      vmImage: 'ubuntu-latest'


- template: jobs/build.yml  # Template reference
  parameters:
    name: Windows
    pool:
      vmImage: 'windows-latest'
    sign: true  # Extra step on Windows only

```

## Step templates

You can define steps in one file and reuse them in other files.

```YAML
# File: steps/build.yml

steps:

- script: npm install
- script: npm test

```

```YAML
# File: azure-pipelines.yml

jobs:

- job: macOS
  pool:
    vmImage: 'macOS-latest'
  steps:

  - template: steps/build.yml # Template reference


- job: Linux
  pool:
    vmImage: 'ubuntu-latest'
  steps:

  - template: steps/build.yml # Template reference


- job: Windows
  pool:
    vmImage: 'windows-latest'
  steps:

  - template: steps/build.yml # Template reference
  - script: sign              # Extra step on Windows only

```

## Variable templates

You can define variables in one file and reuse them in other files.

In this example, variables are shared across different pipelines. You define the variables only once.

```YAML
# File: variables/build.yml
variables:

- name: vmImage
  value: windows-latest

- name: arch
  value: x64

- name: config
  value: debug

```

```YAML
# File: component-x-pipeline.yml
variables:

- template: variables/build.yml  # Template reference
pool:
  vmImage: ${{ variables.vmImage }}
steps:

- script: build x ${{ variables.arch }} ${{ variables.config }}

```

```YAML
# File: component-y-pipeline.yml
variables:

- template: variables/build.yml  # Template reference
pool:
  vmImage: ${{ variables.vmImage }}
steps:

- script: build y ${{ variables.arch }} ${{ variables.config }}

```
