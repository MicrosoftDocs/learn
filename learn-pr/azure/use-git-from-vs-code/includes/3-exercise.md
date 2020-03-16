<!-- See https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master#use-the-standard-exercise-unit-introduction-format -->

<!-- The titles of exercise units specified in the YAML should be prefixed with "Exercise - " -->

<!-- Keep module prerequisites in mind when writing instructions for readers. Don't spend lots of words on instructions about steps that they should generally already know how to do. Focus on the configuration options and items they need to select. -->

<!-- The CLI is more time- and space-efficient for tasks that are not directly relevant to the module. For example, if your exercise requires creating an App Service web app to host an app, but the module isn't directly about creating App Service instances, strongly consider using the CLI. -->

<!-- If you have sample code, include it with the content. Assume that it will end up in a public git repo for consumption during the exercise (and write your instructions with that assumption, but leave a TODO for the repo name). The Learn team will work with you to get it into the right place.-->

<!-- Exercises should generally make use of the sandbox. See the following:
  - https://review.docs.microsoft.com/en-us/learn-docs/docs/unit-enable-azure-sandbox?branch=master
  - https://review.docs.microsoft.com/en-us/learn-docs/docs/unit-add-embedded-interactivity?branch=master

    The most important things to keep in mind are:
  - Include the proper YAML markup for the unit
  - Don't ask the user to create a resource group; use <rgn>[Sandbox resource group]</rgn> to specify the sandbox resource group name (search the repo for "<rgn>" for examples)
  - Use [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) to link to the portal
  - Use the appropriate region includes (search the repo for "azure-sandbox-regions" for examples. There are four includes for different situations - the "friendly" ones are for activities in the portal as opposed to the CLI, and the "first mention" includes are to be used at the first mention of location specification in a module exercise)
  - There's also an include (azure-sandbox-activate.md) that should precede the first interactive directions that require the sandbox to have been activated
-->

<!-- Keep bulleted/numbered lists to seven items max. Break them up into groups with headers if necessary -->