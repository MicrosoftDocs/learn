In most cases, the database administrator will not be writing their own Azure Resource Manager template from scratch. You may either build them from the Azure portal or using a template from the Quickstart templates that are provided by Microsoft on GitHub. If you click on the deploy to GitHub button, you will log in to the Azure portal and you will see the following screen:

:::image type="content" source="../media/module-66-automation-final-03.png" alt-text="Azure Resource Manager deployment screen":::

The template parameters are defined by the parameters section of the template file. In this deployment example, there are only two VM sizes defined (the default value is a Standard_DS13_v2).

If you click the edit template button, you will see the JSON defining the template, which would allow you to change the values to meet your requirements.

```javascript
"virtualMachineSize": {

 "type": "String",

 "defaultValue": "Standard_DS13_v2",

 "allowedValues": [

 "Standard_DS13_v2",

 "Standard_DS3_v2"

 ],

 "metadata": {

 "description": "The virtual machine size."

 }

 }
```

After filling in the required parameters in the deployment screen, you click Purchase and deploy your template.
