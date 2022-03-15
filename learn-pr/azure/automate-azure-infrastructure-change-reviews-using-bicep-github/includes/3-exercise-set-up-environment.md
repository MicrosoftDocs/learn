**Note to John: leaving this one mainly to you.**

During the process you'll:

> [!div class="checklist"]
> * Copy and clone a template repository
> * Create a service principal and GitHub secret

## Copy and clone a template repository

## Create a service principal and GitHub secret

**Note to John: the below is an exact copy and paste from the other module, however, this already contains the fact that the SP needs wider permissions ... we only need those wider perms though for the exercise after the next chapter. So basically leaving it up to you how you want to word the SP creation here ...**

First you will need to create a service principal that has the permissions to create resource groups and resources in your subscription. You will also need a GitHub secret that uses this service principal.

> [!WARNING]
> Since the service principal you will be creating will get quite wide permissions on your subscription, do not execute this exercise in an environment that holds any of your production workloads.

**Note to John: not copying the steps here, since this is (almost) copy paste of the SP and GH secret creation steps we already have. Only permissions on the SP should be wider.**