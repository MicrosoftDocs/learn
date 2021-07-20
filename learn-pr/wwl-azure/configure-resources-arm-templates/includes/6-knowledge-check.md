Choose the best response for each question. Then select Check your answers.

## Multiple Choice
What is an Azure Resource Manager template?
( ) A series of Azure CLI commands to deploy infrastructure to Azure. {{That's incorrect. An Azure Resource Manager template is a JSON file that defines the infrastructure and configuration for your deployment. ARM templates allow you to declare what you intend to deploy without having to write the sequence of programming commands to create it.}}
(x) A JavaScript Object Notation (JSON) file that defines the infrastructure and configuration for your deployment. {{That's correct. An Azure Resource Manager template is a JSON file that defines the infrastructure and configuration for your deployment. ARM templates allow you to declare what you intend to deploy without having to write the sequence of programming commands to create it.}}
( ) A script held in Azure Resource Manager to manage your Azure storage account. {{That's incorrect. An Azure Resource Manager template is a JSON file that defines the infrastructure and configuration for your deployment. ARM templates allow you to declare what you intend to deploy without having to write the sequence of programming commands to create it.}}

## Multiple Choice
Which of the following is not an element in the template schema?
( ) Parameters {{That's incorrect. Parameters are part of the template schema. Parameter values are provided when a deployment is executed to customize resource deployment.}}
(x) Inputs {{That's correct. Inputs are not part of the template schema.}}
( ) Outputs {{That's incorrect. Outputs is part of the template schema. You use outputs when you need to return values from the deployed resources.}}

## Multiple Choice
What happens if the same template is accidently run a second time?
( ) Azure Resource Manager will deploy new resources as copies of the previously deployed resources. {{That's incorrect. If the resource already exists and no change is detected in the properties, no action is taken. If the resource already exists and a property has changed, the resource is updated. If the resource doesn't exist, it's created.}}
(x) Azure Resource Manager won't make any changes to the deployed resources. {{That's correct. If the resource already exists and no change is detected in the properties, no action is taken. If the resource already exists and a property has changed, the resource is updated. If the resource doesn't exist, it's created.}}
( ) Azure Resource Manager will delete the previously deployed resources and redeploy them. {{That's incorrect. If the resource already exists and no change is detected in the properties, no action is taken. If the resource already exists and a property has changed, the resource is updated. If the resource doesn't exist, it's created.}}
