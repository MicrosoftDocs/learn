In this unit, you extend your RAG application to demonstrate an *Evaluator Optimizer Agent* pattern. This pattern leverages multiple AI agents to generate, evaluate, and refine content iteratively. You can use this pattern to generate and refine content from blog posts.

## Implement Evaluator Optimizer Agent for Blog Post Generation

In this exercise, you implement an Evaluator Optimizer Agent pattern to improve generated content. In this design, one AI agent - the *Writer* - generates an initial draft - for example, a blog post. Another agent - the *Evaluator* - reviews and provides actionable feedback. The Writer refines the draft based on the feedback, and the process repeats until the content is approved or the maximum number of iterations is reached.

## Set up environment variables

For this exercise, you need some environment variables from the previous exercise. Use the following commands to verify these variables are available. If these variables aren't available, refer to the prior exercises to recreate them.

```bash
echo AZURE_OPENAI_ENDPOINT: $AZURE_OPENAI_ENDPOINT
echo AZURE_OPENAI_API_KEY: $AZURE_OPENAI_API_KEY
```

### Create the BlogWriterService

Within the **service** directory, create a new file named **BlogWriterService.java** with the following code:

```java
package com.example.springaiapp.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.client.SimpleLoggerChatClientBuilder;
import org.springframework.stereotype.Service;

@Service
public class BlogWriterService {
    private static final Logger logger = LoggerFactory.getLogger(BlogWriterService.class);
    private static final int MAX_ITERATIONS = 3;

    private final ChatClient chatClient;

    public BlogWriterService(ChatClient.Builder chatClientBuilder) {
        // Enable Simple Logger Advisor for detailed logging of AI interactions
        this.chatClient = new SimpleLoggerChatClientBuilder(chatClientBuilder).build();
    }

    public String generateBlogPost(String topic) {
        // First Agent: Writer - Generates initial blog post draft
        String initialPrompt = String.format("""
            You are a professional blog writer. Write a well-structured, engaging blog post about "%s".
            The post should have a clear introduction, body paragraphs, and conclusion.
            Include relevant examples and maintain a conversational yet professional tone.
            """, topic);

        String draft = chatClient.prompt(initialPrompt).call().chatResponse().getResult().getOutput().getText();

        boolean approved = false;
        int iteration = 1;
        while (!approved && iteration <= MAX_ITERATIONS) {
            // Second Agent: Evaluator - Reviews and provides feedback
            String evalPrompt = String.format("""
                You are a critical blog editor. Evaluate the following blog draft and respond with either:
                PASS - if the draft is well-written, engaging, and complete
                NEEDS_IMPROVEMENT - followed by specific, actionable feedback on what to improve

                Focus on:
                - Clarity and flow of ideas
                - Engagement and reader interest
                - Professional yet conversational tone
                - Structure and organization

                Draft:
                %s
                """, draft);

            String evaluation = chatClient.prompt(evalPrompt).call()
                .chatResponse().getResult().getOutput().getText();

            if (evaluation.toUpperCase().contains("PASS")) {
                approved = true;
                logger.info("Draft approved by editor on iteration {}", iteration);
            } else {
                String feedback = extractFeedback(evaluation);
                logger.info("Editor feedback (iteration {}): {}", iteration, feedback);

                // Third Agent: Standby Writer - Refines the draft based on editor's feedback
                String refinePrompt = String.format("""
                    You are a blog writer. Improve the following blog draft based on this editorial feedback:

                    Feedback: %s

                    Current Draft:
                    %s

                    Provide the complete improved version while maintaining the original topic and structure.
                    """, feedback, draft);

                draft = chatClient.prompt(refinePrompt).call()
                    .chatResponse().getResult().getOutput().getText();
            }
            iteration++;
        }

        if (!approved) {
            logger.warn("Maximum iterations ({}) reached without editor approval", MAX_ITERATIONS);
        }

        return draft;
    }

    private String extractFeedback(String evaluation) {
        if (evaluation == null) return "";
        int idx = evaluation.toUpperCase().indexOf("NEEDS_IMPROVEMENT");
        if (idx != -1) {
            return evaluation.substring(idx + "NEEDS_IMPROVEMENT".length()).trim();
        }
        return evaluation;
    }
}
```

This method generates a blog post on a given topic and refines it through an iterative process. The following steps provide a high-level overview of this functionality:

1. Initial draft generation: constructs an initial prompt asking the AI model to write a well-structured blog post on the given topic and sends it to the `chatClient` to retrieve an initial draft.
1. Evaluator-Optimizer loop:
    - Enters a loop that continues until the draft is approved or the maximum number of iterations is reached.
    - Checks whether the evaluation response contains `PASS`. If so, marks the draft as approved and logs the approval.
    - If the draft needs improvement, extracts feedback from the evaluation.
    - Sends the refinement prompt to the `chatClient` and retrieves the revised draft.
1. Final check: returns the final draft if either the evaluation receives a "PASS" response or the maximum iterations was reached.

### Create the BlogWriterController class

To expose the blog generation functionality via a REST endpoint, create a new file named **BlogWriterController.java** within the **controller** directory:

```java
package com.example.springaiapp.controller;

import com.example.springaiapp.service.BlogWriterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/blog")
public class BlogWriterController {

    private final BlogWriterService blogWriterService;

    @Autowired
    public BlogWriterController(BlogWriterService blogWriterService) {
        this.blogWriterService = blogWriterService;
    }

    @GetMapping
    public String generateBlogPost(@RequestParam String topic) {
        return blogWriterService.generateBlogPost(topic);
    }
}
```

This controller exposes a GET endpoint at `/api/blog` that accepts a `topic` parameter and delegates the blog post generation to the `BlogWriterService`.

### Test the blog generation

After adding the `BlogWriterService` and its controller, use the following command to compile and run the application:

```bash
mvn spring-boot:run
```

Then, use the following command to test the blog generation endpoint:

```bash
curl -G "http://localhost:8080/api/blog" --data-urlencode "topic=Spring AI Innovation"
```

This command should return a blog post that's been generated and iteratively refined through the Evaluator Optimizer Agent process. Because of the review iteration cycle, this request takes longer to complete. After it completes, you should see a blog entry similar to the following excerpt:

```markdown
# Spring AI Innovation: Embracing the Season of Transformation

Spring is a season synonymous with growth, renewal, and fresh beginnings. As nature awakens from its winter slumber, so too does the world of technology. In recent years, artificial intelligence (AI) has followed a similar pattern of blossoming innovation, with spring heralding exciting breakthroughs and applications. From revolutionizing industries to improving our everyday lives, AI is in full bloom, and its potential seems as boundless as the season itself.

In this blog post, we'll explore the latest AI innovations that are flourishing this spring, highlight real-world examples of their impact, and discuss how they're reshaping the future. Whether you're an AI enthusiast, a tech professional, or simply curious about the role of AI in our lives, this is your guide to the season's most exciting developments.
```

## Unit summary

In this unit, you extended your Spring AI application capabilities by incorporating an Evaluator Optimizer Agent pattern. This pattern enhances content generation by iteratively refining a blog post through automated evaluation and optimization. The module exposes this blog generation capability via a new REST endpoint.
