# zs - Zed Smart Setup

> One command, zero configuration. The smartest way to set up Zed for any project.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell: Bash](https://img.shields.io/badge/Shell-Bash-blue.svg)](https://www.gnu.org/software/bash/)
[![Editor: Zed](https://img.shields.io/badge/Editor-Zed-orange.svg)](https://zed.dev)

## What is zs?

`zs` (Zed Smart Setup) automatically configures the [Zed editor](https://zed.dev) for your project. It detects your project type, installs necessary debug dependencies, creates task configurations, and sets up appropriate git hooks - all with a single command.

### Features

- **Zero Configuration**: Just run `zs` in any project directory
- **Smart Detection**: Automatically identifies Rails, React, Python, Elixir, and more
- **Minimal Dependencies**: Only installs what Zed needs for debugging
- **Context Aware**: Different setups for work, personal, and learning projects
- **Non-Intrusive**: Smart caching prevents unnecessary re-runs
- **Git Hook Management**: Installs appropriate hooks based on project context

## Installation

### Quick Install

```bash
curl -sSL https://raw.githubusercontent.com/yourusername/zs-zed-smart-setup/main/install.sh | bash
```

### Manual Install

```bash
git clone https://github.com/yourusername/zs-zed-smart-setup.git
cd zs-zed-smart-setup
./install.sh
```

## Usage

Navigate to any project and run:

```bash
zs
```

That's it. No flags, no configuration files, no setup wizards.

### What happens?

1. **Detects your project type** by examining files like `Gemfile`, `package.json`, `requirements.txt`
2. **Installs minimal debug dependencies** (only for Zed, not global)
3. **Creates `.zed/tasks.json`** with project-appropriate tasks
4. **Creates `.zed/debug.json`** with debug configurations
5. **Sets up git hooks** based on your workspace context

### Examples

```bash
# In a Rails project
$ zs
✅ Rails project ready (15 tasks, debugging enabled)

# In a React project
$ zs
✅ React project ready (12 tasks, debugging enabled)

# In a Python project
$ zs
✅ Python project ready (8 tasks, debugging enabled)

# Running again (smart caching)
$ zs
✅ Already configured (Rails project)
```

## Project Type Detection

zs automatically detects:

- **Rails/Ruby**: Presence of `Gemfile`
- **LTI Tools**: Rails projects with `lti` gem
- **React**: `package.json` with react dependency
- **Node.js**: Generic `package.json`
- **Python**: `requirements.txt` or `pyproject.toml`
- **Elixir**: `mix.exs`
- **Universal**: Fallback for other projects

## Workspace Context

zs adapts based on directory patterns:

- **Work** (`*/work/*`): Adds commit message reminders for ticket references
- **Learning** (`*/code/learning/*`): Optimized for tutorials and experiments
- **Personal** (`*/code/*`): Standard personal project setup

## Advanced Usage

### Force Regeneration

```bash
zs force
```

### Verbose Mode

```bash
ZS_VERBOSE=true zs
```

### Skip Hooks

Create a `.nohooks` file in your project or `.git/` directory to skip git hook installation.

## File Structure

After running `zs`, your project will have:

```
your-project/
├── .zed/
│   ├── tasks.json      # Task runner configurations
│   └── debug.json      # Debug adapter configurations
└── .git/hooks/         # Smart git hooks (if applicable)
    ├── pre-commit
    └── commit-msg
```

## Templates

zs includes templates for various project types:

- Task configurations for Rails, React, Python, Elixir, and more
- Debug configurations for each language/framework
- CI/CD templates for GitHub Actions and GitLab CI
- Git commit message templates

## Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT License - see [LICENSE](LICENSE) for details.

## FAQ

**Q: Do I need to configure anything?**  
A: No. That's the point.

**Q: What if I already have `.zed` configurations?**  
A: zs won't overwrite recent configs (< 30 days old) unless you use `zs force`.

**Q: Can I customize the templates?**  
A: Yes! Templates are stored in `~/.config/zs/templates/`. Feel free to modify them.

**Q: Does it work with other editors?**  
A: No. zs is specifically designed for Zed's task and debug systems.

**Q: How do I uninstall?**  
A: Remove `~/.config/zs/` and delete the zs line from your shell RC file.

---

*The best interface is no interface.*