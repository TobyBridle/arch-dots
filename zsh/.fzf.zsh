# Setup fzf
# ---------
if [[ ! "$PATH" == */home/tobybridle/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/tobybridle/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/tobybridle/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/tobybridle/.fzf/shell/key-bindings.zsh"
