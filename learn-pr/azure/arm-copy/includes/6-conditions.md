There might be situations where you need to optionally deploy a resource. The reason could be if a certain resource should only exist on certain environments like _staging_ for example.

Picture the following situations:

- **Pre-existing resource**. Let's say you hav an Azure KeyVault already deployed. If it exists, there's no need to create a new one. Being able to express that in a template can save you time when deploying.
- **Branching logic**. Depending on what parameters you pass to a template, at deployment time, you might want to deploy a different set of resources. What you are expressing is something known as *branching logic*. If the parameter has a certain type of value, then select the first branch otherwise select the second or third branch to deploy and so on.

Both of the above situations represents scenarios where conditional logic is being applied. The logic is either in the ARM system itself or it's something you need to explicitly express.

## Conditional deployment

There's a construct called _condition_. It's a property with a value that needs to evaluate to either `true` or `false`. By attaching it to a resource element, you are instructing Azure Resource Manager to evaluate whether this resource should be deployed or not.

### Evaluation

There are two ways in which the _condition_ can be evaluated. Knowing about these two ways might affect how you choose to express your *conditional* logic. The two different ways are:

- **The value is either true/false**. An example of this case is, for example the following construct **"condition": "[parameters('deployAccount')]"**. The `deployAccount` value is a parameter who's value can be passed at deploy time, or it can fall back to the `defaultValue`. Regardless of the approach used, the value is strictly _false_ or _true_. Attempt to assign another value that's not a boolean will lead to an error.

- **There's an expression evaluating to true/false**. How's this version different from the first one? The difference lies in that instead of assigning a strict true/false value to the _condition_ construct you instead use a the built-in template function `equals(arg1, arg2)`. `arg1` needs to be equal to `arg2` for the function to evaluate to true. Your `condition` construct can now be expressed like so instead:

   ```json
   "condition": "[equals(parameters('newOrExisting'),'new')]"
   ```

   Using the `equals()` function, the value you pass into a parameter no longer needs to be `true` or `false` but it needs to match the second argument in the `equals()` function. In the above JSON example, the value of the `newOrExisting` parameter needs to match the string **new** for the function to evaluate to true.
