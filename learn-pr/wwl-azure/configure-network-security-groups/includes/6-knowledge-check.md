Choose the best response for each question. Then select Check your answers.

## Multiple Choice
The infrastructure team has two NSG security rules for inbound traffic to your web servers. There is an allow rule with a priority of 200. And, there is a deny rule with a priority of 150. Which rule takes precedence?
( ) The allow rule takes precedence. {{That's incorrect. Rules are processed by priority.}}
(x) The deny rule takes precedence. {{That's correct. The deny rule takes precedence because it's processed first. The rule with priority 150 is processed before the rule with priority 200.}}
( ) The rule that was created first takes precedence. {{That's incorrect. Rules are processed using the priority.}}

## Multiple Choice
Which of the following is a default inbound security rule?
(x) Allow inbound coming from any VM to any other VM within the subnet. {{That's correct. By default, inbound security rules allow traffic from any VM to any other VM within the subnet.}}
( ) Allow inbound coming from any VM to any other VM within the virtual network. {{That's incorrect. That is not a default inbound security rule?}}
( ) Allow traffic from any external source to any of the VMs. {{That's incorrect. That is not a default inbound security rule?}}

## Multiple Choice
The comptroller wants to simplify network security group rules by using service tags. Which of the following is a valid service tag?
(x) VirtualNetwork  {{That's correct. VirtualNetwork is a valid service tag. Service tags represent a group of IP addresses. Other service tags are Internet, SQL, Storage, AzureLoadBalancer, and AzureTrafficManager.}}
( ) VPNGateway {{That's incorrect. VPNGateway is not a valid service tag.}}
( ) Database {{That's incorrect. Database is not a valid service tag.}}
 
