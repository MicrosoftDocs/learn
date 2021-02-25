# Title

Push a commit to a new GitHub repository with Visual Studio 2019 [(Title guidance)](/help/learn/id-guidance-title)

## Role(s)

- Developer [Role guidance](https://review.docs.microsoft.com/en-us/new-hope/information-architecture/metadata/taxonomies?branch=master#role)
- Student

## Level

- Beginner  [Level guidance](https://review.docs.microsoft.com/en-us/new-hope/information-architecture/metadata/taxonomies?branch=master#level)

## Product(s)

- Visual Studio 2019

## Prerequisites

- Basic understanding of Git concepts [(Prerequisite guidance)](/help/learn/id-guidance-prerequisites)
- Familiarity with beginner Git commands
- A GitHub account
- Visual Studio installed

## Summary

Create a new local Git repository and push it to GitHub using the Git tooling in Visual Studio 2019. Add and modify files, then create a commit to push to your remote. [(Summary guidance)](/help/learn/id-guidance-introductory-summaries)*

## Learning objectives

1. Add a GitHub account to sign into Visual Studio [(Learning objective guidance)](/help/learn/id-guidance-learning-objectives)
2. Initialize a Git repository and push it to GitHub
3. Make and push commits to a remote branch

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Add a GitHub account to VS | GitHub account is required to backup your code on GitHub | Knowledge Check | 1 | Yes |
| Create a new local project | New projects are used to start coding in VS | Exercise | 2 | No, combine with 'Create a local Git repo' |
| Create a local Git repo | Local Git repos store version history | Exercise | 2 | Yes |
| Push the repo to GitHub | Once code is pushed, GitHub stores a copy | Exercise | 2 | No, combine with 'Create a local Git repo' |
| Make a change to the code | Explore the Git Changes window | Exercise | 3 | No, combine with 'Commit the change' |
| Commit the change | save the code you added | Exercise | 3 | Yes |
| Push the change to remote | store the code on a GitHub backup| Exercise | 3 | Yes |
| View the branch history | See how to manage the changes you made | Exercise | 3 | No, combine with 'Push the change to remote' |


## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    Provide a scenario of a real-world job-task that shows how the technology is used in practice:

    *Add your scenario [(Scenario guidance)](/help/learn/id-guidance-scenarios)*

    Suppose you are creating a tictactoe game. You want to make sure your code is backed up so that you don't lose it. You also want to share the game with your friends so they can also see what you've created.

    Suppose you join a new software development team working in C# and .NET using Visual Studio 2019.  While some team members are comfortable with using git from the command line, others are less confident with working in the command line and would prefer a more visual, integrated experience.  Your management team asks you to evaluate which tools are available to help developers work effectively with git repositories and execute git commands. You heard that there’s new tooling from Microsoft that could help developers work worry free and mistake-free right from within Visual Studio 2019.

1. **Add a GitHub account to Visual Studio**

    List the content that will enable the learner to *add a GitHub account to VS*:

    - Open Visual Studio account settings
        - What are the different types of Visual Studio accounts
    - GitHub accounts
        - what is the point of a GitHub account in VS
        - what do the credentials allow you to do
    
1.  **Exercise - Add a GitHub account**
   
    List the steps which apply the learning content from previous unit:

    1. Launch Visual Studio
    1. Open Account Settings
    1. Click add an account and select GitHub
    1. Sign in to GitHub via the browser
    1. Verify sign in successful in VS
   
1. **Create a Git repository**
   
    List the content that will enable the learner to *Create a new local project*, *Create a local Git repo*, and *Push the repo to GitHub* :

    - Add local code to source control
        - why to start with creating projects in VS
        - what does VS add to your folder when creating a Git repo
    
1.  **Exercise - Create a Git repository**
   
    List the steps which apply the learning content from previous unit:

    1. Create a new console application
    1. Add the project to Git by creating a new Git repo through VS
    1. Push the repo to the GitHub account you are signed into
    1. Verify the repo on GitHub.com

1. **Commit your changes**

    List the content that will enable the learner to *Make a change to the code* and *Commit the change* :

    - Make a change
        - How are changes tracked in VS
        - where to see changes
        - what are the different things you can do with a change
    - commit the change
        - how are commits tracked in VS
    
1.  **Exercise - Commit your changes**
   
    List the steps which apply the learning content from previous unit:

    1. Make changes to your code
    1. Check the branch you are on
    1. Stage and Commit the changes

1. **Push your changes to the remote branch**

    List the content that will enable the learner to *Push the change to remote* and *View the branch history* :

    - Push the change
        - what does pushing the change do
        - what are the different ways to push
    - Verify the change is pushed
        - how does VS display branch history

1. **Exercise - Push your changes**

    List the steps which apply the learning content from previous unit:

    1. Push your changes
    1. View confirmation notification for push
    1. View branch history

1. **Knowledge Check**

    What types of questions will test *learning objective*? *[(Knowledge check guidance)](/help/learn/id-guidance-knowledge-check)*

    - use of GitHub accounts
    - How to see changes in your repo in VS
    - how to create a new repo in VS

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module? 
    
    *Add your summary [(Summary guidance)](/help/learn/id-guidance-module-summary-unit)*

    - Easy to get started and connect Visual Studio with GitHub
    - Work with a simple Git workflow all within Visual Studio
    - Well-suited for individuals, small teams, and open source projects

## Notes
- related video to embed https://www.youtube.com/watch?v=GCZ9x3yqkyc&list=PLReL099Y5nRc-zbaFbf0aNcIamBQujOxP