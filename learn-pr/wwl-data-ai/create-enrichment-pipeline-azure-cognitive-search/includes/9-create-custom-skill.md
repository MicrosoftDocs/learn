Your custom skill must implement the expected schema for input and output data that is expected by skills in an Azure AI Search skillset.

## Input Schema

The input schema for a custom skill defines a JSON structure containing a record for each document to be processed. Each document has a unique identifier, and a data payload with one or more inputs, like this:

```JSON
{
    "values": [
      {
        "recordId": "<unique_identifier>",
        "data":
           {
             "<input1_name>":  "<input1_value>",
             "<input2_name>": "<input2_value>",
             ...
           }
      },
      {
        "recordId": "<unique_identifier>",
        "data":
           {
             "<input1_name>":  "<input1_value>",
             "<input2_name>": "<input2_value>",
             ...
           }
      },
      ...
    ]
}
```

## Output schema

The schema for the results returned by your custom skill reflects the input schema. It is assumed that the output contains a record for each input record, with either the results produced by the skill or details of any errors that occurred.

```JSON
{
    "values": [
      {
        "recordId": "<unique_identifier_from_input>",
        "data":
           {
             "<output1_name>":  "<output1_value>",
              ...
           },
         "errors": [...],
         "warnings": [...]
      },
      {
        "recordId": "< unique_identifier_from_input>",
        "data":
           {
             "<output1_name>":  "<output1_value>",
              ...
           },
         "errors": [...],
         "warnings": [...]
      },
      ...
    ]
}
```

The output value in this schema is a *property bag* that can contain any JSON structure, reflecting the fact that index fields aren't necessarily simple data values, but can contain complex types.
