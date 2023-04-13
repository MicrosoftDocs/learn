You've created a deployment workflow. When you run the workflow, it fails when it reaches the **deploy** job.

You see an error in the workflow log that's similar to the following message:

```Output
The provided location is not available for this resource type.
```

You fix the problem in your Bicep file by changing the `location` property of the resource, and you rerun the workflow successfully.
