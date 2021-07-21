Choose the best response for each question. Then select Check your answers.

## quiz 

## Multiple Choice
Which criteria does Application Gateway use to route requests to a web server? 
(x) The hostname, port, and path in the URL of the request. {{That's correct. An Application Gateway uses the hostname, port and URL path.}}
( ) The region in which the servers hosting the web application are located. {{That's incorrect. The Application Gateway does not directly use the region to route requests.}}
( ) The users authentication information. {{That's incorrect. The Application Gateway does not consider user authentication information when routing requests. }}

## Multiple Choice
Which load balancing strategy does the Application Gateway implement? 
(x) Distributes requests to each available server in a backend pool in turn, round-robin. {{That's correct. The Application Gateway distributes requests using round-robin.}}
( ) Distributes requests to the server in the backend pool with the lightest load. {{That's incorrect. The Application gateway does not consider workloads.}}
( ) Polls each server in the backend pool in turn, and sends the request to the first server that responds. {{That's incorrect. The Application Gateway does not use polling.}}

## Multiple Choice
The web team is installing the Application Gateway. They want to ensure incoming requests are checked for common security threats like cross-site scripting and crawlers. To address the concerns what should be done? 
( ) Install an internal load balancer {{That's incorrect. An internal load balancer would not be the best choice in this scenario.}}
( ) Install Azure Firewall {{That's incorrect. An Azure Firewall would not be the best choice in this scenario. }}
(x) Install the Web Application Firewall {{That's correct. The Web Application Firewall is an optional component that handles incoming requests before they reach a listener. The web application firewall checks each request for many common threats, based on the Open Web Application Security Project).}}
 
