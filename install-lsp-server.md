## `install-lsp.sh`

This script automates the installation of Language Server Protocol (LSP) servers for Neovim on both Arch Linux and macOS.

### Usage

To run the script, execute it from your terminal:

```bash
./install-lsp.sh [options]
```

### Options

The script accepts the following optional arguments to customize the installation:

-   `--system`: Installs only system packages using the native package manager (`pacman` for Arch Linux, `brew` for macOS).
-   `--npm`: Installs only Node.js-based LSP servers via `npm`.
-   `--ruby`: Installs only Ruby-based tools and LSP servers via `gem`.
-   `--help`: Displays the help message with usage instructions.

If no arguments are provided, the script will install all available LSP servers.

### Supported Operating Systems

-   **Arch Linux**: Utilizes `pacman` for system packages and checks for an AUR helper (`yay` or `paru`) for additional packages.
-   **macOS**: Uses Homebrew (`brew`) for all system-level installations.

### Installed LSP Servers

The script installs the following LSP servers and tools:

-   **harper**: A grammar and spell checker.
-   **lua-language-server**: For Lua.
-   **typescript-language-server**: For TypeScript and JavaScript.
-   **tflint**: A linter for Terraform.
-   **terraform-ls**: The official Terraform LSP.
-   **rust-analyzer**: For Rust.
-   **ruff**: A fast Python linter.
-   **@prisma/language-server**: For Prisma schemas.
-   **@fsouza/prettierd**: A Prettier daemon for formatting.
-   **tailwindcss-language-server**: For TailwindCSS.
-   **gopls**: The official Go LSP.
-   **graphql-language-service-cli**: For GraphQL.
-   **bash-language-server**: For Bash scripts.
-   **rubocop**: A Ruby linter and formatter.
-   **ruby-lsp**: The official Ruby LSP.
