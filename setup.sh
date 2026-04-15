#!/bin/bash

# ==============================================================================
# macOS Developer Setup Script
# Uses 'gum' for an interactive, glamorous CLI experience.
# ==============================================================================

# --- UI Helpers ---
print_header() {
    if command -v gum &> /dev/null; then
        gum style --foreground 212 --border-foreground 212 --border double --align center --width 50 "macOS Setup Wizard"
    else
        echo "=================================================="
        echo "              macOS Setup Wizard                  "
        echo "=================================================="
    fi
}

print_step() {
    if command -v gum &> /dev/null; then
        gum style --foreground 86 "➜ $1"
    else
        echo "➜ $1"
    fi
}

# --- Bootstrapping ---

# Ensure Homebrew is installed
if ! command -v brew &> /dev/null; then
    print_step "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add brew to path for the rest of the script if it's the first install
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Ensure Gum is installed
if ! command -v gum &> /dev/null; then
    print_step "Installing 'gum' for interactive UI..."
    brew install gum
fi

# --- Configuration ---
# Format: "Display Name|brew_identifier|install_type(formula/cask)"

TERMINALS=(
    "Alacritty|alacritty|cask"
    "Ghostty|ghostty|cask"
    "iTerm2|iterm2|cask"
)

IDES=(
    "Antigravity|antigravity|cask"
    "VS Codium|vscodium|cask"
    "Zed|zed|cask"
)

BROWSERS=(
    "Brave|brave-browser|cask"
    "Firefox|firefox|cask"
    "Google Chrome|google-chrome|cask"
    "Orion Browser|orion|cask"
)

UTILITIES=(
    "Htop|htop|formula"
    "Password generator|pwgen|formula"
    "Tig|tig|formula"
    "Tree|tree|formula"
    "Watch|watch|formula"
    "Flycut|flycut|cask"
    "Rectangle|rectangle|cask"
    "Zoom|zoom|cask"
)

# Mapping of Group Label to the Array Variable Name
SOFTWARE_GROUPS=(
    "Terminals|TERMINALS"
    "Web Browsers|BROWSERS"
    "IDEs|IDES"
    "Utilities|UTILITIES"
)

# --- Core Logic ---

install_group() {
    local group_label="$1"
    shift
    local options=("$@")
    
    # Check if options are empty
    if [ ${#options[@]} -eq 0 ]; then return; fi

    print_step "Let's setup $group_label"

    # Prepare display names for gum
    local display_names=()
    for opt in "${options[@]}"; do
        display_names+=("${opt%%|*}")
    done

    # User Selection using gum
    # --no-limit allows selecting multiple options
    local selections=$(printf "%s\n" "${display_names[@]}" | gum choose --no-limit --header "Select $group_label (Space: pick, Enter: confirm)")

    if [ -z "$selections" ]; then
        echo "   (Skipped $group_label)"
        return
    fi

    echo "Installing selections for $group_label..."
    
    # Iterate through each user-selected display name using a dedicated file descriptor
    while IFS= read -r selection <&3; do
        if [ -z "$selection" ]; then continue; fi

                # Match selection back to the original array to find brew ID and type
                for opt in "${options[@]}"; do
                    local dname="${opt%%|*}"
                    if [ "$selection" == "$dname" ]; then
                        local b_id=$(echo "$opt" | cut -d'|' -f2)
                        local b_type=$(echo "$opt" | cut -d'|' -f3)

                        # Check if already installed
                        if brew list --$b_type "$b_id" &>/dev/null; then
                            echo "   ⠿ $selection is already installed."
                            break
                        fi

                        # Install using brew
                        gum spin --spinner dot --title "Installing $selection ($b_id)..." -- \
                            brew install $( [ "$b_type" == "cask" ] && echo "--cask" ) "$b_id" < /dev/null

                        if [ $? -eq 0 ]; then
                            echo "   ✅ $selection installed."
                        else
                            echo "   ❌ Failed to install $selection."
                        fi
                        break
                    fi
                done
    done 3<<< "$selections"
}

# --- Main Flow ---

clear
print_header

for group in "${SOFTWARE_GROUPS[@]}"; do
    group_label="${group%%|*}"
    group_var="${group##*|}"

    eval "group_options=(\"\${${group_var}[@]}\")"

    install_group "$group_label" "${group_options[@]}"
done

echo ""
gum style --foreground 212 --bold "✨ All tasks complete! Enjoy your new setup. ✨"
