You might need to deploy a resource optionally, under certain conditions. A common case is adding a load balancer on a VM. Let's say you have an e-commerce site, and you want to ensure the site can withstand the increased traffic from a big sale. A load balancer is a type of resource that you can associate with a VM. By adding a rule conditionally, you either enable or disable the load balancer being applied to the VM in question. 

Picture the following situations:

- **Pre-existing resource**. When you specify a resource in a template and deploy it, one of two things happens. Either the resource is deployed, or it's not deployed if it already exists. Checking whether a resource exists is something Azure Resource Manager does for you; it's implicit. The question is if you can use this mechanism to your advantage when you reason about _how_ you can check the preexistence of something.
- **Branching logic**. Depending on what parameters you pass to a template, at deployment time, you might want to deploy a different set of resources. What you are expressing is something known as *branching logic*. If the parameter has a certain type of value, then select the first branch. Otherwise, select the second or third branch to deploy. The branching logic continues in this manner.

Both of the above situations represent scenarios where conditional logic is being applied. The logic is either in the Resource Manager system itself, or it's something you need to explicitly express.

## Conditional deployment

The `condition` construct enables you to express whether you want something deployed or not. It's a property, with a value of either `true` or `false`, that you attach to a resource element. You'd typically find a `condition` construct looking like the following JSON in your template:

```json
"resources" : [
  {
    "condition": "[parameters('shouldDeploy')]"
  }
]
```

In the above JSON, a `condition` property is added to a resource. The value of the property will be evaluated to be the value of the parameter `shouldDeploy`.

### Evaluation

There are two ways in which the `condition` construct can be evaluated. Knowing about these two ways might affect how you choose to express your conditional logic. The two different ways are:

- **The value is either true/false**. For example, consider the following construct:

   ```json
   "condition": "[parameters('deployAccount')]"
   ```

   The `deployAccount` value is a parameter who's value can be passed at deploy time, or it can fall back to the default value. Regardless of the approach used, the value is strictly false or true. Attempting to assign another value that's not a Boolean results in an error.

- **There's an expression evaluating to true/false**. Here, instead of assigning a strict true/false value to the `condition` construct, you use the built-in template function `equals(arg1, arg2)`. `arg1` needs to be equal to `arg2` for the function to evaluate to true. Your `condition` construct can now be expressed like this:

   ```json
   "condition": "[equals(parameters('newOrExisting'),'new')]"
   ```

   Using the `equals()` function, the value you pass into a parameter no longer needs to be `true` or `false`. It needs to match the second argument in the `equals()` function. In the preceding JSON example, the value of the `newOrExisting` parameter needs to match the string `new` for the function to evaluate to `true`.
