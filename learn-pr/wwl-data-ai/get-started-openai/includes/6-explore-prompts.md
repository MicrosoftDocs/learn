A prompt is the text-in request that is sent to the completions endpoint. The response is known as a completion, which can come in form of text, code, or other formats. It is important to understand how prompt design and other factors affect the responses from a generative AI solution. 

## Prompt types 

Prompts can be grouped into types of requests based on task: 
- Classifying content 
- Generating new content
- Holding a conversation
- Transformation, including translation and conversion 
- Summarizing content 
- Picking up where you left off  
- Giving factual responses 

## Engineering prompts 

## Completions  

The completions endpoint 

```HTTP
POST https://{your-resource-name}.openai.azure.com/openai/deployments/{deployment-id}/completions?api-version={api-version}
```