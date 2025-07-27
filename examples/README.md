# zs Examples

This directory contains example configurations and use cases for zs.

## Basic Usage

### Rails Project

```bash
cd my-rails-app
zs
# Output: ✅ Rails project ready (15 tasks, debugging enabled)
```

### React Project

```bash
cd my-react-app
zs
# Output: ✅ React project ready (12 tasks, debugging enabled)
```

### Python Project

```bash
cd my-python-project
zs
# Output: ✅ Python project ready (8 tasks, debugging enabled)
```

## Advanced Examples

### Force Regeneration

If you've modified templates or want to refresh your configuration:

```bash
zs force
```

### Verbose Mode

To see what zs is doing behind the scenes:

```bash
ZS_VERBOSE=true zs
```

### Custom Configuration Directory

You can override the default configuration directory:

```bash
ZS_CONFIG_DIR=/path/to/custom/config zs
```

## Customizing Templates

### Adding a New Task

Edit `~/.config/zs/templates/your-type-tasks.json`:

```json
{
  "label": "My Custom Task",
  "command": "npm",
  "args": ["run", "custom"],
  "cwd": "$ZED_WORKTREE_ROOT"
}
```

### Modifying Debug Configuration

Edit `~/.config/zs/templates/debug-configs/your-type-debug.json`:

```json
{
  "label": "Debug with Custom Settings",
  "adapter": "node",
  "request": "launch",
  "program": "${workspaceFolder}/app.js",
  "args": ["--inspect"]
}
```

## Project Structure Examples

### Monorepo

```bash
my-monorepo/
├── apps/
│   ├── frontend/  # Run zs here for React setup
│   └── backend/   # Run zs here for Rails setup
└── packages/
```

### Multi-Language Project

```bash
my-project/
├── server/        # Run zs here - detects Rails
├── client/        # Run zs here - detects React
└── scripts/       # Run zs here - detects Python
```

## Workspace Context Examples

### Work Projects

Projects in `*/work/*` paths get special treatment:

```bash
cd ~/work/company-project
zs
# Output: ✅ Rails project ready (15 tasks, debugging enabled)
#         → Work project: commits need 'Refs: PFS-XXXX'
```

### Learning Projects

Projects in `*/code/learning/*` are optimized for experimentation:

```bash
cd ~/code/learning/react-tutorial
zs
# Output: ✅ React project ready (12 tasks, debugging enabled)
```

## Troubleshooting Examples

### Missing Dependencies

```bash
$ zs
❌ zs config not found at /home/user/.config/zs
❌ Run the installer first: curl -sSL https://raw.githubusercontent.com/AnjanJ/zs/main/install.sh | bash
```

### Skipping Git Hooks

```bash
# Create a .nohooks file to skip git hook installation
touch .nohooks
zs
```

### Checking Installation

```bash
# Verify zs is installed correctly
which zs
# Output: /home/user/.local/bin/zs

# Check version
zs version
# Output: zs version 1.0.0
```