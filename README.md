# macOS Dev Setup

Welcome to your ultimate macOS developer setup! This tool is designed to bootstrap a fresh machine with elegance, speed, and zero friction. Whether you're a terminal purist or an IDE power user, this script simplifies your onboarding experience.

## Interactive Setup

The primary way to set up your machine is via the interactive wizard. It walks you through different categories of software (Terminals, IDEs, Browsers, Utilities, etc.) and lets you pick exactly what you need.

### Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/6ameDev/dev-setup.git
   ```

2. Navigate into the directory:
   ```bash
   cd dev-setup
   ```

3. Run the setup script:
   ```bash
   ./setup.sh
   ```

**Features:**
- **Interactive Selection**: Uses `gum` for a sleek, terminal-based selection UI.
- **Smart Bootstrapping**: Automatically installs Homebrew and `gum` if they are missing.
- **Extensible**: Software lists are managed in a separate [apps.conf](apps.conf) file. Add new groups or programs with zero changes to the script logic.

---

## Roadmap & Future Updates

- [ ] **Automatic Configuration Application**: If a selected software (cask or formula) has a recommended configuration file stored in this repository (e.g., in the `terminals/` directory), it will be applied automatically during the installation process.

---

## Manual Setup / Reference

For those who prefer a manual approach or want to see the list of essentials:

### Homebrew Essentials

Recommended for every fresh install:
- **Formulae**: `git`, `tig`, `tree`, `htop`, `watch`
- **Casks**: `brave-browser`, `flycut`, `ghostty`, `rectangle`, `vscodium`

### ZSH Configuration
Place the [.zshrc](.zshrc) file in your home directory.

### Browser Search Triggers
Configure shortcuts in Brave (`brave://settings/searchEngines`):

| Search Engine | Shortcut | URL |
| --- | --- | --- |
| Google | `goo` | `https://www.google.com/search?q=%s` |
| Youtube | `you` | `https://www.youtube.com/results?search_query=%s` |
| Google Drive | `dri` | `https://drive.google.com/drive/search?q=%s` |
| Amazon | `ama` | `https://www.amazon.in/s?k=%s` |
| Flipkart | `fli` | `https://www.flipkart.com/search?q=%s` |
| RottenTomatoes | `rot` | `https://www.rottentomatoes.com/search?search=%s` |
