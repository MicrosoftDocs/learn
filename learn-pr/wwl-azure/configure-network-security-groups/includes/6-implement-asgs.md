[Application Security Groups (ASGs)](/azure/virtual-network/application-security-groups) ) logically group virtual machines by workload and define network security rules based on those groups. ASGs work in the same way as NSGs but provide an application-centric way of looking at your infrastructure. You join virtual machines to the ASG, and then use the ASG as a source or destination in NSG rules.

## When to use Application Security Groups

Let’s consider a usage case for an online retailer. In this scenario, it's important to control the network traffic to the application virtual machines. Here are the requirements. 

- Shoppers access the company’s product catalog hosted on Web Servers. The Web Servers must be accessible from the internet over HTTP port 80 and HTTPS port 443. 

- Inventory information is located on Database Servers. The Database Servers must be accessible over port 1433. Only the Web Servers should have access to the Database Servers. 

## How to use Application Security Groups

:::image type="content" source="../media/asgs.png" alt-text="Diagram of how an A S G combines with an N S G to protect applications.":::

For this scenario, we would:

Create an ASG (WebASG) that groups the Web Servers. Create another ASG (DBASG) that groups the Database Servers. Assign the corresponding server NICs to each ASG.

Inside the NSG, create following rules:
- Priority: 100, allow access from the internet to WebASG with port 80 and 443.
- Priority: 110, allow access from WebASG to DBASG with port 1433.
- Priority: 120, deny access from anywhere to DBASG with port 1433.

## Advantages of using an application security group

This configuration has several advantages:

- The configuration doesn’t require specific IP addresses. It would be difficult to specify IP addresses because of the number of servers and because the IP addresses could change. You also don't need to arrange the servers into a specific subnet. 

- This configuration doesn't require multiple rule sets. You don't need to create a separate rule for each VM. You can dynamically apply new rules to ASG. New security rules are automatically applied to all the VMs in the Application Security Group.

- The configuration is easy to maintain and understand since is based on workload usage. 
