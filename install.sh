#!/bin/bash
# zs (Zed Smart Setup) Installer
# Smart installation with dependency checking and backup

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Configuration
ZS_INSTALL_DIR="$HOME/.local/bin"
ZS_CONFIG_DIR="$HOME/.config/zs"
ZS_REPO_URL="https://github.com/yourusername/zs-zed-smart-setup"
REQUIRED_COMMANDS="git curl"
BACKUP_DIR="$HOME/.config/zs-backup-$(date +%Y%m%d_%H%M%S)"

# Output helpers
success() { echo -e "${GREEN}✅ $1${NC}"; }
warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
error() { echo -e "${RED}❌ $1${NC}"; }
info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
progress() { echo -e "${BLUE}⏳ $1${NC}"; }

# Banner
echo ""
echo -e "${GREEN}╔═══════════════════════════════════╗${NC}"
echo -e "${GREEN}║       zs - Zed Smart Setup        ║${NC}"
echo -e "${GREEN}║    One command, zero config       ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════╝${NC}"
echo ""

# Check dependencies
check_dependencies() {
  progress "Checking dependencies..."
  
  local missing=()
  for cmd in $REQUIRED_COMMANDS; do
    if ! command -v "$cmd" &> /dev/null; then
      missing+=("$cmd")
    fi
  done
  
  if [[ ${#missing[@]} -gt 0 ]]; then
    error "Missing required commands: ${missing[*]}"
    echo "Please install them first:"
    for cmd in "${missing[@]}"; do
      case "$cmd" in
        git)
          echo "  • git: https://git-scm.com/downloads"
          ;;
        curl)
          echo "  • curl: Usually pre-installed, or 'brew install curl' on macOS"
          ;;
      esac
    done
    exit 1
  fi
  
  success "All dependencies found"
}

# Check Zed installation
check_zed() {
  progress "Checking for Zed editor..."
  
  if [[ -d "$HOME/.config/zed" ]]; then
    success "Zed configuration directory found"
  else
    warning "Zed configuration directory not found"
    echo "  Please install Zed first: https://zed.dev"
    read -p "Continue anyway? [y/N] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      exit 1
    fi
  fi
}

# Backup existing installation
backup_existing() {
  if [[ -d "$ZS_CONFIG_DIR" || -f "$ZS_INSTALL_DIR/zs" ]]; then
    progress "Backing up existing installation..."
    mkdir -p "$BACKUP_DIR"
    
    if [[ -d "$ZS_CONFIG_DIR" ]]; then
      cp -r "$ZS_CONFIG_DIR" "$BACKUP_DIR/"
      success "Config backed up to $BACKUP_DIR"
    fi
    
    if [[ -f "$ZS_INSTALL_DIR/zs" ]]; then
      cp "$ZS_INSTALL_DIR/zs" "$BACKUP_DIR/"
      success "Executable backed up to $BACKUP_DIR"
    fi
  fi
}

# Download and install
install_zs() {
  progress "Installing zs..."
  
  # Create directories
  mkdir -p "$ZS_INSTALL_DIR"
  mkdir -p "$ZS_CONFIG_DIR"
  
  # Download from current directory if it exists (for local testing)
  if [[ -f "$(dirname "$0")/src/zs" ]]; then
    info "Installing from local repository..."
    cp -r "$(dirname "$0")"/* "$ZS_CONFIG_DIR/"
    cp "$ZS_CONFIG_DIR/src/zs" "$ZS_INSTALL_DIR/zs"
    chmod +x "$ZS_INSTALL_DIR/zs"
  else
    # Download from GitHub
    info "Downloading from GitHub..."
    temp_dir=$(mktemp -d)
    git clone --depth 1 "$ZS_REPO_URL" "$temp_dir" &> /dev/null || {
      error "Failed to download zs"
      exit 1
    }
    
    # Copy files
    cp -r "$temp_dir"/templates "$ZS_CONFIG_DIR/"
    cp -r "$temp_dir"/hooks "$ZS_CONFIG_DIR/"
    cp "$temp_dir/src/zs" "$ZS_INSTALL_DIR/zs"
    chmod +x "$ZS_INSTALL_DIR/zs"
    
    # Cleanup
    rm -rf "$temp_dir"
  fi
  
  success "zs installed successfully"
}

# Configure shell
configure_shell() {
  progress "Configuring shell..."
  
  # Detect shell
  local shell_rc=""
  if [[ -n "${ZSH_VERSION:-}" ]] || [[ "$SHELL" == *"zsh"* ]]; then
    shell_rc="$HOME/.zshrc"
  elif [[ -n "${BASH_VERSION:-}" ]] || [[ "$SHELL" == *"bash"* ]]; then
    shell_rc="$HOME/.bashrc"
  else
    warning "Unknown shell. Please add $ZS_INSTALL_DIR to your PATH manually"
    return
  fi
  
  # Add to PATH if not already there
  if ! grep -q "$ZS_INSTALL_DIR" "$shell_rc" 2>/dev/null; then
    echo "" >> "$shell_rc"
    echo "# zs - Zed Smart Setup" >> "$shell_rc"
    echo "export PATH=\"\$PATH:$ZS_INSTALL_DIR\"" >> "$shell_rc"
    success "Added zs to PATH in $shell_rc"
    echo "  Run: source $shell_rc"
  else
    success "zs already in PATH"
  fi
}

# Post-installation message
post_install() {
  echo ""
  echo -e "${GREEN}════════════════════════════════════${NC}"
  echo -e "${GREEN}Installation complete!${NC}"
  echo ""
  echo "Next steps:"
  echo "1. Reload your shell:"
  echo "   source ~/.${SHELL##*/}rc"
  echo ""
  echo "2. Navigate to any project and run:"
  echo "   zs"
  echo ""
  echo "That's it! No configuration needed."
  echo -e "${GREEN}════════════════════════════════════${NC}"
}

# Main installation flow
main() {
  check_dependencies
  check_zed
  backup_existing
  install_zs
  configure_shell
  post_install
}

# Handle errors
trap 'error "Installation failed. Check the error messages above."' ERR

# Run installation
main