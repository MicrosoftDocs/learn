The Azure Pipelines Visual Designer (also called "Classic Pipelines") provides a graphical interface for creating and managing CI/CD pipelines without writing code.

## How Visual Designer works

1. **Connect your repository**: Link Azure Pipelines to your Git repository
2. **Design your pipeline**: Use drag-and-drop interface to add tasks
3. **Trigger builds**: Code pushes automatically start your pipeline
4. **Create artifacts**: Build process generates deployable artifacts
5. **Deploy**: Release pipeline delivers artifacts to target environments

:::image type="content" source="../media/flowchart-edit-code-94cc665f.png" alt-text="Screenshot of Flowchart with edit code, push to code repo, build tasks, and test tasks, create artifact, release tasks, and deploy to target.":::

## Visual Designer benefits

**Easy for beginners**: Perfect for teams new to CI/CD concepts

- Visual pipeline representation makes workflows clear
- No need to learn YAML syntax initially
- Drag-and-drop interface for adding tasks

**Integrated experience**:

- Designer and build results share the same interface
- Easy switching between configuration and monitoring
- Built-in task library with pre-configured options

**Quick setup**: Get pipelines running faster with:

- Template-based pipeline creation
- GUI-based configuration
- Visual task dependencies

## When to use Visual Designer

**Choose Visual Designer if you**:

- Are new to Azure Pipelines
- Prefer graphical interfaces over code
- Want quick pipeline setup
- Need simple, straightforward workflows

>[!Note]
> Microsoft recommends YAML pipelines for new projects due to version control benefits and modern DevOps practices. However, Visual Designer remains valuable for learning and simpler scenarios.
