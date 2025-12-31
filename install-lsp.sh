#!/bin/bash

set -e

show_help() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --system      Install only system packages (pacman/brew)."
    echo "  --npm         Install only npm packages."
    echo "  --ruby        Install only Ruby gems."
    echo "  --help        Show this help message."
    echo ""
    echo "If no options are provided, all packages will be installed."
}

detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ -f /etc/arch-release ]]; then
        echo "arch"
    else
        echo "unknown"
    fi
}

install_arch_system() {
    echo "Installing system packages for Arch Linux..."
    sudo pacman -Sy
    sudo pacman -S --needed \
        lua-language-server \
        rustup \
        gopls \
        bash-language-server \
        tflint \
        typescript-language-server \
        harper \
        ruff \
        nodejs \
        npm

    rustup component add rust-analyzer

    if command -v yay &> /dev/null; then
        AUR_HELPER="yay"
    elif command -v paru &> /dev/null; then
        AUR_HELPER="paru"
    else
        echo "Warning: No AUR helper found. Skipping AUR packages: terraform-ls"
        AUR_HELPER=""
    fi

    if [[ -n "$AUR_HELPER" ]]; then
        $AUR_HELPER -S --needed terraform-ls
    fi
}

install_npm() {
    echo "Installing npm packages..."
    npm install -g \
        @fsouza/prettierd \
        @prisma/language-server \
        tailwindcss-language-server \
        graphql-language-service-cli
}

install_ruby() {
    echo "Installing Ruby gems..."
    if command -v ruby &> /dev/null; then
        echo "Ruby detected, installing gems..."
        gem install rubocop ruby-lsp
    else
        echo "Ruby not found, skipping gem installation."
    fi
}
install_arch_ruby() {
    echo "Installing Ruby gems for Arch Linux..."
    if ! command -v ruby &> /dev/null; then
        sudo pacman -S --needed ruby
    fi
    gem install rubocop ruby-lsp
}

install_arch() {
    echo "Installing LSP servers for Arch Linux..."
    if [ "$install_system" = true ]; then
        install_arch_system
    fi
    if [ "$install_npm" = true ]; then
        install_npm
    fi
    if [ "$install_ruby" = true ]; then
        install_arch_ruby
    fi
}

install_macos_system() {
    echo "Installing system packages for macOS..."
    brew update
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
}

install_macos() {
    echo "Installing LSP servers for macOS..."
    if [ "$install_system" = true ]; then
        install_macos_system
    fi
    if [ "$install_npm" = true ]; then
        install_npm
    fi
    if [ "$install_ruby" = true ]; then
        install_ruby
    fi
}

main() {
    install_system=false
    install_npm=false
    install_ruby=false

    if [ $# -eq 0 ]; then
        install_system=true
        install_npm=true
        install_ruby=true
    else
        for arg in "$@"; do
            case $arg in
                --system)
                install_system=true
                shift
                ;;
                --npm)
                install_npm=true
                shift
                ;;
                --ruby)
                install_ruby=true
                shift
                ;;
                --help)
                show_help
                exit 0
                ;;
                *)
                echo "Unknown option: $arg"
                show_help
                exit 1
                ;;
            esac
        done
    fi

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
