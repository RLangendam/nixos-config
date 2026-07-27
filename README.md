# Ralph's NixOS Flake Configuration

A modern, modular NixOS configuration using flakes with:
- **Home Manager** for user environment management
- **Neovim** (lazy.nvim) with Rust LSP and full IDE setup
- **Terminal Tools**: WezTerm, Zellij, tmux, and zsh with direnv integration
- **Rust Development**: rust-analyzer, cargo, clippy, rustfmt, and OCI/container support
- **sops-nix** for encrypted secret management

## Repository Structure

```
.
├── flake.nix                    # Main flake configuration with all inputs
├── flake.lock                   # Locked versions of all dependencies
├── hosts/
│   └── desktop/                 # Desktop host configuration
│       ├── configuration.nix     # Main host config (imports modules)
│       ├── hardware-configuration.nix  # Generated hardware scan
│       └── configuration-old.nix # Legacy config (kept for reference)
├── home/
│   ├── ralph.nix               # Main home-manager config
│   ├── neovim.nix              # Neovim setup
│   ├── neovim-config/          # Lua-based Neovim configuration
│   │   └── lua/
│   │       ├── config.lua       # Config entry point
│   │       ├── settings.lua     # Editor settings
│   │       ├── keymaps.lua      # Keybindings
│   │       ├── plugins.lua      # Plugin specifications (lazy.nvim)
│   │       └── lsp.lua          # LSP configuration
│   ├── zsh.nix                 # Zsh shell configuration
│   ├── git.nix                 # Git configuration
│   ├── tmux.nix                # Tmux configuration
│   ├── wezterm.nix             # WezTerm terminal configuration
│   └── zellij.nix              # Zellij multiplexer configuration
├── modules/
│   ├── common/
│   │   └── locale.nix          # Locale, time, and Nix settings
│   ├── desktop/
│   │   ├── kde.nix             # KDE Plasma 6 + SDDM
│   │   └── nvidia.nix          # Nvidia GPU setup
│   └── services/
│       ├── pipewire.nix        # Audio (PipeWire + ALSA)
│       ├── networking.nix      # NetworkManager
│       └── sops.nix            # sops-nix configuration template
├── secrets/
│   ├── .sops.yaml              # SOPS key management policy
│   └── desktop-example.yaml    # Example secrets file
└── .gitignore                  # Ignore local secrets and build artifacts
```

## Building & Deploying

### Build (dry run)
```bash
nixos-rebuild build --flake .#ralph-desktop
```

### Switch (apply changes)
```bash
sudo nixos-rebuild switch --flake .#ralph-desktop
```

### Dry activate (test changes without applying)
```bash
sudo nixos-rebuild dry-activate --flake .#ralph-desktop
```

## What's Configured

### Desktop Environment
- **Display Manager**: SDDM
- **Desktop**: KDE Plasma 6
- **GPU**: Nvidia with proprietary drivers
- **Audio**: PipeWire + ALSA

### Development Environment
- **Editor**: Neovim with lazy.nvim plugin manager
  - Telescope (fuzzy finder)
  - Treesitter (syntax highlighting)
  - LSP Config (Rust, Nix, Lua)
  - nvim-cmp (completion)
  - Conform (formatting)
  - TokyoNight colorscheme
- **Rust Tooling**: cargo, rustc, rust-analyzer, clippy, rustfmt
- **Container Support**: podman, buildah, skopeo
- **Language Tools**: nil (Nix LSP), stylua (Lua formatter)

### Terminal & Shell
- **Terminals**: WezTerm (primary), tmux, Zellij
- **Shell**: Zsh with direnv integration
- **Multiplexing**: Full keybinding support in tmux and Zellij
- **Editor Default**: Neovim (EDITOR, VISUAL, GIT_EDITOR)

### Project Development
- **Direnv**: Automatic environment loading via `.envrc`
- **nix-direnv**: Flake-aware direnv for Rust/Nix projects
- **Flake Support**: cargo, crane for OCI builds

## Using with Rust Projects

### 1. Create a project flake.nix
```nix
{
  description = "My Rust Project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ rust-overlay.overlays.rust-overlay ];
        pkgs = import nixpkgs { inherit system overlays; };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            (rust-bin.stable.latest.default.override {
              extensions = [ "rust-src" ];
            })
            cargo
            rust-analyzer
            clippy
            rustfmt
            pkg-config
          ];
        };
      }
    );
}
```

### 2. Create an .envrc
```bash
use flake
```

### 3. Run direnv
```bash
direnv allow
```

## Secret Management with sops-nix

### Configure encrypted secrets
1. Generate an age key pair if needed:
  ```bash
  mkdir -p ~/.config/age
  age-keygen -o ~/.config/age/keys.txt
  ```

2. Add your public age key to `secrets/.sops.yaml`:
  ```yaml
  creation_rules:
    - path_regex: ".*"
     age:
      - "age1...your_public_key..."
     encrypted_regex: "^(data|stringData)$"
     kms: []
     pgp: []
     azure_key_vault: []
     gcp_kms: []
     hc_vault: []
  ```

3. Copy the example to a real secrets file and edit it:
  ```bash
  cp secrets/desktop-example.yaml secrets/desktop.yaml
  sops secrets/desktop.yaml
  ```

4. Reference the encrypted secrets in your NixOS configuration:
  ```nix
  sops.secrets."myapp/password" = {
    owner = "myapp";
    group = "myapp";
    mode = "0400";
  };
  ```

5. Rebuild or switch the system:
  ```bash
  sudo nixos-rebuild switch --flake .#ralph-desktop
  ```

### How it works
- `sops` encrypts the YAML file in `secrets/desktop.yaml` and stores the ciphertext in Git-safe format.
- `sops-nix` reads the decrypted values at build time and writes the requested secrets to disk with the specified ownership and permissions.
- Keep the unencrypted secret file out of version control; only commit the encrypted file.
> Note: the current repository already includes `secrets/.sops.yaml` and `secrets/desktop-example.yaml`. Use the example file as a template and save the real encrypted file as `secrets/desktop.yaml`.
## Post-Deployment

### From /etc/nixos
After successfully deploying the flake:
1. Backup /etc/nixos if needed
2. Optionally remove /etc/nixos and create a symlink:
   ```bash
   sudo mv /etc/nixos /etc/nixos.backup
   ```
3. Future rebuilds use: `sudo nixos-rebuild switch --flake /path/to/this/repo#ralph-desktop`

## Development Workflow

### Editing Neovim Config
Config lives in `home/neovim-config/lua/`:
- `config.lua`: Entry point (loads other modules)
- `settings.lua`: Editor options
- `keymaps.lua`: Keybindings
- `plugins.lua`: Plugin setup with lazy.nvim
- `lsp.lua`: Language server configuration

Changes take effect after sourcing or restarting nvim.

### Adding New Modules
1. Create module file in `modules/{category}/newmodule.nix`
2. Import in `hosts/desktop/configuration.nix`
3. Run `nixos-rebuild build --flake .#ralph-desktop`
4. Commit with git

### Adding Home Manager Options
1. Edit relevant file in `home/`
2. Rebuild with Home Manager via Nix shell if the `home-manager` command is not installed:
  ```bash
  nix run nixpkgs#home-manager -- switch --flake .#ralph-desktop
  ```
  Or install the binary globally first:
  ```bash
  nix profile install nixpkgs#home-manager
  home-manager switch --flake .#ralph-desktop
  ```
3. Or combine with NixOS: `sudo nixos-rebuild switch --flake .#ralph-desktop`

## Troubleshooting

### Build fails with "path does not exist"
- Files must be staged with git before the flake can see them
  ```bash
  git add <file>
  ```

### Neovim plugins not loading
- Ensure `~/.local/share/nvim/site/pack/packer/start` doesn't conflict with lazy.nvim
- lazy.nvim manages plugins in `~/.local/share/nvim/site/pack/lazy`

### Podman permission denied
- Add your user to the podman group (already done in config)
- May require restart: `newgrp podman` or logout/login

### sops key not found
- Ensure age key exists at `/var/lib/sops-nix/key.txt`
- Or update `sops.age.keyFile` in `modules/services/sops.nix`
### home-manager command not found
- This repo config uses `home-manager` through the NixOS flake integration, so the `home-manager` CLI may not be installed in your shell by default.
- Use `nix run nixpkgs#home-manager -- switch --flake .#ralph-desktop` to apply home-manager config without installing the command globally.
- If you want the command available permanently, install it with `nix profile install nixpkgs#home-manager`.

## Further Improvements

Potential enhancements:
- [ ] Fenix for extended Rust toolchain management
- [ ] Language-specific dev shells in project flakes
- [ ] Unified theme system across all tools (Tokyo Night)
- [ ] Backup/restore automation with borgmatic
- [ ] Additional LSPs: Python, Go, TypeScript
- [ ] Git hooks and pre-commit setup
- [ ] Containerized dev environments with devenv.sh

## Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Flakes Documentation](https://wiki.nixos.org/wiki/Flakes)
- [sops-nix](https://github.com/Mic92/sops-nix)
- [Neovim Config Guide](https://neovim.io/doc/user/nvim.1.html)
- [Rust Overlay](https://github.com/oxalica/rust-overlay)
