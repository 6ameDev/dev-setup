# 1. Homebrew completions on fpath before plugins load
command -v brew >/dev/null && fpath+=("$(brew --prefix)/share/zsh/site-functions")

# 2. Antidote plugin manager
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load

# 3. Completion display
zstyle ':completion:' menu select
zstyle ':completion:' matcher-list 'm:{a-z}={A-Z}'

# 4. Prompt
autoload -U promptinit; promptinit
prompt pure

# 5. Fuzzy finder keybindings and completion
command -v fzf >/dev/null && source <(fzf --zsh)

# 6. Smart directory jumping
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# 7. History behavior
HISTSIZE=5000
SAVEHIST=5000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# 8. Extra bins on PATH
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d /opt/homebrew/opt/libpq/bin ] && PATH="/opt/homebrew/opt/libpq/bin:$PATH"
[ -d "$HOME/.antigravity/antigravity/bin" ] && PATH="$HOME/.antigravity/antigravity/bin:$PATH"
[ -d "$HOME/.lmstudio/bin" ] && PATH="$HOME/.lmstudio/bin:$PATH"

# 9. Android SDK
export ANDROID_HOME="$HOME/Library/Android/sdk"
[ -d "$ANDROID_HOME/platform-tools" ] && PATH="$ANDROID_HOME/platform-tools:$PATH"
[ -d "$ANDROID_HOME/cmdline-tools/latest/bin" ] && PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export PATH

# 10. Version managers
command -v mise >/dev/null && eval "$(mise activate zsh)"
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
