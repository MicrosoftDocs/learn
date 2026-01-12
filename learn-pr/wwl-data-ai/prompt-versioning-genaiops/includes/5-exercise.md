# Exercise - Versioning Prompts with GitHub and Foundry

In this exercise, you'll practice the complete prompt versioning workflow using GitHub and Microsoft Foundry.

## Prerequisites

Before you begin, ensure you have:
- GitHub account with repository creation permissions
- Access to Microsoft Foundry workspace
- Git installed on your local machine
- Basic familiarity with command line operations

## Exercise overview

You'll work with a customer support prompt that needs improvement. The current prompt occasionally generates responses that are too technical for general customers.

## Step 1: Clone the starter repository

1. Navigate to the provided starter repository: `[Repository URL to be provided]`
2. Fork the repository to your GitHub account
3. Clone your fork locally:
   ```bash
   git clone https://github.com/[your-username]/prompt-versioning-exercise.git
   cd prompt-versioning-exercise
   ```

## Step 2: Review the existing prompt in Microsoft Foundry

1. Open Microsoft Foundry and navigate to your workspace
2. Import the current customer support prompt from `prompts/customer-support/general-inquiry.md`
3. Test the prompt with these sample inputs:
   - "My internet is slow"
   - "I can't log into my account"
   - "What's included in my plan?"
4. Note any responses that seem too technical or unclear

## Step 3: Create a development branch

1. Create a new branch for your prompt improvements:
   ```bash
   git checkout -b feature/improve-customer-prompt
   ```

## Step 4: Modify the prompt

1. Open `prompts/customer-support/general-inquiry.md` in your text editor
2. Review the current prompt structure and identify areas for improvement
3. Modify the prompt to:
   - Use simpler language
   - Include instructions for avoiding technical jargon
   - Add guidance for explaining concepts clearly
4. Update the metadata header with your changes and new version number

## Step 5: Test your improved prompt

1. In Microsoft Foundry, create a new prompt session with your updated version
2. Test with the same sample inputs from Step 2
3. Compare outputs between original and improved versions
4. Document the differences in a testing notes file

## Step 6: Commit your changes

1. Add your changes to git:
   ```bash
   git add prompts/customer-support/general-inquiry.md
   git add testing-notes/improvement-comparison.md
   ```
2. Commit with a descriptive message:
   ```bash
   git commit -m "Improve customer prompt clarity and reduce technical jargon

   - Simplified language for general audience  
   - Added anti-jargon instructions
   - Updated version to 1.3.0
   - Tested with common support scenarios"
   ```

## Step 7: Open a pull request

1. Push your branch to GitHub:
   ```bash
   git push origin feature/improve-customer-prompt
   ```
2. Open a pull request with:
   - Clear title describing the improvement
   - Description of changes made
   - Testing results showing before/after comparisons
   - Performance impact assessment

## Step 8: Merge and tag the new version

1. After review approval, merge the pull request
2. Switch to main branch and pull changes:
   ```bash
   git checkout main
   git pull origin main
   ```
3. Tag the new version:
   ```bash
   git tag -a v1.3.0 -m "Improved customer prompt clarity"
   git push origin v1.3.0
   ```

## Step 9: Deploy to production

1. In Microsoft Foundry, update the production prompt with your validated version
2. Monitor initial responses for quality
3. Document the successful deployment in your changelog

## Validation checklist

Confirm you've completed:
- [ ] Created a feature branch for development
- [ ] Improved the prompt based on testing feedback
- [ ] Documented changes with clear commit messages
- [ ] Used pull request process for review
- [ ] Tagged the approved version
- [ ] Updated production environment

## What you've learned

This exercise demonstrated a complete GenAIOps workflow:
- Safe prompt iteration using branches
- Testing and comparison methodologies
- Collaborative review through pull requests
- Version tagging and production deployment
- Documentation and change tracking

This process ensures prompt changes are deliberate, tested, and trackable—critical capabilities for maintaining reliable AI systems in production environments.