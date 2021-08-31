In the parameters section of the template, you specify which values you can input when deploying the resources. The available properties for a parameter are:

```json
"parameters": {
  "&lt;parameter-name&gt;" : {
    "type" : "&lt;type-of-parameter-value&gt;",
    "defaultValue": "&lt;default-value-of-parameter&gt;",
    "allowedValues": [ "&lt;array-of-allowed-values&gt;" ],
    "minValue": &lt;minimum-value-for-int&gt;,
    "maxValue": &lt;maximum-value-for-int&gt;,
    "minLength": &lt;minimum-length-for-string-or-array&gt;,
    "maxLength": &lt;maximum-length-for-string-or-array-parameters&gt;,
    "metadata": {
      "description": "&lt;description-of-the parameter&gt;"
    }
  }
}
```

Here's an example that illustrates two parameters: one for a virtual machine's username, and one for its password:

```json
"parameters": {
  "adminUsername": {
    "type": "string",
    "metadata": {
      "description": "Username for the Virtual Machine."
    }
  },
  "adminPassword": {
    "type": "securestring",
    "metadata": {
      "description": "Password for the Virtual Machine."
    }
  }
```

> [!NOTE]
> You're limited to 256 parameters in a template. You can reduce the number of parameters by using objects that contain multiple properties.
