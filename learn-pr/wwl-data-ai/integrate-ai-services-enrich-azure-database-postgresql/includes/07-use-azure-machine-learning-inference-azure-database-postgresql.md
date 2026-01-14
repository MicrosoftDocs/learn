Many applications rely on predictive models to make decisions, such as estimating demand, detecting anomalies, or recommending actions. Building and deploying these models can be complex, requiring coordination between databases, services, and machine learning frameworks. Without integration, organizations often face delays in applying predictions to live data.  

Let’s consider **Margie’s Travel**, a vacation rental company that wants to predict nightly rental prices for its listings. Their historical booking data contains useful signals like location, number of bedrooms, and amenities. With this data, they can train a machine learning model to estimate price ranges for new properties. Instead of exporting data and manually running predictions, Margie’s Travel wants to run these predictions directly from their database where the data already lives.  

Azure Machine Learning provides the tools to train and deploy models at scale:contentReference[oaicite:0]{index=0}. Once deployed, models are exposed as endpoints that can be invoked for real-time or batch predictions. With the `azure_ai` extension in Azure Database for PostgreSQL, you can use the `azure_ml` schema to call these endpoints directly from SQL queries:contentReference[oaicite:1]{index=1}.  

## Automated machine learning

Automated machine learning (AutoML) simplifies the process of training and selecting models. It automates repetitive tasks like feature engineering, model selection, and hyperparameter tuning, while maintaining model quality:contentReference[oaicite:2]{index=2}.  

For Margie’s Travel, AutoML can be used to build a regression model that predicts nightly rental prices based on inputs such as neighborhood, number of bedrooms, and property type. This process makes it possible for staff to estimate competitive prices for new listings without requiring deep expertise in data science.  

## Real-time inference with Azure Database for PostgreSQL

After training and deploying a model in Azure Machine Learning, you can connect your database to it for real-time predictions.  

The `azure_ml.inference()` function in the `azure_ml` schema allows you to send input data as JSON and receive predictions directly in query results:contentReference[oaicite:3]{index=3}. You can configure the connection by setting the model’s scoring endpoint and API key in the extension settings.  

For example, given property attributes like location and number of bedrooms, Margie’s Travel can run a query that returns a predicted nightly rate. Because the prediction happens inside Azure Database for PostgreSQL, the workflow is efficient and scales with the rest of their data operations.  

## Why it matters

Integrating Azure Machine Learning with Azure Database for PostgreSQL allows organizations to:  
- Apply predictions directly where their data resides.  
- Support both real-time and batch inferencing scenarios.  
- Reduce the need for complex data pipelines.  
- Enable smarter applications by combining transactional data with machine learning.  

For Margie’s Travel, this means being able to deliver real-time insights to property owners and renters, improving decision-making and customer experience.  

## Key takeaways

In this unit, you learn how to use Azure Machine Learning with Azure Database for PostgreSQL to perform inferencing directly from the database. AutoML helps build models efficiently, and the `azure_ml.inference()` function enables real-time predictions on live data. This integration turns raw information into actionable intelligence that applications can use immediately.  
