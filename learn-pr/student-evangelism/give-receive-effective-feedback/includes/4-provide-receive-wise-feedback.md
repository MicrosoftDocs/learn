Now that you’re aware of the key wise feedback characteristics, you’re ready to review your team members’ code and provide them with specific feedback. Because every developer on the team brings different skills and approaches to code design and development, you should provide feedback that’s unique to each developer while at the same time guiding everyone toward achieving the common goal.

## Give wise feedback in code reviews

Code review is an integral part of software development. A peer review process conducted with the objectives of finding code defects, educating, transferring knowledge, facilitating shared code ownership and more helps maintain a level of consistency in software design and implementation. During the code review process, team members gain a better understanding of the code base and learn from each other, while correcting and educating each other and producing a high-quality end product.

There are many potential opportunities for negative interpersonal dynamics in the code review process that can be mitigated by the use of wise and effective feedback. For example, if a developer has the perception that a code change was treated unfairly or hostilely, it can lead to resentment and might result in actions that are not in the best interest of the project or team. Or, if a senior developer is giving feedback that lacks context and is curt, it can be perceived by a more junior developer as harsh and deflating.

Often, taking the time to share rationale or context for a comment can make all the difference when providing feedback. For example, explaining whether a comment is identifying a must-solve problem or is pointing out a “nice to have” improvement can guide the developer better.  Remember from the video: effective feedback is similar to a box delivered with useful tools. By adding as many details as possible in the feedback and providing clear guidance on how to improve, you’re empowering the developer.

:::image type="content" source="../media/4-code-review.png" alt-text="A new team member is working on code while another developer is reviewing the code on their respective computers." border="false":::

Suppose a new developer joins your team and starts to work on various aspects of the game. During the code development process, the developer finds that their code is displaying errors that they’re not able to resolve. They come to you for help in troubleshooting the error messages. You review the following code:

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

- “Oh, it’s just a simple issue of a missing parenthesis. Let me fix that for you.”

- “The logic of your code is great. But the error you’re getting is because of a missing parenthesis. Every opening parenthesis should have a corresponding closing parenthesis. Otherwise, it’s considered a syntax error. I’ll share with you how to check the help file to identify issues like this one if you encounter them again.”

Through building a relationship with the new team member you learn that this person welcomes educational information and that they need coaching on troubleshooting errors. By reinforcing what the developer got right and providing detailed feedback on the error, such as giving the short-term solution (how to fix) and the long-term solution (how to avoid), you encourage the developer to become a better coder.

Consider the following examples of effective and ineffective feedback.

| Not effective                                                | Effective                                                    |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| “Your program doesn’t meet the  assignment requirements. I spent hours figuring out how to fix it, so please review  the comments I made.” | “It’s clear you put a lot of effort  into this code—you seem to really want to learn. However, your program didn’t  meet the assignment requirements. I spent time figuring out how to fix it, so  please review the specific corrections I suggest. They can hopefully help you  recognize where you have some gaps. You might want to try going back to the  lecture notes to run the sample code on conditionals as a starting point.  After that, I encourage you to try correcting your code without referring to my  corrections to figure out if you can find some on your own. Remember that you  can also seek help in office hours if you get stuck on a future assignment!” |

 You might also have feedback related to style or design in code. Coding style determines the appearance of your code and can vary across programming languages, projects, and development teams. The coding style that you follow in JavaScript might not be the same that you follow when using CSS. For instance, both JavaScript and CSS can use either single or double quotes. You might decide to use double quotes in JavaScript strings and single quotes in CSS strings. Some examples of elements that the coding style determines include how to use variables and functions and their naming conventions.

Code design feedback is related to how developers arrange code in functions, classes, modules, and deployable packages. By following some principles and widely known patterns and code structures, you can help create high-quality code that’s maintainable, reusable and extensible.

## Process for conducting a code review

There are several aspects to a code review. Depending on the context, you might need to meet different requirements in your review. A typical code review process includes the following five steps:

1. Understand the requirements for the program. Every project has specific requirements and every program you write within a project will have even more specific functional requirements. Familiarize yourself with the associated assignment.

1. Attempt to (compile and) run the program. Note the compile errors, if any. When you attempt to run a program, a compiler analyzes the code statements, one after the other, to check for syntax, logical statements, and other programming issues.

1. Analyze whether the program behavior meets the requirements. Every program or software has specific functional requirements. As a reviewer, you should be aware of the functional requirements and goals of the program. It’s possible for a program to run without errors and produce a result. However, does the output of the program match the program requirements? Ask yourself, “Does the program achieve what it intends to do?”

1. Review the code itself and add written comments or suggestions. At this point, you might decide to note specific bugs or issues. Provide specific comments related to issues in the code. These might be related to syntax errors in the code statements, logical errors, or issues related to code style and design. Providing details and context to the developer would help them identify and avoid similar issues in the future.

1. Provide high-level feedback with a summary. Be sure to aim for wise feedback here! In addition to providing as many specific details as possible, you should also include a high-level summary of the feedback. Make sure to affirm the positive aspects along with mentioning the areas that need improvement.

## Guidelines for conducting an inclusive code review

To review code efficiently and to provide constructive and effective feedback for the recipient, employ the following guidelines:

- Provide detailed comments where applicable for the developer to understand the error. Comments should be understandable and respectful.

- If the code has many errors, focus on a few high-level comments about process. Group errors into common categories and give global feedback for those categories. For example, if the developer has followed an incorrect variable naming convention that doesn’t align with the project style in several places, leave a global comment providing an example of the correct convention.

- If the code has few errors, comments about organization or design might be more appropriate. The code might not have any errors and might run and compile successfully. However, you might still find issues in the code style design, where the data structures or created variables might not comply with the project guidelines. In such cases, you can provide comments to explain where the code deviates from the project specifications and provide additional references for the developer.

- Use code review checklists. Code review checklists can help maintain consistency among various teams working together on a project. Both developers and reviewers can check for the same items to ensure that all code developed has the same style and design.