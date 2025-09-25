YAML pipelines represent the "infrastructure as code" approach for CI/CD. Instead of clicking through a visual interface, you define your entire pipeline in a YAML file stored with your source code.

## Why use YAML?

**Modern microservice architectures** often need many similar deployment pipelines. Creating these manually through a UI becomes tedious and error-prone. YAML enables:

- **Code reuse**: Share pipeline templates across projects
- **Version control**: Pipeline changes follow the same review process as code
- **Consistency**: Identical setups across multiple services
- **Collaboration**: Team members can contribute pipeline improvements

## How YAML pipelines work

1. **Create YAML file**: Define your pipeline in `azure-pipelines.yml` in your repository
2. **Connect repository**: Link Azure Pipelines to your Git repository  
3. **Push changes**: Code and pipeline changes trigger builds automatically
4. **Monitor results**: Track build and deployment progress

:::image type="content" source="../media/flowchart-edit-code-yaml-1e1c3048.png" alt-text="Screenshot of Flowchart with edit code, edit YAML file, push to code repo, Azure Pipelines, and deploy to target.":::

## YAML pipeline benefits

**Version control integration**:
- Pipeline definitions live alongside your code
- Changes follow the same branching strategy as your application
- Pull request reviews include both code and pipeline changes

**Branch flexibility**:
- Each branch can customize its build process
- Feature branches can test pipeline changes safely
- Merge conflicts help identify pipeline incompatibilities

**Better troubleshooting**:
- Pipeline changes are tracked in version history
- Easier to identify when pipeline modifications cause issues
- Rollback pipeline changes like any other code change

**Enhanced security**: 
- Pipeline configurations are reviewed like code
- Branch policies protect production pipeline definitions
- Approvals and checks provide additional safety layers

## Getting started

YAML has a steeper learning curve but offers more power and flexibility. Microsoft now recommends YAML for new pipelines due to its modern DevOps benefits and active feature development.
