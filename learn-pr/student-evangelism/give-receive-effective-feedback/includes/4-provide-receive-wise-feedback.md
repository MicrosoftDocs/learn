Now that you're aware of the key characteristics of wise feedback, you're ready to review a team member's code and provide some specific feedback. Because every developer brings a different approach to code design and development, you should provide feedback that's unique to each one as you're guiding all team members toward a common goal.

## Give wise feedback in code reviews

Code reviews are an integral part of software development. A peer review process with the objectives of finding code defects, educating, transferring knowledge, and facilitating shared code ownership helps maintain consistency in software design and implementation. During the code review process, team members gain a better understanding of the code base by correcting and educating each other. In the end, they produce a higher-quality product.

By delivering wise and effective feedback during code reviews, you can help lessen potential negative interpersonal dynamics. For example, if a developer perceives that a certain code change was treated unfairly or with hostility, such a feeling might lead to resentment or even actions that aren't in the best interest of the project or team. Or curt feedback from a senior developer that lacks context might be perceived by a more junior developer as harsh and deflating.

When you provide feedback, taking the time to share the rationale or context for a comment can often make all the difference. For example, you can offer better guidance by clarifying whether a comment identifies a must-solve problem or points out a “nice to have” improvement. In the earlier video, you saw that effective feedback is similar to a box delivered with useful tools. By adding as many details as possible in the feedback and providing clear guidance on how to improve, you're empowering the developer.

:::image type="content" source="../media/4-code-review.png" alt-text="Cartoon-style drawing of a new team member writing code on a computer while a more senior developer reviews the same code on another computer." border="false":::

Suppose a new developer on your team is writing code for various aspects of the game. During the code development process, the code is displaying errors that the new team member is unable to resolve. The person comes to you for help in troubleshooting the error messages. You review the following code:

```java
if ((5 < 9) && (4 > 1)**
 **System.out.println(“Hello, Friends!”).**
```

You realize that the code is missing a parenthesis. The corrected code should be:

```java
if ( (5 < 9) && (4 > 1) )
 System.out.println( “Hello, Friends!” );**
```

Which of the following examples of feedback would you choose?

- "Oh, it's just a simple issue of a missing parenthesis. Let me fix that for you."
- "The logic of your code is great. But the error you're getting is because of a missing parenthesis. Every opening parenthesis should have a corresponding closing parenthesis. Otherwise, it's considered a syntax error. I'll share with you how to check the help file to identify issues like this one if you encounter them again."

Through building a relationship with the new team member, you learn that this person welcomes educational information and that they need coaching on troubleshooting errors. By reinforcing what the developer got right and providing detailed feedback on the error, such as giving the short-term solution (how to fix) and the long-term solution (how to avoid), you encourage the developer to become a better coder.

Consider the following examples of ineffective and effective feedback:

| Ineffective feedback | Effective feedback |
| --- | --- |
| "Your program doesn't meet the  assignment requirements. I spent hours figuring out how to fix it, so please review  the comments I made." | "It's clear you put a lot of effort into this code. You seem to really want to learn. However, your program didn't  meet the assignment requirements. I spent time figuring out how to fix it, so please review the specific corrections I suggest. They can hopefully help you recognize where you have some gaps. You might want to try going back to the lecture notes to run the sample code on conditionals as a starting point. After that, I encourage you to try correcting your code without referring to my corrections to figure out if you can find some on your own. Remember that you can also seek help during office hours if you get stuck on a future assignment." |
| | |

You might also have feedback that's related to style or design in code. Coding style determines the appearance of your code and can vary across programming languages, projects, and development teams. The coding style that you follow in JavaScript might not be the same as the style that you follow when you're using CSS. For instance, both JavaScript and CSS can use either single or double quotation marks. You might decide to use double quotation marks in JavaScript strings and single quotation marks in CSS strings. Some examples of elements that the coding style determines include how to use variables and functions and their naming conventions.

Code design feedback is related to how developers arrange code in functions, classes, modules, and deployable packages. By following some principles and widely known patterns and code structures, you can help create high-quality code that's maintainable, reusable, and extensible.

## Process for conducting a code review

Each code review has several aspects. Depending on the context, you might need to meet various requirements in your review. A typical code review process includes the following five steps:

1. **Understand the requirements for the program**. Every project has specific requirements, and every program you write within a project has even more specific functional requirements. Familiarize yourself with the associated assignment.

1. **Attempt to compile and run the program**. Note the compile errors, if any. When you attempt to run a program, a compiler analyzes the code statements, one after another, to check for syntax, logical statements, and other programming issues.

1. **Analyze whether the program behavior meets the requirements**. Every program or software has specific functional requirements. As a reviewer, you should be aware of the functional requirements and goals of the program. It's possible for a program to run without errors and produce a result. However, does the output of the program match the program requirements? Ask yourself, Does the program achieve what it intends to do?

1. **Review the code itself and add written comments or suggestions**. At this point, you might decide to note specific bugs or issues. Provide specific comments related to issues in the code. These might be related to syntax errors in the code statements, logical errors, or issues of code style and design. Providing details and context to the developer can help them identify and avoid similar issues in the future.

1. **Provide high-level feedback with a summary**. Be sure to aim for wise feedback here. In addition to providing as many specific details as possible, you should also include a high-level summary of the feedback. Be sure to affirm the positive aspects as you're pointing out the areas that need improvement.

## Guidelines for conducting an inclusive code review

To review code efficiently and to provide constructive and effective feedback for the recipient, apply the following guidelines:

- Provide detailed comments, where applicable, to help the developer understand the error. Comments should be understandable and respectful.

- If the code has many errors, focus on a few high-level comments about process. Group errors into common categories, and give global feedback for those categories. For example, if the developer has followed an incorrect variable-naming convention that doesn't consistently align with project style, leave a global comment providing an example of the correct convention.

- If the code has few errors, comments about organization or design might be more appropriate. The code might not have any errors and might run and compile successfully. However, you might still find issues in the code style design, where the data structures or created variables might not comply with the project guidelines. In such cases, you can provide comments to explain where the code deviates from the project specifications and provide additional references for the developer.

- Use code review checklists. Code review checklists are key to maintaining consistency, especially when multiple teams are working together on a single project. Both developers and reviewers can check for the same items to ensure that all code is written with the same style and design.
