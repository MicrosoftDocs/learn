### Delete the Data Science VM

In this unit, you will delete the resource group created in Exercise 1 when you created the Data Science VM. Deleting the resource group deletes everything in it and prevents any further charges from being incurred for it. Resource groups that are deleted can't be recovered, so be certain you're finished using it before deleting it. However, it is **important not to leave this resource group deployed any longer than necessary** because a Data Science VM is moderately expensive.

1. Return to the blade for the resource group you created in Exercise 1. Then, click the **Delete resource group** button at the top of the blade.

    ![Deleting the resource group](../media/6-delete-resource-group.png)

1. For safety, you are required to type in the resource group's name. (Once deleted, a resource group cannot be recovered.) Type the name of the resource group. Then, click the **Delete** button to remove all traces of this module from your Azure subscription.

After a few minutes, the resource group and all of its resources will be deleted. Billing stops when you click **Delete**, so you're not charged for the time required to delete the resources. Similarly, billing doesn't start until the resources are fully and successfully deployed.

### Summary

The steps in this module may be generalized to perform other types of image-classification tasks. For example, you could train the same TensorFlow model to recognize cat images or identify defective parts produced on an assembly line. Image classification is one of the most prevalent uses of machine learning today, and its usefulness will only increase over time. Now that you have a basis to work from, try creating some image-classification models of your own. You never know what might come of it!