#!/bin/bash

set -e

detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ -f /etc/arch-release ]]; then
        echo "arch"
    else
        echo "unknown"
    fi
}

install_arch() {
    echo "Installing LSP servers for Arch Linux..."
    
    # Update package database
    sudo pacman -Sy
    
    # Install packages available in official repos
    sudo pacman -S --needed \
        lua-language-server \
        rust-analyzer \
        gopls \
        bash-language-server \
        tflint \
        typescript-language-server \
        harper \
        python-ruff \
        nodejs \
        npm
    
    # Install packages from AUR (requires yay or paru)
    if command -v yay &> /dev/null; then
        AUR_HELPER="yay"
    elif command -v paru &> /dev/null; then
        AUR_HELPER="paru"
    else
        echo "Warning: No AUR helper found. Please install yay or paru to install AUR packages."
        echo "Skipping AUR packages: terraform-ls"
        AUR_HELPER=""
    fi
    
    if [[ -n "$AUR_HELPER" ]]; then
        $AUR_HELPER -S --needed terraform-ls
    fi
    
    # Install remaining packages via npm (only those not available in pacman)
    npm install -g \
        @fsouza/prettierd \
        @prisma/language-server \
        tailwindcss-language-server \
        graphql-language-service-cli
    
    # Install Ruby gems (Ruby should be installed if needed)
    if ! command -v ruby &> /dev/null; then
        sudo pacman -S --needed ruby
    fi
    
    gem install rubocop ruby-lsp
}

install_macos() {
    echo "Installing LSP servers for macOS..."
    
    # Update Homebrew
    brew update
    
    # Install packages available in Homebrew
    brew install \
        lua-language-server \
        rust-analyzer \
        gopls \
        bash-language-server \
        terraform-ls \
        tflint \
        harper \
        typescript-language-server \
        ruff \
        node
    
    # Install remaining packages via npm (only those not available in brew)
    npm install -g \
        @fsouza/prettierd \
        @prisma/language-server \
        tailwindcss-language-server \
        graphql-language-service-cli
    
    # Install Ruby gems if Ruby is available
    if command -v ruby &> /dev/null; then
        echo "Ruby detected, installing gems..."
        gem install rubocop ruby-lsp
    else
        echo "Ruby not found, skipping gem installation."
    fi
}

main() {
    OS=$(detect_os)
    
    case $OS in
        "arch")
            install_arch
            ;;
        "macos")
            install_macos
            ;;
        *)
            echo "Unsupported operating system. This script supports Arch Linux and macOS only."
            exit 1
            ;;
    esac
    
    echo ""
    echo "Installation complete! LSP servers installed:"
    echo "- harper (grammar/spell checker)"
    echo "- lua-language-server (Lua)"
    echo "- typescript-language-server (TypeScript/JavaScript)"
    echo "- tflint (Terraform linter)"
    echo "- terraform-ls (Terraform)"
    echo "- rust-analyzer (Rust)"
    echo "- ruff (Python)"
    echo "- @prisma/language-server (Prisma)"
    echo "- @fsouza/prettierd (formatter)"
    echo "- tailwindcss-language-server (TailwindCSS)"
    echo "- gopls (Go)"
    echo "- graphql-language-service-cli (GraphQL)"
    echo "- bash-language-server (Bash)"
    echo "- rubocop (Ruby linter)"
    echo "- ruby-lsp (Ruby)"
    echo ""
    echo "Note: Some LSP servers may require additional configuration in your Neovim setup."
}

main "$@"
