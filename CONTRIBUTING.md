# Contributing to zs

Thank you for your interest in contributing to zs! We value all contributions, from bug reports to new features.

## Code of Conduct

Be respectful and inclusive. We're all here to make Zed setup easier for everyone.

## How to Contribute

### Reporting Bugs

1. Check if the issue already exists
2. Create a new issue with:
   - Clear title and description
   - Steps to reproduce
   - Expected vs actual behavior
   - Your environment (OS, Zed version, shell)

### Suggesting Features

1. Check existing issues and discussions
2. Open a discussion or issue describing:
   - The problem you're trying to solve
   - Your proposed solution
   - Alternative approaches considered

### Contributing Code

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**
   - Follow the existing code style
   - Keep it simple and focused
   - Test your changes thoroughly
4. **Commit with clear messages**
   ```bash
   git commit -m "Add support for Rust projects"
   ```
5. **Push and create a Pull Request**

### Code Guidelines

- **Simplicity First**: zs philosophy is "zero configuration"
- **Bash Compatible**: Ensure scripts work with bash 3.2+ (macOS default)
- **Minimal Dependencies**: Avoid adding new requirements
- **Smart Defaults**: Make intelligent choices so users don't have to
- **Clear Output**: One line of success output is usually enough

### Adding Project Type Support

To add support for a new project type:

1. Update detection in `src/zs`:
   ```bash
   detect_project_type() {
     # Add your detection logic
     if [[ -f "your-project-file" ]]; then
       echo "your-type"
     fi
   }
   ```

2. Add task template in `templates/your-type-tasks.json`

3. Add debug config in `templates/debug-configs/your-type-debug.json`

4. Update dependencies installation if needed:
   ```bash
   ensure_dependencies() {
     case "$project_type" in
       your-type)
         # Install what's needed for Zed
         ;;
     esac
   }
   ```

### Testing

Before submitting:

1. Test installation on a clean system
2. Test with various project types
3. Verify smart caching works
4. Check edge cases (no git, missing dependencies)

### Documentation

- Update README.md if adding features
- Keep examples simple and clear
- Document any new environment variables

## Pull Request Process

1. Ensure all tests pass
2. Update documentation as needed
3. Add yourself to CONTRIBUTORS if it's your first contribution
4. PR title should clearly describe the change
5. Link any related issues

## Release Process

Maintainers will:
1. Review and merge PRs
2. Update version in `src/zs`
3. Tag releases following semantic versioning
4. Update installation URLs if needed

## Questions?

Open an issue or discussion. We're here to help!

---

Remember: The best contribution maintains zs's philosophy of simplicity. When in doubt, choose the path that requires less user configuration.