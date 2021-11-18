When you create a new container, you can specify the indexing policy at the point of creation using the CLI.

> &#128221; Remember, if you do not specify the indexing policy, the default policy will be used.

To create a new container with a custom index policy, you must use the **--idx** argument in one of two ways.

## JSON file

You can pass in the name of a JSON file with a custom index policy. Let's assume that you have an indexing policy defined in a file named **policy.json**.

:::code language="json" source="../media/3-indexing-policy.json":::

You only need to pass in the filename to the CLI command for the **--idx** argument.

:::code language="azurecli" source="../media/3-script.sh" range="1-8" highlight="7":::

## Raw JSON string

Alternatively, you can pass in a raw JSON string with the indexing policy defined. This example uses the same JSON indexing policy defined as a minified string:

:::code language="azurecli" source="../media/3-script.sh" range="10-16" highlight="7":::

> &#128161; If you are planning to use a raw JSON string with the **--idx** argument, you should read up on your shell's specific behavior around escaping and processing strings. Common shells like Bash and PowerShell can have wildly different behaviors when processing JSON string literals.
