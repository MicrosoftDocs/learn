Run test regularly as part of your development lifecycle, this should be built into a CI/CD pipeline.

Both load test and Chaos Studio need to be defined as Infrastructure-as-Code (IaC). This can be done with ARM templates/Bicep or Terraform.





Although you can run load tests manually ((with or without Azure Chaos experiments), it's highly recommended for a mission-critical system to run them regularly. We call that Continuous Validation. To enable this and make it a standard practice as part of your development lifecycle, this should be built into a CI/CD pipeline 

It does not matter which CI/CD tool you use for this (Azure Pipelines, GitHub Actions, Gitlab etc) 

Both, load test and chaos studio need to be defined as Infrastructure-as-Code (IaC). This can be done with ARM templates/Bicep or Terraform. 

 

