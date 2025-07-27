---
title: "zs: One Command to Rule Your Zed Setup"
published: false
description: "Introducing zs - a zero-configuration tool that automatically sets up Zed editor for any project with a single command"
tags: zed, productivity, developer-tools, automation
cover_image: https://dev-to-uploads.s3.amazonaws.com/uploads/articles/your-cover-image.png
canonical_url: 
---

# zs: One Command to Rule Your Zed Setup

**TL;DR**: Tired of manually configuring Zed for every project? Just run `zs`. It auto-detects your project type, installs debug dependencies, creates tasks, and sets up git hooks. Zero configuration required.

```bash
curl -sSL https://raw.githubusercontent.com/AnjanJ/zs/main/install.sh | bash
cd any-project
zs
✅ Rails project ready (15 tasks, debugging enabled)
```

## The Problem

Every time I switched projects in [Zed](https://zed.dev), I found myself:

- 🔧 Manually creating `.zed/tasks.json` for that specific framework
- 🐛 Setting up debug configurations (that never quite worked)
- 📦 Installing language-specific debug adapters
- 🔒 Configuring different git hooks for work vs personal projects
- 😤 Googling the same configurations over and over

Multiply this by switching between Rails, React, Python, and Elixir projects daily... you get the idea.

## The Solution: zs

After one too many manual setups, I decided to automate everything. The goal? **Zero cognitive load**.

```bash
cd ~/work/canvas-lti-app
zs
✅ Rails project ready (21 tasks, debugging enabled)
  → Work project: commits need 'Refs: PFS-XXXX'
```

That's it. No flags. No options. No decisions.

## How It Works

`zs` is built on a simple philosophy: **The best interface is no interface**.

When you run `zs`, it:

1. **Detects** your project type automatically
   - Rails? ✓ (Gemfile + config/application.rb)
   - React? ✓ (package.json with react dependency)
   - Python? ✓ (requirements.txt)
   - Elixir? ✓ (mix.exs)

2. **Installs** only what Zed needs
   - Ruby: `debug` gem (provides rdbg)
   - Python: `debugpy`
   - Elixir: `elixir-ls`
   - Nothing else - no `bundle install` or `npm install`

3. **Creates** proper configurations
   - `.zed/tasks.json` with framework-specific tasks
   - `.zed/debug.json` with working debug configs (using Zed's format, not VS Code's!)

4. **Configures** smart git hooks
   - Work projects: Reminds about JIRA tickets
   - Personal projects: Standard format
   - Never blocks, just reminds

5. **Reports** success in one line
   - `✅ Project ready (15 tasks)`

## Real-World Examples

### Rails Project
```json
// Auto-generated .zed/tasks.json includes:
{
  "label": "💎 Rails Server",
  "command": "bundle",
  "args": ["exec", "rails", "server"]
},
{
  "label": "🧪 Run Current Test File",
  "command": "bundle", 
  "args": ["exec", "rspec", "$ZED_FILE"]
},
// ... 13 more tasks
```

### Work vs Personal Context
```bash
# Personal project
cd ~/code/my-app
zs
✅ Rails project ready (15 tasks, debugging enabled)

# Work project (auto-detected from path)
cd ~/work/enterprise-app
zs
✅ Rails project ready (21 tasks, debugging enabled)
  → Work project: commits need 'Refs: PFS-XXXX'
```

### Smart Caching
```bash
# First run
zs
✅ React project ready (16 tasks, debugging enabled)

# Run again
zs
✅ Already configured (react project)
```

## The Hidden Power

While the interface is minimal, `zs` packs some smart features:

- **30-day refresh**: Automatically updates stale configs
- **Docker awareness**: Adjusts commands for containerized environments
- `.nohooks` file: Disable git hooks when needed
- **Force refresh**: `zs force` (hidden feature for power users)

## Performance

Setup time: **< 100ms** ⚡

That's faster than opening the tasks menu in most editors.

## Installation

```bash
# One-time install
curl -sSL https://raw.githubusercontent.com/AnjanJ/zs/main/install.sh | bash
source ~/.zshrc

# Then forever
cd any-project
zs
```

## The Philosophy

After building increasingly complex configurations, I realized the best solution was radical simplification:

- ❌ 10+ commands → ✅ 1 command
- ❌ Multiple flags → ✅ 0 flags  
- ❌ Verbose output → ✅ 1 line
- ❌ Manual validation → ✅ Automatic
- ❌ Decision fatigue → ✅ Zero decisions

As Antoine de Saint-Exupéry said: "Perfection is achieved not when there is nothing more to add, but when there is nothing left to take away."

## Open Source

`zs` is MIT licensed and open for contributions. The entire brain is just 231 lines of shell script.

🌟 [GitHub: AnjanJ/zs](https://github.com/AnjanJ/zs)

Special features for contributors:
- Plugin system for custom project types
- Team configurations via `.zsrc`
- CI/CD ready with GitHub Actions

## What's Next?

Currently, `zs` supports:
- Rails / Ruby
- React / Node.js
- Python
- Elixir
- LTI projects
- Docker environments

Want support for your stack? PRs welcome!

## Try It Now

If you use Zed and switch between projects, give `zs` a try:

```bash
curl -sSL https://raw.githubusercontent.com/AnjanJ/zs/main/install.sh | bash
```

Then just run `zs` in any project. That's it.

---

**One command. Zero configuration. Pure productivity.**

If `zs` saves you time, give it a star on [GitHub](https://github.com/AnjanJ/zs). If you have ideas for improvement, I'd love to hear them!

What repetitive tasks do you automate in your development workflow? Let me know in the comments!

---

*Anjan Jagirdar is a developer who believes the best tools get out of your way. When not automating workflows, he's probably debugging why his automation isn't working.*