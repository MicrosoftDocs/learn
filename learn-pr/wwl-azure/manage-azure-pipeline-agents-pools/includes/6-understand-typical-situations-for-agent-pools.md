When you have many agents intended for different teams or purposes, you might want to create additional pools. Here are typical situations when creating agent pools makes sense:

## Team-specific agent pools

**Scenario:** You're a project member who wants to use machines your team owns for running build and deployment jobs.

**Steps:**

1. Ensure you're a member of a group in All Pools with the Administrator role.
2. Create a new project agent pool in your project settings.
3. Select the option to "Create a new organization agent pool".
4. Install and configure agents to join that agent pool.

**Result:** Both organization and project-level agent pools are created for your team's exclusive use.

## Organization-wide agent pools

**Scenario:** You're a member of the infrastructure team setting up a pool for use across all projects.

**Steps:**

1. Ensure you're a member of a group in All Pools with the Administrator role.
2. Create a new organization agent pool in admin settings.
3. Select "Auto-provision corresponding project agent pools in all projects".
4. Install and configure agents to join that agent pool.

**Result:** All projects get a pool pointing to the organization agent pool, including future projects.

## Selective sharing agent pools

**Scenario:** You want to share agent machines with multiple projects, but not all of them.

**Steps:**

1. Create a project agent pool in one project.
2. Select "Create a new organization agent pool".
3. Go to each target project and create a pool.
4. Select "Use an existing organization agent pool".
5. Install and configure agents to join the shared pool.

**Result:** Only specified projects can access the shared agent pool.
