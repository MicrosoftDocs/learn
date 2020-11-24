Let's obtain keys for the translator service. As mentioned previously, we will need an [Azure account](https://azure.microsoft.com/account/free?WT.mc_id=python-11210-chrhar). We'll create the key using the portal and store it in a **.env** file in our application.

## Obtain Translator service key

1. Navigate to the [Azure portal](https://portal.azure.com)
2. Click **Create a resource**

![Azure portal Create a resource](../media/create-resource.png)

3. In the **Search** box, type **Translator**
4. Click **Translator**

![Translator search results](../media/translator-search.png)

5. Click **Create**

![Translator create dialog](../media/create-translator.png)

6. Fill out the Create Translator form with the following values:
  - **Subscription**: *Your subscription*
  - **Resource group**:
    - Click **Create new**
    - Name: **flask-ai**
  - **Resource group region**: *Select a region near you*
  - **Resource region**: *Select the same region as above*
  - **Name**: *A unique value, such as ai-yourname*
  - **Pricing tier**: **Free F0**

![Completed Translator create form](../media/create-translator-form.png)

7. Click **Review + create**
8. Click **Create**
9. After a few moments the resource will be created
10. Click **Go to resource**
11. Click **Keys and Endpoint** on the left side under **RESOURCE MANAGEMENT**

![Keys and endpoints](../media/translator-key-endpoint.png)

12. Next to **KEY 1**, click on **Copy to clipboard**

![Key dashboard](../media/translator-keys.png)

> [!NOTE]
> There is no difference between Key 1 and Key 2. By providing two keys you have the opportunity to migrate to new keys by regenerating one while using the other.

13. Make a note of the **endpoint** and **location** values

## Create .env file to store the key

1. Returning to Visual Studio Code, create a new file in the root of the application by clicking **New file** and naming it **.env**

> [!IMPORTANT]
> The **.** at the beginning of the file is required.

2. Paste the following into **.env**

```text
KEY=your_key
ENDPOINT=your_endpoint
LOCATION=your_location
```

3. Replace the placeholders
  - **your_key** with the key you copied above
  - **your_endpoint** with the endpoint from Azure
  - **your_location** with the location from Azure
4. Your **.env** file should look like the following (with your values):

```text
KEY=00d09299d68548d646c097488f7d9be9
ENDPOINT=https://api.cognitive.microsofttranslator.com/
LOCATION=westus2
```

## Next steps

With our Translator service configured and variables set in **.env** we can turn our attention to adding the necessary code!
