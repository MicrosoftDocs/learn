## Template references

You can export reusable sections of your pipeline to a separate file. These individual files are known as templates. Azure Pipelines supports four kinds of templates:

Azure Pipelines supports four types of templates:

 -  Stage
 -  Job
 -  Step
 -  Variable

You can also use templates to control what is allowed in a pipeline and define how parameters can be used.

 -  Parameter

Templates themselves can include other templates. Azure Pipelines supports a maximum of 50 individual template files in a single pipeline.

## Stage templates

You can define a set of stages in one file and use it multiple times in other files.

In this example, a stage is repeated twice for two different testing regimes. The stage itself is specified only once.

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
      vmImage: vs2017-win2016
    steps:

    - script: npm install
    - script: npm test -- --file=${{ parameters.testFile }}

  - job: ${{ parameters.name }}_Mac
    pool:
      vmImage: macos-10.14
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

You can define a set of jobs in one file and use it multiple times in other files.

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
      vmImage: 'macOS-10.14'


- template: jobs/build.yml  # Template reference
  parameters:
    name: Linux
    pool:
      vmImage: 'ubuntu-16.04'


- template: jobs/build.yml  # Template reference
  parameters:
    name: Windows
    pool:
      vmImage: 'vs2017-win2016'
    sign: true  # Extra step on Windows only

```

## Step templates

You can define a set of steps in one file and use it multiple times in another file.

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
    vmImage: 'macOS-10.14'
  steps:

  - template: steps/build.yml # Template reference


- job: Linux
  pool:
    vmImage: 'ubuntu-16.04'
  steps:

  - template: steps/build.yml # Template reference


- job: Windows
  pool:
    vmImage: 'vs2017-win2016'
  steps:

  - template: steps/build.yml # Template reference
  - script: sign              # Extra step on Windows only

```

## Variable templates

You can define a set of variables in one file and use it multiple times in other files.

In this example, a set of variables is repeated across multiple pipelines. The variables are specified only once.

```YAML
# File: variables/build.yml
variables:

- name: vmImage
  value: vs2017-win2016

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
