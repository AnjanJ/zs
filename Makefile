.PHONY: install test lint clean help

# Default target
help:
	@echo "zs - Zed Smart Setup"
	@echo ""
	@echo "Available targets:"
	@echo "  install    Install zs locally"
	@echo "  test       Run tests (requires shellcheck)"
	@echo "  lint       Lint shell scripts"
	@echo "  clean      Remove installed files"
	@echo "  help       Show this help message"

install:
	@echo "Installing zs..."
	@./install.sh

test: lint
	@echo "Running tests..."
	@bash -n install.sh
	@bash -n src/zs
	@echo "All tests passed!"

lint:
	@echo "Linting shell scripts..."
	@if command -v shellcheck >/dev/null 2>&1; then \
		shellcheck install.sh src/zs hooks/git/*; \
	else \
		echo "Warning: shellcheck not installed. Install it for linting."; \
	fi

clean:
	@echo "Cleaning up..."
	@rm -rf ~/.config/zs
	@rm -f ~/.local/bin/zs
	@echo "Clean complete. Run 'make install' to reinstall."