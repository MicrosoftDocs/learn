In this unit, you extend your RAG application to demonstrate the *Evaluator-Optimizer Agent* pattern. This pattern uses multiple AI agents to generate, evaluate, and refine content iteratively. You can use this pattern to generate and refine content from blog posts.

## Implement the Evaluator-Optimizer agent pattern for blog post generation

In this exercise, you implement the Evaluator-Optimizer agent pattern to improve generated content. In this design, one AI agent - the *Writer* - generates an initial draft - for example, a blog post. Another agent - the *Evaluator* - reviews and provides actionable feedback. The Writer refines the draft based on the feedback, and the process repeats until the content is approved or the maximum number of iterations is reached.

## Set up environment variables

For this exercise, you need some environment variables from prior exercises. If you're using the same Bash window, these variables should still exist. If the variables are no longer available, use the following commands to recreate them. Be sure to replace the `<...>` placeholders with your own values, and use the same values that you used previously.

```azurecli
export RESOURCE_GROUP=<resource-group>
export DB_SERVER_NAME=<server-name>
export OPENAI_RESOURCE_NAME=OpenAISpringAI
export AZURE_OPENAI_ENDPOINT=$(az cognitiveservices account show \
    --resource-group $RESOURCE_GROUP \
    --name $OPENAI_RESOURCE_NAME \
    --query "properties.endpoint" \
    --output tsv \
    | tr -d '\r')
export AZURE_OPENAI_API_KEY=$(az cognitiveservices account keys list \
    --resource-group $RESOURCE_GROUP \
    --name $OPENAI_RESOURCE_NAME \
    --query "key1" \
    --output tsv \
    | tr -d '\r')
export PGHOST=$(az postgres flexible-server show \
    --resource-group $RESOURCE_GROUP \
    --name $DB_SERVER_NAME \
    --query fullyQualifiedDomainName \
    --output tsv \
    | tr -d '\r')
```

### Create the BlogWriterService

Within the **service** directory, create a new file named **BlogWriterService.java** and add the following code:

```java
package com.example.springaiapp.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.client.advisor.SimpleLoggerAdvisor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * This service demonstrates the Evaluator-Optimizer agent pattern using Spring AI.
 * 
 * The pattern involves multiple AI agents working together to iteratively improve content:
 * 1. Writer agent - Creates the initial draft and refines based on feedback
 * 2. Editor agent - Evaluates the draft and provides actionable feedback
 * 
 * This iterative refinement continues until the content is approved or reaches max iterations.
 */
@Service
public class BlogWriterService {
    private static final Logger logger = LoggerFactory.getLogger(BlogWriterService.class);
    private static final int MAX_ITERATIONS = 3;  // Maximum number of refinement iterations

    private final ChatClient chatClient;

    /**
     * Initialize the service with a ChatClient that has SimpleLoggerAdvisor.
     * 
     * The SimpleLoggerAdvisor automatically logs all AI interactions (prompts and responses)
     * when the application's logging level is set to DEBUG for the advisor package.
     * 
     * @param chatClientBuilder Builder for creating a configured ChatClient
     */
    public BlogWriterService(ChatClient.Builder chatClientBuilder) {
        // Add SimpleLoggerAdvisor to log requests and responses for debugging
        this.chatClient = chatClientBuilder
                .defaultAdvisors(new SimpleLoggerAdvisor())
                .build();
        logger.info("BlogWriterService initialized with ChatClient and SimpleLoggerAdvisor");
    }

    /**
     * Generates a concise blog post (max 10 sentences) using the Evaluator-Optimizer agent pattern.
     * 
     * The method uses multiple AI agents to:
     * 1. Generate an initial draft
     * 2. Evaluate the draft for quality and brevity
     * 3. Provide feedback for improvement
     * 4. Refine the draft based on feedback
     * 5. Repeat until approved or max iterations reached
     * 
     * This method ensures at least one feedback-improvement cycle occurs to demonstrate
     * the full evaluator-optimizer pattern in action, regardless of initial draft quality.
     * 
     * @param topic The blog post topic
     * @return A BlogGenerationResult containing the content and metadata
     */
    public BlogGenerationResult generateBlogPostWithMetadata(String topic) {
        logger.info("Starting blog generation with metadata for topic: {}", topic);
        
        BlogGenerationResult result = new BlogGenerationResult();
        result.setModelName("Azure OpenAI");
        
        // PHASE 1: WRITER AGENT
        // Prompt the Writer agent to generate the initial blog draft
        String initialPrompt = String.format("""
            You are a professional blog writer. Write a well-structured, engaging blog post about "%s".
            The post should have a clear introduction, body paragraphs, and conclusion.
            Include relevant examples and maintain a conversational yet professional tone.
            
            IMPORTANT FORMATTING REQUIREMENTS:
            1. Format as plain text only (no Markdown, HTML, or special formatting)
            2. Use simple ASCII characters only
            3. For the title, simply put it on the first line and use ALL CAPS instead of "#" symbols
            4. Separate paragraphs with blank lines
            5. The blog post must be concise and contain NO MORE THAN 10 SENTENCES total.
            """, topic);
        
        // Using Spring AI's fluent API to send the prompt and get the response
        logger.info("Sending initial draft generation prompt to AI model");
        String draft = chatClient.prompt()
                .user(initialPrompt)
                .call()
                .content();
        
        // Estimate token usage as we can't directly access it
        estimateTokenUsage(result, initialPrompt, draft);
        logger.info("Initial draft successfully generated for topic: {}", topic);

        // PHASE 2: EVALUATION & REFINEMENT LOOP
        // Setup for the iterative improvement process
        boolean approved = false;
        int iteration = 1;
        boolean forceFirstIteration = true; // Force at least one feedback cycle to demonstrate the pattern
        
        // Continue until we reach max iterations or get approval (but always do at least one iteration)
        while ((!approved && iteration <= MAX_ITERATIONS) || forceFirstIteration) {
            logger.info("Starting iteration {} of blog refinement", iteration);
            
            // PHASE 2A: EDITOR AGENT
            // Prompt the Editor agent to evaluate the current draft
            String evalPrompt = String.format("""
                You are a critical blog editor with extremely high standards. Evaluate the following blog draft and respond with either:
                PASS - if the draft is exceptional, well-written, engaging, and complete
                NEEDS_IMPROVEMENT - followed by specific, actionable feedback on what to improve
                
                Focus on:
                - Clarity and flow of ideas
                - Engagement and reader interest
                - Professional yet conversational tone
                - Structure and organization
                - Strict adherence to the 10-sentence maximum length requirement
                
                IMPORTANT EVALUATION RULES:
                1. The blog MUST have no more than 10 sentences total. Count the sentences carefully.
                2. For the first iteration, ALWAYS respond with NEEDS_IMPROVEMENT regardless of quality.
                3. Be extremely thorough in your evaluation and provide detailed feedback.
                4. If the draft exceeds 10 sentences, it must receive a NEEDS_IMPROVEMENT rating.
                5. Even well-written drafts should receive suggestions for improvement in early iterations.
                
                Draft:
                %s
                """, draft);
            
            // Send the evaluation prompt to the AI model
            logger.info("Sending draft for editorial evaluation (iteration: {})", iteration);
            String evaluation = chatClient.prompt()
                    .user(evalPrompt)
                    .call()
                    .content();
            
            // After first iteration, remove the force flag
            if (forceFirstIteration) {
                forceFirstIteration = false;
            }
            
            estimateTokenUsage(result, evalPrompt, evaluation);
            
            // Check if the Editor agent approves the draft
            if (evaluation.toUpperCase().contains("PASS") && iteration > 1) { // Only allow PASS after first iteration
                // Draft is approved, exit the loop
                approved = true;
                logger.info("Draft approved by editor on iteration {}", iteration);
            } else {
                // Draft needs improvement, extract the specific feedback
                String feedback = extractFeedback(evaluation);
                logger.info("Editor feedback received (iteration {}): {}", iteration, feedback);
                result.addEditorFeedback(feedback);
                
                // PHASE 2B: WRITER AGENT (REFINEMENT)
                // Prompt the Writer agent to refine the draft based on the feedback
                String refinePrompt = String.format("""
                    You are a blog writer. Improve the following blog draft based on this editorial feedback:
                    
                    Feedback: %s
                    
                    Current Draft:
                    %s
                    
                    IMPORTANT REQUIREMENTS:
                    1. The final blog post MUST NOT exceed 10 sentences total.
                    2. Maintain a clear introduction, body, and conclusion structure.
                    3. Keep formatting as plain text only (NO Markdown, HTML, or special formatting)
                    4. For the title, use ALL CAPS instead of any special formatting
                    5. Separate paragraphs with blank lines
                    6. Use only simple ASCII characters
                    7. Provide the complete improved version while addressing the feedback.
                    8. Count your sentences carefully before submitting.
                    """, feedback, draft);
                
                // Send the refinement prompt to the AI model
                logger.info("Requesting draft revision based on feedback (iteration: {})", iteration);
                String revisedDraft = chatClient.prompt()
                        .user(refinePrompt)
                        .call()
                        .content();
                
                estimateTokenUsage(result, refinePrompt, revisedDraft);
                draft = revisedDraft;
                logger.info("Revised draft received for iteration {}", iteration);
            }
            iteration++;
        }

        // PHASE 3: FINALIZATION
        // Set final result properties
        result.setContent(draft);
        result.setApproved(approved);
        result.setIterations(iteration - 1);
        
        if (!approved) {
            logger.warn("Maximum iterations ({}) reached without editor approval", MAX_ITERATIONS);
        } else {
            logger.info("Blog post generation completed successfully for topic: {}", topic);
        }

        return result;
    }

    /**
     * Helper method to extract actionable feedback from the Editor agent's evaluation.
     * This extracts the text after "NEEDS_IMPROVEMENT" to get just the feedback portion.
     * 
     * @param evaluation The full evaluation text from the Editor agent
     * @return Just the actionable feedback portion
     */
    private String extractFeedback(String evaluation) {
        if (evaluation == null) return "";
        int idx = evaluation.toUpperCase().indexOf("NEEDS_IMPROVEMENT");
        if (idx != -1) {
            // Return text after "NEEDS_IMPROVEMENT"
            return evaluation.substring(idx + "NEEDS_IMPROVEMENT".length()).trim();
        }
        return evaluation;
    }
    
    /**
     * Helper method to estimate token usage as we can't directly access it
     * This is a rough estimation: approximately 4 characters per token
     */
    private void estimateTokenUsage(BlogGenerationResult result, String prompt, String response) {
        try {
            // Very rough estimation: ~4 characters per token
            int estimatedPromptTokens = prompt.length() / 4;
            int estimatedCompletionTokens = response.length() / 4;
            
            result.addPromptTokens(estimatedPromptTokens);
            result.addCompletionTokens(estimatedCompletionTokens);
            
            logger.debug("Estimated token usage: prompt={}, completion={}, total={}",
                estimatedPromptTokens, estimatedCompletionTokens, 
                estimatedPromptTokens + estimatedCompletionTokens);
        } catch (Exception e) {
            logger.warn("Failed to estimate token usage", e);
        }
    }
    
    /**
     * Class to hold blog generation result, including the content and metadata.
     */
    public static class BlogGenerationResult {
        private String content;
        private int iterations;
        private boolean approved;
        private int promptTokens;
        private int completionTokens;
        private int totalTokens;
        private String modelName;
        private List<String> editorFeedback = new ArrayList<>();
        
        // Getters and setters
        public String getContent() {
            return content;
        }
        
        public void setContent(String content) {
            this.content = content;
        }
        
        public int getIterations() {
            return iterations;
        }
        
        public void setIterations(int iterations) {
            this.iterations = iterations;
        }
        
        public boolean isApproved() {
            return approved;
        }
        
        public void setApproved(boolean approved) {
            this.approved = approved;
        }
        
        public int getPromptTokens() {
            return promptTokens;
        }
        
        public void setPromptTokens(int promptTokens) {
            this.promptTokens = promptTokens;
            this.totalTokens = this.promptTokens + this.completionTokens;
        }
        
        public void addPromptTokens(int tokens) {
            this.promptTokens += tokens;
            this.totalTokens = this.promptTokens + this.completionTokens;
        }
        
        public int getCompletionTokens() {
            return completionTokens;
        }
        
        public void setCompletionTokens(int completionTokens) {
            this.completionTokens = completionTokens;
            this.totalTokens = this.promptTokens + this.completionTokens;
        }
        
        public void addCompletionTokens(int tokens) {
            this.completionTokens += tokens;
            this.totalTokens = this.promptTokens + this.completionTokens;
        }
        
        public int getTotalTokens() {
            return totalTokens;
        }
        
        public String getModelName() {
            return modelName;
        }
        
        public void setModelName(String modelName) {
            this.modelName = modelName;
        }
        
        public List<String> getEditorFeedback() {
            return editorFeedback;
        }
        
        public void setEditorFeedback(List<String> editorFeedback) {
            this.editorFeedback = editorFeedback;
        }
        
        public void addEditorFeedback(String feedback) {
            if (this.editorFeedback == null) {
                this.editorFeedback = new ArrayList<>();
            }
            this.editorFeedback.add(feedback);
        }
    }
}
```

This implementation includes the following key features:

- Basic blog generation. The `generateBlogPost` method:
  - Creates a well-structured blog post on a given topic.
  - Uses an iterative refinement process with Writer and Editor agents.
  - Enforces a 10-sentence maximum length.

- Enhanced metadata generation. The `generateBlogPostWithMetadata` method:
  - Extends the basic functionality to capture detailed metadata about the generation process.
  - Tracks iterations, approval status, token usage, and editor feedback history.
  - Returns all information in a structured `BlogGenerationResult` object.

- Token usage estimation:
  - Provides a rough approximation of token usage by counting characters.
  - Tracks prompt tokens, completion tokens, and total tokens used.
  - This process is a workaround because we no longer directly access the `ChatResponse` class.

- The `BlogGenerationResult` inner class:
  - Serves as a container for both the generated content and its metadata.
  - Includes fields for content, iterations, approval status, token usage, and editor feedback.
  - Provides getters, setters, and convenience methods for tracking metadata.

The service is thoroughly commented to explain the Evaluator-Optimizer agent pattern and how Spring AI's fluent API facilitates interactions between AI agents.

### Create the BlogWriterController class

To expose the blog generation functionality via a REST endpoint, create a new file named **BlogWriterController.java** within the **controller** directory, and then add the following code:

```java
package com.example.springaiapp.controller;

import com.example.springaiapp.service.BlogWriterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;

@RestController
@RequestMapping("/api/blog")
public class BlogWriterController {

    private final BlogWriterService blogWriterService;

    @Autowired
    public BlogWriterController(BlogWriterService blogWriterService) {
        this.blogWriterService = blogWriterService;
    }

    @GetMapping(produces = "application/json")
    public Map<String, Object> generateBlogPost(@RequestParam String topic) {
        // Generate the blog post and capture metadata
        BlogWriterService.BlogGenerationResult result = blogWriterService.generateBlogPostWithMetadata(topic);
        
        // Create a structured JSON response
        Map<String, Object> response = new HashMap<>();
        response.put("topic", topic);
        response.put("content", result.getContent());
        response.put("metadata", createMetadataObject(result));
        
        return response;
    }
    
    private Map<String, Object> createMetadataObject(BlogWriterService.BlogGenerationResult result) {
        Map<String, Object> metadata = new HashMap<>();
        metadata.put("iterations", result.getIterations());
        metadata.put("approved", result.isApproved());
        metadata.put("totalTokensUsed", result.getTotalTokens());
        
        if (result.getEditorFeedback() != null && !result.getEditorFeedback().isEmpty()) {
            List<Map<String, Object>> feedbackHistory = new ArrayList<>();
            for (int i = 0; i < result.getEditorFeedback().size(); i++) {
                Map<String, Object> feedbackEntry = new HashMap<>();
                feedbackEntry.put("iteration", i + 1);
                feedbackEntry.put("feedback", result.getEditorFeedback().get(i));
                feedbackHistory.add(feedbackEntry);
            }
            metadata.put("editorFeedback", feedbackHistory);
        }
        
        // Include token usage statistics if available
        if (result.getPromptTokens() > 0) {
            Map<String, Object> tokenUsage = new HashMap<>();
            tokenUsage.put("promptTokens", result.getPromptTokens());
            tokenUsage.put("completionTokens", result.getCompletionTokens());
            tokenUsage.put("totalTokens", result.getTotalTokens());
            metadata.put("tokenUsage", tokenUsage);
        }
        
        // Include model information if available
        if (result.getModelName() != null) {
            metadata.put("model", result.getModelName());
        }
        
        return metadata;
    }
}
```

This controller exposes a GET endpoint at `/api/blog` that accepts a `topic` parameter and returns a structured JSON response containing both the generated blog content and detailed metadata about the generation process. The metadata includes the following information:

- The number of iterations performed during generation.
- The approval status of the final blog post by the Editor agent.
- Estimated token usage statistics: prompt, completion, and total tokens.
- Editor feedback history from each iteration.
- Information about the AI model used.

### Test the blog generation

After you add the `BlogWriterService` and its controller, use the following command to compile and run the application:

```bash
mvn spring-boot:run
```

Then, use the following command to test the blog generation endpoint:

```bash
curl --request GET \
    --url 'http://localhost:8080/api/blog?topic=Java%2520on%2520Azure'
```

This command returns a JSON response containing both the blog content and metadata about the generation process, as shown in the following example:

```json
{
  "topic": "Java on Azure",
  "content": "JAVA ON AZURE\n\nIf you're a Java developer looking to elevate your applications in the cloud, Microsoft Azure offers a powerful platform for building and scaling your projects.\n\nAzure App Service allows for quick deployment of Java web applications with frameworks like Spring Boot and Java EE, while Azure Functions provides a serverless option that lets you write Java code without worrying about the underlying infrastructure. Together, these services make it easier for developers to focus on coding rather than managing servers.\n\nFor example, a startup used Azure to build a scalable e-commerce app, leveraging App Service for web hosting and Azure Functions for processing payments. This combination streamlined their development process and improved efficiency.\n\nIn summary, Azure's services enhance flexibility, simplify deployment, and foster innovation for Java developers. How could these tools transform your Java development experience?",
  "metadata": {
    "iterations": 3,
    "approved": false,
    "totalTokensUsed": 5480,
    "editorFeedback": [
      {
        "iteration": 1,
        "feedback": "1. **Length**: The draft exceeds the 10-sentence maximum requirement, containing 12 sentences. You need to condense the content without losing essential information.\n   \n2. **Clarity and Flow**: While the ideas are mostly clear, the flow can be improved by connecting the sentences more cohesively. For example, consider linking the features of Azure more directly to the benefits for Java developers.\n\n3. **Engagement and Reader Interest**: The draft is informative but could be more engaging. Adding a question or a call-to-action might spark more interest and prompt readers to think about how they could apply this information.\n\n4. **Professional yet Conversational Tone**: The tone is somewhat formal. Try using a more conversational style to make it more relatable, such as directly addressing the reader (\"If you're a Java developer...\").\n\n5. **Structure and Organization**: Consider rearranging the content to start with a more compelling hook that highlights the importance of Java in the cloud landscape before diving into specific features.\n\nTo improve the draft, aim to succinctly capture the main points and eliminate redundancy while keeping within the sentence limit."
      },
      {
        "iteration": 2,
        "feedback": "While the draft is informative and covers important features of Azure for Java developers, it exceeds the 10-sentence limit, which is a critical requirement. Here are specific, actionable suggestions to improve the draft:\n\n1. **Condense Information**: Try to combine related ideas into fewer sentences. For example, you could merge the sentences about Azure App Service and Docker support to create a more concise point about deployment options.\n   \n2. **Remove Redundant Phrases**: Phrases like \"ideal platform\" and \"simplifies the process\" could be streamlined to save space.\n\n3. **Focus on Key Features**: You might want to highlight only one or two standout features instead of discussing multiple options, which would help keep the content focused and within the sentence limit.\n\n4. **Engaging Question**: The concluding question is a good touch, but consider integrating it more seamlessly into the conclusion to avoid exceeding the limit.\n\nBy implementing these changes, you can create a more concise and impactful blog post."
      },
      {
        "iteration": 3,
        "feedback": "1. The draft contains 11 sentences, exceeding the 10-sentence maximum requirement. Consider condensing some of the ideas to fit this constraint.\n2. The structure could benefit from clearer transitions between the main points about Azure services. For instance, you might explicitly link how App Service and Azure Functions both contribute to a developer's efficiency.\n3. While the concluding question is engaging, it could be more impactful if you briefly summarize the benefits discussed before asking it, reinforcing the key takeaways.\n4. Aim for a more conversational tone by using simpler language in some areas. For example, \"allows for seamless deployment via Docker\" could be rephrased to \"makes it easy to deploy using Docker.\"\n5. Consider adding a specific example or a brief case study to make the content more relatable and demonstrate practical application. \n\nBy addressing these points, the blog can be more engaging and adhere to the required length."
      }
    ],
    "tokenUsage": {
      "promptTokens": 3590,
      "completionTokens": 1890,
      "totalTokens": 5480
    },
    "model": "Azure OpenAI"
  }
}
```

### Expected behavior

With this implementation, you should consistently see at least two iterations - and often three - in the feedback loop. The first iteration is guaranteed by the instruction to the Editor agent to always provide improvement feedback on the first round. This instruction ensures that you can observe the complete Evaluator-Optimizer agent pattern in action. Without this forced iteration, you might occasionally see the Editor agent approve the first draft immediately, which doesn't demonstrate the full pattern.

The JSON response provides valuable insights into the generation process, enabling you to track the following information:

- How many iterations were needed - three in this example.
- The approval status of the post by the Editor agent - false in this example, meaning it reached the maximum number of iterations.
- The specific feedback from the Editor agent during each iteration.
- Estimated token usage for the entire process.

You can also examine the detailed logs, which `SimpleLoggerAdvisor` captures automatically, by ensuring that your application's logging level is set to DEBUG for the Spring AI packages. This setting is shown in the following example:

```properties
# In application.properties
logging.level.org.springframework.ai.chat.client.advisor=DEBUG
```

## Unit summary

In this unit, you extended your Spring AI application capabilities by incorporating the Evaluator-Optimizer agent pattern. This pattern enhances content generation by iteratively refining a blog post through automated evaluation and optimization. You also learned how to implement a structured JSON response that includes detailed metadata about the generation process, providing insights into the iterative refinement and resource usage of the AI-powered content generation.
