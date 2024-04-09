



The `azure_ml` schema empowers your database with the ability to interact with custom-build machine learning models capabilities. By utilizing the `azure_ml` schema, you can seamlessly integrate your PostgreSQL database with Azure Machine Learning services. This integration enables you to deploy and serve machine learning models directly from your database, making real-time inferencing efficient and scalable.

## Real-time inference with the `azure_ml` schema

Using the `azure_ai` extension, the `azure_ml` schema provides a function for performing real-time inference directly from the database. The `inference` function within this schema is designed to facilitate making predictions or generating outputs using a trained model from Azure ML. When you deploy a model, the inference function allows you to invoke the model and obtain predictions on new data.

- `azure_ml.inference(jsonb,integer,boolean,text)`

The `inference()` function expects the following input parameters:

| Parameter | Type | Default | Description |
| --------- | ---- | ------- | ----------- |
| input | `jsonb` || A JSON object containing the `input_data` object required for interacting with Azure ML models. |
| timeout_ms | `integer` | `NULL::integer`| The timeout... |
| throw_on_error | `boolean` | `true` | desc... |
| deployment_name | `text` | `NULL::text` | (Optional) Name of the model deployment to target at the specified Azure ML endpoint. |

Azure ML inferencing endpoints expect a JavaScript Object Notation (JSON) object as input. However, the structure of this object is dependent upon the underlying model. For example, a regression model trained to predict daily rental prices for short-term housing rentals in the Seattle, Washington area, given certain inputs like the neighborhood, ZIP Code, number of bedrooms, number of bathrooms, and more has the following shape:

```json
{
    "input_data": {
        "columns": [
            "host_is_superhost",
            "host_has_profile_pic",
            "host_identity_verified",
            "neighbourhood_group_cleansed",
            "zipcode",
            "property_type",
            "room_type",
            "accommodates",
            "bathrooms",
            "bedrooms",
            "beds"
        ],
        "index": [0],
        "data": [["False", "False", "False", "Central Area", "98122", "House", "Entire home/apt", 4, 1.5, 3, 3]]
    }
}
```

The specific input object structure expected can be retrieved by examining the Swagger definition associated with your deployed endpoint. This definition specifies the `ServiceInput` and `ServiceOutput` structures, which you can use to determine both your inputs and outputs.

## Configure a connection to AML

Before using the `azure_ml.inference()` function to perform real-time inference, you must configure the extension with your AML scoring endpoint and key. The value for `azure_ml.scoring_endpoint` will be the REST endpoint for your deployed model. The value for `azure_ml.endpoint_key` may be either the primary or the secondary key for this endpoint.

```sql
SELECT azure_ai.set_setting('azure_ml.scoring_endpoint', '{endpoint}');
SELECT azure_ai.set_setting('azure_ml.endpoint_key','{api-key}');
```
