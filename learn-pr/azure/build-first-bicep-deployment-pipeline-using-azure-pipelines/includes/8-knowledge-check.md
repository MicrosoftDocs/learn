Consider the following pipeline definition:

```yaml
trigger:
  branches:
    include:
    - master
    - releases/*
  paths:
    include:
    - templates
    exclude:
    - templates/README.md
```