Answer the questions to check your knowledge of Azure Sentinel.
## Review Questions

## Multiple Choice 
Where can you create and manage custom security alerts? 
() Azure Security Center{{Security Center lets you see how your systems are doing in Azure.}}
(x) Azure Sentinel{{Azure Sentinel. Custom alert rules were retired from Azure Security Center on June 30, 2019 because its underlying infrastructure was retired. We recommend that you enable Azure Sentinel and re-create your custom alerts there. Alternatively, you can create your alerts with Azure Monitor log alerts.}}
() Azure Storage{{Azure Storage is for storing data.}}


## Multiple Choice 
You are explaining what an Azure Sentinel playbook is and how it can be used? You cover all the following, except? Select one. 
() A Sentinel playbook can help automate and orchestrate an incident response.{{You can automate and orchestrate responses with Sentinel.}} 
() A Sentinel playbook be run manually or set to run automatically when specific alerts are triggered.{{The fact that Sentinel runs when an trigger is fired is a good topic to share.}}
(x) A Sentinel playbook be created to handle several subscriptions at once.{{A security playbook is a collection of procedures that can be run from Azure Sentinel in response to an alert. A security playbook can help automate and orchestrate your response and can be run manually or set to run automatically when specific alerts are triggered. Each playbook is created for a specific subscription you choose.}}



## Multiple Choice 
You are using Sentinel to investigate an incident. When you view the incident detailed information you see all of the following, except? Select one.  
() Incident ID{{All incidents have an Incident ID.}} 
(x) Incident owner{{Incident owner. The incident detailed information includes its severity, summary of the number of entities involved, the raw events that triggered this incident, and the incident’s unique ID.  All incidents start as unassigned. For each incident you can assign an owner, by setting the Incident owner field. You can also add comments so that other analysts will be able to understand what you investigated and what your concerns are around the incident.}}
() Number of entities involved{{You will see the number of entities involved in the incident.}} 


## Multiple Choice 
You are creating roles within your security operations team to grant appropriate access to Azure Sentinel. All the following are built-in Azure Sentinel roles, except? Select one.  
() Azure Sentinel reader{{Reader is a valid role in Sentinel.}} 
() Azure Sentinel responder{{Responder is a valid role in Sentinel.}}
(x) Azure Sentinel owner{{The Sentinel built-in roles are reader, responder, and contributor.}} 


## Multiple Choice 
You are an investigator who wants to be proactive about looking for security threats. You have read about Sentinel’s hunting capabilities and notebooks. What is an Azure Sentinel notebook? Select one. 
(x) A step-by-step playbook where you can walk through to the steps of an investigation and hunt.{{A step-by-step playbook. A notebook is a step-by-step playbook where you can walk through to the steps of an investigation and hunt. Other hunting techniques are described by the other choices: built-in query, bookmarks, and event tables.}}
() A table you can query to locate actions like DNS events.{{This is a event storage location.}}
() A saved item you can come back to create an incident for investigation.{{A playbook is more than a single saved item.}}

