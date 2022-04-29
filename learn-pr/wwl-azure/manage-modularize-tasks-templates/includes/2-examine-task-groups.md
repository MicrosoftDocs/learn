A task group allows you to encapsulate a sequence of tasks, already defined in a build or a release pipeline, into a single reusable task that can be added to a build or release pipeline, just like any other task.

You can choose to extract the parameters from the encapsulated tasks as configuration variables and abstract the rest of the task information.

Task groups are a way to standardize and centrally manage deployment steps for all your applications.

When you include a task group in your definitions and then make a change centrally to the task group, the change is automatically reflected in all the definitions that use the task group.

There's no need to change each one individually.

For more information, see [Task groups for builds and releases](/azure/devops/pipelines/library/task-groups).

> [!NOTE]
> Note: Task Groups aren't currently supported in YAML. Use templates instead. See [Template References](/azure/devops/pipelines/yaml-schema).
