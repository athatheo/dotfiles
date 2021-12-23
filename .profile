export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/bin/nvim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
# fix "xdg-open fork-bomb" export your preferred browser from here

# Adds `~/.local/bin/` and all subdirectories to $PATH
BIN_PATH="$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"

# mons -e left

export BROWSER="/usr/bin/google-chrome-stable"
export TERMINAL="kitty"
export FILES="ranger"
export CODEEDITOR="code"

xset r rate 200 50

# Add ForceFullCompositionPipeline in nvidia-settings

nvidia-settings --assign CurrentMetaMode="DPY-3: nvidia-auto-select +1920+0 {ForceFullCompositionPipeline=On}, DPY-2: nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
