In the previous exercises, you worked with Linux virtual machines. Here, you switch gears a bit and focus on managing storage accounts.

Let's say that you have three environments that you need to deploy to: Dev, Staging, and Production.

* The _Dev_ environment is the first place where everything your application needs comes together. This environment might include web servers, a load balancer, and a database.
* The _Staging_ environment is where final testing happens before new application features are released to your end users.
* The _Production_ environment is where your end users access your application.

As you move from Dev to Production, you require additional infrastructure. For example, in Production, you require an additional storage account that you don't need in the previous environments.

Here, you use a condition to control when a storage account is provisioned. Doing so enables you to support each of your infrastructure environments from the same ARM template.

::: zone pivot="powershell"

[!include[](./powershell/7-exercise-conditions.md)]

::: zone-end

::: zone pivot="cli"

[!include[](./azcli/7-exercise-conditions.md)]

::: zone-end
