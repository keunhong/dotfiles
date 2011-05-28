# turn on autocompletion

#------------------------------------------
# Options
#------------------------------------------
# why would you type 'cd dir' if you could just type 'dir'?
setopt AUTO_CD

# If I type cd and then cd again, only save the last one
setopt HIST_IGNORE_DUPS

# Alt+S to insert sudo at beginning of line
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo


zmodload zsh/complist
autoload -U compinit && compinit

#------------------------------------------
# Autocompletion
#------------------------------------------
zstyle ':completion:::::' completer _complete _approximate
zstyle ':completion:*' menu select

zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' verbose yes

# allow approximate
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# colorizer auto-completion for kill
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
#zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete
zstyle ':completion:*' completer _expand _force_rehash _complete _approximate _ignored

# generate descriptions with magic.
zstyle ':completion:*' auto-description 'specify: %d'

# Don't prompt for a huge list, page it!
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Don't prompt for a huge list, menu it!
zstyle ':completion:*:default' menu 'select=0'

# Have the newer files last so I see them first
zstyle ':completion:*' file-sort modification reverse

# color code completion!!!!  Wohoo!
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"

#------------------------------------------
# Colors
#------------------------------------------
# set colors to make terminal pretty!
autoload colors; colors
export CLICOLOR=1
#export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
export LS_OPTIONS='--color=auto'
export LSCOLORS=Exfxcxdxbxegedabagacad
#PROMPT="%{$fg[green]%}%n@%m%{$reset_color%} %{$fg[blue]%}%~%{$reset_color%} %{$fg[green]%}%#%{$reset_color%} "
PROMPT="%{$fg[green]%}%n@%m%{$reset_color%} %{$fg[green]%}%#%{$reset_color%} "
RPROMPT="[%{$fg[blue]%}%~%{$reset_color%}][%?][%D{%H:%M:%S}]" # prompt for right side of screen

#------------------------------------------
# Key Bindings
#------------------------------------------
bindkey "[1~" beginning-of-line
bindkey "[4~" end-of-line
bindkey "OA" up-line-or-history
bindkey '[3~' delete-char
bindkey 'OB' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char

setopt no_list_beep

# directory in titlebar
chpwd() {
  [[ -t 1 ]] || return
  case $TERM in
    sun-cmd) print -Pn "\e]l%~\e\\"
      ;;
    *xterm*|rxvt|(dt|k|E)term) print -Pn "\e]2;%~\a"
      ;;
  esac
}

# call chpwd when first loaded
chpwd


###


#. ~/.zsh/mouse.zsh
#zle-toggle-mouse  

#export TERM=screen-256color
if [[ "$TMUX" == "" ]]; then if tmux has-session; then exec tmux -2 -u attach; else exec tmux -2 -u new; fi; fi

source .zprofile
