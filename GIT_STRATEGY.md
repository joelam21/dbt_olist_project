# Git Branching Strategy - dbt_olist_project

## Overview
This document outlines the Git branching strategy for the dbt_olist_project to ensure clean, organized development workflow and proper environment separation.

## Branch Structure

### Core Branches
- **`main`** - Production-ready code only
  - Protected branch
  - All code here should be deployment-ready
  - Only updated via pull requests from `develop`
  - Used for production deployments

- **`develop`** - Integration branch for ongoing development
  - Where features are integrated and tested together
  - Should always be in a deployable state
  - Used for development environment deployments
  - Source for feature branches

### Working Branches
- **`feature/<feature-name>`** - Individual feature development
  - Branch from `develop`
  - Merge back to `develop` via pull request
  - Examples: `feature/customer-segmentation`, `feature/order-metrics`

- **`hotfix/<issue-name>`** - Critical production fixes
  - Branch from `main`
  - Merge to both `main` and `develop`
  - For urgent production issues only

## Workflow

### Feature Development
1. Create feature branch from `develop`:
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b feature/your-feature-name
   ```

2. Develop and commit changes:
   ```bash
   git add .
   git commit -m "feat: descriptive commit message"
   ```

3. Push and create pull request:
   ```bash
   git push origin feature/your-feature-name
   # Create PR to develop branch
   ```

4. After review and approval, merge to `develop`

### Release Process
1. Test thoroughly in `develop` branch
2. Create pull request from `develop` to `main`
3. Deploy to production after merge

### Hotfix Process
1. Create hotfix branch from `main`:
   ```bash
   git checkout main
   git checkout -b hotfix/critical-issue-fix
   ```

2. Fix issue and test
3. Merge to `main` first, then to `develop`

## Commit Message Convention
Use conventional commits for clear history:
- `feat:` - New features
- `fix:` - Bug fixes
- `docs:` - Documentation updates
- `style:` - Code formatting
- `refactor:` - Code refactoring
- `test:` - Adding tests
- `chore:` - Maintenance tasks

Examples:
```
feat: add customer lifetime value model
fix: correct date formatting in orders staging
docs: update README with setup instructions
```

## Environment Mapping
- **Development Environment** ← `develop` branch
- **Production Environment** ← `main` branch

## Current State
- ✅ Repository initialized
- ✅ `main` branch created with initial commit
- ✅ `develop` branch created and checked out
- 🔄 Currently on `develop` branch for ongoing development

## Next Steps
1. Set up remote repository (GitHub/GitLab)
2. Configure branch protection rules
3. Set up automated CI/CD pipelines
4. Create pull request templates

---

*Last Updated: July 19, 2025*
