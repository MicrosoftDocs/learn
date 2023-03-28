Once the model is deployed, you can test how it completes prompts. A prompt is the text-in request that is sent to the deployed model's completions endpoint. Responses are referred to as *completions*, which can come in form of text, code, or other formats. 

## Prompt types 

Prompts can be grouped into types of requests based on task.

|Task type| Prompt example | Completion example|
|:--------|:------------------------ |:-------------------------------|
|**Classifying content** | Tweet: I enjoyed the trip. <br/> Sentiment: | Positive|
|**Generating new content** | List ways of traveling|1. Bike <br/> 2. Car ...|
|**Holding a conversation** | A friendly AI assistant |[See examples](https://learn.microsoft.com/azure/cognitive-services/openai/how-to/completions#conversation?portal=true)
|**Transformation** (translation and symbol conversion)| English: Hello <br/> French:|bonjour| 
|**Summarizing content**|Provide a summary of the content <br/> {text} |The content's goal is to share methods of machine learning.| 
|**Picking up where you left off** | One way to grow tomatoes |is to plant seeds.|  
|**Giving factual responses** | How many moons does Earth have? |One|

## Completion quality 

Several factors affect the quality of completions you will from a generative AI solution. 

- The way a prompt is engineered. Learn more about [prompt engineering here](https://learn.microsoft.com/azure/cognitive-services/openai/concepts/prompt-engineering?portal=true). 
- The model parameters (covered next) 
- The data the model is trained on, which can be adapted through [model fine-tuning with customization](https://learn.microsoft.com/azure/cognitive-services/openai/how-to/fine-tuning?pivots=programming-language-studio?portal=true) 

You will have more control over the completions returned by training a custom model than through prompt engineering and parameter adjustment. 

## Making calls 

You can start making calls to your deployed model via REST, Python, C#, or the Studio. If your deployed model has a ChatGPT or GPT-4 model base, please use the [Chat completions documentation](https://learn.microsoft.com/en-us/azure/cognitive-services/openai/reference#chat-completions?portal=true), which has different request endpoints and configurations.   

#### Prompts and completions from REST 

To send a prompt to your model's completion endpoint, you will want to replace the following variables from the example below with your own configurations: 

- YOUR_RESOURCE_NAME: *replace with your Azure OpenAI Service resource name*
- YOUR_DEPLOYMENT_NAME: *replace with the unique name of your deployed model* 
- YOUR_API_KEY: *replace with the [API key from your Azure OpenAI Service resource](https://learn.microsoft.com/azure/cognitive-services/openai/quickstart?tabs=command-line&pivots=rest-api#retrieve-key-and-endpoint?porta=true)* 
- Once upon a time: *replace with your own prompt text*

```bash
curl https://YOUR_RESOURCE_NAME.openai.azure.com/openai/deployments/YOUR_DEPLOYMENT_NAME/completions?api-version=2022-12-01\
  -H "Content-Type: application/json" \
  -H "api-key: YOUR_API_KEY" \
  -d "{
  \"prompt\": \"Once upon a time\",
  \"max_tokens\": 5
}"
```

