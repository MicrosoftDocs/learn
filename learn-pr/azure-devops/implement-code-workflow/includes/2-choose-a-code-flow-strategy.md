It's important to choose a code-flow strategy that fits the way your team works. You have several strategies to consider. At the end of the module, you can explore options. The Tailspin web team decides to develop a code-flow strategy that's based on Git and GitHub.

When Mara set up Azure Boards, she and the team identified a few initial tasks to address. One task was to create a Git-based workflow.

:::image type="content" source="../../shared/media/build-initial-tasks.png" alt-text="Screenshot of Azure Boards showing the initial three tasks.":::

Let's listen in on the team as they work out a better way to collaborate. Currently, they're using a centralized version-control system, but the plan is to move to Git, a distributed system.

Mara is diligently working on her assigned features when Andy walks in.

**Andy:** Hi Mara. In the leadership meeting this morning, it was brought up that our team and the game-development team are using different version-control systems. To streamline how we share resources between teams, we've been asked to move to a distributed version-control system that can better handle the collaboration.

**Mara:** That's good to know. If you remember, we put it on our board. Currently, we're using a centralized version-control system. It works great for us now, but I agree that a distributed version-control system is a better choice when we start to share between teams and our team gets bigger. It's also a task on our board to increase visibility so that all the stakeholders know what everyone is doing. I think a distributed source-control system like Git would also help.

**Andy:** I've been wanting to try Git for a while. I never seem to have the time. Is it difficult to learn or set up? If it seems reasonable, maybe we could work on it now. I'm tired of always putting things off. And it would be nice to be able to see what everyone is doing and to have access to the entire repository. OK, what's it all about?

**Mara:** Let me explain it, and then you can decide if it sounds like something we want to implement right away.

Mara and Andy move to the whiteboard for a discussion on version control.

## What is Git and distributed version control?

:::image type="content" source="../media/2-whiteboard-centralized-vs-distributed-drawing.png" border="false" alt-text="Diagram of a hand-drawn illustration of centralized versus distributed source control.":::

**Mara:** The drawing on the left is _centralized version control_, like what we're using now. We have a central version of the code base :::image type="icon" source="../../shared/media/callout-01.png"::: in Team Foundation Version Control (TFVC) that everyone uses. We each work on the files we need to change and then merge them back into the main repository when we're finished with them.

**Andy:** Yes, and that's working for us. Well, except when I was blocked that time when a breaking change got merged into the central repo.

**Mara:** Right! You were blocked :::image type="icon" source="../../shared/media/callout-02.png":::. We could use a branching strategy with TFVC to solve the blocking issue, but in our current configuration, merging might get a bit more complicated. And when we had that breaking change :::image type="icon" source="../../shared/media/callout-03.png":::, no one could get any work done until we got that resolved. That problem is always lurking, because we're all using the same copy of the code.

On the right is a drawing of _distributed version control_. We still have a central repository :::image type="icon" source="../../shared/media/callout-04.png"::: that's the stable version of the code base, but each developer has their own copy :::image type="icon" source="../../shared/media/callout-05.png"::: of it from which to work. This frees us up to experiment and try various approaches without affecting the central repository.

Distributed version control also ensures that only the working code :::image type="icon" source="../../shared/media/callout-06.png"::: is merged into the central repository. We could even set it up so that code can't be merged until it's reviewed.

What's cool about Azure DevOps is that it works well both with centralized version-control systems and distributed version-control systems.

**Andy:** What happens when more than one person changes the same file?

**Mara:** Often, Git can merge multiple changes automatically. Of course, we want to always make sure that the combination of changes results in code that works. When Git can't automatically merge changes, it marks the conflicts directly in the files so that a human can choose which changes to accept.

**Andy:** Right now, our code is stored on our own server. If we move to using distributed version control, where will the code be stored?

**Mara:** I'm glad you asked. That's where hosting comes in.

## Where can I host my repository?

**Mara:** When we're deciding where to host our repositories, we have a few options. For example, we can host them on a local server, in Bitbucket, or in GitHub. Bitbucket and GitHub are web-based hosting solutions. We can access them from anywhere.

**Andy:** Have you used either of them?

**Mara:** I've used GitHub in the past. It has features that are important to developers, like easy access to change logs and version-control features from either the command line or the online portal.

**Andy:** So how does Git work?

## How do I work with Git?

**Mara:** Like I mentioned before, with distributed systems, developers are free to access any file they need without affecting other developers' work, because they have their own copy of the repository. A _clone_ is your local copy of a repository.

When we work on a feature or a bug fix, we usually want to try out different approaches until we find the best solution. However, trying out code on your copy of the main code base isn't a good idea, because you might not want to keep the first few tries.

To give you a better option, Git has a feature called _branching_, where you can maintain as many copies as you want and merge back only the one you want to keep. This keeps the main branch stable.

**Andy:** I get the concepts so far. How do I check in my code?

## How do my local changes get up to the main code base?

**Mara:** In Git, the default branch, or _trunk_, is typically called `main`.

When you feel your code is ready to be merged into the `main` branch in the central repository that's shared by all developers, you create what's called a _pull request_. When you create a pull request, you're telling the other developers that you have code ready to review, and you want it merged into the `main` branch. When your pull request is approved and then merged, it becomes part of the central code base.

## What does a branching workflow look like?

 :::row:::
    :::column span="8":::
**Step 1**:
When you begin to work on a new feature or bug fix, the first thing you want to do is ensure that you're starting with the latest stable code base. To do this, you can synchronize your local copy of the `main` branch with the server's copy. This pulls into your local copy all other developer changes that were pushed to the `main` branch on the server since your last sync.

    :::column-end:::
    :::column:::
         :::image type="content" source="../media/2-github-paths-1.png" border="false" alt-text="Diagram of a pull from the remote main branch into the local main branch.":::
    :::column-end:::
 :::row-end:::
 :::row:::
    :::column span="8":::
**Step 2**:
To ensure that you're working only on your _copy_ of the code, you create a new branch just for that feature or bug fix. As you can imagine, having many branches for all the things you're doing might get hard to remember, so using a good naming convention is critical.

Before you make changes to a file, you check out a new branch so that you know you're working on the files from that branch and not from a different branch. You can switch branches anytime by checking out that branch.
    :::column-end:::
    :::column:::
        :::image type="content" source="../media/2-github-paths-2.png" border="false" alt-text="Diagram of a new branch being created in the local repository.":::
    :::column-end:::
:::row-end:::
 :::row:::
    :::column span="8":::
**Step 3**:
You're now safe to make whatever changes you want, because these changes are only in your branch. As you work, you can _commit_ your changes to your branch to ensure that you don't lose any work, and to provide a way to roll back any changes you've made to earlier versions. Before you can commit changes, you need to stage your files so that Git knows which ones you're ready to commit.
    :::column-end:::
    :::column:::
        :::image type="content" source="../media/2-github-paths-3.png" border="false" alt-text="Diagram of the commits being made to the local branch.":::
    :::column-end:::
:::row-end:::
 :::row:::
    :::column span="8":::
**Step 4**:
The next step is to _push_, or upload, your local branch up to the remote repository (such as GitHub) so that others can see what you're working on. Don't worry, this won't merge your changes yet. You can push up your work as often as you'd like. In fact, that's a good way to back up your work or allow yourself to work from multiple computers.
    :::column-end:::
    :::column:::
        :::image type="content" source="../media/2-github-paths-4.png" border="false" alt-text="Diagram of the local commits being pushed to the remote repository.":::
    :::column-end:::
:::row-end:::
:::row:::
    :::column span="8":::
**Step 5**:
This step is a common one, but not required. When you're satisfied that your code is working as you want it to, you can _pull_, or merge, the remote `main` branch back into your local `main` branch. Changes have been taking place there that your local `main` branch doesn't have yet. After you've synchronized the remote `main` branch with yours, merge your local `main` branch into your working branch and test your build again.

This process helps ensure that your feature works with the latest code. It also helps ensure that your work will integrate smoothly when you submit your pull request.
    :::column-end:::
    :::column:::
        :::image type="content" source="../media/2-github-paths-5.png" border="false" alt-text="Diagram of the remote changes being pulled down into the local repository.":::
    :::column-end:::
:::row-end:::
:::row:::
    :::column span="8":::
**Step 6**:
Your local code now needs to be committed and pushed up to the hosted repository. This is the same as steps 3 and 4.
    :::column-end:::
    :::column:::
        :::image type="content" source="../media/2-github-paths-6.png" border="false" alt-text="Diagram of the merged commits being pushed to the remote repository.":::
    :::column-end:::
:::row-end:::
:::row:::
    :::column span="8":::
**Step 7**:
You're finally ready to propose your changes to the remote `main` branch. To do this, you begin a pull request. When configured in Azure Pipelines or another CI/CD system, this step triggers the build process, and you can watch your changes move through the pipeline. After the build succeeds and others approve your pull request, your code can be merged into the remote `main` branch. (It's still up to a human to merge the changes.)
    :::column-end:::
    :::column:::
        :::image type="content" source="../media/2-github-paths-7.png" border="false" alt-text="Diagram of a pull request from a branch into main.":::
:::row-end:::

**Andy:** This all looks complicated and hard to learn.

**Mara:** Git can seem intimidating because it's so powerful, but after you get the hang of the flow, it starts to feel natural.

You'll use only a few commands daily. Here's a summary:

| Category                 | To perform this task                       | Use this command |
|--------------------------|--------------------------------------------|------------------|
| Repository management    | Create a Git repository                    | `git init`       |
|                          | Download a remote repository               | `git clone`      |
| Branch                   | Create a branch                            | `git checkout`   |
| Stage and commit changes | See which files have been changed          | `git status`     |
|                          | Stage files to commit                      | `git add`        |
|                          | Commit files to your branch                | `git commit`     |
| Remote synchronization   | Download a branch from a remote repository | `git pull`       |
|                          | Upload a branch to a remote repository     | `git push`       |

**Andy:** That sounds like a great starting point. I can definitely handle that. I can learn more advanced commands as I need them.
