Git tags provide a way to mark specific points in your repository's history, typically for releases. Understanding how to use tags effectively is essential for managing software versions and creating releases that teams can depend on.

## Understanding Git tags and releases

Git tags are references that point to specific commits in your repository's history. They create permanent markers that don't move, unlike branches. Tags are perfect for marking release points, version milestones, and other important commits that you want to reference later.

**Two types of Git tags:**

1. **Lightweight tags**: Simple pointers to specific commits
2. **Annotated tags**: Full objects with metadata (recommended for releases)

## Creating and managing Git tags

### Creating annotated tags (recommended)

```bash
# Create an annotated tag with a message
git tag -a v1.0.0 -m "Release version 1.0.0: Initial stable release"

# Create a tag for a specific commit
git tag -a v1.0.1 -m "Hotfix: Security vulnerability patch" abc1234

# View tag information
git show v1.0.0
```

### Creating lightweight tags

```bash
# Create a lightweight tag (just a pointer)
git tag v1.0.0-beta

# List all tags
git tag

# List tags matching a pattern
git tag -l "v1.0.*"
```

### Pushing tags to remote repository

```bash
# Push a specific tag
git push origin v1.0.0

# Push all tags
git push origin --tags

# Push all tags (including lightweight tags)
git push origin --follow-tags
```

## Semantic versioning with Git tags

Follow semantic versioning (SemVer) principles for consistent version management:

```bash
# Format: MAJOR.MINOR.PATCH
git tag -a v1.0.0 -m "Major: Initial stable API"
git tag -a v1.1.0 -m "Minor: New feature additions"
git tag -a v1.1.1 -m "Patch: Bug fixes and improvements"

# Pre-release versions
git tag -a v2.0.0-alpha -m "Alpha: Pre-release for testing"
git tag -a v2.0.0-beta.1 -m "Beta: Feature-complete pre-release"
git tag -a v2.0.0-rc.1 -m "Release candidate: Final testing"
```

**Version increment rules:**

- **MAJOR**: Breaking changes that require user action
- **MINOR**: New features that maintain backward compatibility
- **PATCH**: Bug fixes and small improvements

## Automating release creation with GitHub Actions

### Automatic tag creation workflow

```yaml
name: Create Release Tag

on:
  push:
    branches: [main]
  workflow_dispatch:
    inputs:
      version:
        description: "Version number (e.g., v1.2.3)"
        required: true
        type: string

jobs:
  create-tag:
    if: contains(github.event.head_commit.message, '[release]')
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0 # Get full history for tag creation

      - name: Extract version from commit message
        id: version
        run: |
          # Extract version from commit message like "[release] v1.2.3"
          VERSION=$(echo "${{ github.event.head_commit.message }}" | grep -oP '\[release\]\s*\K\S+')

          if [[ -z "$VERSION" ]]; then
            echo "No version found in commit message"
            exit 1
          fi

          echo "version=$VERSION" >> $GITHUB_OUTPUT
          echo "Found version: $VERSION"

      - name: Create and push tag
        run: |
          VERSION="${{ steps.version.outputs.version }}"

          # Configure git
          git config user.name "Release Bot"
          git config user.email "release-bot@company.com"

          # Create annotated tag
          git tag -a "$VERSION" -m "Release $VERSION

          Changes in this release:
          $(git log --oneline $(git describe --tags --abbrev=0)..HEAD)"

          # Push tag to remote
          git push origin "$VERSION"

          echo "Created and pushed tag: $VERSION"
```

### Release creation from tags

````yaml
name: Create GitHub Release

on:
  push:
    tags:
      - "v*" # Trigger on version tags

jobs:
  create-release:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Generate changelog
        id: changelog
        run: |
          # Get the previous tag for changelog generation
          PREVIOUS_TAG=$(git describe --tags --abbrev=0 HEAD^ 2>/dev/null || git rev-list --max-parents=0 HEAD)
          CURRENT_TAG=${GITHUB_REF#refs/tags/}

          # Generate changelog between tags
          CHANGELOG=$(git log --pretty=format:"- %s (%an)" $PREVIOUS_TAG..$CURRENT_TAG)

          # Save multiline output
          {
            echo 'changelog<<EOF'
            echo "$CHANGELOG"
            echo EOF
          } >> $GITHUB_OUTPUT

      - name: Create GitHub Release
        uses: actions/create-release@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          tag_name: ${{ github.ref_name }}
          release_name: Release ${{ github.ref_name }}
          body: |
            ## Changes in ${{ github.ref_name }}

            ${{ steps.changelog.outputs.changelog }}

            ## Installation

            ### NPM
            ```bash
            npm install my-package@${{ github.ref_name }}
            ```

            ### Docker
            ```bash
            docker pull ghcr.io/myorg/myapp:${{ github.ref_name }}
            ```
          draft: false
          prerelease: ${{ contains(github.ref_name, 'alpha') || contains(github.ref_name, 'beta') || contains(github.ref_name, 'rc') }}
````

## Advanced tagging strategies

### Branch-specific tagging

```yaml
# Different tagging strategies for different branches
name: Smart Tagging

on:
  push:
    branches:
      - main
      - develop
      - "release/**"

jobs:
  create-tag:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Determine tag strategy
        id: strategy
        run: |
          BRANCH=${GITHUB_REF#refs/heads/}

          case $BRANCH in
            main)
              TAG_PREFIX="v"
              TAG_TYPE="stable"
              ;;
            develop)
              TAG_PREFIX="dev-"
              TAG_TYPE="development"
              ;;
            release/*)
              TAG_PREFIX="rc-"
              TAG_TYPE="release-candidate"
              ;;
            *)
              echo "No tagging for branch: $BRANCH"
              exit 0
              ;;
          esac

          # Generate version based on date and commit
          VERSION="${TAG_PREFIX}$(date +'%Y%m%d')-$(git rev-parse --short HEAD)"

          echo "version=$VERSION" >> $GITHUB_OUTPUT
          echo "tag-type=$TAG_TYPE" >> $GITHUB_OUTPUT

      - name: Create tag
        if: steps.strategy.outputs.version
        run: |
          git config user.name "Auto Tagger"
          git config user.email "auto-tagger@company.com"

          git tag -a "${{ steps.strategy.outputs.version }}" \
            -m "${{ steps.strategy.outputs.tag-type }} build from ${GITHUB_SHA}"

          git push origin "${{ steps.strategy.outputs.version }}"
```

## Managing and organizing tags

### Viewing and searching tags

```bash
# List all tags
git tag

# List tags with pattern matching
git tag -l "v1.*"

# Show tag details
git show v1.0.0

# Find tags containing specific commit
git tag --contains abc1234

# Sort tags by version
git tag -l | sort -V
```

### Cleaning up old tags

```bash
# Delete local tag
git tag -d v1.0.0-beta

# Delete remote tag
git push origin --delete v1.0.0-beta

# Delete multiple tags matching pattern
git tag -l "v1.0.*-beta" | xargs git tag -d
git tag -l "v1.0.*-beta" | xargs -I {} git push origin --delete {}
```

### Tag security and verification

```bash
# Create signed tag (requires GPG setup)
git tag -s v1.0.0 -m "Signed release v1.0.0"

# Verify signed tag
git tag -v v1.0.0

# List signed tags
git tag -l --format="%(refname:short) %(taggername) %(signature)"
```

## Best practices for Git tags and releases

### Consistent naming conventions

```bash
# Good: Semantic versioning
v1.0.0, v1.1.0, v1.1.1

# Good: Clear pre-release indicators
v2.0.0-alpha.1, v2.0.0-beta.2, v2.0.0-rc.1

# Avoid: Inconsistent naming
release-1, ver1.0, final-version
```

### Meaningful tag messages

```bash
# Good: Descriptive messages
git tag -a v1.2.0 -m "Version 1.2.0

Features:
- Add user authentication system
- Implement API rate limiting
- Add database migrations

Bug fixes:
- Fix memory leak in file processing
- Resolve race condition in user sessions

Breaking changes:
- Change API endpoint structure (see migration guide)"

# Avoid: Generic messages
git tag -a v1.2.0 -m "New version"
```

### Automated validation

```yaml
# Validate tags before creation
name: Tag Validation

on:
  push:
    tags:
      - "v*"

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - name: Validate tag format
        run: |
          TAG=${GITHUB_REF#refs/tags/}

          # Check semantic versioning format
          if [[ ! $TAG =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9]+(\.[0-9]+)?)?$ ]]; then
            echo "Invalid tag format: $TAG"
            echo "Expected format: v1.2.3 or v1.2.3-alpha.1"
            exit 1
          fi

          echo "Valid tag format: $TAG"

      - name: Check for changelog entry
        run: |
          TAG=${GITHUB_REF#refs/tags/}

          if ! grep -q "$TAG" CHANGELOG.md; then
            echo "No changelog entry found for $TAG"
            exit 1
          fi

          echo "Changelog entry exists for $TAG"
```

Using Git tags effectively creates a clear history of your project's evolution and provides reliable reference points for releases, deployments, and rollbacks. Combined with GitHub Actions automation, tags become powerful tools for managing your software delivery pipeline.
