
It's essential to follow best practices when creating actions:

 -  Create chainable actions. Don't create large monolithic actions. Instead, create smaller functional actions that can be chained together.
 -  Version your actions like other code. Others might take dependencies on various versions of your actions. Allow them to specify versions.
 -  Provide the **latest** label. If others are happy to use the latest version of your action, make sure you provide the **latest** label that they can specify to get it.
 -  Add appropriate documentation. As with other codes, documentation helps others use your actions and can help avoid surprises about how they function.
 -  Add details **action.yml** metadata. At the root of your action, you'll have an **action.yml** file. Ensure it has been populated with author, icon, expected inputs, and outputs.
 -  Consider contributing to the marketplace. It's easier for us to work with actions when we all contribute to the marketplace. Help to avoid people needing to relearn the same issues endlessly.
