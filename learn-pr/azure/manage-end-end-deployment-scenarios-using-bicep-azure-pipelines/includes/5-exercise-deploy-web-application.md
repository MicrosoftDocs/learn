TODO

## Add output to Bicep file

1. Open VS Code

1. Open main.bicep

1. Add output to bottom of the file

   :::code language="bicep" source="code/5-main.bicep" range="102-103" highlight="1" :::

## Add pipeline template for build job

1. Create build.yml

1. Add content

   :::code language="yaml" source="code/5-build.yml" :::

## Rename first pipeline stage, and add build job

1. Open azure-pipelines.yml

1. Change the lint stage to build and add build job

   :::code language="yaml" source="code/5-azure-pipelines.yml" highlight="11-17" :::

## Update deployment stage

1. Switch to Windows pool

   :::code language="yaml" source="code/5-deploy.yml" range="55-64" highlight="6-7" :::

1. Propagate App Service app name output to pipeline variable

   :::code language="yaml" source="code/5-deploy.yml" range="78-90" highlight="10, 12" :::

1. Add app deployment

   :::code language="yaml" source="code/5-deploy.yml" range="92-101" :::

1. Verify whole file

   :::code language="yaml" source="code/5-deploy.yml" highlight="60-61, 87, 89, 92-101" :::

## Update smoke test file

Website has health endpoint that checks the website can talk to the database too

1. Open Website.Tests.ps1

1. Add new test case

   :::code language="powershell" source="code/5-website-tests.ps1" highlight="23-28" :::

## Commit and push

```cmd
git add .
git commit -m "Build and deploy website application"
git push
```

## Run pipeline and see smoke test fail

1. Open pipeline and watch

   Build stage completes successfully

1. The *Validate (Test Environment)* stage pauses - needs permission to variable group

   Validate stage completes successfully

1. Then pauses again at *Deploy (Test Environment)* for environment permission

   Deployment stage completes successfully

1. The *Smoke Test (Test Environment)* stage fails

   Look at test tab. Getting errors. This is because the SQL server isn't available. You'll fix this shortly.
