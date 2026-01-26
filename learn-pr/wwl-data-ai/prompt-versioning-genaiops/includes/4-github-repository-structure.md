GitHub repository organization determines how effectively your team can find, manage, and collaborate on prompt development.

In the customer service scenario, the team needs a clear structure for storing multiple agent prompts, deployment scripts, and configurations. With proper organization, any team member can quickly locate the current production prompt, compare it to previous versions, and understand the deployment process.

Here, you learn how to select file formats for prompts, organize repository folders for collaboration, establish naming conventions, and track agent deployments with Git tags.

## Select file formats for prompt storage

**Why standardize file formats?**

Choosing the right file format for prompt storage affects readability, tool compatibility, version control effectiveness, and team collaboration. The format should balance human readability with machine processing capabilities.

**Plain text (`.txt`) - Simple and effective**

Plain text files offer straightforward prompt storage:

- **Maximum simplicity**: No formatting complexity or special syntax to learn
- **Universal compatibility**: Works with any text editor and programming language
- **Version control friendly**: Git shows clear line-by-line differences between versions
- **Direct SDK integration**: Python scripts can read files directly without parsing
- **Minimal dependencies**: No libraries or special tools required

> [!NOTE]
> The Microsoft Foundry SDK examples use `.txt` files for system instructions, making this a natural choice for agent prompts.

**Markdown (`.md`) - Enhanced documentation**

Markdown offers extra formatting capabilities when you need richer documentation:

- **Human-readable**: Plain text with simple formatting for headers, lists, and emphasis
- **Documentation support**: Tables, code blocks, and links for comprehensive prompt context  
- **Universal tool support**: Works in every editor, IDE, and documentation platform
- **Balanced approach**: Adds structure without significant complexity

**Alternative formats for specific needs**

- **JSON (`.json`)**: Excellent for structured data and API integration, particularly when prompts include metadata or multiple components
- **YAML (`.yaml`)**: Useful for configuration management and metadata storage
- **Python files (`.py`)**: Useful for programmatic prompt templates with dynamic content
- **Jinja2 templates (`.jinja2`)**: Powerful templating for variable substitution in prompts

**Microsoft Foundry compatibility**

Microsoft Foundry agents primarily use plain text files for system instructions, read directly by the Python SDK during agent creation. The format choice depends on your workflow:

| Use Case | Recommended Format | Purpose |
|----------|-------------------|---------|
| Agent system instructions | `.txt` or `.md` | Simple prompts read by deployment scripts |
| Configuration files | `.yaml` or `.json` | Environment settings and metadata |
| Dynamic prompt content | `.py` or `.jinja2` | Templates with variable substitution |
| Documentation | `.md` | Human-readable prompt guides and standards |

> [!TIP]
> Start with plain text (`.txt`) for agent prompts and Markdown (`.md`) for documentation. This combination provides simplicity for deployment scripts while maintaining comprehensive documentation. Add other formats only when specific requirements demand them.

## Organize prompts in repository structure

The typical project structure for versioned agent prompts looks like this:

```
project-root/
├── src/
│   └── agents/
│       └── trail_guide_agent/
│           ├── trail_guide_agent.py      # Deployment script
│           └── prompts/
│               ├── v1_instructions.txt   # Version 1 prompt
│               ├── v2_instructions.txt   # Version 2 prompt
│               └── v3_instructions.txt   # Version 3 prompt
├── .env                                  # Environment configuration
└── requirements.txt                      # Python dependencies
```

This structure:

- Groups related prompts with their deployment scripts
- Maintains version history through file naming
- Enables side-by-side comparison of prompt evolution
- Supports automated testing across versions

## Establish naming conventions

**Hierarchical folder structure**

A well-organized repository makes prompt discovery and maintenance straightforward. Based on the Microsoft Foundry agent development workflow, here's a recommended structure:

```
project-root/
├── README.md                           # Project overview and setup guide
├── .env                                # Environment configuration (not committed)
├── .gitignore                          # Files to exclude from version control
├── requirements.txt                    # Python dependencies
├── src/
│   ├── agents/
│   │   ├── trail_guide_agent/
│   │   │   ├── trail_guide_agent.py    # Deployment script
│   │   │   └── prompts/
│   │   │       ├── v1_instructions.txt # Version 1 prompt
│   │   │       ├── v2_instructions.txt # Version 2 prompt
│   │   │       └── v3_instructions.txt # Version 3 prompt
│   │   ├── customer_support_agent/
│   │   │   ├── support_agent.py
│   │   │   └── prompts/
│   │   │       ├── v1_greeting.txt
│   │   │       └── v2_greeting.txt
│   │   └── content_generator/
│   │       ├── content_agent.py
│   │       └── prompts/
│   │           └── blog_post.txt
├── tests/
│   ├── test_trail_guide.py            # Automated agent tests
│   └── test_support_agent.py
├── docs/
│   ├── deployment-guide.md            # Deployment procedures
│   ├── testing-standards.md           # Quality assurance
│   └── prompt-guidelines.md           # Writing standards
├── infra/                             # Infrastructure as code
│   └── main.bicep                     # Azure resource definitions
└── .github/
    └── workflows/                     # CI/CD automation
        ├── test-agents.yml
        └── deploy-agents.yml
```

**File naming conventions:**

- Use descriptive, lowercase names: `trail_guide_agent.py`
- Separate words with underscores for Python files: `customer_support_agent.py`  
- Include version numbers for prompt files: `v1_instructions.txt`, `v2_instructions.txt`
- Use descriptive suffixes for prompt variants: `greeting.txt`, `escalation.txt`
- Avoid spaces, special characters, and abbreviations
- Maintain consistent file extensions per file type

**Folder organization conventions:**

- Group by agent or function: `trail_guide_agent/`, `support_agent/`
- Place prompts in dedicated `prompts/` subdirectories within each agent folder
- Keep deployment scripts at the agent root level
- Maintain shallow hierarchies (maximum three levels deep)
- Use clear, descriptive folder names matching agent names
- Separate source code (`src/`), tests (`tests/`), and infrastructure (`infra/`)

**Version naming patterns:**

- **Semantic versions**: `v1_instructions.txt`, `v2_instructions.txt`, `v3_instructions.txt`
- **Feature-based**: `basic_greeting.txt`, `enhanced_greeting.txt`, `production_greeting.txt`
- **Date-based**: `instructions_2024_01.txt` (when semantic versioning isn't practical)

> [!NOTE]
> Microsoft Foundry automatically assigns incremental version numbers to agents (version 1, version 2, version 3, etc.). Use similar incremental numbering for your prompt files (`v1_instructions.txt`, `v2_instructions.txt`) to create clear alignment between file versions and deployed agent versions, simplifying tracking and debugging.

## Version agent deployments with Git tags

Git tags provide semantic versioning for agent deployments. Each agent version corresponds to a Git tag marking that deployment milestone:

| Git Tag | Prompt File | Agent Version | Description |
|---------|-------------|---------------|-------------|
| `v1` | `v1_instructions.txt` | Agent version 1 | Basic trail guide functionality |
| `v2` | `v2_instructions.txt` | Agent version 2 | Enhanced with personalization |
| `v3` | `v3_instructions.txt` | Agent version 3 | Production-ready with advanced features |

This creates a traceable relationship between your repository state and deployed agents:

```bash
# Deploy version 1
python trail_guide_agent.py
git add trail_guide_agent.py
git commit -m "Deploy trail guide agent V1"
git tag v1

# Deploy version 2 (after updating script to use v2_instructions.txt)
python trail_guide_agent.py
git add trail_guide_agent.py
git commit -m "Deploy trail guide agent V2"
git tag v2
```

> [!TIP]
> Git tags enable you to quickly identify which repository version corresponds to any deployed agent, simplifying debugging and rollback scenarios.
This foundational structure establishes the groundwork for treating prompts as first-class code assets, enabling reliable collaboration, change tracking, and deployment processes essential for production GenAI systems.