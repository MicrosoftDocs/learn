Many apps need to reach services that sit outside the app's own data, and those calls often need a key or a token that must never reach the browser. A server-side function gives the app a trusted place to run that work. In a Fabric app, a function runs next to the data, keeps secrets on the server, and calls other services as the app identity.

You build a shipment lookup tool at Adventure Works Cycles that keeps a carrier key on the server and lists accessible workspaces through the Fabric REST API. The exercises create a new app and supply a carrier simulation, so you don't need an existing project or carrier account. The Fabric call uses permissions you grant deliberately, and its local and deployed identities determine which resources it can access.

In this module, you explore when logic belongs in a function and how to scaffold, run, and deploy one. You learn how secrets stay on the server, and how audiences and tokens let a function call Microsoft services as the app identity. Hands-on exercises in your own Fabric tenant let you check that Functions work in your region, store and use a secret, call the Fabric REST API, deploy, and diagnose a function that fails only after deployment.

By the end of this module, you can move sensitive or external work to server-side functions that call services as the app identity.
