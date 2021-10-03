With _pipelines_ you can deploy to multiple environments, however it might be that the steps needed to deploy to each environment are very similar to each other or even exactly the same. It makes sense to avoid repetition in your pipeline code, since repetition leads to errors.

In this unit you'll learn how to leverage pipeline templates to avoid repetition and to allow for reuse. 

## Reusable YAML templates and how they work

Pipeline templates let you create reusable content. This reusable content can be steps you want to reuse across pipelines, or jobs and even stages you want to reuse in other pipelines. You can also create a template for a set of variables you want to use in multiple pipelines. 

A template is nothing more than another YAML file that contains your reusable content. A simple template might look like this: 

```YAML
# File: templates/include-bicep-steps.yml

steps:
- script: |
    az bicep version
- script: |
    az bicep upgrade
- script: |
    az bicep build --file deploy/main.bicep
```

Using a pipeline template can be done by including it in your pipeline. In the below example the above steps get included twice, once for Europe and once for US: 

```YAML
# File: templates/jobs.yml

jobs:
- job: Europe
  pool:
    vmImage: 'ubuntu-latest'
  steps:
  - template: templates/include-bicep-steps.yml  # Template reference
- job: US
  pool:
    vmImage: 'ubuntu-latest'
  steps:
  - template: templates/include-bicep-steps.yml  # Template reference
```

You can now reuse this jobs template in a pipeline as well: 

```YAML
# File: azure-pipelines.yml

jobs:
- template: templates/jobs.yml  # Template reference
```

Beware though when creating templates that have jobs or stages in them you want to reuse and you want to use that template twice in a pipeline: 

```YAML
# File: azure-pipelines.yml

jobs:
- template: templates/jobs.yml  # Template reference
- template: templates/jobs.yml  # Template reference
```

With the above jobs.yml template definition this pipeline will fail, since both the Linux and Windows job will exist twice in your pipeline. For now you can remove the name to make the pipeline succeed: 

```YAML
# File: templates/jobs.yml

jobs:
- job: # no more name for the job
  pool:
    vmImage: 'ubuntu-latest'
  steps:
  - template: templates/include-bicep-steps.yml  # Template reference
- job: # no more name for the job
  pool:
    vmImage: 'windows-latest'
  steps:
  - template: templates/include-bicep-steps.yml  # Template reference
```

In the next chapter you will see another way to solve this restriction by using parameters. 

A YAML template file can exist in the same repository as the one where you want to use the template in or it can live in another repository. In case a template is located in another repository, you need to include that other repository in your pipeline as a resource. In case the above template with steps exists in another repository, the above example for including the template would be: 

```YAML
# File: azure-pipelines.yml

resources:
  repositories:
    - repository: templates
      type: git
      name: TemplateProject/TemplatesRepo

jobs:
- job: Linux
  pool:
    vmImage: 'ubuntu-latest'
  steps:
  - template: include-bicep-steps.yml@templates  # Template reference
- job: Windows
  pool:
    vmImage: 'windows-latest'
  steps:
  - template: include-bicep-steps.yml@templates  # Template reference
```

It might be useful in some cases to build a library of reusable templates that can be used across projects. 

> [!NOTE]
> Another way of using a template in a pipeline is by extending from it. This gives you an inheritance relationship between the template and your pipeline as opposed to a usage relationship. Additionally you can add extra security to your pipeline through this inheritance relationship. For the use case of Bicep template deployments to multiple environments extending from a template is out of scope. 
