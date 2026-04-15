# macOS Dev Setup

Designed and maintained purely based on personal preferences of the author. Now with a beautiful interactive setup experience!

## 🚀 Interactive Setup

The primary way to set up your machine is via the interactive wizard. It walks you through different categories of software (Terminals, IDEs, Browsers, Utilities) and lets you pick exactly what you need.

```bash
./setup.sh
```

**Features:**
- **Interactive Selection**: Uses `gum` for a sleek, terminal-based selection UI.
- **Smart Bootstrapping**: Automatically installs Homebrew and `gum` if they are missing.
- **Progress Tracking**: Keeps terminal output clean while showing installation status.
- **Extensible**: Easily add new software groups by modifying the arrays in `setup.sh`.

---

## 📅 Roadmap & Future Updates

- [ ] **Automatic Configuration Application**: If a selected software (cask or formula) has a recommended configuration file stored in this repository (e.g., in the `terminal/` directory), it will be applied automatically during the installation process.

---

## 🛠 Manual Setup / Reference

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
