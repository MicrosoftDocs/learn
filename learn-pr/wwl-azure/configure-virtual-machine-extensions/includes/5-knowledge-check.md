Choose the best response for each question. Then select Check your answers.

## Multiple Choice
Which of the following is a small application that provides post-deployment configuration and automation tasks on Azure virtual machines?
( ) Automation State Configuration {{That's incorrect. Automated state configuration ensures all virtual machines in a collection are in the same consistent state.}}
( ) Desired state configuration {{That's incorrect. DSC helps with deploying and managing configuration data for software services.}}
(x) Virtual machine extensions. {{That's correct. Virtual machine extensions automate the tasks of creating, maintaining, and removing virtual machines}}

## Multiple Choice
Custom script extensions timeout after which of the following?
( ) 30 minutes {{That's incorrect. Custom script extensions will timeout, but not after only 30 minutes.}}
(x) 90 minutes  {{That's correct. Custom script extensions will timeout and that should be considered when deciding on the scope of the script. }}
( ) 120 minutes {{That's incorrect. Custom script extensions will timeout, but sooner than 120 minutes. }}

## Multiple Choice
The infrastructure team needs to install IIS on the localhost. They do not want to use a Custom Script Extension. Which of the following could be used instead?
(x) Desired state configuration {{That's correct. DSC is a good choice for installing virtual machine features.}}
( ) Virtual machine extension {{That's incorrect. Virtual machine extensions automate the tasks of creating, maintaining, and removing virtual machines}}
( ) Windows update {{That's incorrect. Windows update is not appropriate in this scenario.}}

