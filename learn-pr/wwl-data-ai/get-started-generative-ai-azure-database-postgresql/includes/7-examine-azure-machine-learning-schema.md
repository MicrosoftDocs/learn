The `azure_ml` schema of the `azure_ai` extension allows your database to interact with the capabilities of custom-built machine-learning models. By utilizing the `azure_ml` schema, you can seamlessly integrate your PostgreSQL database with Azure Machine Learning services. This integration enables you to deploy and serve machine learning models directly from your database, making real-time inferencing efficient, and scalable.

## Real-time inference with the `azure_ml` schema

**Azure Machine Learning** is a cloud-based platform streamlining end-to-end machine learning workflows. Models are trained using frameworks like PyTorch and TensorFlow and are deployed as **online endpoints**, which expose a stable URL for requesting predictions.

With online endpoints providing real-time inference, Azure Machine Learning integrated with the `azure_ai` extension equips you to obtain predictions directly from your database. The function used for calling a deployed model is now:

- `azure_ml.invoke(jsonb, text)`

This function sends the JSON input payload to your Azure Machine Learning endpoint and returns the model’s output as `jsonb`.

Azure Machine Learning endpoints expect a JSON object as input. The structure of this object depends on the model you deployed. For example, a regression model trained to predict daily rental prices might expect input shaped like:

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
    "data": [
      ["False", "False", "False", "Central Area", "98122", "House", "Entire home/apt", 4, 1.5, 3, 3]
    ]
  }
}
```

The expected input structure can be verified by reviewing the Swagger definition for your deployed endpoint. It lists the `ServiceInput` and `ServiceOutput` schemas that determine the required shapes for requests and responses.

## Call a model

The following example shows the full flow for sending input to an Azure Machine Learning model and returning its predictions.

1. Send the input payload

    ```sql
    SELECT azure_ml.invoke(
        '{
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
            "data": [
              ["False","False","False","Central Area","98122","House","Entire home/apt",4,1.5,3,3]
            ]
          }
        }'::jsonb,
        'rental-price-deployment'
    ) AS prediction;
    ```

    The result is returned as a `jsonb` value that contains the model's output. You can extract fields from this result using standard PostgreSQL JSON functions.

1. Working with the output

    For example, if the model returns an array of predicted values:

    ```sql
    WITH result AS (
        SELECT azure_ml.invoke(
            '{
              "input_data": {
                "columns": ["neighbourhood","bedrooms","bathrooms"],
                "index": [0],
                "data": [["Queen Anne", 2, 1]]
              }
            }'::jsonb,
            'rental-price-deployment'
        ) AS output
    )
    SELECT jsonb_array_elements(output) AS predicted_value
    FROM result;
    ```

    You can incorporate this solution into views, functions, and reporting queries as needed.

## Configure a connection to Azure Machine Learning

Before using `azure_ml.invoke()` for real-time inference, you must configure the extension with your Azure Machine Learning scoring endpoint and key. The value for `azure_ml.scoring_endpoint` is the REST endpoint for your deployed model, and `azure_ml.endpoint_key` is either the primary or secondary key.

```sql
SELECT azure_ai.set_setting('azure_ml.scoring_endpoint', '{endpoint}');
SELECT azure_ai.set_setting('azure_ml.endpoint_key', '{api-key}');
```

## Takeaways

By applying the `azure_ml` schema in the `azure_ai` extension, you can easily integrate your PostgreSQL database with Azure Machine Learning services. This integration allows for real-time inferencing using custom machine learning models, enabling you to enhance your applications with predictive capabilities directly from your database environment.