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
CONFIG_FILE="apps.conf"

# Helper to extract group names from apps.conf
get_groups() {
    grep "^\[.*\]$" "$CONFIG_FILE" | sed 's/\[//;s/\]//'
}

# Helper to extract items for a specific group
get_items_for_group() {
    local group="$1"
    # Extracts lines between [group] and the next [section] or EOF, skipping empty lines
    awk -v group="[$group]" '
        $0 == group {flag=1; next}
        /^\[.*\]$/ {flag=0}
        flag && NF {print $0}
    ' "$CONFIG_FILE"
}

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
        # Handle pipe-delimited format: "Display Name | id | type"
        local dname=$(echo "$opt" | cut -d'|' -f1 | xargs)
        display_names+=("$dname")
    done

    # User Selection using gum
    local selections=$(printf "%s\n" "${display_names[@]}" | gum choose --no-limit --header "Select $group_label (Space: pick, Enter: confirm)")

    if [ -z "$selections" ]; then
        echo "   (Skipped $group_label)"
        return
    fi

    echo "Installing selections for $group_label..."
    
    # Iterate through each user-selected display name using a dedicated file descriptor
    while IFS= read -r selection <&3; do
        if [ -z "$selection" ]; then continue; fi

                # Match selection back to the original options to find brew ID and type
                for opt in "${options[@]}"; do
                    local dname=$(echo "$opt" | cut -d'|' -f1 | xargs)
                    if [ "$selection" == "$dname" ]; then
                        local b_id=$(echo "$opt" | cut -d'|' -f2 | xargs)
                        local b_type=$(echo "$opt" | cut -d'|' -f3 | xargs)

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

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: $CONFIG_FILE not found!"
    exit 1
fi

# Dynamically load and run each group
while read -r group; do
    [ -z "$group" ] && continue

    # Load items for this group into an array
    items=()
    while read -r item; do
        items+=("$item")
    done < <(get_items_for_group "$group")

    install_group "$group" "${items[@]}"
done < <(get_groups)

echo ""
gum style --foreground 212 --bold "✨ All tasks complete! Enjoy your new setup. ✨"
