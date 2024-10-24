To integrate a custom skill into your indexing solution, you must add a skill for it to a skillset using the **Custom.WebApiSkill** skill type.

The skill definition must:

- Specify the URI to your web API endpoint, including parameters and headers if necessary.
- Set the context to specify at which point in the document hierarchy the skill should be called.
- Assign input values, usually from existing document fields.
- Store output in a new field, optionally specifying a target field name (otherwise the output name is used).

```JSON
{
    "skills": [
      ...,
      {
        "@odata.type": "#Microsoft.Skills.Custom.WebApiSkill",
        "description": "<custom skill description>",
        "uri": "https://<web_api_endpoint>?<params>",
        "httpHeaders": {
            "<header_name>": "<header_value>"
        },
        "context": "/document/<where_to_apply_skill>",
        "inputs": [
          {
            "name": "<input1_name>",
            "source": "/document/<path_to_input_field>"
          }
        ],
        "outputs": [
          {
            "name": "<output1_name>",
            "targetName": "<optional_field_name>"
          }
        ]
      }
  ]
}

```

Your skillset can include both built-in skills and custom skills, depending on your use case. The `skills` array seen in the above example will contain all of your skills, with the custom skills code running outside of the search service (as applicable) which we'll see in the exercise later in this module.

The following units explore specific kinds of custom skills through the use additional Azure resources.
